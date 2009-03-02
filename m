From: Tay Ray Chuan <rctay89@gmail.com>
Subject: http: a non-curl_multi interface?
Date: Mon, 2 Mar 2009 21:14:35 +0800
Message-ID: <be6fef0d0903020514h28995ec2v2acd9f65131c1515@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 02 14:16:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Le806-00021L-81
	for gcvg-git-2@gmane.org; Mon, 02 Mar 2009 14:16:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751362AbZCBNOi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Mar 2009 08:14:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751278AbZCBNOi
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Mar 2009 08:14:38 -0500
Received: from rv-out-0506.google.com ([209.85.198.232]:57447 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751265AbZCBNOi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Mar 2009 08:14:38 -0500
Received: by rv-out-0506.google.com with SMTP id g37so2263254rvb.1
        for <git@vger.kernel.org>; Mon, 02 Mar 2009 05:14:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=jxCcLUDq+bV8DmRpcrm7nkoMlYu/w3MpEhRX66YhQHs=;
        b=W167vRAN9E83gkC+riwdHdtRLcyaUJt3JHK0aWmaVRiQEjZ2aNoHzo0xN0NBDgoeRC
         P61KCPYaOkXVe4h9DOAOuHJT9ppsSlA/reYCVDWPbE4ztLNrPrlUjp3I3TQ31AWBpTEk
         KVpGUub1PGc6/KGMUFlKBsdbdAu6co7w5DZfk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=UvjOx5cqL0zlFLvTnOa5oEPGvIbdFSEebOCZUnz1zkLDXVuikTxEktVBeTd9CF1Jot
         QWp2H5kBptVv3bpJv6tRBAME2fV5jtHjZYwvkCZf3kZWdo4mrrvThtC/4zGvfOMugY12
         mu3uJ4r95cNGNzPEvp7UyTdGgu5FUHzweb4lk=
Received: by 10.114.47.12 with SMTP id u12mr2612884wau.147.1235999675348; Mon, 
	02 Mar 2009 05:14:35 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111938>

HI,

there's been several complaints about how git uses curl, particularly
how it forces one to use curl's multi interface, so I've tried my hand
at implementing a curl interface that doesn't need curl_multi.

This would allow git to work without curl_multi.

The non-curl_multi set of functions are done, and I've also taught
push and http-push --persistent, to force git to behave as though
USE_CURL_MULTI isn't defined.

Do you guys think this would bring any benefits, apart from requiring
the user to use a curl library with the multi interface? Based on what
I read in the docs, this would mean less open/closed connections,
minimized credential prompting (if authentication is required), more
backward compatibility, but it would also mean a possible performance
degradation in git, since all http requests are sequential.

--
Cheers,
Ray Chuan
