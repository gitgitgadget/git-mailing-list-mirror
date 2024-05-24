Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1CCA128374
	for <git@vger.kernel.org>; Fri, 24 May 2024 07:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716534432; cv=none; b=eyerqzH7rq5rdNd5VfAqrH42opGFSh74O2sDIURUZu4k4lyVZPoJBHH/dRG10Hc/15iPKI4gpUMsBRHSoQ3Eqnk0YMl/Bv1I4fC0E/BDXq/TvApinsuaUryN2VWcNJDSkAWL/W+CyuoiBARa9PKUuT9nfqtTKQuEe9Na6dipiac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716534432; c=relaxed/simple;
	bh=hx36JXMUGIcqZ4YWn2lybP65theARDfhQXcoLekpPss=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=i8CDz1segclqAh2RPUQCO24x9HCUlQ9nTikAUPu1DePXG+5Prm51xDMlZLYGXRq9vtektfG7A8s+ErP78+EKtv4aIEXLoGUPAaywmJfrd1ykNpyP6k94yvpxLcy0n/zQ9M/6Zn4t0mSzi2E69+LEeiki7+DU/ge0jXYklZJI+08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DaVMa6XS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DaVMa6XS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716534428;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=YSuHnSICHKzHAs9yzEhLvdvURpho0eCcYAvYMJfMAnw=;
	b=DaVMa6XSWM5ipXVv3+NONe53inr8f3LfWELTnT4yPFhrmGaRRY5WBXibNW4VULjvfbrnJo
	rSJUzc8RW8nzj0kxYroZMNNpbT90PK5dazM+Qt5R4qLCzH9hdqUoLk/7jNOEk4s/fbkBv+
	agifJ6Pi3ApDSLIRBZHJG2b0SHpf4VI=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-345-yQZc1hZ6MjGVrNPaRbCEkA-1; Fri, 24 May 2024 03:07:06 -0400
X-MC-Unique: yQZc1hZ6MjGVrNPaRbCEkA-1
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-3c9a56ffb64so1580894b6e.2
        for <git@vger.kernel.org>; Fri, 24 May 2024 00:07:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716534425; x=1717139225;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YSuHnSICHKzHAs9yzEhLvdvURpho0eCcYAvYMJfMAnw=;
        b=VHgEbJjhBY9Q1cBFpAGbUftCS05v+DI4gufI3cUMrQ4twrdSRQzg/ZtpBl9ZAqylyU
         YpzNNNhlmS+VQ+huMDX30cpGFyAN+5OiXYwJC2PYBs9gKuSHTW+iiOnaXDIqHHlfTUEz
         ohSnsPKhSzwmCqqbeugZ5GScbApuM/54pR1YZYsP9TPZGx7RJHXYMR5c7KceLzFjuQHM
         VXYW9ib7UDdk+gC1qGz9EOb2kXES1HzRUNDVA+WAwXklAyelpvp0CXiEmW4PslwLlqlP
         XSoYNLkZUTon6+ihJVt0Oszepjus6ufy0RT15AQWODk5I475UVA8+wloWwsCQKjo3295
         beng==
X-Gm-Message-State: AOJu0Yz62IJEKDtLvTGfxYlPg1re+iqM/kWlwFGR8glOsumrfRKzhitc
	x6hZZd69EyDB3SHyxuq0StcXSUmOXd08I3I3DYpHqylnmelm5fE9ENchGaLgoD8shP4yameDdT6
	Sz72s/i+spz+LuiWq6KLN4LGUsgNCFMPeaqK6WyXnTlHClbRn57FPVG1n6vlq44XFHdbpjm0CY/
	FgggqDQZaPNaheOot6bWxsS1mTLbPDDdudPQ==
X-Received: by 2002:a05:6808:285:b0:3c9:73a2:6862 with SMTP id 5614622812f47-3d1a6113869mr1609412b6e.31.1716534425510;
        Fri, 24 May 2024 00:07:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFF0Y1VZSj95rTRzXgqmfaOA5tyDBvy0lg0hwocSIA3xfAOD78iKGwRvsFsivbShqg/dKgx4w==
X-Received: by 2002:a05:6808:285:b0:3c9:73a2:6862 with SMTP id 5614622812f47-3d1a6113869mr1609383b6e.31.1716534424861;
        Fri, 24 May 2024 00:07:04 -0700 (PDT)
Received: from fedora19.redhat.com (203-12-11-234.dyn.launtel.net.au. [203.12.11.234])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-794abd0839esm40078685a.83.2024.05.24.00.07.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 May 2024 00:07:04 -0700 (PDT)
From: Ian Wienand <iwienand@redhat.com>
To: git@vger.kernel.org
Cc: Ian Wienand <iwienand@redhat.com>
Subject: [PATCH] alias: pass --help through to shell alias
Date: Fri, 24 May 2024 17:04:14 +1000
Message-ID: <20240524070623.1344636-2-iwienand@redhat.com>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In trying to make some aliases more consistent in an internal tool, I
implemented both -h/--help in the underlying command for a shell
alias, and was a bit surprised when "git <alias> -h" worked but "git
<alias> --help" didn't.

In the "-h" case in git.c:handle_alias() we have a little check for
"-h" which pre-prints the "<alias> is aliased to..." line and then
continues to run the alias.

However in the "--help" case we fall into the logic that turns "git
cmd --help" into "git help cmd"

help.c contains a check to just print the alias mapping if called as
"git help <alias>", but if called as "git <alias> --help", will
redirect to the help of the aliased-command.  Since a shell alias does
not have a 1:1 mapping with an internal command, the current check
prints the alias mapping and simply exits in that case (causing my
alias script "--help" command to never trigger).

I would propose that "--help" to a shell alias is passed through to
the underlying command.  This way you can write aliases that act more
like the other git commands.

To do this, we make "--help" work the same as "-h" for shell aliases.
In git.c where we check for the "--help" argument, for shell aliases
we print the aliased command as "-h" does, but then shortcut the
rewriting to "git help", so the aliased command will run and not be
sent to "git help".

Since "git <alias> --help" will not be re-written for shell aliases,
"git help" can now assume that it is being asked to help on a
git-command alias.  Thus we can remove the "is this a rewritten shell
alias" check.

A test-case is added to ensure "--help" is passed through to the
underlying command of a shell alias.

Signed-off-by: Ian Wienand <iwienand@redhat.com>
---
 builtin/help.c   |  7 +++----
 git.c            | 15 +++++++++++++++
 t/t0014-alias.sh |  8 ++++++++
 3 files changed, 26 insertions(+), 4 deletions(-)

diff --git a/builtin/help.c b/builtin/help.c
index 222f994f86..5e9d5edbb2 100644
--- a/builtin/help.c
+++ b/builtin/help.c
@@ -547,11 +547,10 @@ static const char *check_git_cmd(const char* cmd)
 		 * handle_builtin() in git.c rewrites "git cmd --help"
 		 * to "git help --exclude-guides cmd", so we can use
 		 * exclude_guides to distinguish "git cmd --help" from
-		 * "git help cmd". In the latter case, or if cmd is an
-		 * alias for a shell command, just print the alias
-		 * definition.
+		 * "git help cmd". In the latter case, just print the
+		 * alias definition.
 		 */
-		if (!exclude_guides || alias[0] == '!') {
+		if (!exclude_guides) {
 			printf_ln(_("'%s' is aliased to '%s'"), cmd, alias);
 			free(alias);
 			exit(0);
diff --git a/git.c b/git.c
index 3d8e48cf55..4c93296550 100644
--- a/git.c
+++ b/git.c
@@ -691,12 +691,27 @@ static void strip_extension(const char **argv)
 static void handle_builtin(int argc, const char **argv)
 {
 	struct strvec args = STRVEC_INIT;
+	char *alias;
 	const char *cmd;
 	struct cmd_struct *builtin;
 
 	strip_extension(argv);
 	cmd = argv[0];
 
+	/*
+	 * If this is a shell alias with --help, print it's alias
+	 * mapping to be consistent with -h and pass it through
+	 */
+	alias = alias_lookup(cmd);
+	if (alias && alias[0] == '!') {
+		if (argc > 1 && !strcmp(argv[1], "--help")) {
+			fprintf_ln(stderr, _("'%s' is aliased to '%s'"), cmd, alias);
+			free(alias);
+			return;
+		}
+		free(alias);
+	}
+
 	/* Turn "git cmd --help" into "git help --exclude-guides cmd" */
 	if (argc > 1 && !strcmp(argv[1], "--help")) {
 		int i;
diff --git a/t/t0014-alias.sh b/t/t0014-alias.sh
index 8d3d9144c0..7b1d559420 100755
--- a/t/t0014-alias.sh
+++ b/t/t0014-alias.sh
@@ -44,4 +44,12 @@ test_expect_success 'run-command formats empty args properly' '
     test_cmp expect actual
 '
 
+test_expect_success '--help is passed to execed alias' '
+    echo "echo \"\$@\"" > exec-alias.sh &&
+    chmod +x exec-alias.sh &&
+    git config alias.exec-alias "!\"$(pwd)/exec-alias.sh\"" &&
+    GIT_TRACE=1 git exec-alias --help &> output &&
+    test_i18ngrep -- "--help" output
+'
+
 test_done
-- 
2.45.1

