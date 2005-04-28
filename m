From: Kris Shannon <kris.shannon.kernel@gmail.com>
Subject: RT[1/3]: Alternate Encodings (esp. Delta Compression)
Date: Thu, 28 Apr 2005 23:47:59 +1000
Message-ID: <5d4799ae05042806477eb1e222@mail.gmail.com>
References: <5d4799ae0504280559109cd00e@mail.gmail.com>
Reply-To: Kris Shannon <kris.shannon.kernel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Thu Apr 28 15:45:56 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DR9Hr-0005re-HB
	for gcvg-git@gmane.org; Thu, 28 Apr 2005 15:42:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262131AbVD1NsE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Apr 2005 09:48:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262134AbVD1NsE
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Apr 2005 09:48:04 -0400
Received: from zproxy.gmail.com ([64.233.162.198]:29038 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262131AbVD1Nr7 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Apr 2005 09:47:59 -0400
Received: by zproxy.gmail.com with SMTP id 13so472289nzp
        for <git@vger.kernel.org>; Thu, 28 Apr 2005 06:47:59 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=tjVGZ12D2eWS6tl/YV1kSxswtOfAIRXHrVXRrNVPbVPEJvoEExYrhap87q7wifufkDWzdGBJ0v0dLU5ia7Oifh2L4qn+IjAOmBdQWKlXisS7k8rSQGJLAjkHtqfo18WCWCbmr2H5ONUcELXKZ35pGMDp12dbLFcfYirsyX0xVSg=
Received: by 10.36.9.18 with SMTP id 18mr97702nzi;
        Thu, 28 Apr 2005 06:47:59 -0700 (PDT)
Received: by 10.36.4.16 with HTTP; Thu, 28 Apr 2005 06:47:59 -0700 (PDT)
To: GIT Mailing List <git@vger.kernel.org>
In-Reply-To: <5d4799ae0504280559109cd00e@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

If a format is defined for representing delta compression then
it would be prudent to make sure that it could be used for
encoding both forward and backward deltas (not necessarily
in the same delta :) These deltas could then by kept in the 
objects directory (i.e. 00/a29c403e751c2a2a61eb24fa2249c8956d1c80.xdelta)

Doing delta compression of old versions is something that should
be done manually (the subversion people have empirical data
to back that up I think but I can't seem to find a link ATM)
A command for wiping old versions from a repository to save space
could be altered to replace the files with their xdelta equivalents
for a reduced space savings but still keeping a full history.

Using delta compression of the new versions (against the old) for
efficient bandwidth consumption is another possible area.  If these
delta's are produced on the fly,  they could be cached in the objects
directory.

These two different use cases are IMO a good argument for
using this as a convention even if it doesn't become a part of git's
core (i.e. changing read_sha1_file to transparently expand xdelta's)

If you add .xdelta it would follow that other encodings might be useful,
and added to the objects directory in the same way.

-- 
Kris Shannon <kris.shannon.kernel@gmail.com>
