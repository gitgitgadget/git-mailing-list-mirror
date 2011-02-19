From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 05/72] gettextize: git-init "Initialized [...] repository" message
Date: Sat, 19 Feb 2011 19:23:48 +0000
Message-ID: <1298143495-3681-6-git-send-email-avarab@gmail.com>
References: <1298143495-3681-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 19 20:25:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PqsR3-0001pR-NH
	for gcvg-git-2@lo.gmane.org; Sat, 19 Feb 2011 20:25:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755840Ab1BSTZd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 19 Feb 2011 14:25:33 -0500
Received: from mail-ew0-f46.google.com ([209.85.215.46]:42684 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755776Ab1BSTZc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Feb 2011 14:25:32 -0500
Received: by ewy5 with SMTP id 5so1970000ewy.19
        for <git@vger.kernel.org>; Sat, 19 Feb 2011 11:25:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=AJOnnXJfVIn4P1N6q6bOoQSexh39InklSjPiW16LZxk=;
        b=s1QFvqZlZ7Lv3V0UDe57Fmkg7eaSx/orIWyY6WL3Wp8YQK4YDblrUE3Bk+HbRn3VOK
         xNFB1kUEBuzGO65nmM3VU/1TvBnShLYT3hAD36hurZq4mngO43HRxYXlD1MUDcadT59Q
         pmbsgEZP9jSV4ngbU+JNMv+ugcBh9hz9CebUc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=QPBcAof1l9do8LAwUQaPXcWEAyTsKcc2KKI6xKxQhSTh6pv//3/ITFtyyyrGpvHlff
         8NWqSwecagBaEhlCID6VVez7Ix8tgTCy1OVgYuj6Dzj0AVunt+hz8drz0UONMz9maKmf
         IFmEFKD1Ikx+w1jtsnFMJr6ilcsk6tSXn8vbo=
Received: by 10.213.15.135 with SMTP id k7mr2531602eba.26.1298143531502;
        Sat, 19 Feb 2011 11:25:31 -0800 (PST)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id b52sm3205790eei.7.2011.02.19.11.25.30
        (version=SSLv3 cipher=OTHER);
        Sat, 19 Feb 2011 11:25:30 -0800 (PST)
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1298143495-3681-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167310>

Change the git-init "Initialized empty Git repository" message and its
variants to use gettext.

This is one of the messages that could do with splitting up, I had a
WIP patch to do that that began like this:

    const char *reinit_shared   =3D _("Reinitialized existing shared Gi=
t repository in %s\n");
    const char *init_shared	    =3D _("Initialized empty shared Git rep=
ository in %s\n");
    const char *reinit_noshared =3D _("Reinitialized existing Git repos=
itory in %s\n");
    const char *init_noshared   =3D _("Initialized empty Git repository=
 in %s\n");

But in the first round of gettextization I'm aiming to keep code
changes to a minimum for ease of review.

We can solicit input from translators about which messages that use
too much sprintf-ing are troublesome, and change those later.

Note that the TRANSLATORS comment doesn't use the usual Git
style. This is because everything from "/* TRANSLATORS: " to "*/" will
extracted as-is xgettext(1) and presented to translators, including
newlines and leading "*"'s. There seems to be no way to change that,
short of patching xgettext itself.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 builtin/init-db.c |   10 +++++++---
 t/t0001-init.sh   |    2 +-
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/builtin/init-db.c b/builtin/init-db.c
index 35f9f13..67462ad 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -354,9 +354,13 @@ int init_db(const char *template_dir, unsigned int=
 flags)
 	if (!(flags & INIT_DB_QUIET)) {
 		const char *git_dir =3D get_git_dir();
 		int len =3D strlen(git_dir);
-		printf("%s%s Git repository in %s%s\n",
-		       reinit ? "Reinitialized existing" : "Initialized empty",
-		       shared_repository ? " shared" : "",
+
+		/* TRANSLATORS: The first '%s' is either "Reinitialized
+		   existing" or "Initialized empty", the second " shared" or
+		   "", and the last '%s%s' is the verbatim directory name. */
+		printf(_("%s%s Git repository in %s%s\n"),
+		       reinit ? _("Reinitialized existing") : _("Initialized empty")=
,
+		       shared_repository ? _(" shared") : "",
 		       git_dir, len && git_dir[len-1] !=3D '/' ? "/" : "");
 	}
=20
diff --git a/t/t0001-init.sh b/t/t0001-init.sh
index f684993..4235ad4 100755
--- a/t/t0001-init.sh
+++ b/t/t0001-init.sh
@@ -180,7 +180,7 @@ test_expect_success 'GIT_DIR & GIT_WORK_TREE (2)' '
 	fi
 '
=20
-test_expect_success 'reinit' '
+test_expect_success NO_GETTEXT_POISON 'reinit' '
=20
 	(
 		sane_unset GIT_CONFIG GIT_WORK_TREE GIT_CONFIG &&
--=20
1.7.2.3
