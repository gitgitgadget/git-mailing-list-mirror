Received: from mail-oi2-f12.google.com (mail-oi2-f12.google.com [74.125.231.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8B7D447814
	for <git@vger.kernel.org>; Wed, 23 Sep 2026 22:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790202440; cv=none; b=Ucuhsx5a+3M44x3ujxgt4kRETkernqX0sFyCRrCsnm9rrBzUupj8mukFLkAn6GhlKa5DuODh2vLO4iZbOI20Cwkne8Z7GLNBkX5OFMvjJh0Z4c8pMDNRqF4WtxnKNhNi0tvzweMV0+4Flrkt6DVHx/qlBIozAg+J4rKzHTbPgRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790202440; c=relaxed/simple;
	bh=ISzwmYyv8N3tsUgF0f8Doow2EEF86nO518LaoIfpL6s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SEi2YbBsh7gTC/ZqyS+RH2f93ceVSlutz3QyMfuE6uCksvvBB+9YdF5PVstn22ufSxFhQg+EIdy7gkzLIFuNPm21toNOSvDHfims77JRx55ml+vop05q/JOBnEPkzgEvchEkOQ524VlL2FqeJgz8vu6xCi0mmfl7+zWpFcULAlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZXrXCJAn; arc=none smtp.client-ip=74.125.231.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZXrXCJAn"
Received: by mail-oi2-f12.google.com with SMTP id 46e09a7af769-801a8bf8112so693105a34.1
        for <git@vger.kernel.org>; Wed, 23 Sep 2026 15:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790202437; x=1790807237; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=H6WQh9j+JtES1x4ORTJ74w9vw3y00pkUGRH3Qyeyvp0=;
        b=ZXrXCJAnb9qDMy9AtpKl/EtRaU61YaKh8PrWL8fnGtXWhMnxhdqCQ1v3mUWZO03Vrf
         owD0Dlit8FeVAGsce8GPMKpWKMHd4ywNjzp4SKXGm4C7DURrSRSMSLcUMVXYg0uQFN/m
         wJUu2T5tnV3rNeYWrKOrLE6gvFPakTEpacxjExKliJSZXFe+lZVCylTAOOC789vaqp+w
         YAiFdOHqWyXQ1QZhsZdmS0XwUsiJXycpxhq/GK1HeEV0RiM9BrMGdM/rQzOzcqO5gl5U
         He6Mc0ObD5LMTVqIYzwUk/cCz4KP3AplAujlWhEw37U7p4GQmoP/kI+8QwvE63GG9a/e
         uxIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790202437; x=1790807237;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=H6WQh9j+JtES1x4ORTJ74w9vw3y00pkUGRH3Qyeyvp0=;
        b=zafers1fRiqo219QPlA1VKxyq6MHhBzYl+tJble/Yl7mFxjqE00pq2wHkcXaUQhi+/
         RiESPusHChM+9fDtYsq45dAHzQZ7YTou0e1N+4nSsv/JR0Z8TT7lYKE8gIydQLgVyct7
         UwPhV12RVbRbxFfHBhN/IacbHfx3fMCbfU9y6/ZKqQMehVKgOqCqgYCEAkHJRYVrzqDs
         aPyJNkknp79xmAgEg4sLQ9kafoA8X/qeU4YhN0tTUc17n/nZm5zYfoHo3gYXrC5SoxR5
         QnO/tBByrEVNaLfRiWF5nleZ1ipJsuv5S/Ht2CJJ148zMJaku6y4Gl3lbVhB9gQI/i3N
         suxQ==
X-Gm-Message-State: AFuF++ndJvwPUbOlpaW5M0ZiSpJ6SE7c2rnPWmKLcNyBt42WmRtQoM69
	yGbIB4KPtcJe/ZuFPrwWSP/58oU7ifsP9WPQ9q+1b/irCYICtQVbP98d
X-Gm-Gg: AYBFou27F0cAY9TUUbay6mJIBGOFi2UZi+4gr7FWySb6RmSO5DQmjtdgVhF5ZiRE0Ya
	CC+m3cgf6gK29XFKw231shFoWuQZ86YDztc9Xj98o8D2rab78GzdMzp5Tp6rKcwCs4AqkihwlxL
	b60YO22BDmVpkNbVPGa31xLD7vhWE5w/eveQAGMjV7yY2rkSz6nTsaxCWaDmXHku5ccamC8wNk8
	RlLyuFqoMGM/BqoxnEj8A6hJecBhbdfK6a00J/HxuyQZIPsamgUdwmNFpLGRrOIYBeQ/S30bDKw
	OWEU9mQm8gddQZ9v+9oVDihsn3FXH54EvNfI7UHc5wXETAdmJA0u9wxjioYrrsAUm1bCsFHwzf4
	ImGC4Rhfh1iIPc7ar3yFK5wqHJbTnA+ixIyJa5N1RpZ4UWnNUfRldq0AREj2fXUv3VXdA4PTQCD
	zVBXhCyx7QScC+Y41LS/jfhkOeRlo8f1sAnGhfCCBWI8fnYuk9Ro/eRPCUJoAOEv1Td0HmMzfSk
	Uc3EDkv/uAvLwpGbEfSHSJX2nWvl+TYrFk4nbjpgQMwbdI2mASFyaJLB51Txn0a0zE88x9A7qF4
	y+sTjHZ0uY9LIJWtSRCqwhzUnDBTVKl58q3W+7AzXq0/6D4luc6tscdFkrr4chb0880uCgdOxQu
	xRuMh2VbAgHwiNH5ha7WB+c10rTmca1uBgYrpTqWv/HGuDew/ebxBKyczZbU=
X-Received: by 2002:a05:6830:a8f:b0:7f4:eb9e:54b with SMTP id 46e09a7af769-81782a8e44cmr679992a34.7.1790202437526;
        Wed, 23 Sep 2026 15:27:17 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa (vpn-centralus-02.tradc-corp.com. [20.98.136.114])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-81603ad0f20sm4727670a34.9.2026.09.23.15.27.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 15:27:15 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Wed, 23 Sep 2026 18:26:58 -0400
Subject: [PATCH v2 1/3] dir: hash ignore files before appending newline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260923-ls-files-untracked-cache-v2-1-d7ee33476eb8@gmail.com>
References: <20260923-ls-files-untracked-cache-v2-0-d7ee33476eb8@gmail.com>
In-Reply-To: <20260923-ls-files-untracked-cache-v2-0-d7ee33476eb8@gmail.com>
To: git@vger.kernel.org
Cc: Tao Klerks <tao@klerks.biz>, Junio C Hamano <gitster@pobox.com>, 
 Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>, 
 =?utf-8?q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= <avarab@gmail.com>, 
 Tamir Duberstein <tamird@gmail.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openssh-sha256; t=1790202425; l=2569;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=ISzwmYyv8N3tsUgF0f8Doow2EEF86nO518LaoIfpL6s=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QHh+0SZZbOTZrWI68sMu08CVSrA96fyiw67Fan058Lo+8UG9W5QRryc3yHJGYVMT/qTECuv20KH
 tZZwxlqFRww4=
X-Developer-Key: i=tamird@gmail.com; a=openssh;
 fpr=SHA256:264rPmnnrb+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc

add_patterns() appends a newline for the pattern parser before computing
an ignore file's object ID. Hashing the buffer therefore includes a byte
that is absent from the file. When the file has an up-to-date index entry
and needs no content conversion, the function instead uses that entry's
object ID.

Switching between these paths changes the cached object ID even when the
file has not changed, invalidating the untracked cache below it. Compute
the hash before appending the newline so both paths agree. Update the
expected object IDs of the untracked ignore files accordingly.

Assisted-by: LLM
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 dir.c                             | 6 +++++-
 t/t7063-status-untracked-cache.sh | 8 ++++----
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/dir.c b/dir.c
index d896e7be4b..5484eb1562 100644
--- a/dir.c
+++ b/dir.c
@@ -1195,7 +1195,6 @@ static int add_patterns(const char *fname, const char *base, int baselen,
 			close(fd);
 			return -1;
 		}
-		buf[size++] = '\n';
 		close(fd);
 		if (oid_stat) {
 			int pos;
@@ -1215,6 +1214,11 @@ static int add_patterns(const char *fname, const char *base, int baselen,
 			fill_stat_data(&oid_stat->stat, &st);
 			oid_stat->valid = 1;
 		}
+		/*
+		 * The extra newline is only for parsing. Like do_read_blob(),
+		 * keep it out of the file's object ID.
+		 */
+		buf[size++] = '\n';
 	}
 
 	if (size > PATTERN_MAX_FILE_SIZE) {
diff --git a/t/t7063-status-untracked-cache.sh b/t/t7063-status-untracked-cache.sh
index 8929ef481f..10d4850077 100755
--- a/t/t7063-status-untracked-cache.sh
+++ b/t/t7063-status-untracked-cache.sh
@@ -98,11 +98,11 @@ test_expect_success 'setup' '
 	: >.git/info/exclude &&
 	git update-index --untracked-cache &&
 	test_oid_cache <<-EOF
-	root sha1:e6fcc8f2ee31bae321d66afd183fcb7237afae6e
-	root sha256:b90c672088c015b9c83876e919da311bad4cd39639fb139f988af6a11493b974
+	root sha1:8510665149157c2bc901848c3e0b746954e9cbd9
+	root sha256:09ef24b38105f396a61ad78d73ba6a18ee3cbd89ce4524b4e13b6c1af191e2d8
 
-	exclude sha1:13263c0978fb9fad16b2d580fb800b6d811c3ff0
-	exclude sha256:fe4aaa1bbbbce4cb8f73426748a14c5ad6026b26f90505a0bf2494b165a5b76c
+	exclude sha1:2bdf67abb163a4ffb2d7f3f0880c9fe5068ce782
+	exclude sha256:b83643f4390b339c1b3ff2f5132c99bd4a77687dd321d3f386c25953aa6f1ce4
 
 	done sha1:1946f0437f90c5005533cbe1736a6451ca301714
 	done sha256:7f079501d79f665b3acc50f5e0e9e94509084d5032ac20113a37dd5029b757cc

-- 
2.56.0.rc0.807.ga0c0929ce1.frankengit

