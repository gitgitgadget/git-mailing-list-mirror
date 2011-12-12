From: Conrad Irwin <conrad.irwin@gmail.com>
Subject: =?UTF-8?q?=5BPATCH=5D=20Update=20documentation=20for=20stripspace?=
Date: Mon, 12 Dec 2011 15:52:51 -0800
Message-ID: <1323733971-12495-1-git-send-email-conrad.irwin@gmail.com>
References: <7vwra1z7bg.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Conrad Irwin <conrad.irwin@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 13 00:53:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RaFgW-0000GC-Ec
	for gcvg-git-2@lo.gmane.org; Tue, 13 Dec 2011 00:53:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754517Ab1LLXxU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 12 Dec 2011 18:53:20 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:50142 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753577Ab1LLXxS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Dec 2011 18:53:18 -0500
Received: by iaeh11 with SMTP id h11so3871505iae.19
        for <git@vger.kernel.org>; Mon, 12 Dec 2011 15:53:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=fDCcGFNVRGid47x2i1udF7iN0H6lhRD7+0aPjy3hHxQ=;
        b=NTkJJ2i26n1A9zvHMumeeDgjkzRY0G6mIrZgQH5++zp6gLX0gjZtm2/aXHXXmNx3+Q
         jjhuEpuGUfZDv+giHUKCtEf5YH07eiz2k3lbEPlFil/2151pL9LQR/ICuyR+x3YTaBxO
         n7znnBlK0PTomDw4YudIiegeGx8NRcA5/kSA4=
Received: by 10.50.17.168 with SMTP id p8mr17127048igd.20.1323733997770;
        Mon, 12 Dec 2011 15:53:17 -0800 (PST)
Received: from monteverdi.rapportive.com (173-228-114-254.static.sonic.net. [173.228.114.254])
        by mx.google.com with ESMTPS id py9sm31761395igc.2.2011.12.12.15.53.16
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 12 Dec 2011 15:53:17 -0800 (PST)
X-Mailer: git-send-email 1.7.8.164.g00d7e
In-Reply-To: <7vwra1z7bg.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186978>

2011/12/12 Junio C Hamano <gitster@pobox.com>:
> Conrad Irwin <conrad.irwin@gmail.com> writes:
>> I've moved the *NOTE* into a SEE ALSO section where I think it reads
>> less opinionatedly =E2=80=95 is that better?
>
> I think it looks a lot worse.
[snip]
>
> The new example section looks good. Perhaps we can just drop the extr=
a SEE
> ALSO and resurrect the *NOTE* from your v1 patch.
>
> Thanks.

Done.

Conrad

---8<---

Tell the user what this command is intended for, and expand the
description of what it does.

Signed-off-by: Conrad Irwin <conrad.irwin@gmail.com>
---
 Documentation/git-stripspace.txt |   69 ++++++++++++++++++++++++++++++=
++++---
 builtin/stripspace.c             |    2 +-
 2 files changed, 64 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-stripspace.txt b/Documentation/git-strip=
space.txt
index b78f031..a548444 100644
--- a/Documentation/git-stripspace.txt
+++ b/Documentation/git-stripspace.txt
@@ -3,26 +3,83 @@ git-stripspace(1)
=20
 NAME
 ----
-git-stripspace - Filter out empty lines
+git-stripspace - Remove unnecessary whitespace
=20
=20
 SYNOPSIS
 --------
 [verse]
-'git stripspace' [-s | --strip-comments] < <stream>
+'git stripspace' [-s | --strip-comments] < input
=20
 DESCRIPTION
 -----------
-Remove multiple empty lines, and empty lines at beginning and end.
+
+Clean the input in the manner used by 'git' for text such as commit
+messages, notes, tags and branch descriptions.
+
+With no arguments, this will:
+
+- remove trailing whitespace from all lines
+- collapse multiple consecutive empty lines into one empty line
+- remove empty lines from the beginning and end of the input
+- add a missing '\n' to the last line if necessary.
+
+In the case where the input consists entirely of whitespace characters=
, no
+output will be produced.
+
+*NOTE*: This is intended for cleaning metadata, prefer the `--whitespa=
ce=3Dfix`
+mode of linkgit:git-apply[1] for correcting whitespace of patches or f=
iles in
+the repository.
=20
 OPTIONS
 -------
 -s::
 --strip-comments::
-	In addition to empty lines, also strip lines starting with '#'.
+	Skip and remove all lines starting with '#'.
+
+EXAMPLES
+--------
+
+Given the following noisy input with '$' indicating the end of a line:
=20
-<stream>::
-	Byte stream to act on.
+--------
+|A brief introduction   $
+|   $
+|$
+|A new paragraph$
+|# with a commented-out line    $
+|explaining lots of stuff.$
+|$
+|# An old paragraph, also commented-out. $
+|      $
+|The end.$
+|  $
+---------
+
+Use 'git stripspace' with no arguments to obtain:
+
+--------
+|A brief introduction$
+|$
+|A new paragraph$
+|# with a commented-out line$
+|explaining lots of stuff.$
+|$
+|# An old paragraph, also commented-out.$
+|$
+|The end.$
+---------
+
+Use 'git stripspace --strip-comments' to obtain:
+
+--------
+|A brief introduction$
+|$
+|A new paragraph$
+|explaining lots of stuff.$
+|$
+|The end.$
+---------
=20
 GIT
 ---
diff --git a/builtin/stripspace.c b/builtin/stripspace.c
index 1288ffc..f16986c 100644
--- a/builtin/stripspace.c
+++ b/builtin/stripspace.c
@@ -75,7 +75,7 @@ int cmd_stripspace(int argc, const char **argv, const=
 char *prefix)
 				!strcmp(argv[1], "--strip-comments")))
 		strip_comments =3D 1;
 	else if (argc > 1)
-		usage("git stripspace [-s | --strip-comments] < <stream>");
+		usage("git stripspace [-s | --strip-comments] < input");
=20
 	if (strbuf_read(&buf, 0, 1024) < 0)
 		die_errno("could not read the input");
--=20
1.7.8.164.g00d7e
