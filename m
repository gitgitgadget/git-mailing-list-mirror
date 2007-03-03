From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: [PATCH] Remove use of git-rev-parse and replace git-rev-list --pretty with git-log
Date: Sat, 3 Mar 2007 08:25:16 +0000
Message-ID: <200703030825.18378.andyparkins@gmail.com>
References: <Pine.LNX.4.64.0703020839350.3953@woody.linux-foundation.org> <200703021929.20969.andyparkins@gmail.com> <7vbqjbdyxc.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 03 09:28:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HNPbC-0001yv-D7
	for gcvg-git@gmane.org; Sat, 03 Mar 2007 09:28:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751250AbXCCI2K (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 3 Mar 2007 03:28:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751253AbXCCI2K
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Mar 2007 03:28:10 -0500
Received: from ug-out-1314.google.com ([66.249.92.170]:2547 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751250AbXCCI2I (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Mar 2007 03:28:08 -0500
Received: by ug-out-1314.google.com with SMTP id 44so891021uga
        for <git@vger.kernel.org>; Sat, 03 Mar 2007 00:28:07 -0800 (PST)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=j1VsmJl853MscKeCBaSSaG4JinzeOFX9UCiDkUZERnEzZAN8CZiCpS9Xl8ls3Qq9KpBrtBP2tDfQqas8G5c+B3D0tVwXNDYrCV6FjR+jSdKF6DwoErJ7KRgF3SdvWcVbC2AENWl8qtaBDaU+FfqakJqRGL/h5kd17Cb/WMKPrL0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=SrsJEUutAcPTwKKtNigPMCIOvgE+fN8zgj38L9iFCo+xuE2vYI3SUSstzY8Bm+y9cft38g/VlS571JAikC6Z4AJITUDTbGe87yZfh2M4fUSl9T2b4BkvmGCWnscMzeAj6ZS0/bYqv1/+egA3KjUPA7U1j1M4DYbNy6GDpKOOYgA=
Received: by 10.67.92.1 with SMTP id u1mr4939498ugl.1172910487053;
        Sat, 03 Mar 2007 00:28:07 -0800 (PST)
Received: from grissom.internal.parkins.org.uk ( [84.201.153.164])
        by mx.google.com with ESMTP id b35sm3968855ugd.2007.03.03.00.28.04;
        Sat, 03 Mar 2007 00:28:05 -0800 (PST)
User-Agent: KMail/1.9.6
In-Reply-To: <7vbqjbdyxc.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41277>

On Friday 2007, March 02, Junio C Hamano wrote:

> Please look at your Subject: line above and ponder how it would
> look in the next issue of "What's cooking in git.git".  Do I
> have to spend extra brain cycles to go back to "git log --stat"
> and realize that this one only updates a sample hook script?

Apologies.  It's easy to drop into focusing narrowly on on your own 
patch and forget about the larger picture.

> Also, please don't do "--- >8 ---".  If you want to, please use
> two dashes; this is purely for technical reasons.

I'm happy to comply of course.  However, this seems like a bug in git to 
me.  This makes it so that some content is not allowed in a log 
message, which seems very much out of keeping with git's normal "I can 
handle anything" stance.

Finding the "---" separator between diff and log message could at least 
rely on finding "---" alone on a line so that "--- something else" 
wouldn't trigger the end of log?

I assume this is too simple?

diff --git a/builtin-mailinfo.c b/builtin-mailinfo.c
index 766a37e..4e0795a 100644
--- a/builtin-mailinfo.c
+++ b/builtin-mailinfo.c
@@ -670,7 +670,7 @@ static int handle_commit_msg(int *seen)
        return 0;
    do {
        if (!memcmp("diff -", line, 6) ||
-           !memcmp("---", line, 3) ||
+           !memcmp("---\n", line, 4) ||
            !memcmp("Index: ", line, 7))
            break;
        if ((multipart_boundary[0] && is_multipart_boundary(line))) {

> I'll massage the log message and move "^$base --not" around as
> Linus suggested, but next time please be a bit more careful.

I will try.  Once again, my apologies.



Andy
-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
