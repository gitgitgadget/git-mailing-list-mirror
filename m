Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B6B82D0606
	for <git@vger.kernel.org>; Wed, 24 Jun 2026 21:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782338119; cv=none; b=RjLtO4wISKGnte3mqF0BhMfjCUF6/U+iui8k5VTELjCxFN1osaQPfK0jVYW1hh20UqI2MtVPWRn7QciC5DlYyWR53z4pvRABVpA8pk0JKgrEAg+7awVZISwQWa2UDNZrj/Fj7LJZxyyB+v5gOMQdZvTUQ/RDW2z7AF3uhtKPi28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782338119; c=relaxed/simple;
	bh=SlJ8vCncI4OXcZNNtar+qtPPxEzCJHoXcEx6E2fsEvc=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=aG2odJicjAj0nSeglKflNlUPXghUz8Vz926drQy/tnJrMcDuDi4g3Aaqx9WR32Vo1jM7+l9jN3KiDAoAfak5zzlD3DdEIWUoC4L7sruw4hcQIG/ELQSlPAWJ+vdl3SDKRW8OYv/h1K2a/nNDEOzSF8+/4Lo6sLvRuPvpptIUyAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ka2jwVO9; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ka2jwVO9"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-9159f631656so41158785a.1
        for <git@vger.kernel.org>; Wed, 24 Jun 2026 14:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782338117; x=1782942917; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c9fBk7pGQnGltvKnAdPiUXD8IXY9XzmP1DDt7gcO9ng=;
        b=Ka2jwVO9j/KlkCJN+qjnT2kGIY87z9etuVhuBlvpMuhV149zrYDmZ6h5KdYIOu+C41
         bf8ssd8F0H+F5PSyeulbJ4E00lhbO+t/Wp0dowDxaqpY/qRaYtU1Z9Pjd0WK9Yg7q1Pm
         wY1oChr7PtGNqHxX8p/ocXPg2toYjWuPJG1KPRrLtpMF9a3Sn15i75KVLs8u7moTBvVr
         0EBmSlf49k/hIDxjE8vM2XvDzL4x+i2xgXVsmMpHy62tHp3Ea30sx+44BRtB0uAsfNsq
         TIvBq0ODnPoKuhFKWgRT40jGLZVzqoaNmwpktVa34rw7/MK4B1dpGXTxAFknGN1yXmSB
         dGUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782338117; x=1782942917;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=c9fBk7pGQnGltvKnAdPiUXD8IXY9XzmP1DDt7gcO9ng=;
        b=Q7WqXrt3viLdU9xc3PzhknvN2DbEFT+bG2mQj9h7NGq4DPfKqLe9ASWQt+CqsGYErW
         J1WC/gy3bgtkbxCxMZNDUy815PK4P35MsKPu0BRqBf13rZwitnaS+wJ87mA1UXUyTWdx
         8kmO9CKfg09IP4kMNXtVAQx6Ju3+9mMsNgjY+MmquCqndmx1JeibqOqmKEC30UaWnSJZ
         9d2/7L4RTDPjkmzMRSu8bIB7LRVRgdaMhWvNh/oPScOdXpkFYukSGkPBuQPeRViYFmXc
         lDwd3Zx4hNYLycPwXK6zKLFmpJkxqrFnLphTa+kyOmBBZ+1o83k7Vr1rp2e+uU4WZsJF
         tYqA==
X-Gm-Message-State: AOJu0YwREHHmm2Y6AOzMYXN7RqzzR+9tpjwrGkdJIDdj6qahaERLhqyz
	WtxPHOEFJrO9rfjMR+9efkUuZqDJPYH6gYorLO9Q9DuKd2Lp5qyNAClI8arnSg==
X-Gm-Gg: AfdE7cm/UA8eLUTWIBK3fNTNU5ZCa220St4zpBHhpMmVtLCg35IHPIEs2XH5ApEtmXo
	WpYL/Jfi2MCYx4LE3frzTHVq1AYvMRsqLsARExBayqdhH65PVVoEzZXUWEzdjXZ2VVoY2FW5AjS
	bvIrOq/u1CiVuMwZInbtNoHs3dcAV1yr37NVtCjh2aTtP0HBlEa6jf2x9HRV4y+VvxL5ZGAEm30
	+ywSZIpJ73wDukhG8BnP1fO2eE7X99lkOnBp9/d1Cqk2qdkfuXN8JxerT89H8d0l3OvRkVPavO6
	o05djWY/D/w4YESl/UOq3ZjzGwM0pSC5pJGdKec0kSNfyjArbCMWFyF76bJLUPC4Gqz0WVmF9AZ
	DrM9l9AYW37tdXlnev75y8U/utH0t0pvzvqdbprU3mjFEGzr0D39PoElE7VK+THRDJuIoD7C3A7
	ngvo5lsx9VhYGSklmAgywMDDoUOg==
X-Received: by 2002:a05:620a:2694:b0:920:7491:7362 with SMTP id af79cd13be357-9288354dee2mr343540385a.10.1782338117256;
        Wed, 24 Jun 2026 14:55:17 -0700 (PDT)
Received: from [127.0.0.1] ([64.236.160.20])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92600a87303sm658345085a.42.2026.06.24.14.55.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 14:55:16 -0700 (PDT)
Message-Id: <11bcecebf43797a889f08e79401370f43b2917a8.1782338114.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2331.v2.git.git.1782338114.gitgitgadget@gmail.com>
References: <pull.2331.git.git.1781262619.gitgitgadget@gmail.com>
	<pull.2331.v2.git.git.1782338114.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 24 Jun 2026 21:55:13 +0000
Subject: [PATCH v2 1/2] branch: suggest <remote>/<branch> on upstream slip
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Harald Nordgren <haraldnordgren@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

From: Harald Nordgren <haraldnordgren@gmail.com>

When setting the upstream of the current branch to the 'main' branch
of the remote 'origin', i.e.,

    $ git branch --set-upstream-to origin/main

it is easy to mistakenly write

    $ git branch --set-upstream-to origin main

That is parsed as a request to set the upstream of the local branch
'main' to 'origin'. When 'main' does not exist, the command dies
with:

    fatal: branch 'main' does not exist

pointing at a branch the user never meant to name.

When the operated-on branch is missing and '<remote>/<branch>' names
a real remote-tracking ref, suggest the intended form:

    $ git branch --set-upstream-to=origin/main

The suggestion is gated on '<remote>/<branch>' existing so it only
appears when a slipped slash is the likely explanation.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 builtin/branch.c  | 26 ++++++++++++++++++++++++++
 t/t3200-branch.sh | 38 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 64 insertions(+)

diff --git a/builtin/branch.c b/builtin/branch.c
index 1572a4f9ef..cefc4519a7 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -706,6 +706,29 @@ static int edit_branch_description(const char *branch_name)
 	return 0;
 }
 
+static void die_if_upstream_looks_like_remote(const char *new_upstream, const char *branch_name)
+{
+	struct strbuf remote_ref = STRBUF_INIT;
+	int code;
+
+	if (strchr(new_upstream, '/') ||
+	    !remote_is_configured(remote_get(new_upstream), 0))
+		return;
+
+	strbuf_addf(&remote_ref, "refs/remotes/%s/%s", new_upstream, branch_name);
+	if (!refs_ref_exists(get_main_ref_store(the_repository), remote_ref.buf)) {
+		strbuf_release(&remote_ref);
+		return;
+	}
+
+	code = die_message(_("--set-upstream-to takes a single <remote>/<branch> argument"));
+	advise_if_enabled(ADVICE_SET_UPSTREAM_FAILURE,
+			  _("Did you mean to use: git branch --set-upstream-to=%s/%s?"),
+			  new_upstream, branch_name);
+	strbuf_release(&remote_ref);
+	exit(code);
+}
+
 int cmd_branch(int argc,
 	       const char **argv,
 	       const char *prefix,
@@ -957,6 +980,9 @@ int cmd_branch(int argc,
 		if (!refs_ref_exists(get_main_ref_store(the_repository), branch->refname)) {
 			if (!argc || branch_checked_out(branch->refname))
 				die(_("no commit on branch '%s' yet"), branch->name);
+			if (argc == 1 &&
+			    advice_enabled(ADVICE_SET_UPSTREAM_FAILURE))
+				die_if_upstream_looks_like_remote(new_upstream, argv[0]);
 			die(_("branch '%s' does not exist"), branch->name);
 		}
 
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index e7829c2c4b..e2682a83a0 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -1022,6 +1022,44 @@ test_expect_success '--set-upstream-to fails on a missing dst branch' '
 	test_cmp expect err
 '
 
+test_expect_success '--set-upstream-to suggests <remote>/<branch> on slip' '
+	test_when_finished "git remote remove slip-remote" &&
+	git remote add slip-remote . &&
+	git update-ref refs/remotes/slip-remote/slip-feature HEAD &&
+	test_must_fail git branch --set-upstream-to slip-remote slip-feature 2>err &&
+	test_grep "takes a single <remote>/<branch> argument" err &&
+	test_grep "hint: Did you mean to use: git branch --set-upstream-to=slip-remote/slip-feature?" err &&
+	test_must_fail git -c advice.setUpstreamFailure=false \
+		branch --set-upstream-to slip-remote slip-feature 2>err &&
+	test_grep ! "Did you mean" err
+'
+
+test_expect_success '--set-upstream-to does not suggest when no matching remote ref' '
+	test_when_finished "git remote remove slip-remote" &&
+	git remote add slip-remote . &&
+	test_must_fail git branch --set-upstream-to slip-remote no-such-branch 2>err &&
+	test_grep "branch ${SQ}no-such-branch${SQ} does not exist" err &&
+	test_grep ! "Did you mean" err
+'
+
+test_expect_success '--set-upstream-to to a local branch is not mistaken for a slip' '
+	git branch slip-local-upstream &&
+	git branch slip-local-target &&
+	git branch --set-upstream-to=slip-local-upstream slip-local-target 2>err &&
+	test_grep ! "Did you mean" err &&
+	echo refs/heads/slip-local-upstream >expect &&
+	git config branch.slip-local-target.merge >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success '--set-upstream-to slip suggestion keeps a slashed branch name' '
+	test_when_finished "git remote remove slip-remote" &&
+	git remote add slip-remote . &&
+	git update-ref refs/remotes/slip-remote/slip/feature HEAD &&
+	test_must_fail git branch --set-upstream-to slip-remote slip/feature 2>err &&
+	test_grep "hint: Did you mean to use: git branch --set-upstream-to=slip-remote/slip/feature?" err
+'
+
 test_expect_success '--set-upstream-to fails on a missing src branch' '
 	test_must_fail git branch --set-upstream-to does-not-exist main 2>err &&
 	test_grep "the requested upstream branch '"'"'does-not-exist'"'"' does not exist" err
-- 
gitgitgadget

