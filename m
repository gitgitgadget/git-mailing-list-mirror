Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06DB8199E9D
	for <git@vger.kernel.org>; Mon, 22 Sep 2025 01:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758505166; cv=none; b=nsv2Il+pUyavC1dlFp4ijFP8rteUndXMnvXPNcw79J94HzH7FywJJf1LDGdH76iJcgPH4cpdwXLcSHG8eW0iAE0qmBeqWnepkp2/DLx40GsAzj9S/yGz2dD5+gR+MWSCbId7Mut41yuMnDJO/3nz0fljiBCYS5iHnh2NPJ5QdAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758505166; c=relaxed/simple;
	bh=UC9HRoIYtwl824f/YezEGuaTE+7QP6j+mWwmcOjC4B0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dFuWctrx3fZTQ/yNAicHfPyb3RL3wclHz/aTO9lx0/U0BY+G4IWVrJR0x0kzDujHHJqhzU21BFxMZYst6zSps88WqlBjFX4RFWnf/lxIiXeAdkG9SplrCjligT+RT5g3KPODxzdloFDQsO7PyXR0TieSC8opM8+4H5PZcdfrbUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i7o/eZJ9; arc=none smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i7o/eZJ9"
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-6354a4b4871so171892d50.2
        for <git@vger.kernel.org>; Sun, 21 Sep 2025 18:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758505164; x=1759109964; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RYv+rbkFxsxkyaChG8In6kryiIiuPySFuAWmE+4pwAU=;
        b=i7o/eZJ9tAjBpBXj6sYhnTdB48X6fbe5X9cQOQ7QJgazNgo7UlavagyRUpCPLhsmws
         zGFCoS/tyDCdxMrBJlhAmSxqWkVS0hxmaWuxUfajt36U7tY6C6uzWBk7KDYBkMito0Uo
         LfX6rjg/5MnPiZttIprQE1wmitK/cuLCPsgKmKdzPxZRx2acnmQvkLUuL5gKE6TLBouA
         B8tXIwbQKlo/iuKmOvQTZx0lrfwCSxqQtc0iKAf0pOfZwy9BdZMQXkN98rEEn6B3ZfRE
         vQK4UoFNbF6vmGy14Rs9rgi/xsgV9rTvJ3UbWwG14k2RdjmKO6jINEMuajDmxXfMEfYV
         W5Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758505164; x=1759109964;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RYv+rbkFxsxkyaChG8In6kryiIiuPySFuAWmE+4pwAU=;
        b=LGahDsF6IaXu0WjSmbP9xG2G8w3w6tPah22rC+he1GSt0NIknjySpYtClvc65Fmml7
         mxaL7WZv2BO32Si0FA8aH7Td/knhtTT+t0DJG51k0bv1HYTl8cd4ku5NINiI2ncVSOAP
         bxLUT79osqxKNW1CjTbw6f9GfB/ouCOhY09K1Yug2RsPRy+x5u8v+ASeTZ3ZnuZqTYK2
         ap907+b/7t9NUX5q4GTFC37MlibJqUyBdBMsuuYvmulQDUXqYLE8DRR6XuoazB2ROnt3
         RB7g9Un2e+ByQtDFUaSxE4p4KQdYcKaFpnYc+WP3sHmnceJ+YW9JX5I27SsvwXA7LYEI
         b/Kw==
X-Gm-Message-State: AOJu0YzOL0ByZvpBrp1kxe13n5pdHjb2rCXMzcdLhUaksFTVR2E0/Lvu
	6SmnnALj+0qzDM8q14yqMZC7eQILRwvIvsRkGjX91O9Mmlq9pcWfAHurk016GTkz
X-Gm-Gg: ASbGncv3z5qEubZ2UWK3Xo7+Fiesu2I732ZaeBw2kDhDWzfflR08ry7O+udv14319DH
	BKho89fRF0kqEGhV4zHILGoJe5TXZvXp0ukDDOLQcqBTqVWoInQU2ubnK6Xh+T3BM//S1Cduv08
	fAhHfFR6HkVwWtE/LBvEV21Ybd7XNTzoGRNaMSqL9f0gqR2sstA8/ZeI2LV18yToFJerx11VR7v
	DMsyrpkYLeDSCT+Go9M73DdB26m/eO+i62WsXLUuYy0lZBfSkj5tw4OaZzUYcWk2ls8bDRMzq+a
	QbhAV1svspjhlzep3JDOr18VaWpjx36wgvrrjGbg+BmPGHwX5lP4+qkTJJI1faifwLHj70/774t
	9vG5Pht+/lpQl4rgYfRlD0+ZrNkJCpqucPAox+71BXzeOSmKEK8pLPCMJX0dHKNtePiiUgRvDKu
	quKQ==
X-Google-Smtp-Source: AGHT+IE80327J14uv1CvWrwr0iCK65FtM/4SnK3nl8DDHLkOaYmIpnIrWFHrXT18Prybhf/GNZaOBA==
X-Received: by 2002:a05:690e:250e:10b0:5f3:315d:900b with SMTP id 956f58d0204a3-6347f5e08f8mr7544353d50.38.1758505163695;
        Sun, 21 Sep 2025 18:39:23 -0700 (PDT)
Received: from localhost.localdomain (69-77-149-20.skybest.com. [69.77.149.20])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-633bcd05dd7sm3942069d50.7.2025.09.21.18.39.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Sep 2025 18:39:23 -0700 (PDT)
Sender: "D. Ben Knoble" <ben.knoble@gmail.com>
From: "D. Ben Knoble" <ben.knoble+github@gmail.com>
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble+github@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	moti sd <motisd8@gmail.com>,
	Denton Liu <liu.denton@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Karthik Nayak <karthik.188@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= <avarab@gmail.com>,
	Glen Choo <glencbz@gmail.com>
Subject: [PATCH v3 4/4] stash: honor stash.index in apply, pop modes
Date: Sun, 21 Sep 2025 21:39:06 -0400
Message-ID: <8e6cafbf3a01b968663b65559acf3df615eecbad.1758505011.git.ben.knoble+github@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1758505011.git.ben.knoble+github@gmail.com>
References: <cover.1757982870.git.ben.knoble+github@gmail.com> <cover.1758505011.git.ben.knoble+github@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With stash.index=true, git-stash(1) command now tries to reinstate the
index by default in the "apply" and "pop" modes. Not doing so creates a
common trap [1], [2]: "git stash apply" is not the reverse of "git stash
push" because carefully staged indices are lost and have to be manually
recreated. OTOH, this mode is not always desirable and may create more
conflicts when applying stashes. As usual, "--no-index" will disable
this behavior if you set "stash.index".

[1]: https://lore.kernel.org/git/CAPx1GvcxyDDQmCssMjEnt6JoV6qPc5ZUpgPLX3mpUC_4PNYA1w@mail.gmail.com/
[2]: https://lore.kernel.org/git/c5a811ac-8cd3-c389-ac6d-29020a648c87@gmail.com/

Signed-off-by: D. Ben Knoble <ben.knoble+github@gmail.com>
---
 Documentation/config/stash.adoc |  5 +++++
 builtin/stash.c                 |  9 ++++++--
 t/t3903-stash.sh                | 37 +++++++++++++++++++++++++++++++++
 3 files changed, 49 insertions(+), 2 deletions(-)

diff --git a/Documentation/config/stash.adoc b/Documentation/config/stash.adoc
index ec1edaeba6..e556105a15 100644
--- a/Documentation/config/stash.adoc
+++ b/Documentation/config/stash.adoc
@@ -1,3 +1,8 @@
+stash.index::
+	If this is set to true, `git stash apply` and `git stash pop` will
+	behave as if `--index` was supplied. Defaults to false. See the
+	descriptions in linkgit:git-stash[1].
+
 stash.showIncludeUntracked::
 	If this is set to true, the `git stash show` command will show
 	the untracked files of a stash entry.  Defaults to false. See
diff --git a/builtin/stash.c b/builtin/stash.c
index d9b478d1d1..8a0eef3c70 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -130,6 +130,7 @@ static struct strbuf stash_index_path = STRBUF_INIT;
 static int show_stat = 1;
 static int show_patch;
 static int show_include_untracked;
+static int use_index;
 
 /*
  * w_commit is set to the commit containing the working tree
@@ -662,7 +663,7 @@ static int apply_stash(int argc, const char **argv, const char *prefix,
 {
 	int ret = -1;
 	int quiet = 0;
-	int index = 0;
+	int index = use_index;
 	struct stash_info info = STASH_INFO_INIT;
 	struct option options[] = {
 		OPT__QUIET(&quiet, N_("be quiet, only report errors")),
@@ -759,7 +760,7 @@ static int pop_stash(int argc, const char **argv, const char *prefix,
 		     struct repository *repo UNUSED)
 {
 	int ret = -1;
-	int index = 0;
+	int index = use_index;
 	int quiet = 0;
 	struct stash_info info = STASH_INFO_INIT;
 	struct option options[] = {
@@ -864,6 +865,10 @@ static int git_stash_config(const char *var, const char *value,
 		show_include_untracked = git_config_bool(var, value);
 		return 0;
 	}
+	if (!strcmp(var, "stash.index")) {
+		use_index = git_config_bool(var, value);
+		return 0;
+	}
 	return git_diff_basic_config(var, value, ctx, cb);
 }
 
diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index b8936a653b..d6127173b1 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -1595,4 +1595,41 @@ setup_stash()
 	)
 '
 
+test_expect_success 'stash.index=true implies --index' '
+	# setup for a few related tests
+	test_commit file base &&
+	echo index >file &&
+	git add file &&
+	echo working >file &&
+	git stash &&
+
+	test_when_finished "git reset --hard" &&
+	git -c stash.index=true stash apply &&
+	echo index >expect &&
+	git show :0:file >actual &&
+	test_cmp expect actual &&
+	echo working >expect &&
+	test_cmp expect file
+'
+
+test_expect_success 'stash.index=true overridden by --no-index' '
+	test_when_finished "git reset --hard" &&
+	git -c stash.index=true stash apply --no-index &&
+	echo base >expect &&
+	git show :0:file >actual &&
+	test_cmp expect actual &&
+	echo working >expect &&
+	test_cmp expect file
+'
+
+test_expect_success 'stash.index=false overridden by --index' '
+	test_when_finished "git reset --hard" &&
+	git -c stash.index=false stash apply --index &&
+	echo index >expect &&
+	git show :0:file >actual &&
+	test_cmp expect actual &&
+	echo working >expect &&
+	test_cmp expect file
+'
+
 test_done
-- 
2.48.1

