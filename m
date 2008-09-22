From: "Sean Davis" <sdavis2@mail.nih.gov>
Subject: git http-push and MKCOL error (22/409)
Date: Mon, 22 Sep 2008 19:51:02 -0400
Message-ID: <264855a00809221651i170c7f93o4f063f0cedeae13c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 23 01:52:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KhvCW-0001Oq-PT
	for gcvg-git-2@gmane.org; Tue, 23 Sep 2008 01:52:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754142AbYIVXvI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Sep 2008 19:51:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754172AbYIVXvG
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Sep 2008 19:51:06 -0400
Received: from rn-out-0910.google.com ([64.233.170.189]:56934 "EHLO
	rn-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754104AbYIVXvE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Sep 2008 19:51:04 -0400
Received: by rn-out-0910.google.com with SMTP id k40so572080rnd.17
        for <git@vger.kernel.org>; Mon, 22 Sep 2008 16:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender
         :to:subject:mime-version:content-type:content-transfer-encoding
         :content-disposition:x-google-sender-auth;
        bh=lCLPGkqTixOTEia0BY1+Xh1PPtn4B0jQg/IVuNV3L1o=;
        b=FppIGfNFqGynlMQyjel8DCy6UjSs9BXKp05oEzI27WVPKYphwQ69Axc2DtY93W+iWs
         A2YxLg3uVqNL+5KFmM8feI8P53ZDwFFgbKvkGoxusbWykVyR4Qt786AzJYyApXhfq6rY
         8FQWJwz1t49tzw/M0DpHJRfYxXZLRL4/C4TuA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition:x-google-sender-auth;
        b=ZcMMpAxQXQlbEmXV5NA0LqW1/52Ikd5ajHd4k4IiC6yVNZezP3SQsGUTW/FCDThQ3w
         GSiFZPvF54FQHiwdfLzB41K2iokchKgm6iIE7PyD9ijtbpUPmi+XFSbt9gLOPifF7ZlK
         qEQpIkGoAl2GvqNLuos9PQgCVZctMgfUoAG+c=
Received: by 10.100.132.2 with SMTP id f2mr3798375and.36.1222127462959;
        Mon, 22 Sep 2008 16:51:02 -0700 (PDT)
Received: by 10.100.197.2 with HTTP; Mon, 22 Sep 2008 16:51:02 -0700 (PDT)
Content-Disposition: inline
X-Google-Sender-Auth: 9146d682dc6ef6b0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96517>

I built git from source for mac os and after updating curl to the
latest version and installing the latest expat (both from source), I
have git-http-push installed.  I have a bare repository in the webDAV
directory (which was placed there over a webDAV mount, so it appears
that webDAV is working).  When I try to push to it, I get the
following:

sdavis$ git push http://sdavis@example.com/git/stuff.git master
Fetching remote heads...
  refs/
  refs/heads/
updating 'refs/heads/master'
  from 0000000000000000000000000000000000000000
  to   f1ea50f8f60497ea3eca2355c10c141734db6451
    sending 3070 objects
MKCOL d7a940ff6c7bbc924f6e2d2c319aea22b8b0fdac failed, aborting (22/409)
MKCOL c9ac4c17871308e520a9944e12d846be9f24f91d failed, aborting (22/409)
MKCOL 1ac1bf55510deade68b14debd71357e3d929fe1c failed, aborting (22/409)
MKCOL da5e8ff9649c2b6ee0fde2280163ab4b399a1f1a failed, aborting (22/409)
MKCOL 87fc8ecfa98c36e0f9e44ed772d49d02378fc191 failed, aborting (22/409)
UNLOCK HTTP error 500
error: failed to push some refs to 'http://sdavis@example.com/git/stuff.git'

The apache error log shows:

[Mon Sep 22 19:48:53 2008] [error] [client 156.40.148.25] File does
not exist: /home/www/git/stuff.git/info
[Mon Sep 22 19:48:53 2008] [error] [client 156.40.148.25] File does
not exist: /home/www/git/stuff.git/objects
[Mon Sep 22 19:49:47 2008] [error] [client 156.40.148.25] (2)No such
file or directory: Cannot create collection; intermediate collection
does not exist.  [409, #0]
[Mon Sep 22 19:49:47 2008] [error] [client 156.40.148.25] (2)No such
file or directory: Cannot create collection; intermediate collection
does not exist.  [409, #0]
[Mon Sep 22 19:49:47 2008] [error] [client 156.40.148.25] (2)No such
file or directory: Cannot create collection; intermediate collection
does not exist.  [409, #0]
[Mon Sep 22 19:49:47 2008] [error] [client 156.40.148.25] (2)No such
file or directory: Cannot create collection; intermediate collection
does not exist.  [409, #0]
[Mon Sep 22 19:49:47 2008] [error] [client 156.40.148.25] (2)No such
file or directory: Cannot create collection; intermediate collection
does not exist.  [409, #0]

Any ideas?

Thanks,
Sean
