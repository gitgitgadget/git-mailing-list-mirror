From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC PATCH] GIT-VERSION-GEN: restrict tags used
Date: Tue, 11 May 2010 18:05:42 -0500
Message-ID: <20100511230542.GC31163@progeny.tock>
References: <1273599198-1008-1-git-send-email-rctay89@gmail.com>
 <20100511230100.GB31163@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 12 01:05:37 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OByW9-0004dK-0U
	for gcvg-git-2@lo.gmane.org; Wed, 12 May 2010 01:05:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753752Ab0EKXFc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 11 May 2010 19:05:32 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:33479 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751693Ab0EKXFa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 May 2010 19:05:30 -0400
Received: by gyg13 with SMTP id 13so3036841gyg.19
        for <git@vger.kernel.org>; Tue, 11 May 2010 16:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=kyV4+OI8ALHwAOnF/Cz70+gLnIzD0d8vp+/0zYX9rF0=;
        b=Fnag9mqJ/gxfnokhnnB7WpK84V54SC35rc4I+LiJTWRPWZuA2bzB4v6rjL9aaLfU3U
         mnTwsbdSgxC2N2bD3fZIC0w3dEnbZkmRmRcN0dPEiVKRNdEV6D4jPmzjD1tdr8NkOhHQ
         arY+Ok4yqFwhvyFG9ocgFVnoALpfLv+kxWINg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=q39eTRfbPz/mWy0I/9XiN5URiz7Mx/GMTlnCMCJ67P4cdcXo1ig+QwJAAbafrYuQlo
         pMkVThYWdGD4WIz7qdqTYM5GZl7/milUN814UONJA5zQD0IQl4dLzt3PNjr2mjJUUPlx
         GPzHL0eC8WDwAhB0+19EYmFRn70vSJq59KugQ=
Received: by 10.231.166.77 with SMTP id l13mr4174900iby.63.1273619129099;
        Tue, 11 May 2010 16:05:29 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id k10sm1159705ibu.7.2010.05.11.16.05.27
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 11 May 2010 16:05:28 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100511230100.GB31163@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146911>

Jonathan Nieder wrote:
> Tay Ray Chuan wrote:

>> since git's tags for git-core (ie. excluding git-gui)
>> are all of the form "vX.Y...".
>
> git gui=E2=80=99s too, now.

Aggh --- sent early, there.  Here is what I meant to say.

Shawn, this helps avoid any stray (annotated) tags the user may have
made, following Tay=E2=80=99s example.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
diff --git a/GIT-VERSION-GEN b/GIT-VERSION-GEN
index b3f937e..d6a6601 100755
--- a/GIT-VERSION-GEN
+++ b/GIT-VERSION-GEN
@@ -13,7 +13,7 @@ tree_search ()
 	for p in $(git rev-list --parents --max-count=3D1 $head 2>/dev/null)
 	do
 		test $tree =3D $(git rev-parse $p^{tree} 2>/dev/null) &&
-		vn=3D$(git describe --abbrev=3D4 $p 2>/dev/null) &&
+		vn=3D$(git describe --match=3Dgitgui-[0-9]* --abbrev=3D4 $p 2>/dev/n=
ull) &&
 		case "$vn" in
 		gitgui-[0-9]*) echo $vn; break;;
 		esac
--=20
