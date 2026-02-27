Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0B3044D01E
	for <git@vger.kernel.org>; Fri, 27 Feb 2026 19:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772220655; cv=none; b=GsjMkmdWQLDt1TYZD+tUag6u+jx7WKKq5+YeYV+nXuN24bs0bI5Z4W/xJnSYlIqRlywy5cQak9mCUEzk6EMANv1zRY3I83OHUEC476A1pnqOTw5bhGfQ5CfXyrH9CkQ8VlAPZkOwks9Z+Ecq9kDdZXqY6Q9pN1D0YE10yQ+NRbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772220655; c=relaxed/simple;
	bh=BXKnxJAYzI5+BQyq4ke6xQZoUjJgWhMNKWdahyYmu6g=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=NZ9HeXXyMwovzK+IShIkZzfMn2puzH7zFfZ5+BbfsftxCTUybJrp10uh3eHXZBxG4Kc09GLNqjeB31c95P5xCdcvx+VQR0xuEu8J+BJihkb94EZfLe9KwtdjczyOmcCEvvc+PBDKXm4hjaGWY2ec0kE/HyAXALBScSh9e2Vos8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ejYIlvaq; arc=none smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ejYIlvaq"
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-2bdcd7f0222so3345573eec.0
        for <git@vger.kernel.org>; Fri, 27 Feb 2026 11:30:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772220653; x=1772825453; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6aKeJpnmXGNCGtZ7wzEwaHUJPnmqm1Yzc5DSgNEAels=;
        b=ejYIlvaq51Aqbs6c4eeybm8kwoc6t4jn2h49bzqGMZIuRUL1P6TTWnJ02340KpUuQH
         jmAUnW+u8MeimFIfQAwhbl9YAgP8sCWk6NO9w14GhYpmQKnSDv++vJ6OyFYxvVIouTgB
         PkS2cWLXA2rYY5uCH6W4PIaek3gIN0GjQasWo8LCz/i5AS+N0ztbmBM/MdWTEOJct2pl
         Km715eetpogpI5YmzYQz/s0FgiXuXMxmn9c/myg/2o2XfMgnrI7AqMr9wgo4mrOpFlyQ
         LmPoXJvKXg8lELZ/nbn6+le0d8JgrmrAUvqrbC3dWKIsTJK1xQCwOfTomH9eSKt4zuOH
         +qIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772220653; x=1772825453;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6aKeJpnmXGNCGtZ7wzEwaHUJPnmqm1Yzc5DSgNEAels=;
        b=u6h0uUZKJF9RPE5vNOGci8Odx61EmIjs4A2Be/d9FH3IFtDE2bYqHquqyN909RDCba
         COMlqDKr3C7uuDDObWJA8GIer3w6+BhScv9JZVPNLUJJIiMMYRC5q1lDN3eEb3Apz14U
         zO/4YsJ037q4N1ASXiqeA5Bmd29z+TWNjzebFtUVbcyRd9HgBZQJ8eyKLaYUGS4kNxrl
         DrWAAYwXfOwZSNDefKSZBJ6NddspXMnjolEWkTAw0eA5Wnl5GbhVfXrVEqUSzBQub6tH
         eRLDN9tzyw/+p2un/xjIx+PEx1VoTzT/h+/dhn+NuNnaYcJpBcJXwXvFJLv/4euiX7UN
         PZJQ==
X-Gm-Message-State: AOJu0YyaRjhLaFzgfd5ST1jRzqJgisxan6oiriKahMvtvyzHUBwzN1yb
	KsKzdEMg7cgp0V59m+jrcUbXalocGOJ5OlCk5QXVo2WJRXtN1wuCMJK1nKxMsA==
X-Gm-Gg: ATEYQzz6exE7oXWSsLEHahYUdAc1Leh55If8Y9A+naMcU0+qDHTTEjkKc2oTrKVgnq9
	IHCIUiKcZjdxpM66XOFSiltgsVs3stvOYomAiTQYEfzyaGAxhiUhH0yymDBAYQVot/QPSwtb94B
	Xie7I3Mwy2tAG9aq2OIP11tnBXD3O02Ge48MxhpR6K+RRB0XORxx2TGTCZDta0rUZJZKiq9m21f
	5PndeEraWKt2RcHxwONfArGhoaPzWfQiu3feVwGcvuNE8wPjI4ZxYH4xGtfp6uhPrPcjUMpiT3R
	nRkJcaoCEWPvZcsHX22N+jedNCyFx48DoKNNsqjIP7IowcG03SeairTWqTQJiyfD/V9E5Jtj7F7
	xEKNL4CHbnBTXU+U2MxR/rHv9/V2Vy8dyEjs0TnU6KqqnZh/is9TyD/9vWQLLfN+39Tk+KPdrZz
	FfqZsmy601CBUoEbZHBdf9rm3OxNo=
X-Received: by 2002:a05:7300:bc1a:b0:2bd:d157:678c with SMTP id 5a478bee46e88-2bde1ee0a1dmr1441178eec.38.1772220652349;
        Fri, 27 Feb 2026 11:30:52 -0800 (PST)
Received: from [127.0.0.1] ([172.184.191.161])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2bdd1f23c01sm4501934eec.16.2026.02.27.11.30.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 11:30:51 -0800 (PST)
Message-Id: <fd18f28db0bac01317c892f14bd9bf16038e07f0.1772220640.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2208.v5.git.git.1772220640.gitgitgadget@gmail.com>
References: <pull.2208.v4.git.git.1772140487.gitgitgadget@gmail.com>
	<pull.2208.v5.git.git.1772220640.gitgitgadget@gmail.com>
From: "Eslam reda ragheb via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 27 Feb 2026 19:30:36 +0000
Subject: [PATCH v5 07/11] t1900: cover repo info path keys and path-format
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
Cc: Phillip Wood <phillip.wood123@gmail.com>,
    eslam reda <eslam.reda.div@gmail.com>,
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

