From: =?iso-8859-1?Q?Sidney_San_Mart=EDn?= <s@sidneysm.com>
Subject: Question about commit message wrapping
Date: Thu, 8 Dec 2011 20:59:06 -0500
Message-ID: <35A5A513-91FD-4EF9-B890-AB3D1550D63F@sidneysm.com>
Mime-Version: 1.0 (Apple Message framework v1251.1)
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 09 02:59:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RYpk8-0005Iw-Qd
	for gcvg-git-2@lo.gmane.org; Fri, 09 Dec 2011 02:59:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754150Ab1LIB7L convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 8 Dec 2011 20:59:11 -0500
Received: from mail-qw0-f53.google.com ([209.85.216.53]:56415 "EHLO
	mail-qw0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751454Ab1LIB7H convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 8 Dec 2011 20:59:07 -0500
Received: by qadb15 with SMTP id b15so2368684qad.19
        for <git@vger.kernel.org>; Thu, 08 Dec 2011 17:59:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sidneysm.com; s=google;
        h=from:content-type:content-transfer-encoding:subject:date:message-id
         :to:mime-version:x-mailer;
        bh=XIJlxvIDV4dZiRkc5QQYpshlfEGe4txNVoE3ajXsqM4=;
        b=C6p5VjSB4T7jV4L6hmkB5ypJyFnmhQ+wKSNSW2ZoRdzZrg4ujMtyIuYOKqM7a9x8fz
         REPfPMtx1LbHVBtPx/BgsIfEP4rqRoUj1Qffe7nErbpBNNYRC/RQlr6u5tEqSKa7gmGZ
         TJ8XozWoIU4oXWlJRMos8f5Sw8qS6C+zNCccA=
Received: by 10.224.192.10 with SMTP id do10mr5269011qab.50.1323395947030;
        Thu, 08 Dec 2011 17:59:07 -0800 (PST)
Received: from [192.168.1.5] (ool-43536f0d.dyn.optonline.net. [67.83.111.13])
        by mx.google.com with ESMTPS id ha3sm13433962qab.2.2011.12.08.17.59.05
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 08 Dec 2011 17:59:06 -0800 (PST)
X-Mailer: Apple Mail (2.1251.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186604>

Hey, I want to ask about the practice of wrapping commit messages to 70=
-something charaters.

The webpage most cited about it, which I otherwise really like, is

	http://tbaggery.com/2008/04/19/a-note-about-git-commit-messages.html

*Nothing else* in my everyday life works this way anymore. Line wrappin=
g gets done on the display end in my email client, my web browser, my e=
book reader entirely automatically, and it adapts to the size of the wi=
ndow.

That article gives two reasons why commits should be wrapped to 72 colu=
mns. First:

> git log doesn=92t do any special special wrapping of the commit messa=
ges. With the default pager of less -S, this means your paragraphs flow=
 far off the edge of the screen, making them difficult to read. On an 8=
0 column terminal, if we subtract 4 columns for the indent on the left =
and 4 more for symmetry on the right, we=92re left with 72 columns.

Here, I put a patch at the bottom of this email that wraps commit messa=
ges to, right now, 80 columns when they're displayed. (It=92s a quick o=
ne, probably needs configurability. Also, beware, I don=92t program in =
C too much.)

Second:

> git format-patch --stdout converts a series of commits to a series of=
 emails, using the messages for the message body. Good email netiquette=
 dictates we wrap our plain text emails such that there=92s room for a =
few levels of nested reply indicators without overflow in an 80 column =
terminal. (The current rails.git workflow doesn=92t include email, but =
who knows what the future will bring.)

There's been a standard for flowed plain text emails (which don't have =
to wrap at 80 columns) for well over ten years, RFC-2646 and is widely =
supported. Besides, code in diffs is often longer than 7x characters, a=
nd wrapping, like `git log`, could be done inside git. FWIW, there are =
a bunch of merge commits with lines longer than 80 characters in the gi=
t repo itself.

=46inally, people read commits these days in many other places than `gi=
t log` (and make commits in many other places than a text editor config=
ured to wrap). Most every GUI and already word wraps commit messages ju=
st fine. As a result, there are commits in popular repos much longer th=
an the 72-column standard and no one notices. Instead, properly-formatt=
ed commit messages end up looking cramped when you see them in anywhere=
 wider than 80 columns.

Am I crazy? If this makes sense to anyone else, I'd be happy to help ma=
ssage this into something git-worthy, with some help (never worked on G=
it before).

- - -

=46rom a93b390d1506652d4ad41d1cbd987ba98a8deca0 Mon Sep 17 00:00:00 200=
1
=46rom: =3D?UTF-8?q?Sidney=3D20San=3D20Marti=3DCC=3D81n?=3D <s@sidneysm=
=2Ecom>
Date: Thu, 8 Dec 2011 20:26:23 -0500
Subject: [PATCH] Wrap commit messages on display

- Wrap to 80 characters minus the indent
- Use a hanging indent for lines which begin with "- "
- Do not wrap lines which begin with whitespace
---
 pretty.c |   10 ++++++++--
 1 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/pretty.c b/pretty.c
index 230fe1c..15804ce 100644
--- a/pretty.c
+++ b/pretty.c
@@ -1243,8 +1243,14 @@ void pp_remainder(const struct pretty_print_cont=
ext *pp,
 			memset(sb->buf + sb->len, ' ', indent);
 			strbuf_setlen(sb, sb->len + indent);
 		}
-		strbuf_add(sb, line, linelen);
-		strbuf_addch(sb, '\n');
+		if (line[0] =3D=3D ' ' || line[0] =3D=3D '\t') {
+			strbuf_add(sb, line, linelen);
+		} else {
+			struct strbuf wrapped =3D STRBUF_INIT;
+			strbuf_add(&wrapped, line, linelen);
+			strbuf_add_wrapped_text(sb, wrapped.buf, 0, indent + (line[0] =3D=3D=
 '-' && line[1] =3D=3D ' ' ? 2 : 0), 80 - indent);
+			strbuf_addch(sb, '\n');
+		}
 	}
 }
=20
--=20
1.7.8