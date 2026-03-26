Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D67343C6616
	for <git@vger.kernel.org>; Thu, 26 Mar 2026 15:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774538106; cv=none; b=HXrOmb0GCx2w+MdcN6UoRZcV1zWyAyBLfzCUDqLdYUTpN1ZgWYKekxWjmERkX51BRCnqyrwDyDxZ95oscwaaBAPsgXzLANWwsH+SAdECN+8KkdNazygSrAKC5FvRkx5xqOgbBQsAYEeVIrUZIU+hBXWey/sWtJIxDKZxnpyjaWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774538106; c=relaxed/simple;
	bh=REUO1vh1nePGk9EpCs6XvxY+8qD95WwKwZX5ckO9HM8=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Z0bZSRn5oZ8fyumlFRQLRgzUgtEJ1bci/sUiGWhElhQYSlW6CJTqpHzCEI2Ec7rc4knR527fRYgosp6biBDm+v89ETG9z28BS5/1ZUOsquP2PIeRqzYwC+48tCv88tZY4ZCywf8hiDS6D7gHalT98ojqhif4SpgArI9jiqwLiX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EI+BrG+V; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EI+BrG+V"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-89c52db6231so11175706d6.3
        for <git@vger.kernel.org>; Thu, 26 Mar 2026 08:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774538103; x=1775142903; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9ATEau/KDV+hGR3HaTdiAFBGwp3GkYjNa18epO9gHOE=;
        b=EI+BrG+VXIJni0B3sgLdaq2jO4c9oZVzhYgh3y82zAzM+9RQV/+m058zKUiD1SX5Jl
         Rz0OV5HJcsXuHvbfM8sgP1QuPIv++POrstS3wnedGgALg/qj95eI6pjGQZLJg1W10PHw
         YYxIPFkzJO2qWeZsQrCuELaNtaABvK2R8083I+q9+3gBYoSLiF7OH0dLuEVaY25At+Ms
         ul74pq3PTqwS42QN9YWgbnadlwFpg3nJ5JqTp7rBZNjjNuB1F4V7KpFmnYHn105qaZL7
         dlRx25uVHY37do5E0rZ4EWM3IzxnpsEXACibNjeTqY23C0ZCLErE/O0ijr3UeGb3ethV
         FZoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774538103; x=1775142903;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9ATEau/KDV+hGR3HaTdiAFBGwp3GkYjNa18epO9gHOE=;
        b=TFOkAsrHX5faM7W4ZEsHGUDjyn51LvHZEowCcJgjV4Iu+Ssomgcdl+xE4tmkOiOtyN
         VXC7Zt0gIIqL/ixcjlAb5HZClQH2thR6sP+DR/ZbUqUZAKaWennhPgrbz5T4sBhZoYVz
         TK5OHb6PmxRlb1JXsWYqrE4/JEg4X+oWCojMyAVFSqTSpxjfmIcSPB+JxOKQpgkhRmOU
         1T72cveejp1G1zTIGj7ZO9zuo7P1Fh9600zauQOQsSky/NLFYspn4slMQ3YqVIgfX5Iv
         JUMJzG5eTdANbjLTnLl+c4o5fYKrMO6BdU1Ta8+U9iVwfpnSE0YJDMIRAhIE0Nzh/cp+
         /8Vw==
X-Gm-Message-State: AOJu0YzL8W51PrA3m+OQ6NWtS5C6yDNurlHU79LwCAxTOLQAWFKQ7Emf
	U1UiBEgoptp9xpeurlB6K9LK3fdZFi25tbcQEQKnhtJaeT8Iu6vzkXrn7Dki0g==
X-Gm-Gg: ATEYQzwc/Js3X8EqszQTNBNwfz4gthsJrPQHLH3u3nBowW+AtTuzaNS2otziy9odQy1
	tYiM8Snjw1jogfQSHZ7LJasCDgSuPrkySIvK/YVtszP7f79bQZXhkeM9uQ46krcIdxbbMNcSKsN
	wd6SQCDDPiBxUQB5TpCKWCiQKZb02cGD2F8mTKcoojEo84c15hJzT1pDxAi9dU6LXrha2Jk8NCD
	IqmclhprVS9ZuUAb3c+UirTaa5bTaboBJGyftmZ2L94bivqf+mILcpylAlDfbjbd/qrvDHwkUyM
	9lO1ZphZVVAdaP4ROp7Ta6nB241JABW86dbbgVzk6xoKoIhEtk2ofBD+/CZcSs1tQrfSZXAvJps
	dfki3vZuD75E8zisjRiD+w0FE8dr4Y9910GIkY6BfDYe/TsukGivnuqzIFzs9OVgjuEElKQf+8N
	Eb/016QGFIh63JieA4K7E/W2giUw==
X-Received: by 2002:a05:6214:3c85:b0:89c:c2e7:97ab with SMTP id 6a1803df08f44-89cc4984c16mr99615136d6.2.1774538103264;
        Thu, 26 Mar 2026 08:15:03 -0700 (PDT)
Received: from [127.0.0.1] ([64.236.133.199])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89cd5a18926sm27562536d6.32.2026.03.26.08.15.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 08:15:02 -0700 (PDT)
Message-Id: <b6423f9595bf003fc87670658f172a98c6257155.1774538094.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2070.v3.git.1774538094.gitgitgadget@gmail.com>
References: <pull.2070.v2.git.1774266019.gitgitgadget@gmail.com>
	<pull.2070.v3.git.1774538094.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 26 Mar 2026 15:14:54 +0000
Subject: [PATCH v3 6/6] t5620: test backfill's unknown argument handling
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
Cc: gitster@pobox.com,
    Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    r.siddharth.shrimali@gmail.com,
    ps@pks.im,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

Before the recent changes to parse rev-list arguments inside of 'git
backfill', the builtin would take arbitrary arguments without complaint (and
ignore them). This was noticed and a patch was sent [1] which motivates
this change.

[1] https://lore.kernel.org/git/20260321031643.5185-1-r.siddharth.shrimali@gmail.com/

Note that the revision machinery can output an "ambiguous argument"
warning if a value not starting with '--' is found and doesn't make
sense as a reference or a pathspec. For unrecognized arguments starting
with '--' we need to add logic into builtin/backfill.c to catch leftover
arguments.

Reported-by: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>
Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 builtin/backfill.c  | 3 +++
 t/t5620-backfill.sh | 8 ++++++++
 2 files changed, 11 insertions(+)

diff --git a/builtin/backfill.c b/builtin/backfill.c
index 90c9d84793..edc19c01e5 100644
--- a/builtin/backfill.c
+++ b/builtin/backfill.c
@@ -142,6 +142,9 @@ int cmd_backfill(int argc, const char **argv, const char *prefix, struct reposit
 	repo_init_revisions(repo, &ctx.revs, prefix);
 	argc = setup_revisions(argc, argv, &ctx.revs, NULL);
 
+	if (argc > 1)
+		die(_("unrecognized argument: %s"), argv[1]);
+
 	repo_config(repo, git_default_config, NULL);
 
 	if (ctx.sparse < 0)
diff --git a/t/t5620-backfill.sh b/t/t5620-backfill.sh
index c6f54ee91c..2c347a91fe 100755
--- a/t/t5620-backfill.sh
+++ b/t/t5620-backfill.sh
@@ -7,6 +7,14 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
 
+test_expect_success 'backfill rejects unexpected arguments' '
+	test_must_fail git backfill unexpected-arg 2>err &&
+	test_grep "ambiguous argument .*unexpected-arg" err &&
+
+	test_must_fail git backfill --all --unexpected-arg --first-parent 2>err &&
+	test_grep "unrecognized argument: --unexpected-arg" err
+'
+
 # We create objects in the 'src' repo.
 test_expect_success 'setup repo for object creation' '
 	echo "{print \$1}" >print_1.awk &&
-- 
gitgitgadget
