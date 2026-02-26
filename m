Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FEC7477988
	for <git@vger.kernel.org>; Thu, 26 Feb 2026 21:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772140501; cv=none; b=PvKdfvN2l2cqgdUJj5tVPc2inMUenDcgjgDVlwdtkFcGtraXBW4AIFMuVosncCXxE4Sc+oqQq7I7wARxdX4mapVtaBg+8hw7vycRrJ1M3pDjrHSUKFm+WsoNXuOezVnDdIFxct3AslBPvquFaUMwVO1yKI+X/wqujTxG8Vw2SbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772140501; c=relaxed/simple;
	bh=BXKnxJAYzI5+BQyq4ke6xQZoUjJgWhMNKWdahyYmu6g=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=r2pjgGSMer4rj2m+J9AHHv1B0JidPTTl2TPgL9FxRjdB9zq2MEU0gZJ9HmT+REZeq8xMUXF6eWks4rxC3IG9FXN4Um43gBjk0RGvMs+ukD1hPUdu+3ABKMq62MwbbiDVbqHv/rsumwr09e4oZN7NwArgocf5LDMP31kcc928yAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YpT2IpaJ; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YpT2IpaJ"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-8cb5c9ba82bso194976085a.2
        for <git@vger.kernel.org>; Thu, 26 Feb 2026 13:14:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772140497; x=1772745297; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6aKeJpnmXGNCGtZ7wzEwaHUJPnmqm1Yzc5DSgNEAels=;
        b=YpT2IpaJgbca7N4bXU3Ne7b1ddRR/lWLoK7LY0wT0N4h57DcmZdhNBC8L+6Ot3UvBF
         MBf+IqHsl2GVVJkoN626ecuyNo97uVJUdztD7a1mON7Qk5MrcinNTh0ch3TPjT2E6m3U
         TEeSZZUnO0zduG2+koHKYb/kgHLFcrtzmrLU3vea/Y6k4nRjBJ9IE2KcBSO8KiHBG7Ul
         xrxxnDlapodWqjLq4nzgQFewDiAB7o8ZDMJaNz/86gDM7cuFWXQpQzSg8M7QdazXTFUd
         rIpsPNLmHfBhE6XyKv9rQ41skRB110wwkz8CJrrQWD+LVcf7BxVJobkPwSMJlOQF6Pnq
         l5Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772140497; x=1772745297;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6aKeJpnmXGNCGtZ7wzEwaHUJPnmqm1Yzc5DSgNEAels=;
        b=KPBvJb2P04qEFVavZY3A2kXwHsvFMU1Qe6En8meq9bUm6n1URJ0xsSDPUlFCwc5FuR
         GRA1CQp9DfWIGNj7gasrcBPWcQVKnuK2UEOx0auM2bJfzE0Y26qSbr0iskFsR3rganAI
         Fw+MEfkx48xaNkQcdMdjB7nAxqDwtO+XEQsC92bz9vZMn/8a3voAsNhCkUpo6Ku1mUtM
         lxrdTGphWxXlyK0bxZRrZWv+lO/c0Ld3HI+bkDLzU/dL0lT+yeoWsn22UDj4DZNFVWKK
         ODDWGN0fVdKeiEyQMIYFm9oLkokuiqVGcQJDdLvlFME7ZD7BaXB+K+UdrUmt6OMe/dhj
         pwqg==
X-Gm-Message-State: AOJu0YwB7Xj3TpfumXk+1UgQpJ8xB2GOYyCzdY/G7GE4+BkZPO3HOKrO
	5rHK+XBPdkQqSqOu/Fc5HGAFgwPAeI0F4eF6yRE9SoUorxo+gSNvj0ad8q8ADw==
X-Gm-Gg: ATEYQzxhIL+wSIrlXy9mu6zcbGF2/myVEvJlKd40lgrw/vASCJCFT34DxaKDhJ/SAQ1
	PjjYLfgyMsM0+uZOeOnhPuSdukA9NaKfTm5kJXTN21lN98NzK1wCike6fWl2aSrbuGfqGJJ+sOT
	HN7PiMUOQmY3BRnmCq7VHx6VQhyHCe9ViNHM7sYWU2t/2hU4NZXu85D7B8oyIDGYBtG1soJb7NT
	iTLlJeAujwIWD7lZEmIthHcgOOef2u0gwLEvaO4D8ALvPvkGGELys4adZ7T9AY4moUf+dj45TF8
	pf5+gbI5sYheCJeLotmkv0uSyiDmlC6Bg6ayCv1mGJ9P3G6El+AGTuduBgYBIRMI1c9qjelCRV1
	0sjj57ugvFyruuk0p9OIP4pMTvLtK7UtAGoBnF7bsbOAbZ81HZfxH8hVH+e6vGCOZDKokeK8Qhb
	KF5YhWRQH2RvaUZ87ItWbvbj2ObA==
X-Received: by 2002:a05:620a:198a:b0:8b2:7435:f5ef with SMTP id af79cd13be357-8cbc8e4f7a8mr54052685a.41.1772140496835;
        Thu, 26 Feb 2026 13:14:56 -0800 (PST)
Received: from [127.0.0.1] ([145.132.100.81])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cbbf71a8cesm299378885a.38.2026.02.26.13.14.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 13:14:56 -0800 (PST)
Message-Id: <fd18f28db0bac01317c892f14bd9bf16038e07f0.1772140487.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2208.v4.git.git.1772140487.gitgitgadget@gmail.com>
References: <pull.2208.v3.git.git.1771875812.gitgitgadget@gmail.com>
	<pull.2208.v4.git.git.1772140487.gitgitgadget@gmail.com>
From: "Eslam reda ragheb via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 26 Feb 2026 21:14:44 +0000
Subject: [PATCH v4 07/10] t1900: cover repo info path keys and path-format
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
Cc: eslam reda <eslam.reda.div@gmail.com>,
    Eslam reda ragheb <eslam.reda.div@gmail.com>

From: Eslam reda ragheb <eslam.reda.div@gmail.com>

Extend t1900 to validate category-key expansion, path.* key
behavior, and --path-format handling for git repo info.

The tests compare repo info output to equivalent rev-parse values.

This ensures behavior remains aligned with existing plumbing
semantics.

Also keep mixed key/category ordering coverage so callers can rely
on deterministic output order when combining explicit keys with
category requests.

Signed-off-by: Eslam reda ragheb <eslam.reda.div@gmail.com>
---
 t/t1900-repo.sh | 196 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 196 insertions(+)

diff --git a/t/t1900-repo.sh b/t/t1900-repo.sh
index 51d55f11a5..dcacf84cc3 100755
--- a/t/t1900-repo.sh
+++ b/t/t1900-repo.sh
@@ -10,9 +10,40 @@ REPO_INFO_KEYS='
 	layout.bare
 	layout.shallow
 	object.format
+	path.common-dir
+	path.config-file
+	path.git-dir
+	path.git-prefix
+	path.grafts-file
+	path.hooks-directory
+	path.index-file
+	path.logs-directory
+	path.objects-directory
+	path.packed-refs-file
+	path.refs-directory
+	path.shallow-file
+	path.superproject-working-tree
+	path.toplevel
 	references.format
 '
 
+REPO_INFO_PATH_KEYS='
+	path.common-dir
+	path.config-file
+	path.git-dir
+	path.git-prefix
+	path.grafts-file
+	path.hooks-directory
+	path.index-file
+	path.logs-directory
+	path.objects-directory
+	path.packed-refs-file
+	path.refs-directory
+	path.shallow-file
+	path.superproject-working-tree
+	path.toplevel
+'
+
 # Test whether a key-value pair is correctly returned
 #
 # Usage: test_repo_info <label> <init command> <repo_name> <key> <expected value>
@@ -89,6 +120,171 @@ test_expect_success 'values returned in order requested' '
 	test_cmp expect actual
 '
 
+test_expect_success 'category key returns all matching keys' '
+	cat >expect <<-\EOF &&
+	layout.bare=false
+	layout.shallow=false
+	EOF
+	git init category-layout &&
+	git -C category-layout repo info layout >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'mixed key/category requests preserve request order' '
+	cat >expect <<-EOF &&
+	object.format=$(test_oid algo)
+	layout.bare=false
+	layout.shallow=false
+	EOF
+	git init mixed-order &&
+	git -C mixed-order repo info object.format layout >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'path.git-dir matches rev-parse --absolute-git-dir' '
+	git init path-git-dir &&
+	expected_value=$(git -C path-git-dir rev-parse --absolute-git-dir) &&
+	echo "path.git-dir=$expected_value" >expect &&
+	git -C path-git-dir repo info path.git-dir >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'path.common-dir matches rev-parse --git-common-dir' '
+	git init path-common-dir &&
+	expected_value=$(git -C path-common-dir rev-parse --path-format=absolute --git-common-dir) &&
+	echo "path.common-dir=$expected_value" >expect &&
+	git -C path-common-dir repo info path.common-dir >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'path.toplevel matches rev-parse --show-toplevel' '
+	git init path-toplevel &&
+	expected_value=$(git -C path-toplevel rev-parse --show-toplevel) &&
+	echo "path.toplevel=$expected_value" >expect &&
+	git -C path-toplevel repo info path.toplevel >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'path.toplevel is empty in bare repository' '
+	git init --bare bare-path-toplevel &&
+	echo "path.toplevel=" >expect &&
+	git -C bare-path-toplevel repo info path.toplevel >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'path.git-prefix matches rev-parse --show-prefix' '
+	git init path-prefix &&
+	mkdir -p path-prefix/a/b &&
+	expected_value=$(git -C path-prefix/a/b rev-parse --show-prefix) &&
+	echo "path.git-prefix=$expected_value" >expect &&
+	git -C path-prefix/a/b repo info path.git-prefix >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'git-path style keys match rev-parse --git-path' '
+	git init path-git-path &&
+
+	expected_value=$(git -C path-git-path rev-parse --path-format=absolute --git-path info/grafts) &&
+	echo "path.grafts-file=$expected_value" >expect &&
+	git -C path-git-path repo info path.grafts-file >actual &&
+	test_cmp expect actual &&
+
+	expected_value=$(git -C path-git-path rev-parse --path-format=absolute --git-path index) &&
+	echo "path.index-file=$expected_value" >expect &&
+	git -C path-git-path repo info path.index-file >actual &&
+	test_cmp expect actual &&
+
+	expected_value=$(git -C path-git-path rev-parse --path-format=absolute --git-path objects) &&
+	echo "path.objects-directory=$expected_value" >expect &&
+	git -C path-git-path repo info path.objects-directory >actual &&
+	test_cmp expect actual &&
+
+	expected_value=$(git -C path-git-path rev-parse --path-format=absolute --git-path hooks) &&
+	echo "path.hooks-directory=$expected_value" >expect &&
+	git -C path-git-path repo info path.hooks-directory >actual &&
+	test_cmp expect actual &&
+
+	expected_value=$(git -C path-git-path rev-parse --path-format=absolute --git-path config) &&
+	echo "path.config-file=$expected_value" >expect &&
+	git -C path-git-path repo info path.config-file >actual &&
+	test_cmp expect actual &&
+
+	expected_value=$(git -C path-git-path rev-parse --path-format=absolute --git-path logs) &&
+	echo "path.logs-directory=$expected_value" >expect &&
+	git -C path-git-path repo info path.logs-directory >actual &&
+	test_cmp expect actual &&
+
+	expected_value=$(git -C path-git-path rev-parse --path-format=absolute --git-path packed-refs) &&
+	echo "path.packed-refs-file=$expected_value" >expect &&
+	git -C path-git-path repo info path.packed-refs-file >actual &&
+	test_cmp expect actual &&
+
+	expected_value=$(git -C path-git-path rev-parse --path-format=absolute --git-path refs) &&
+	echo "path.refs-directory=$expected_value" >expect &&
+	git -C path-git-path repo info path.refs-directory >actual &&
+	test_cmp expect actual &&
+
+	expected_value=$(git -C path-git-path rev-parse --path-format=absolute --git-path shallow) &&
+	echo "path.shallow-file=$expected_value" >expect &&
+	git -C path-git-path repo info path.shallow-file >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'path.superproject-working-tree is empty when not a submodule' '
+	git init path-superproject &&
+	echo "path.superproject-working-tree=" >expect &&
+	git -C path-superproject repo info path.superproject-working-tree >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'path.superproject-working-tree matches rev-parse in submodule' '
+	git init path-superproject-origin &&
+	echo x >path-superproject-origin/x &&
+	git -C path-superproject-origin add x &&
+	git -C path-superproject-origin commit -m x &&
+
+	git init path-superproject-parent &&
+	git -C path-superproject-parent -c protocol.file.allow=always submodule add ../path-superproject-origin sm &&
+
+	expected_value=$(git -C path-superproject-parent/sm rev-parse --show-superproject-working-tree) &&
+	echo "path.superproject-working-tree=$expected_value" >expect &&
+	git -C path-superproject-parent/sm repo info path.superproject-working-tree >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'path category returns all path keys' '
+	git init path-category &&
+	>expect &&
+	for key in $REPO_INFO_PATH_KEYS
+	do
+		git -C path-category repo info "$key" >>expect || return 1
+	done &&
+	git -C path-category repo info path >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'path-format=relative matches rev-parse for git-dir' '
+	git init path-format-relative &&
+	expected_value=$(git -C path-format-relative rev-parse --path-format=relative --git-dir) &&
+	echo "path.git-dir=$expected_value" >expect &&
+	git -C path-format-relative repo info --path-format=relative path.git-dir >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'git repo info uses the last requested path format' '
+	git init path-format-last &&
+	expected_value=$(git -C path-format-last rev-parse --path-format=relative --git-dir) &&
+	echo "path.git-dir=$expected_value" >expect &&
+	git -C path-format-last repo info --path-format=absolute --path-format=relative path.git-dir >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'git-repo-info aborts when requesting an invalid path format' '
+	echo "fatal: invalid path format ${SQ}foo${SQ}" >expect &&
+	test_must_fail git repo info --path-format=foo path.git-dir 2>actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'git-repo-info fails if an invalid key is requested' '
 	echo "error: key ${SQ}foo${SQ} not found" >expect &&
 	test_must_fail git repo info foo 2>actual &&
-- 
gitgitgadget

