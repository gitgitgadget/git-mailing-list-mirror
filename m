From: Wolfgang Denk <wd@denx.de>
Subject: Re: cg-clone not fetching all tags?
Date: Sun, 30 Apr 2006 15:48:40 +0200
Message-ID: <20060430134840.0027C353B12@atlas.denx.de>
References: <7vaca31z50.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, pasky@suse.cz
X-From: git-owner@vger.kernel.org Sun Apr 30 15:48:54 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FaCIA-0006I4-0w
	for gcvg-git@gmane.org; Sun, 30 Apr 2006 15:48:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751124AbWD3Nsp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 30 Apr 2006 09:48:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751125AbWD3Nsp
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Apr 2006 09:48:45 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:20647 "EHLO
	mail-out.m-online.net") by vger.kernel.org with ESMTP
	id S1751124AbWD3Nso (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Apr 2006 09:48:44 -0400
Received: from mail01.m-online.net (svr21.m-online.net [192.168.3.149])
	by mail-out.m-online.net (Postfix) with ESMTP id A0C7470F7A;
	Sun, 30 Apr 2006 15:48:43 +0200 (CEST)
X-Auth-Info: cJxOa72LjSyMRBF4Fhpk64iyEjA7SIScsp740olvN3Y=
X-Auth-Info: cJxOa72LjSyMRBF4Fhpk64iyEjA7SIScsp740olvN3Y=
X-Auth-Info: cJxOa72LjSyMRBF4Fhpk64iyEjA7SIScsp740olvN3Y=
Received: from mail.denx.de (p54966123.dip.t-dialin.net [84.150.97.35])
	by smtp-auth.mnet-online.de (Postfix) with ESMTP id 8968991BF5;
	Sun, 30 Apr 2006 15:48:43 +0200 (CEST)
Received: from atlas.denx.de (atlas.denx.de [10.0.0.14])
	by mail.denx.de (Postfix) with ESMTP id 1B09C6D00A8;
	Sun, 30 Apr 2006 15:48:43 +0200 (CEST)
Received: from atlas.denx.de (localhost.localdomain [127.0.0.1])
	by atlas.denx.de (Postfix) with ESMTP id 0027C353B12;
	Sun, 30 Apr 2006 15:48:40 +0200 (MEST)
To: Junio C Hamano <junkio@cox.net>
In-reply-to: Your message of "Sat, 29 Apr 2006 21:11:07 PDT."
             <7vaca31z50.fsf@assigned-by-dhcp.cox.net> 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19338>

Dear Junio,

in message <7vaca31z50.fsf@assigned-by-dhcp.cox.net> you wrote:
> 
> I suspect there is no need to manufacture the tag.  Something
> like this should do.

Great! Thanks a lot.

> *WARNING* Since I do not do Porcelain, and I am not a Cogito
> user, this is obviously untested.  In addition, I am seriously
> drunk right now... 

Good enough. This one actually works:

> -- >8 --
> [PATCH] (cogito) Auto-follow lightweight tags as well.


--- a/cg-fetchG	2006-04-10 19:14:14.000000000 +0200
+++ b/cg-fetch	2006-04-30 14:35:03.000000000 +0200
@@ -211,7 +211,8 @@
 	git-ls-remote --tags "$uri" |
 		# SHA1 refs/tags/v0.99.8^{} --> SHA1 tags/v0.99.8
 		# where SHA1 is the object v0.99.8 tag points at.
-		sed -ne 's:\([^	]\)	refs/\(tags/.*\)^{}$:\1 \2:p' |
+		sed -n -e 's:\([^	]\)	refs/\(tags/.*\)^{}$:\1 \2:p' \
+		       -e 's:\([^	]\)	refs/\(tags/.*\)$:\1 \2:p' | \
 		while read sha1 tagname; do
 			# Do we have the tag itself?
 			[ -s "$_git/refs/$tagname" ] && continue


Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
It's hard to think of you as the end result of millions of  years  of
evolution.
