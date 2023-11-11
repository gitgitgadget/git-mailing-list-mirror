Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1B0A1D6A6
	for <git@vger.kernel.org>; Sat, 11 Nov 2023 22:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YxZiwU7g"
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A73A1E1
	for <git@vger.kernel.org>; Sat, 11 Nov 2023 14:43:30 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-4083ac51d8aso25614165e9.2
        for <git@vger.kernel.org>; Sat, 11 Nov 2023 14:43:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699742609; x=1700347409; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=e2PrGtZuUmKm4AfCCEDgWwzcO0liZ+Q5sLj9+p28YME=;
        b=YxZiwU7grc+g9YfZTcPNzqD8FL1zmFKsPE3QdN43Nap9VJyfZkqMjz4a5FEX0DTBaa
         AkNzIgE1uEEGt7puownZgPLm23GZErDCMB4VPotcaVSHSnHCCYpQ58hTZPwlTRtDqgNq
         k5kE6vAXnTsbg46NPUZJ7mWIHyuOLKM8B7WshlGwmhyzDeL8agefbSONOdiCyTd71bSn
         4qZ7uYY+lGLyY0K1Yn0I/+0NTaAdV79JGJYXu5VNaTkFCqio+6kMivJXc+gPTBTsBRmK
         s7ZD9xk3KocWWYHbxPTKCz0CjtO4RmRPu5nClCl/3vi0Rtm/6qQ436BuXnG3VU1lcq9s
         MGew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699742609; x=1700347409;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e2PrGtZuUmKm4AfCCEDgWwzcO0liZ+Q5sLj9+p28YME=;
        b=JPI4uLe+Pwk++LMKyeRUdqcxkHUqw8dpyKE6TBZeMZko+TDHunhS1zzhXUassCsbSr
         BoRYPF7H8SZer2HXJD+lK3BX7bFvwpAxG0Yf3zeyyEX6jiBSdelK6gqF0F8fT+MDAFeG
         m3qCuxhzwgC3GyydYuzsoGFuPa0LgQR8/Z/ZBZQxJ1S4F6EuceTtE/HojX/m+e3ZZ/VN
         zmnT6c6OtEQ4fsh6y03fMy/Z6ljvZ1TCY3FDz7gT1J65Rsk3Sn31nIrNzXb1/2uKEWSj
         tJWTEpOvVGDtGGphD1rMk9iJf3CWrjdNrP8tuE0DJxuU0bm+QwAu6u4s+DJh03EeZ/1K
         8kpg==
X-Gm-Message-State: AOJu0YxGKjVFpoHkicgNW3rXGycYZAqyfCF66iIEbWLayU48TarQnngf
	C3dXIHdep5xprGDyijlaEr56q9Vl7zE=
X-Google-Smtp-Source: AGHT+IHAss4mp/q+dcj5ScfonaD+QlSIho4YkIBaw/TPMmLNcNE3b9du48wBpfdYIoRrtcfWGhmvZQ==
X-Received: by 2002:a05:600c:5253:b0:40a:4c76:5ac5 with SMTP id fc19-20020a05600c525300b0040a4c765ac5mr1736800wmb.33.1699742608746;
        Sat, 11 Nov 2023 14:43:28 -0800 (PST)
Received: from localhost.localdomain (cpc105060-sgyl40-2-0-cust995.18-2.cable.virginm.net. [81.111.15.228])
        by smtp.gmail.com with ESMTPSA id m15-20020a05600c4f4f00b004083bc9ac90sm3287607wmq.24.2023.11.11.14.43.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Nov 2023 14:43:28 -0800 (PST)
From: Andy Koppe <andy.koppe@gmail.com>
To: git@vger.kernel.org
Cc: pclouds@gmail.com,
	Andy Koppe <andy.koppe@gmail.com>
Subject: [PATCH] checkout: add config variable checkout.autoDetach
Date: Sat, 11 Nov 2023 22:42:46 +0000
Message-ID: <20231111224253.1923-1-andy.koppe@gmail.com>
X-Mailer: git-send-email 2.43.0-rc1
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The git-checkout command without pathspecs automatically detaches HEAD
when switching to something other than a branch, whereas git-switch
requires the --detach option to do so.

Add configuration variable checkout.autoDetach to choose the behavior
for both: true for automatic detaching, false for requiring --detach.

Amend their documentation and tests accordingly.

Signed-off-by: Andy Koppe <andy.koppe@gmail.com>
---
I like to use git-switch and git-restore instead of git-checkout, and
also recommend them when new users ask how to switch branches or undo
local changes. But I do miss git-checkout's auto-detaching, as I like
to avoid creating local versions of remote branches when I don't intend
to make changes to them.

Hence this patch, which turned out to be very simple in terms of the
actual source change, as the checkout_opts.implicit_detach field
already controls the necessary functionality. That was added in commit
7968bef06b by Nguyễn Thái Ngọc Duy, with the following explanation:

> "git checkout <commit>" will checkout the commit in question and
> detach HEAD from the current branch. It is naturally a right thing to
> do once you get git references. But detached HEAD is a scary concept
> to new users because we show a lot of warnings and stuff, and it could
> be hard to get out of (until you know better).
>
> To keep switch a bit more friendly to new users, we only allow
> entering detached HEAD mode when --detach is given.

I think that makes plenty of sense, and I don't think it conflicts with
the config setting proposed here, as new users are unlikely to mess with
such settings. In fact, the point where "you get git references" would
probably be a good time to enable checkout.autoDetach.

Conversely, admins might want to set checkout.autoDetach to false in the
system-wide config to prevent accidental decapitation by git-checkout
and the resulting support requests.

 Documentation/config/checkout.txt |  8 ++++++++
 Documentation/git-checkout.txt    |  3 +++
 Documentation/git-switch.txt      |  3 +++
 builtin/checkout.c                |  4 ++++
 t/t2020-checkout-detach.sh        | 14 ++++++++++++++
 t/t2060-switch.sh                 |  7 +++++++
 6 files changed, 39 insertions(+)

diff --git a/Documentation/config/checkout.txt b/Documentation/config/checkout.txt
index a323022993..6827ee74d5 100644
--- a/Documentation/config/checkout.txt
+++ b/Documentation/config/checkout.txt
@@ -17,6 +17,14 @@ and by linkgit:git-worktree[1] when `git worktree add` refers to a
 remote branch. This setting might be used for other checkout-like
 commands or functionality in the future.
 
+checkout.autoDetach::
+	If set to true, `git checkout` and `git switch` automatically detach
+	HEAD when switching to something other than a branch. If set to false,
+	they require the `--detach` option to detach HEAD.
++
+If this setting is not specified, `git checkout` defaults to automatic
+detaching, whereas `git switch` defaults to requiring `--detach`.
+
 checkout.guess::
 	Provides the default value for the `--guess` or `--no-guess`
 	option in `git checkout` and `git switch`. See
diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
index 240c54639e..23f90c15ac 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -79,6 +79,9 @@ When the `<commit>` argument is a branch name, the `--detach` option can
 be used to detach `HEAD` at the tip of the branch (`git checkout
 <branch>` would check out that branch without detaching `HEAD`).
 +
+If the `checkout.autoDetach` config variable is set to false, the `--detach`
+option is required even if the `<commit>` argument is not a branch name.
++
 Omitting `<branch>` detaches `HEAD` at the tip of the current branch.
 
 'git checkout' [-f|--ours|--theirs|-m|--conflict=<style>] [<tree-ish>] [--] <pathspec>...::
diff --git a/Documentation/git-switch.txt b/Documentation/git-switch.txt
index c60fc9c138..f6b925c43b 100644
--- a/Documentation/git-switch.txt
+++ b/Documentation/git-switch.txt
@@ -83,6 +83,9 @@ $ git switch <new-branch>
 	Switch to a commit for inspection and discardable
 	experiments. See the "DETACHED HEAD" section in
 	linkgit:git-checkout[1] for details.
++
+If the `checkout.autoDetach` configuration variable is set to true,
+`--detach` can be omitted when the target is not a branch.
 
 --guess::
 --no-guess::
diff --git a/builtin/checkout.c b/builtin/checkout.c
index f02434bc15..d042638bb0 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1205,6 +1205,10 @@ static int git_checkout_config(const char *var, const char *value,
 		handle_ignore_submodules_arg(&opts->diff_options, value);
 		return 0;
 	}
+	if (!strcmp(var, "checkout.autodetach")) {
+		opts->implicit_detach = git_config_bool(var, value);
+		return 0;
+	}
 	if (!strcmp(var, "checkout.guess")) {
 		opts->dwim_new_local_branch = git_config_bool(var, value);
 		return 0;
diff --git a/t/t2020-checkout-detach.sh b/t/t2020-checkout-detach.sh
index 8202ef8c74..b842b6cc89 100755
--- a/t/t2020-checkout-detach.sh
+++ b/t/t2020-checkout-detach.sh
@@ -69,12 +69,26 @@ test_expect_success 'checkout ref^0 detaches' '
 	check_detached
 '
 
+test_expect_success 'checkout of tag with autoDetach=false fails' '
+	reset &&
+	test_config checkout.autoDetach false &&
+	test_must_fail git checkout tag &&
+	check_not_detached
+'
+
 test_expect_success 'checkout --detach detaches' '
 	reset &&
 	git checkout --detach branch &&
 	check_detached
 '
 
+test_expect_success 'checkout --detach with autoDetach=false detaches' '
+	reset &&
+	test_config checkout.autoDetach false &&
+	git checkout --detach branch &&
+	check_detached
+'
+
 test_expect_success 'checkout --detach without branch name' '
 	reset &&
 	git checkout --detach &&
diff --git a/t/t2060-switch.sh b/t/t2060-switch.sh
index e247a4735b..69ff197d11 100755
--- a/t/t2060-switch.sh
+++ b/t/t2060-switch.sh
@@ -50,6 +50,13 @@ test_expect_success 'switch and detach current branch' '
 	test_must_fail git symbolic-ref HEAD
 '
 
+test_expect_success 'switch with checkout.autoDetach=true' '
+	test_when_finished git switch main &&
+	test_config checkout.autoDetach true &&
+	git switch main^{commit} &&
+	test_must_fail git symbolic-ref HEAD
+'
+
 test_expect_success 'switch and create branch' '
 	test_when_finished git switch main &&
 	git switch -c temp main^ &&
-- 
2.43.0-rc1

