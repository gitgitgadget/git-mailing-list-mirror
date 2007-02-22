From: Andy Parkins <andyparkins@gmail.com>
Subject: git-cvsserver and binary files
Date: Thu, 22 Feb 2007 15:04:30 +0000
Message-ID: <200702221504.32848.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 22 16:04:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HKFV0-0006sN-4k
	for gcvg-git@gmane.org; Thu, 22 Feb 2007 16:04:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932160AbXBVPEk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Feb 2007 10:04:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932167AbXBVPEk
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Feb 2007 10:04:40 -0500
Received: from nf-out-0910.google.com ([64.233.182.184]:37432 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932160AbXBVPEj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Feb 2007 10:04:39 -0500
Received: by nf-out-0910.google.com with SMTP id o25so549992nfa
        for <git@vger.kernel.org>; Thu, 22 Feb 2007 07:04:38 -0800 (PST)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=XF28OPMvWwVuXNEPQMQMvbU/QSvJ1j5OP1dFLM9EAZJlhr3HUJJU2yw+JG9Fxnw49p7AYARCm1HmytPORmvuu3QrALCAgnkORguyNXetX3lFhQS7hygOVNc2J5RK31z1ERfrrMEVaQWmOehj9UUW/N1lPaLryYUhdV+zAtoqHGo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=lPX2/+3WrhCo2a52LFYLZ1DkiRkBVMIVD+8SAue6Sf2syGiJtYTKQrph+dZl3FBAsLq7Kn/wrCSnJWVbI7tNbyLeswxcrfycnxDaoRsnnYbmauUbgmYNOOXWcG1lg5CR6w6L0wpy8Ktvoq3wnlXw0uUmDHbmMAGUlR8N/XEsX1I=
Received: by 10.48.230.5 with SMTP id c5mr3703723nfh.1172156678003;
        Thu, 22 Feb 2007 07:04:38 -0800 (PST)
Received: from 360run094l ( [194.70.53.227])
        by mx.google.com with ESMTP id a23sm5979480nfc.2007.02.22.07.04.35;
        Thu, 22 Feb 2007 07:04:35 -0800 (PST)
User-Agent: KMail/1.9.5
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40349>

Hello,

A colleague of mine is using TortoiseCVS to access git-cvserver on my system 
to do development on Windows with a repository stored on my machine.

It's all gone fairly well, nice and easy to use.  However, we've found that 
images stored in the repository are being corrupted on checkout to the 
Windows machine.  Even though they are binary files, they're having the line 
endings rewritten (in a really strange way as well).

I don't think git itself is at fault; the source files are all retaining their 
original unix line endings, and the images are uncorrupted when I check them 
out.  I've done a bit of research though and found that CVS marks binary 
files in the repository, not in the client, so I assume that git-cvsserver is 
at fault.  It's telling the client side that the image files are text.

To be as close to git as possible, I reckon that git-cvsserver should be 
telling the remote that /every/ file is binary and leave the line endings 
alone (although that would perhaps annoy some windows users).  I'd much 
prefer it if what was checked out was what was checked in.  I'm at a bit of a 
loss as to how to do it though.  I don't know enough about the CVS protocol 
to know which part of git-cvsserver is telling the client the file type.

Should I even try to make all binary checkouts via CVS or should I try and use 
the auocrlf work that's going on now?




Andy
-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
