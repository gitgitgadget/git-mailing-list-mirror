Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40D5D4B0E2F
	for <git@vger.kernel.org>; Wed, 16 Sep 2026 20:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789590767; cv=none; b=ktyGs4obwKARB2ZVwErxRNPAOKEIVPKL66EebPrj5rY1Fj2S8nI4WAeoWHBvbrEh1o2S1OfCz+j0kuVb0K08cn975+HtK5rwxHHJLUnEFPL/lyATw6lo3v9VXW4EsUwSG/H2+g5jF14t1y6BlwR2qXm+xqnFm5FSIgsYKppbBcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789590767; c=relaxed/simple;
	bh=evo4oNT9VblbohzMAEFMVuwlT3Z8FBc5/V0fEYU5ZQw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LxzhPy5ng78S0snA3YyWnJG2vH6ihdgPFGPerldrd3k/qBWdlirJRayF3tbzlG8caxCCWeuaceLOBbqlUMtgBrbYFjsqiCKusy0/+AlOUor0Za7e8hMsxpmjRRN5tcfOpiNeeO74DsHrKrCilakAbdtqaMz9uq6vtWRwTF/s4gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L3v4jBlJ; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L3v4jBlJ"
Received: by mail-pj2-f13.google.com with SMTP id d9443c01a7336-2d747eb79f6so992105ad.0
        for <git@vger.kernel.org>; Wed, 16 Sep 2026 13:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789590756; x=1790195556; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Igvo9ZEMFWSyoL3iUr7E0RijZhz1IOlDi4Ti6NwzVsU=;
        b=L3v4jBlJE+06ghtJMqx6tLE1iKNr80YUXdN9wPBYmoQQ0CcNowpQKQf39a33NcbV6t
         z0PQcdwLDiUwsdpW7zMOQPtEmx2Bqwe3sNIpzo9wV65hJdR/2gZO9wcbET0khVabsXlU
         063mp2FMhP4Vp9DHcI0UvKjEz68b6LA9NG0rbwDwfRAqCanft9txNMegl1klsT51F/6f
         9dqqwfBZdgSGaVsS7RLJFMiV9DABwUQId/UUw4hLGU1Y/gAzC8l9n7GCg4xrGnD+tujy
         Y1UevYBs9eXhgmkGVm1gqZK1mwZvyajx0CLxPYVIY7NRSuyMb8iKuXMepZ3oByFHsOvb
         7d0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789590756; x=1790195556;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Igvo9ZEMFWSyoL3iUr7E0RijZhz1IOlDi4Ti6NwzVsU=;
        b=rXi32h7cc049Q97WpQUUHvrK+WMqsK9s6906wdfLv9new4SiIIVd9s8TUCgWm7ErWc
         jnwO9xgPNn/uDElucqD7Q2+LfJGKm0Q+BpE4TeVJ85NH3yVfEMZGkEQVMUqzYYH6dDGQ
         HKmqVPWSs6JAP5EPQH9HZVf2Tl4y00DHa/P6AMTVWr4kWQw0N0AtJBuk08anmdMeMPOi
         +hZ09n++7hn2YgPCljx+z4ZuN808ZfaAVdf27vBylZLFAeO2WyzuBaom9v4rjY9YmZyV
         XbnEwV40p084oIlJlSn5HiA0NHw2AKdXiqApb/z8NczbA5Aqd8t7GULmYDH66dA16Xnf
         Em2Q==
X-Gm-Message-State: AFuF++m2MpSwYxzHl790rnETvOeZTwG6HyaZvyTXnVid1qJI9RXW2JaL
	QrDyEGT2vl0iQpB6xO05oO5qNmZmkm3FbHEIV9tuHwCqVX+qCH646tVDcfN2LQ==
X-Gm-Gg: AYBFou2kvjAVFaMl5jHL/HaRwWqi8w4g3JVKT8CQLujryT/g4wXgm4l2b1qh/xm95F/
	sbEAhqIhSutXqnrvwoSEBYp4LY2NCAcDwNgsGFHeIYvjUkgaTalcHcUZrvIkjsY08VJxDTHDvb/
	hLGo1oklkQ2lUZIpl7vCvcf6uWMM0A4jvHoBDHSyJPojI7n9WrnOtr6pYlRZ0PqmlH0K61yTVYu
	9zG3VCzvh3lny2ywwyYbbp45ZHTGAd5LuhnvUScXJdQvMzS2VozcxhM0dT+thExbiokwp87tvg0
	2whCrjQqQ+jAoNg39UnkRMrN75e4i1jM8hjNVLA5IkZjFu0Y/n/Z+Z5J1AZ84Vb9nTU65RHx7yO
	TutDY4Jm1pVvCVUgt3hJEsye8bXnybUyJkQeXlYDJBj0sRdtpSNwHSFMjp+Tz9/khXgkiH0A5Sw
	7sTBxcpfkIP/RZcnQM1Yj2/woxmVB7WyufhmVfA8wdXs/Iraul+vcico1DBOGVpjoWDmdF9xCG/
	89jQ8bn+chDHPzsemyc5i3tcWmrHiiPAfrMZQ==
X-Received: by 2002:a17:90b:56cc:b0:39d:eac2:7bb1 with SMTP id 98e67ed59e1d1-39e1e26378amr11050354a91.4.1789590756337;
        Wed, 16 Sep 2026 13:32:36 -0700 (PDT)
Received: from royce-MS-7D09.lan (76-14-104-130.rk.wavecable.com. [76.14.104.130])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33bf56d7e5bsm9837881eec.0.2026.09.16.13.32.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 13:32:35 -0700 (PDT)
From: Royce Remer <royceremer@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	Royce Remer <royceremer@gmail.com>
Subject: [PATCH v2] upload-pack: swap wanted-ref/shallow-info responses
Date: Wed, 16 Sep 2026 13:32:21 -0700
Message-ID: <20260916203221.5265-1-royceremer@gmail.com>
X-Mailer: git-send-email 2.55.0.1.ga30d533ec0
In-Reply-To: <20260915193009.222678-1-royceremer@gmail.com>
References: <20260915193009.222678-1-royceremer@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a server enables uploadpack.allowRefInWant, upload_pack_v2()
sends wanted-ref info before shallow-info.  The fetch-pack client
expects shallow-info first; receiving them out of order causes it
to exit:

    fatal: expected 'packfile', received 'shallow-info'

This error condition only applies to protocol v2 clients performs
a shallow fetch (--depth) against servers with allowRefInWant
configured.

Swap the send order so that upload_pack_v2() sends shallow-info
before wanted-ref info.  This is a server-side-only change and is
compatible with all existing client versions.

Signed-off-by: Royce Remer <royceremer@gmail.com>
---
 t/t5703-upload-pack-ref-in-want.sh | 18 ++++++++++++++++++
 upload-pack.c                      |  2 +-
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/t/t5703-upload-pack-ref-in-want.sh b/t/t5703-upload-pack-ref-in-want.sh
index 249137b467..9e2a090c9e 100755
--- a/t/t5703-upload-pack-ref-in-want.sh
+++ b/t/t5703-upload-pack-ref-in-want.sh
@@ -295,6 +295,24 @@ test_expect_success 'fetching with wildcard that matches multiple refs' '
 	grep "want-ref refs/heads/o/bar" log
 '
 
+test_expect_success 'shallow clone with ref-in-want' '
+       rm -rf local &&
+       GIT_TEST_PROTOCOL_VERSION=2 git clone --depth=1 "file://$REPO" local &&
+       git -C "$REPO" rev-parse main >expected &&
+       git -C local rev-parse refs/remotes/origin/main >actual &&
+       test_cmp expected actual &&
+       git -C local log --oneline refs/remotes/origin/main >log &&
+       test_line_count = 1 log
+'
+
+test_expect_success 'incremental shallow fetch with ref-in-want' '
+       rm -rf local &&
+       GIT_TEST_PROTOCOL_VERSION=2 git clone --depth=1 "file://$REPO" local &&
+       GIT_TEST_PROTOCOL_VERSION=2 git -C local fetch --depth=2 origin main &&
+       git -C local log --oneline refs/remotes/origin/main >log &&
+       test_line_count = 2 log
+'
+
 REPO="$(pwd)/repo-ns"
 
 test_expect_success 'setup namespaced repo' '
diff --git a/upload-pack.c b/upload-pack.c
index a52856d869..a70d237ad3 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -1812,8 +1812,8 @@ int upload_pack_v2(struct repository *r, struct packet_reader *request)
 				state = UPLOAD_DONE;
 			break;
 		case UPLOAD_SEND_PACK:
-			send_wanted_ref_info(&data);
 			send_shallow_info(&data);
+			send_wanted_ref_info(&data);
 
 			if (data.uri_protocols.nr) {
 				create_pack_file(&data, &data.uri_protocols);

base-commit: e9019fcafe0040228b8631c30f97ae1adb61bcdc
-- 
2.55.0.1.ga30d533ec0

