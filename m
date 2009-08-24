From: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
Subject: [PATCH] Teach mailinfo to ignore everything before -- >8 -- mark
Date: Mon, 24 Aug 2009 06:16:08 +0200
Message-ID: <20090824041608.GC3526@vidovic>
References: <1250999285-10683-1-git-send-email-git@tbfowler.name> <1250999357-10827-3-git-send-email-git@tbfowler.name> <7vvdkfx8rl.fsf@alter.siamese.dyndns.org> <20090823171819.6117@nanako3.lavabit.com> <7v1vn2yklo.fsf@alter.siamese.dyndns.org> <20090824060708.6117@nanako3.lavabit.com> <alpine.DEB.2.00.0908231705200.29625@GWPortableVCS> <7v7hwurwmu.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thell Fowler <git@tbfowler.name>,
	Nanako Shiraishi <nanako3@lavabit.com>, git@vger.kernel.org,
	Johannes.Schindelin@gmx.de
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 24 06:16:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MfQyj-0002bg-Tb
	for gcvg-git-2@lo.gmane.org; Mon, 24 Aug 2009 06:16:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751171AbZHXEQM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Aug 2009 00:16:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750933AbZHXEQM
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Aug 2009 00:16:12 -0400
Received: from mail-ew0-f207.google.com ([209.85.219.207]:50696 "EHLO
	mail-ew0-f207.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750787AbZHXEQL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Aug 2009 00:16:11 -0400
Received: by ewy3 with SMTP id 3so2043879ewy.18
        for <git@vger.kernel.org>; Sun, 23 Aug 2009 21:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:date:from:to:cc
         :subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=1W8S57XWsegg7PE1ynhj5e3Hq6cpJQMul8KwoVt7B3s=;
        b=H9uPYA38jzwyMxjw7+46vYe9jCh8u1mvKU6oLOgODDlnVCeaVefREJVWpD46fZoLE+
         g8wptOIL4Y04HhO4TguHEWmEcpcfMs1j4ifKjRBV52BheqbjjoeKAEiqDWZMq94nzz9k
         V/J+kZTGBw4Ybwtor0h/CFMjsDtHtsBltMIlQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=rbTxDzmgYibKe4L3WGWAQ7HtILxRaSgKna7jwPKhwhatHJE7m0noZ9n+mlNefCjnDL
         cQPbeXHlH84RRrzPufzeA2ccqOBy5CBsj9BccyeZvHiukC2hKrQ04/D5v0ixvh87FLoa
         aDRPolUwJHIRhNHiDmN1kglELlfPQKmj4BIe0=
Received: by 10.211.194.9 with SMTP id w9mr4357649ebp.4.1251087372799;
        Sun, 23 Aug 2009 21:16:12 -0700 (PDT)
Received: from @ (88-121-114-119.rev.libertysurf.net [88.121.114.119])
        by mx.google.com with ESMTPS id 7sm3757003eyb.37.2009.08.23.21.16.10
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 23 Aug 2009 21:16:12 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7v7hwurwmu.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126903>

Subject: [PATCH] Wong title
From: is this one really the author? <email@somebody.dom>

The 23/08/09, Junio C Hamano wrote:
> 
> >> > Subject: [PATCH] Teach mailinfo to ignore everything before -- >8 -- mark
> 
> The one I sent out had two bugs.  Please discard and replace it with a
> newer one I'll be pushing out on 'pu' later today.

( Tested against current 925bd84 in pu. )

If we have a mail with this form

  <header>
  Subject: [PATCH] BLAH ONE
  </header>

  Subject: [PATCH] BLAH TWO
  <...>
  -- >8 --
  Subject: [PATCH] BLAH THREE


the commit message looks like

    BLAH TWO
    
    Subject: [PATCH] BLAH THREE


I'd expect that we take the "Subject: " line after the mark and fallback
to the header if missing.

Same applies to the "From: " lines.

This mail should be usable to your own tests.

-- >8 -- Please squash this to 925bd84 -- >8 --

    Signed-off-by: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
---
diff --git a/Documentation/git-am.txt b/Documentation/git-am.txt
index fcacc94..0c9a791 100644
--- a/Documentation/git-am.txt
+++ b/Documentation/git-am.txt
@@ -138,6 +138,9 @@ The commit message is formed by the title taken from
the
 where the patch begins.  Excess whitespace at the end of each
 line is automatically stripped.
 
+If a line starts with a "-- >8 --" mark in the body of the message,
+everything before (and the line itself) will be ignored.
+
 The patch is expected to be inline, directly following the
 message.  Any line that is of the form:

-- 
Nicolas Sebrecht
