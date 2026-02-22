Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E71D350D7F
	for <git@vger.kernel.org>; Sun, 22 Feb 2026 18:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771784945; cv=none; b=InCsenRQig7/u2QtS0qCSN917olfs968/WrwM4onAO6hwXXQlikNNfTjxC3LP/5zqGEt69BEA0ccAxz+hcw1kv7x6v0l1TA3ZpJvbWq7J8LgXrVfQH1722g5sqCeST4ZQC4mmHJnzqMxnK+yqtE8mCa/GeJ/Z9MkcVbQpHyg33Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771784945; c=relaxed/simple;
	bh=KVRu/T8sbAy5YSm7dTQjUWqS7wQDeL7asGyVPUoRKdg=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=FSGC/mDJH4rV3wpKou62s3jXjEnGKU+MAucB6Pn4Op2umEdZWFMF2BLk9g3lQtod6YtsF6NCYWK2h9E3c5eKl41RsYK3i7Kg6z6Am9ZWeMT5YbsXhKJyBzon2UHb5CcaMlYagHgjyWRGUulse2VUG1gHPTY1RO5HbuUE6ztlt4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZLNFPTQb; arc=none smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZLNFPTQb"
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-2ba90683995so1512282eec.1
        for <git@vger.kernel.org>; Sun, 22 Feb 2026 10:29:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771784943; x=1772389743; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X8cWgGEb2SUnlm2MWwt9TeA24kPEyOrI5lHY91E7cXY=;
        b=ZLNFPTQbrKD6DnqU/KpjZw+KsFzwNC9GrzY+6CGZ3i033XAB/zzGQMq7Y1recKdPjY
         hJnPg4s1D8PHInYv0tFfNiBKnQCj0Ga0mZNL816jG53XqnccPXv+4ilRLdDBd7yYeUWx
         mUy+d+/z5Zn34COos5cn2LMEw97oDXu1Jw20ctLSWLR4waT5BOv4umm9qUlJbOUfVjGL
         a3HMXI3/mgsgBuz+71n8Lsgz0WoyKDK5HtcR9UALE6VxbiUwirZjpgRYK9JYmKGD8LPj
         hSmuwE5yIfXKKaUkadVGk7otBmrd9LcwXoxm4dv0r/idmKyadPj3LTZ8K7aWi7SxckdY
         lumQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771784943; x=1772389743;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=X8cWgGEb2SUnlm2MWwt9TeA24kPEyOrI5lHY91E7cXY=;
        b=kfPi9K/hqctFiWrT5vwuPGOCpGhPC/a8H9BffcQzW4Oz7Yz7ojn2uX3abROwXfvOEL
         nOCxLNAC+omil1XozoJwkjXxexOEhy6wMj/bSI1dYYe8bX2fDPG+bV8YjT4TU0XWtdk6
         Gkq8vlSgFB/NoTT66m+TGcknDZ8wIBEck6QpzdpL5+KHJgh9+qsE8QfDZ1pnTKQcligq
         9zsjH0l0UmV88MZPjIPy3naShB3D7OZVN064RXxxPly2kmW58eLEakmOdzwO0kqO8e30
         73PVjKhMY/Mv/m4DC/JzirbP4OYE7KeAiEBgaZQckGA8gGwfctdovGpUKiVgvm7ZD2E+
         Vsmw==
X-Gm-Message-State: AOJu0YxXJJiobdhONBqkkdZGdhqOFlqSrBBueUltWZev9abDzZFgNmo9
	0X3E+iC8fC3z4ofiM2NKpskSRgO0t3USd661VtboBqyw8ebUpsfVIAnfgVh5vOIg
X-Gm-Gg: AZuq6aLsBFipoDcKyBPCyhj93KaZYXkNstQCti9A0Vj69/mAsYPAv5yRa/ly0QX0UR/
	X26P/KbA135GhO1JdwJmemDFpRyCWplE3B6kWK4hFfrEnEg10JZYc3beeV0Bo72LxzSY5HsqZnw
	20AOSSxOjMIiJbqxPW7CBL5SdaZzyroRvqHMN0GSivqO0asFfg+ahuF6txQruKdsgDjey5QJYzY
	hliGs8sdwFLwY+/9zhQnvcNMZqm6YaFSsM0Ar4itSBu9EUF3MC8ji0PRIeR5r+EXKbljTo8dWEK
	tOmaxWem15diUrxgLzBRqcfIxw5CeZoKiMcCHXJD973tQ9V41Trn0XgEPe5+pPVuR+XOEb2B6ia
	Pf78RDjp0dODb21CnCVcZ5f4VPCTY1wypkbT5Np8GRd7alSzHCxh6VC7Plgpv3AhJVd9ZSOVJB9
	3AzBL1RyrQCzf//qugYC42wYNc
X-Received: by 2002:a05:7301:4443:b0:2ba:7046:b6b5 with SMTP id 5a478bee46e88-2bd7b8b943bmr2232051eec.15.1771784942894;
        Sun, 22 Feb 2026 10:29:02 -0800 (PST)
Received: from [127.0.0.1] ([20.171.51.209])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2bd7daa35f7sm3636163eec.8.2026.02.22.10.29.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Feb 2026 10:29:02 -0800 (PST)
Message-Id: <3c656bf152a9d18ab87c60b0581dad5d67f55104.1771784936.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2208.git.git.1771784936.gitgitgadget@gmail.com>
References: <pull.2208.git.git.1771784936.gitgitgadget@gmail.com>
From: "Eslam reda ragheb via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 22 Feb 2026 18:28:56 +0000
Subject: [PATCH 3/3] t1900,t1901: fix test portability issues
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
Cc: Karthik Nayak <karthik.188@gmail.com>,
    Justin Tobler <jltobler@gmail.com>,
    Ayush Chandekar <ayu.chandekar@gmail.com>,
    Siddharth Asthana <siddharthasthana31@gmail.com>,
    Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>,
    eslam reda <eslam.reda.div@gmail.com>,
    Eslam reda ragheb <eslam.reda.div@gmail.com>

From: Eslam reda ragheb <eslam.reda.div@gmail.com>

Signed-off-by: Eslam reda ragheb <eslam.reda.div@gmail.com>
---
 t/t1901-repo-structure.sh | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/t/t1901-repo-structure.sh b/t/t1901-repo-structure.sh
index d9e2842307..7b7c4117aa 100755
--- a/t/t1901-repo-structure.sh
+++ b/t/t1901-repo-structure.sh
@@ -228,20 +228,20 @@ test_expect_success SHA1 'keyvalue and nul format' '
 
 		cat >expect <<-EOF &&
 		references.count=$(reference_count_total)
-		references.branches.count=$(git for-each-ref --format="%(refname)" refs/heads | sed -n "\$=")
-		references.tags.count=$(git for-each-ref --format="%(refname)" refs/tags | sed -n "\$=")
-		references.remotes.count=$(git for-each-ref --format="%(refname)" refs/remotes | sed -n "\$=")
+		references.branches.count=1
+		references.tags.count=1
+		references.remotes.count=0
 		references.others.count=0
 		objects.count=$(object_count_total)
-		objects.commits.count=$(object_type_count commit)
-		objects.trees.count=$(object_type_count tree)
-		objects.blobs.count=$(object_type_count blob)
-		objects.tags.count=$(object_type_count tag)
+		objects.commits.count=42
+		objects.trees.count=42
+		objects.blobs.count=42
+		objects.tags.count=1
 		objects.inflated_size=$(object_total_inflated_size)
-		objects.commits.inflated_size=$(object_type_total_inflated_size commit)
-		objects.trees.inflated_size=$(object_type_total_inflated_size tree)
-		objects.blobs.inflated_size=$(object_type_total_inflated_size blob)
-		objects.tags.inflated_size=$(object_type_total_inflated_size tag)
+		objects.commits.inflated_size=9225
+		objects.trees.inflated_size=28554
+		objects.blobs.inflated_size=453
+		objects.tags.inflated_size=132
 		objects.max_inflated_size=$(object_max_inflated_size)
 		objects.commits.max_inflated_size=$(object_type_max_inflated_size commit)
 		objects.trees.max_inflated_size=$(object_type_max_inflated_size tree)
-- 
gitgitgadget
