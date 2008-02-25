From: =?utf-8?q?Santi=20B=C3=A9jar?= <sbejar@gmail.com>
Subject: [PATCH] Teach git-describe --long to output always the long format
Date: Mon, 25 Feb 2008 10:43:33 +0100
Message-ID: <1203932613-7759-1-git-send-email-sbejar@gmail.com>
References: <1203864412-27977-1-git-send-email-sbejar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?q?Santi=20B=C3=A9jar?= <sbejar@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 25 10:44:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JTZsl-0001FZ-4H
	for gcvg-git-2@gmane.org; Mon, 25 Feb 2008 10:44:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751010AbYBYJnr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 25 Feb 2008 04:43:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750913AbYBYJnq
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Feb 2008 04:43:46 -0500
Received: from fk-out-0910.google.com ([209.85.128.189]:11524 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750763AbYBYJnp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Feb 2008 04:43:45 -0500
Received: by fk-out-0910.google.com with SMTP id z23so2096487fkz.5
        for <git@vger.kernel.org>; Mon, 25 Feb 2008 01:43:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references:mime-version:content-type:content-transfer-encoding;
        bh=/bfwdCt8ge7N8VMPr4SdH0tj3zLHwRBzezfSQpN8e9c=;
        b=GzgLxaw08gMWTWiTvxtgYKMzu+ymAjx2xGpkDzdKWW8Jl7Ch/tsckM/pLGgB3nBIRgZES2oQkaHBRa8ng+mzjTExvKGPCogrZzOJ3JrSCLtnYWsbFIzkNvAbsAtuZzv4JA1lSkxoXDa6RIT7cSMAG3MUpsY+3wptFhPs69bZM9k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references:mime-version:content-type:content-transfer-encoding;
        b=Rm3T8DyVDfd+l4tMLNBv2nmysi7mplXJeOQtE4KHILn5fIXxCDMhUauHWY8qm8I/+mjKI6vuOewFGqtreMrQ37UdHXKdrgTbHufd3JAFv4aMq+XePerRG6wxVzvbBoTek4OUu6P0PuEI0atubZZituV1BUllT0AfoTPVbnTuWzA=
Received: by 10.82.134.12 with SMTP id h12mr5321590bud.34.1203932620798;
        Mon, 25 Feb 2008 01:43:40 -0800 (PST)
Received: from localhost ( [91.13.105.170])
        by mx.google.com with ESMTPS id f31sm7661271fkf.15.2008.02.25.01.43.37
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 25 Feb 2008 01:43:38 -0800 (PST)
X-Mailer: git-send-email 1.5.4.3.293.gac81
In-Reply-To: <1203864412-27977-1-git-send-email-sbejar@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75020>

This can be useful when more than one person can make "official" tags
(or nobody), but you want unique identifiers with a descriptive
name. Or when parsing git-describe output if you want to avoid
hardcoding the information about the form of tags in a project
(tags can, and sometimes do, contain '-').

Signed-off-by: Santi B=C3=A9jar <sbejar@gmail.com>
---
Hi,

  this time with documentation and usecases (thanks Jakub)

Santi

 Documentation/git-describe.txt |    9 +++++++++
 builtin-describe.c             |   11 ++++++++++-
 t/t6120-describe.sh            |    2 ++
 3 files changed, 21 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-describe.txt b/Documentation/git-describ=
e.txt
index 1c3dfb4..f46fbdd 100644
--- a/Documentation/git-describe.txt
+++ b/Documentation/git-describe.txt
@@ -51,6 +51,15 @@ OPTIONS
 	being employed to standard error.  The tag name will still
 	be printed to standard out.
=20
+--long::
+	Always output the long format (the tag, the number of commits
+	and the abbreviated commit name) even when it matches a tag.
+	This can be useful when more than one person can make "official" tags
+	(or nobody), but you want unique identifiers with a descriptive
+	name. Or when parsing git-describe output if you want to avoid
+	hardcoding the information about the form of tags in a project
+	(tags can, and sometimes do, contain '-').
+
 --match <pattern>::
 	Only consider tags matching the given pattern (can be used to avoid
 	leaking private tags made from the repository).
diff --git a/builtin-describe.c b/builtin-describe.c
index 3428483..3fd2e73 100644
--- a/builtin-describe.c
+++ b/builtin-describe.c
@@ -17,6 +17,7 @@ static const char * const describe_usage[] =3D {
 static int debug;	/* Display lots of verbose info */
 static int all;	/* Default to annotated tags only */
 static int tags;	/* But allow any tags if --tags is specified */
+static int longformat;
 static int abbrev =3D DEFAULT_ABBREV;
 static int max_candidates =3D 10;
 const char *pattern =3D NULL;
@@ -155,7 +156,11 @@ static void describe(const char *arg, int last_one=
)
=20
 	n =3D cmit->util;
 	if (n) {
-		printf("%s\n", n->path);
+		if (!longformat)
+			printf("%s\n", n->path);
+		else
+			printf("%s-0-g%s\n", n->path,
+				find_unique_abbrev(cmit->object.sha1, abbrev));
 		return;
 	}
=20
@@ -254,6 +259,7 @@ int cmd_describe(int argc, const char **argv, const=
 char *prefix)
 		OPT_BOOLEAN(0, "debug",      &debug, "debug search strategy on stder=
r"),
 		OPT_BOOLEAN(0, "all",        &all, "use any ref in .git/refs"),
 		OPT_BOOLEAN(0, "tags",       &tags, "use any tag in .git/refs/tags")=
,
+		OPT_BOOLEAN(0, "long",       &longformat, "always use long format"),
 		OPT__ABBREV(&abbrev),
 		OPT_INTEGER(0, "candidates", &max_candidates,
 			    "consider <n> most recent tags (default: 10)"),
@@ -270,6 +276,9 @@ int cmd_describe(int argc, const char **argv, const=
 char *prefix)
=20
 	save_commit_buffer =3D 0;
=20
+	if (longformat && abbrev =3D=3D 0)
+		die("--long is incompatible with --abbrev=3D0");
+
 	if (contains) {
 		const char **args =3D xmalloc((6 + argc) * sizeof(char*));
 		int i =3D 0;
diff --git a/t/t6120-describe.sh b/t/t6120-describe.sh
index ae8ee11..a7557bd 100755
--- a/t/t6120-describe.sh
+++ b/t/t6120-describe.sh
@@ -94,4 +94,6 @@ check_describe D-* --tags HEAD^^
 check_describe A-* --tags HEAD^^2
 check_describe B --tags HEAD^^2^
=20
+check_describe B-0-* --long HEAD^^2^
+
 test_done
--=20
1.5.4.3.293.gac81
