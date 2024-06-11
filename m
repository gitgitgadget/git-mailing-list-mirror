Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C914D171E58
	for <git@vger.kernel.org>; Tue, 11 Jun 2024 06:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718088136; cv=none; b=AxEW90ibMsWKLEFY/dVWOzR8NJleMx9jE4u7sRBEaLpUpfRxsx5/NzuOPRRYeKHDRMfgRIMTGF12PjwuGVlOm/zkfT8EWh8M34CKXKDNFDjC4Mtsoe9+dPdsMnCwkemvPEXyPIORgE9i20JdRcr6dUddBY8/tQJX+tWVVH0IOow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718088136; c=relaxed/simple;
	bh=F6POH7ho8PGBmVNlJkF7VXrw0V3ik8Zi0l7km5vLw/8=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=iRtEz2SjBSseSB4KDEDUJ0pPxMV+ZSzHuzYVpwpaIGMGhZa7XR4NsxJMy4T0qVR1+p48E/3Uq6SSB4tj1ZyJ61ecCOB+zHfbej0u83ImtHS3m/3mi6XwmOlOt4DAbKCjlrszte4uEEhQKT7fydoXU3/5Hsr75pGaJ9nvA7fjmVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ky+qQYal; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ky+qQYal"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4218314a6c7so16593175e9.0
        for <git@vger.kernel.org>; Mon, 10 Jun 2024 23:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718088133; x=1718692933; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P2qqmGU50yzWE1RKi003nosD8p/1ffXWT+ICSAiCNJA=;
        b=ky+qQYalV5vJIJpBvHQcKpPbq3Z0X4LLjsmVIFetvE4QpYE+jF9pJQ9LCaUS92BtTs
         LUmyXUUOKTiyTUa5h1zcAMUx4VVljMEY7Ia8GPpy7shMfcPtBXZ+EOeTfoUUzW3sGNA0
         D73oegu/fSdEG8VmobkNn2SCyVaxGVeEZncRgNvdM44kD+fwOExYiFixf7p9tiedcLrx
         JdnS4WOO50oOS538XVxfoFLW1F0+FWEjwk/VX+YdxvHeMWspqVdMUELH2Nb2T37/v1xp
         m9Y4Nf8JMY54cmnVzni92FfaM9ACGr3ld/D1ACF1FCJ3Omqr39B146K4gtounOOrNEw6
         gXIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718088133; x=1718692933;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P2qqmGU50yzWE1RKi003nosD8p/1ffXWT+ICSAiCNJA=;
        b=XKByM4oPV6ni/03mVkTNHgxsa4sxk4Xo4Az3B2pJoiaUAP3xumSkaDogCFASd8uIYX
         cFxzX6b6IAH3R4pIZjr516dE+kwev9Qu7+l1RGrfimxw9Hc2oDldQfQfH4YQUKwvSwvp
         0UvYYs3Hg0s7iLOaiNnS6tbPMSkvQ+Ka3q5z1BiSR39tBTU+rNlXTesRSUOBAigs65ey
         rhBhVZrK/ezoV6GRWVC3m83v3/RcqIfeIqrcha8yMloGsixwGHUqDaCry7ajHd7AIci2
         APCkmri2LtKARe3Z21ZGdpv2f7I+RVl7GMzgzcHiREoJhWNIN8YhNv8kYN5KB6jTaJix
         YU5w==
X-Gm-Message-State: AOJu0YwSlYUT0nBB1KhsLndwkFAogk0Sgsx+Q7RG3Q1YuPI2gY5MXjNa
	v435JQQkb/RN6bfIdPVM54B0DBtkHtcIqGlJU8wXn/IRih2f2iFM2j3DyQ==
X-Google-Smtp-Source: AGHT+IFotFoyDP7yvOs+eiaoM3oAA9xo1oRsehKR8E+LjDWIP1rz3shtzLReM6IBKpox5PjBQzyT+g==
X-Received: by 2002:a05:600c:1988:b0:421:63f7:7e13 with SMTP id 5b1f17b1804b1-42164a3aff5mr76645745e9.39.1718088132620;
        Mon, 10 Jun 2024 23:42:12 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35f215d4602sm5467703f8f.74.2024.06.10.23.42.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jun 2024 23:42:12 -0700 (PDT)
Message-Id: <eb9f21f16b5d2b01e67510eaec160cecabbcc049.1718088127.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1730.v5.git.1718088126.gitgitgadget@gmail.com>
References: <pull.1730.v4.git.1717057290.gitgitgadget@gmail.com>
	<pull.1730.v5.git.1718088126.gitgitgadget@gmail.com>
From: "Xing Xin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 11 Jun 2024 06:42:06 +0000
Subject: [PATCH v5 4/4] unbundle: use VERIFY_BUNDLE_FSCK_FOLLOW_FETCH for
 fetches
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
Cc: Patrick Steinhardt <ps@pks.im>,
    Karthik Nayak <karthik.188@gmail.com>,
    blanet <bupt_xingxin@163.com>,
    Xing Xin <xingxin.xx@bytedance.com>

From: Xing Xin <xingxin.xx@bytedance.com>

This commit passes `VERIFY_BUNDLE_FSCK_FOLLOW_FETCH` to `unbundle` in
the fetching process, including:

- `transport.c:fetch_refs_from_bundle` for direct bundle fetches.
- `bundle-uri.c:unbundle_from_file` for bundle-uri enabled fetches.

This addition ensures a consistent logic for object verification during
fetch operations. Tests have been added to confirm functionality in the
scenarios mentioned above.

Reviewed-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Xing Xin <xingxin.xx@bytedance.com>
---
 bundle-uri.c                |  2 +-
 t/t5558-clone-bundle-uri.sh | 35 ++++++++++++++++++++++++++++++++++-
 t/t5607-clone-bundle.sh     | 33 +++++++++++++++++++++++++++++++++
 transport.c                 |  2 +-
 4 files changed, 69 insertions(+), 3 deletions(-)

diff --git a/bundle-uri.c b/bundle-uri.c
index 65666a11d9c..e7ebac6ce57 100644
--- a/bundle-uri.c
+++ b/bundle-uri.c
@@ -373,7 +373,7 @@ static int unbundle_from_file(struct repository *r, const char *file)
 	 * the prerequisite commits.
 	 */
 	if ((result = unbundle(r, &header, bundle_fd, NULL,
-			       VERIFY_BUNDLE_QUIET)))
+			       VERIFY_BUNDLE_QUIET | VERIFY_BUNDLE_FSCK_FOLLOW_FETCH)))
 		return 1;
 
 	/*
diff --git a/t/t5558-clone-bundle-uri.sh b/t/t5558-clone-bundle-uri.sh
index 8f4f802e4f1..48be1b18802 100755
--- a/t/t5558-clone-bundle-uri.sh
+++ b/t/t5558-clone-bundle-uri.sh
@@ -30,7 +30,21 @@ test_expect_success 'create bundle' '
 		git bundle create B.bundle topic &&
 
 		# Create a bundle with reference pointing to non-existent object.
-		sed "s/$(git rev-parse A)/$(git rev-parse B)/" <A.bundle >bad-header.bundle
+		sed "s/$(git rev-parse A)/$(git rev-parse B)/" <A.bundle >bad-header.bundle &&
+
+		cat >data <<-EOF &&
+		tree $(git rev-parse HEAD^{tree})
+		parent $(git rev-parse HEAD)
+		author A U Thor
+		committer A U Thor
+
+		commit: this is a commit with bad emails
+
+		EOF
+		git hash-object --literally -t commit -w --stdin <data >commit &&
+		git branch bad $(cat commit) &&
+		git bundle create bad-object.bundle bad &&
+		git update-ref -d refs/heads/bad
 	)
 '
 
@@ -52,6 +66,25 @@ test_expect_success 'clone with bundle that has bad header' '
 	! grep "refs/bundles/" refs
 '
 
+test_expect_success 'clone with bundle that has bad object' '
+	# Unbundle succeeds if no fsckObjects confugured.
+	git clone --bundle-uri="clone-from/bad-object.bundle" \
+		clone-from clone-bad-object-no-fsck &&
+	git -C clone-bad-object-no-fsck for-each-ref --format="%(refname)" >refs &&
+	grep "refs/bundles/" refs >actual &&
+	cat >expect <<-\EOF &&
+	refs/bundles/bad
+	EOF
+	test_cmp expect actual &&
+
+	# Unbundle fails with fsckObjects set true, but clone can still proceed.
+	git -c fetch.fsckObjects=true clone --bundle-uri="clone-from/bad-object.bundle" \
+		clone-from clone-bad-object-fsck 2>err &&
+	test_grep "missingEmail" err &&
+	git -C clone-bad-object-fsck for-each-ref --format="%(refname)" >refs &&
+	! grep "refs/bundles/" refs
+'
+
 test_expect_success 'clone with path bundle and non-default hash' '
 	test_when_finished "rm -rf clone-path-non-default-hash" &&
 	GIT_DEFAULT_HASH=sha256 git clone --bundle-uri="clone-from/B.bundle" \
diff --git a/t/t5607-clone-bundle.sh b/t/t5607-clone-bundle.sh
index 0d1e92d9963..5182efc0b45 100755
--- a/t/t5607-clone-bundle.sh
+++ b/t/t5607-clone-bundle.sh
@@ -138,6 +138,39 @@ test_expect_success 'fetch SHA-1 from bundle' '
 	git fetch --no-tags foo/tip.bundle "$(cat hash)"
 '
 
+test_expect_success 'clone bundle with different fsckObjects configurations' '
+	test_create_repo bundle-fsck &&
+	(
+		cd bundle-fsck &&
+		test_commit first &&
+		cat >data <<-EOF &&
+		tree $(git rev-parse HEAD^{tree})
+		parent $(git rev-parse HEAD)
+		author A U Thor
+		committer A U Thor
+
+		commit: this is a commit with bad emails
+
+		EOF
+		git hash-object --literally -t commit -w --stdin <data >commit &&
+		git branch bad $(cat commit) &&
+		git bundle create bad.bundle bad
+	) &&
+
+	git clone bundle-fsck/bad.bundle bundle-no-fsck &&
+
+	git -c fetch.fsckObjects=false -c transfer.fsckObjects=true \
+		clone bundle-fsck/bad.bundle bundle-fetch-no-fsck &&
+
+	test_must_fail git -c fetch.fsckObjects=true \
+		clone bundle-fsck/bad.bundle bundle-fetch-fsck 2>err &&
+	test_grep "missingEmail" err &&
+
+	test_must_fail git -c transfer.fsckObjects=true \
+		clone bundle-fsck/bad.bundle bundle-transfer-fsck 2>err &&
+	test_grep "missingEmail" err
+'
+
 test_expect_success 'git bundle uses expected default format' '
 	git bundle create bundle HEAD^.. &&
 	cat >expect <<-EOF &&
diff --git a/transport.c b/transport.c
index 0ad04b77fd2..6cd5683bb45 100644
--- a/transport.c
+++ b/transport.c
@@ -184,7 +184,7 @@ static int fetch_refs_from_bundle(struct transport *transport,
 	if (!data->get_refs_from_bundle_called)
 		get_refs_from_bundle_inner(transport);
 	ret = unbundle(the_repository, &data->header, data->fd,
-		       &extra_index_pack_args, 0);
+		       &extra_index_pack_args, VERIFY_BUNDLE_FSCK_FOLLOW_FETCH);
 	transport->hash_algo = data->header.hash_algo;
 	return ret;
 }
-- 
gitgitgadget
