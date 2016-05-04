From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH v5 0/4] githooks.txt improvements + core.hooksDirectory
Date: Wed,  4 May 2016 20:18:44 +0000
Message-ID: <1462393128-26762-1-git-send-email-avarab@gmail.com>
References: <xmqqinz4f8mg.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jacob Keller <jacob.keller@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 04 22:19:25 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ay3GW-0005Cg-B4
	for gcvg-git-2@plane.gmane.org; Wed, 04 May 2016 22:19:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755138AbcEDUTT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 4 May 2016 16:19:19 -0400
Received: from mail-wm0-f44.google.com ([74.125.82.44]:38567 "EHLO
	mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754286AbcEDUTQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 May 2016 16:19:16 -0400
Received: by mail-wm0-f44.google.com with SMTP id g17so113537128wme.1
        for <git@vger.kernel.org>; Wed, 04 May 2016 13:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=U7U5TCevWN3WrLaEG8X4C2cWsa8OYLvq1u6YswQe7ik=;
        b=DrCWGOVlIBr3IAm3feKzjSpOhNddHGO3nb4CN1sncPNbVnhVuOnvuv6smDqCzXfkG/
         /9E7VD0ILf0sIKy2kGddF5daS0p3q0L/GpHo5a4Ah+j0vqHSQ1AqxqbTVQRowq7jcqvk
         cAF6IJcF7YQzjca7csZ1wmmKAnxbTqymWgpxkC8iMU52YSku01Kyf9pbuvdmU5SNOYOM
         aO4K4WhHTu8LMPagCm7a5Rkg8WwJqnJ+2p2X2TaZ4q9ATy7BxF1xvmbL0b9VdNp7GZMw
         /LdshfF+hQ0XzL0D0NkW1cRT4yyouLTMo6JROZg0YPMxnJSS37Ck50NdpljjBme3TY8l
         98sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=U7U5TCevWN3WrLaEG8X4C2cWsa8OYLvq1u6YswQe7ik=;
        b=ThviQc07g+JZHK0+sHeyp8QdAe4tMGe3P0kDIWpYlqUEvgRRaDPVYZ6KdYqqYQAdLZ
         Roxf6Z6lWYJbpshuO6v6C6CCdeMmMdTXL+CZOtlRwreAHDEA0JeNjvgjstD+UMnrx1Nw
         YRslW+dzzfWra9PXpXCAuukmfHJpDkVhaF9Kf++9DOMMlaH1ytb44X1iiX/kkCBxjF3r
         pAYFYU+5l7aFfUrJVaVpGyo+JLy1lAovdwpAQlwsiGCZCVr8iWhHqmWym9b99Ui5OZOW
         vKCf/f/s9Mvota6oKBJHT/gq3JnbkbjXcX0IB+/YVugnvWg+a2cAf7AyH4qSvBgSF59M
         FKbg==
X-Gm-Message-State: AOPr4FV9oJrALzdS2PW85/3Pb0snzca2xcWLbDekoDaHhXJWGDOupslUGU+/1UHMuWe48Q==
X-Received: by 10.28.58.77 with SMTP id h74mr33027106wma.82.1462393154442;
        Wed, 04 May 2016 13:19:14 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id w79sm6795893wme.19.2016.05.04.13.19.12
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 04 May 2016 13:19:13 -0700 (PDT)
X-Mailer: git-send-email 2.1.3
In-Reply-To: <xmqqinz4f8mg.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293583>

This is hopefully the last version of this series. I've hopefully
addressed the comments that came up and fixed a couple of other minor
things.

Changes since v4:

 * Changed wording to config.txt's core.hooksPath documentation as
   suggested.

 * Ditto for githooks.txt, and I tried to make the whole "how we
   chdir()" bit less confusing.

 * Use more obvious test idioms, e.g. indent when using <<-\EOF, use a
   multi-line test_cmp file, and use "expect" and "actual" like other
   test files instead of needlessly verbose alternatives.

 * Fixed a grammar error in a commit message.

=46or convenience & ease of review a diff between the bits of v4 and v5
that I changed follows below.

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason (4):
  githooks.txt: Improve the intro section
  githooks.txt: Amend dangerous advice about 'update' hook ACL
  githooks.txt: Minor improvements to the grammar & phrasing
  hooks: Add ability to specify where the hook directory is

 Documentation/config.txt     | 17 ++++++++++
 Documentation/git-init.txt   |  7 ++++-
 Documentation/githooks.txt   | 75 ++++++++++++++++++++++++++----------=
--------
 cache.h                      |  1 +
 config.c                     |  3 ++
 environment.c                |  1 +
 run-command.c                |  5 ++-
 t/t1350-config-hooks-path.sh | 37 ++++++++++++++++++++++
 8 files changed, 114 insertions(+), 32 deletions(-)
 create mode 100755 t/t1350-config-hooks-path.sh

diff --git a/Documentation/config.txt b/Documentation/config.txt
index c007b12..9a74acd 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -625,16 +625,15 @@ core.hooksPath::
 	that directory, e.g. '/etc/git/hooks/pre-receive' instead of
 	in '$GIT_DIR/hooks/pre-receive'.
 +
-The path can either be absolute or relative. When specifying a
-relative path see the discussion in the "DESCRIPTION" section of
-linkgit:githooks[5] for what the relative relative path will be
-relative to.
-+
-This configuration is useful in cases where you'd like to
-e.g. centrally configure your Git hooks instead of configuring them on
-a per-repository basis, or as a more flexible and centralized
-alterantive to having an `init.templateDir` where you've changed the
-'hooks' directory.
+The path can be either absolute or relative. A relative path is
+taken as relative to the directory where the hooks are run (see
+the "DESCRIPTION" section of linkgit:githooks[5]).
++
+This configuration variable is useful in cases where you'd like to
+centrally configure your Git hooks instead of configuring them on a
+per-repository basis, or as a more flexible and centralized
+alterantive to having an `init.templateDir` where you've changed
+default hooks.
=20
 core.editor::
 	Commands such as `commit` and `tag` that lets you edit
diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index 97ae78d..6f562cd 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -21,20 +21,21 @@ By default the hooks directory is `$GIT_DIR/hooks`,=
 but that can be
 changed via the `core.hooksPath` configuration variable (see
 linkgit:git-config[1]).
=20
-When a hook is invoked, it is run at the root of the working tree in a
-non-bare repository, or in the $GIT_DIR in a bare
-repository. I.e. hooks don't need to worry about the user's current
-working directory.
+Hooks don't need to worry about the user's current working
+directory. Before Git invokes a hook it changes its working
+directory. The working directory will be the root of the working tree
+in a non-bare repository, or in the $GIT_DIR directory in a bare
+repository.
=20
 Hooks can get their arguments via the environment, command-line
 arguments, and stdin. See the documentation for each hook below for
 details.
=20
-When 'git init' is run it may, depending on its configuration, copy
-hooks to the new repository, see the the "TEMPLATE DIRECTORY" section
-in linkgit:git-init[1] for details. When the rest of this document
-refers to "default hooks" it's talking about the default template
-shipped with Git.
+'git init' may copy hooks to the new repository, depending on its
+configuration. See the "TEMPLATE DIRECTORY" section in
+linkgit:git-init[1] for details. When the rest of this document refers
+to "default hooks" it's talking about the default template shipped
+with Git.
=20
 The currently supported hooks are described below.
=20
diff --git a/t/t1350-config-hooks-path.sh b/t/t1350-config-hooks-path.s=
h
index f2f0aa9..6e4586a 100755
--- a/t/t1350-config-hooks-path.sh
+++ b/t/t1350-config-hooks-path.sh
@@ -7,10 +7,10 @@ test_description=3D'Test the core.hooksPath configura=
tion variable'
 test_expect_success 'set up a pre-commit hook in core.hooksPath' '
 	mkdir -p .git/custom-hooks .git/hooks &&
 	write_script .git/custom-hooks/pre-commit <<-\EOF &&
-printf "%s" "CUST" >>.git/PRE-COMMIT-HOOK-WAS-CALLED
+	echo CUSTOM >>actual
 EOF
 	write_script .git/hooks/pre-commit <<-\EOF
-printf "%s" "NORM" >>.git/PRE-COMMIT-HOOK-WAS-CALLED
+	echo NORMAL >>actual
 EOF
 '
=20
@@ -24,8 +24,14 @@ test_expect_success 'Check that various forms of spe=
cifying core.hooksPath work'
 	test_commit have_custom_hook_abs_path &&
 	git config core.hooksPath "$PWD/.git/custom-hooks/" &&
 	test_commit have_custom_hook_abs_path_trailing_slash &&
-	printf "%s" "NORMCUSTCUSTCUSTCUST" >.git/PRE-COMMIT-HOOK-WAS-CALLED.e=
xpect &&
-	test_cmp .git/PRE-COMMIT-HOOK-WAS-CALLED.expect .git/PRE-COMMIT-HOOK-=
WAS-CALLED
+	cat >expect <<-\EOF &&
+	NORMAL
+	CUSTOM
+	CUSTOM
+	CUSTOM
+	CUSTOM
+EOF
+	test_cmp expect actual
 '
=20
 test_done


--=20
2.1.3
