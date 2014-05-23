From: Caleb Thompson <cjaysson@gmail.com>
Subject: commit: support commit.verbose and --no-verbose
Date: Fri, 23 May 2014 16:22:22 -0500
Message-ID: <20140523212222.GA10412@sirius.local>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="n8g4imXOkfNTN/H1"
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	James P Howard II <jh@jameshoward.us>,
	Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 23 23:22:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WnwvA-0003mV-3G
	for gcvg-git-2@plane.gmane.org; Fri, 23 May 2014 23:22:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751151AbaEWVW0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 May 2014 17:22:26 -0400
Received: from mail-oa0-f50.google.com ([209.85.219.50]:35019 "EHLO
	mail-oa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751117AbaEWVWZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 May 2014 17:22:25 -0400
Received: by mail-oa0-f50.google.com with SMTP id i7so6222468oag.23
        for <git@vger.kernel.org>; Fri, 23 May 2014 14:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:date:to:cc:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        bh=7FsG/ItgrAbY6DumJO/nOKgKY1Ag2IL+ytY5c666HY0=;
        b=tI9WlSHM4OlrhJUu3dtbhj61MlFV4DdEJQNpXsgHpIxIFYLFv7OmkWbK3om1+b7lvu
         7uQ9qMow/A8Lf5HCMX7DC0i3tLgx9DEK7tasMka+s5zbSzlNDczTjYpKdO0/OSpgZFwp
         v59YmA/ilv0mdm5iBKvPQN3lRwtrT76sRk35V1g5pMvIC/8+zPV8qv67OgL4U7sPq51v
         xVZkdvA0smmVHJY+unaH/sr1UKBuLtDTsgHP5JZ6G87MncZi/qgINbwx/1NzvKw+WjNo
         QT7AWRDrL7RYc+7SbTEPogFV0YV6Sz4bac+Mz8xf6ADFlw6rBQ0N4JIiT8sT8qkQxQPG
         Pljw==
X-Received: by 10.182.106.99 with SMTP id gt3mr8211418obb.24.1400880144475;
        Fri, 23 May 2014 14:22:24 -0700 (PDT)
Received: from localhost (rrcs-67-78-97-126.sw.biz.rr.com. [67.78.97.126])
        by mx.google.com with ESMTPSA id zc8sm7516572obc.1.2014.05.23.14.22.23
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 23 May 2014 14:22:23 -0700 (PDT)
X-Google-Original-From: Caleb Thompson <caleb@calebthompson.io>
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250034>


--n8g4imXOkfNTN/H1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

This patch allows people to set `commit.verbose` to implicitly send `--verb=
ose`
to `git commit`. It also introduces `--no-verbose` to override the configur=
ation
setting.

Caleb Thompson

=46rom aa2a5d48e6cd53082613f53990bc9d0fa60809f4 Mon Sep 17 00:00:00 2001
=46rom: Caleb Thompson <caleb@calebthompson.io>
Date: Fri, 23 May 2014 11:47:44 -0500
Subject: [PATCH] commit: support commit.verbose and --no-verbose

Add a new configuration variable commit.verbose to implicitly pass
`--verbose` to `git-commit`. Add `--no-verbose` to commit to negate that
setting.

Signed-off-by: Caleb Thompson <caleb@calebthompson.io>
---
 Documentation/config.txt               |  5 +++++
 Documentation/git-commit.txt           |  9 ++++++++-
 builtin/commit.c                       |  6 +++++-
 contrib/completion/git-completion.bash |  1 +
 t/t7507-commit-verbose.sh              | 21 +++++++++++++++++++++
 5 files changed, 40 insertions(+), 2 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 1932e9b..a245928 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1009,6 +1009,11 @@ commit.template::
 	"`~/`" is expanded to the value of `$HOME` and "`~user/`" to the
 	specified user's home directory.
=20
+commit.verbose::
+	A boolean to enable/disable inclusion of diff information in the
+	commit message template when using an editor to prepare the commit
+	message.  Defaults to false.
+
 credential.helper::
 	Specify an external helper to be called when a username or
 	password credential is needed; the helper may consult external
diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index 0bbc8f5..0e1f930 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -282,7 +282,14 @@ configuration variable documented in linkgit:git-confi=
g[1].
 	Show unified diff between the HEAD commit and what
 	would be committed at the bottom of the commit message
 	template.  Note that this diff output doesn't have its
-	lines prefixed with '#'.
+	lines prefixed with '#'.  The `commit.verbose` configuration
+	variable can be set to true to implicitly send this option.
+
+-V::
+--no-verbose::
+	Do not show the unified diff  at the bottom of the commit message
+	template.  This is the default behavior, but can be used to override
+	the`commit.verbose` configuration variable.
=20
 -q::
 --quiet::
diff --git a/builtin/commit.c b/builtin/commit.c
index 9cfef6c..7978d7f 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1417,6 +1417,10 @@ static int git_commit_config(const char *k, const ch=
ar *v, void *cb)
 		sign_commit =3D git_config_bool(k, v) ? "" : NULL;
 		return 0;
 	}
+	if (!strcmp(k, "commit.verbose")) {
+		verbose =3D git_config_bool(k, v);
+		return 0;
+	}
=20
 	status =3D git_gpg_config(k, v, NULL);
 	if (status)
@@ -1484,7 +1488,7 @@ int cmd_commit(int argc, const char **argv, const cha=
r *prefix)
 	static struct wt_status s;
 	static struct option builtin_commit_options[] =3D {
 		OPT__QUIET(&quiet, N_("suppress summary after successful commit")),
-		OPT__VERBOSE(&verbose, N_("show diff in commit message template")),
+		OPT_BOOL('v', "verbose", &verbose, N_("show diff in commit message templ=
ate")),
=20
 		OPT_GROUP(N_("Commit message options")),
 		OPT_FILENAME('F', "file", &logfile, N_("read message from file")),
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/gi=
t-completion.bash
index 2c59a76..b8f4b94 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1976,6 +1976,7 @@ _git_config ()
 		color.ui
 		commit.status
 		commit.template
+		commit.verbose
 		core.abbrev
 		core.askpass
 		core.attributesfile
diff --git a/t/t7507-commit-verbose.sh b/t/t7507-commit-verbose.sh
index 2ddf28c..53f68ff 100755
--- a/t/t7507-commit-verbose.sh
+++ b/t/t7507-commit-verbose.sh
@@ -10,6 +10,12 @@ EOF
 chmod +x check-for-diff
 test_set_editor "$PWD/check-for-diff"
=20
+cat >check-for-no-diff <<EOF
+#!$SHELL_PATH
+exec grep -v '^diff --git' "\$1"
+EOF
+chmod +x check-for-no-diff
+
 cat >message <<'EOF'
 subject
=20
@@ -48,6 +54,21 @@ test_expect_success 'verbose diff is stripped out (mnemo=
nicprefix)' '
 	check_message message
 '
=20
+test_expect_success 'commit shows verbose diff with set commit.verbose' '
+	echo morecontent >file &&
+	git add file &&
+	git config commit.verbose true &&
+	check_message message
+'
+
+test_expect_success 'commit does not show verbose diff with --no-verbose' '
+	echo morecontent >file &&
+	git add file &&
+	git config commit.verbose true &&
+	test_set_editor "$PWD/check-for-no-diff" &&
+	git commit --amend --no-verbose
+'
+
 cat >diff <<'EOF'
 This is an example commit message that contains a diff.
=20
--=20
1.9.3


--n8g4imXOkfNTN/H1
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQEcBAEBAgAGBQJTf7wOAAoJEBYhrcKgrOcKgmEH/1xjrglNb0O72rk86/8ZG+PE
mXcx2AJLKldDRRF/te2PuWTNdiTIRImSXLAOwpFsGltM1+P7t4J6XlVPfN5M8aXp
nWMeFwvXoqTVYde4TofHrw3mLRJSabiQbQdkrBMatwSedJXfuvwhsih2nRU94mF4
2LZo49q4sEFpXO13ReNW9nlWqibiXV/uUWVZoFfs2ZIr+Zmycba62xQu/kpoqF1S
Q0SF6nIsdwPNqN7XFzlldxd+FWHj3xtl6PE3zKrti3+pQI5cBxEGmYQF50jZpkJH
6FXJHkXx2qUzIOKMsXZJBHijDpW5INZEQS8z3KtYgEiJruZmc7y+tGUBH7rfKUQ=
=Zvrz
-----END PGP SIGNATURE-----

--n8g4imXOkfNTN/H1--
