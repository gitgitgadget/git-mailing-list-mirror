From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 10/15] gettextize: git-notes "Refusing to %s notes in %s" message
Date: Mon,  6 Sep 2010 12:21:39 +0000
Message-ID: <1283775704-29440-11-git-send-email-avarab@gmail.com>
References: <1283638229-14199-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Jan=20Kr=C3=BCger?= <jk@jk.gs>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 06 14:23:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Osaiw-0000aR-1k
	for gcvg-git-2@lo.gmane.org; Mon, 06 Sep 2010 14:22:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753972Ab0IFMWj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Sep 2010 08:22:39 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:42959 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753721Ab0IFMWh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Sep 2010 08:22:37 -0400
Received: by mail-wy0-f174.google.com with SMTP id 22so2884659wyf.19
        for <git@vger.kernel.org>; Mon, 06 Sep 2010 05:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=teE+m5mPt2C7CprH4d9UnPjkudA60vZaVM27dnIdvYM=;
        b=CTuuxHJry1RrY8tkamyGb0lLX2pK0KMHUqnm8luRfuEYlAg3ik+vCbLZbqoajNOmQ3
         tfxZc0IMnuIzxwC7cGg2AaexZrxQ/KOllZNyHM/jPDf7zMZaFoixtXEd7BA0Sgo7Av3M
         NZUoNeZBHQow46mWr+zKwKy0pFpdAmcC40nDY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=aMOxWxATMepRGx8ebglo2pLBUHInien4qTMNa9byEyi8TDVp0Zwh9Bv+msK0qWKLo8
         DiCr5ZGtgaCxDrVGMR8Wb+vTb7etE0qjeE2j9HnumtQup6kqbyQvb03INxH+fq3btTaV
         +4VqIlGsEd90+TxOwM1pO+xZrhP+k8RQobOAE=
Received: by 10.216.67.6 with SMTP id i6mr510238wed.44.1283775756618;
        Mon, 06 Sep 2010 05:22:36 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id p82sm3297372weq.3.2010.09.06.05.22.35
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 06 Sep 2010 05:22:35 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.3.313.gcd15
In-Reply-To: <1283638229-14199-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155559>

The first %s in "Refusing to %s notes in %s" is one of "git notes
ACTION". So we need to mark those actions for translation and later
use _().

Also add a TRANSLATORS comment explaining to translators what the
first %s means.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 builtin/notes.c |   18 ++++++++++--------
 1 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/builtin/notes.c b/builtin/notes.c
index fe58a41..2b417d7 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -476,8 +476,10 @@ static struct notes_tree *init_notes_check(const c=
har *subcommand)
 	t =3D &default_notes_tree;
=20
 	if (prefixcmp(t->ref, "refs/notes/"))
-		die("Refusing to %s notes in %s (outside of refs/notes/)",
-		    subcommand, t->ref);
+		/* TRANSLATORS: The first %s is one of "git notes ACTION",
+		   e.g. "add", "copy", "append" etc. */
+		die(_("Refusing to %s notes in %s (outside of refs/notes/)"),
+		    _(subcommand), t->ref);
 	return t;
 }
=20
@@ -500,7 +502,7 @@ static int list(int argc, const char **argv, const =
char *prefix)
 		usage_with_options(git_notes_list_usage, options);
 	}
=20
-	t =3D init_notes_check("list");
+	t =3D init_notes_check(N_("list"));
 	if (argc) {
 		if (get_sha1(argv[0], object))
 			die(_("Failed to resolve '%s' as a valid ref."), argv[0]);
@@ -557,7 +559,7 @@ static int add(int argc, const char **argv, const c=
har *prefix)
 	if (get_sha1(object_ref, object))
 		die(_("Failed to resolve '%s' as a valid ref."), object_ref);
=20
-	t =3D init_notes_check("add");
+	t =3D init_notes_check(N_("add"));
 	note =3D get_note(t, object);
=20
 	if (note) {
@@ -633,7 +635,7 @@ static int copy(int argc, const char **argv, const =
char *prefix)
 	if (get_sha1(object_ref, object))
 		die(_("Failed to resolve '%s' as a valid ref."), object_ref);
=20
-	t =3D init_notes_check("copy");
+	t =3D init_notes_check(N_("copy"));
 	note =3D get_note(t, object);
=20
 	if (note) {
@@ -749,7 +751,7 @@ static int show(int argc, const char **argv, const =
char *prefix)
 	if (get_sha1(object_ref, object))
 		die(_("Failed to resolve '%s' as a valid ref."), object_ref);
=20
-	t =3D init_notes_check("show");
+	t =3D init_notes_check(N_("show"));
 	note =3D get_note(t, object);
=20
 	if (!note)
@@ -785,7 +787,7 @@ static int remove_cmd(int argc, const char **argv, =
const char *prefix)
 	if (get_sha1(object_ref, object))
 		die(_("Failed to resolve '%s' as a valid ref."), object_ref);
=20
-	t =3D init_notes_check("remove");
+	t =3D init_notes_check(N_("remove"));
=20
 	fprintf(stderr, _("Removing note for object %s\n"), sha1_to_hex(objec=
t));
 	remove_note(t, object);
@@ -814,7 +816,7 @@ static int prune(int argc, const char **argv, const=
 char *prefix)
 		usage_with_options(git_notes_prune_usage, options);
 	}
=20
-	t =3D init_notes_check("prune");
+	t =3D init_notes_check(N_("prune"));
=20
 	prune_notes(t, (verbose ? NOTES_PRUNE_VERBOSE : 0) |
 		(show_only ? NOTES_PRUNE_VERBOSE|NOTES_PRUNE_DRYRUN : 0) );
--=20
1.7.2.3.313.gcd15
