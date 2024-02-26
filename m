Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49FB0132C06
	for <git@vger.kernel.org>; Mon, 26 Feb 2024 21:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708983578; cv=none; b=XqVKDml2kH0rsGtpkV34ynlQV6+6fAufy8aiGh/pGbpJwcMNN7m3xE6/58AocGRVHFl172AqMaRlzMgjT55nxrqUpSuHU5T4lpBFRSEngiWWfxx9YbUaGQtIprD5pP7MZvdhlq+d7o9/QOlYXSYbwtoCcpQc8byC9r8GZkdqDfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708983578; c=relaxed/simple;
	bh=FO2b0yim3Nlg5M5KqxmDX/ArS0hbUoaoFBZF9hZLt/8=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=LB7pVmthShuAgyE7dQYHXSe/DzZoJLaTr9GiidXdU3pqCk+y50er+i7h6wtI2ApcxN5Vvf9GW4abFgbIzGUqb43fda4Js9Kjo4+8AwqF6ADhZxm7eh2y9eu1yhSpAKoTvy78SDzTiLLmFmcaQB/RvA80uxnQpTgpo6Iy/jkzVjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lrd2n9rw; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lrd2n9rw"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-412a4055897so12906165e9.3
        for <git@vger.kernel.org>; Mon, 26 Feb 2024 13:39:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708983575; x=1709588375; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p28naUfyzbNrl0Bq490tpwa3bMingF0uwBZIP3yLO8E=;
        b=Lrd2n9rwkNRPg1go67AW6VYr7owB8nVuoIFnxz+TvK98mgOK/JDVZXoixiEH6oWvfW
         qWASRXfV1mjfA4ClOmGj1dwMSQrTutuafm2xABI2QE2Gp+kPVBnYjwbF4BoNT/GrOCNQ
         LrhIyzx0dcaNOn02KyZU6QAm73YkYiTf8g8rRl6bvTIlVx6zb5X/h4rtPJ674X8qNHIv
         Z9BAZO75oisuZvwVFdegMFFmlmj08Dhcif4v7FaCuCUENuquB59gixnm4E2/n3WmyadM
         ALgM769kN7UAMBJzzIUrgjYlbl8pEAOFQRWubiw83mgsRoilMmCoXZAZ1KczI39s++0D
         D1lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708983575; x=1709588375;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p28naUfyzbNrl0Bq490tpwa3bMingF0uwBZIP3yLO8E=;
        b=akJhmuPKFLpfyYw6MP10GxjxE1BRqBNWvvvR0jv5OIlNFv3oyLXP+hzBudbq9StmNk
         dJqs14ZqizupmVB4sz/TYSV7T3aKjlBJKA/u2rOvAqpNE+USCAxagjLpRTq/bW+vmznx
         TaPNfFnYgNUUivOt/j5ssXkvqvpwsZHsqFNDNfSE+3S8HXlnoj/UTYVVQ3761o+D3fRz
         5c9TupgcCChQaDE9Rtk4f8+BYa0GUmt3F0FLyXzTOmrhJ2Y3TyCQ8JS0uGEPHEjXqbZg
         2aVJ3cwna+186/kiceLo+UgzDqkGE3Asy5IPbtvPQU56FkVc1kizBGU0h9tWHmUuL1+s
         BRyw==
X-Gm-Message-State: AOJu0YxUTgemaAB25YecHaMe3v2zbM8GjSeWOOc9F5NeNhhkSEtGROpD
	o0ZrvB98GeMRn4rdXmQBpN6EUJU5DDMVfC6ri8YQHRZTwNR6bWPtXEULY4+I
X-Google-Smtp-Source: AGHT+IFUfh5wxMnW00XpYU1pSffcpVuhy0/0zlCxonEkXcIAWQ8ZqFjIO4vx8vPNgxpHqsWQ74YdOw==
X-Received: by 2002:a05:600c:2e04:b0:410:a039:ed5d with SMTP id o4-20020a05600c2e0400b00410a039ed5dmr7366878wmf.33.1708983574837;
        Mon, 26 Feb 2024 13:39:34 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l15-20020a05600c1d0f00b00412a31d2e2asm5946163wms.32.2024.02.26.13.39.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 13:39:34 -0800 (PST)
Message-ID: <5fea8b9476e6bf0e0635e886364f0d718deac97c.1708983566.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1662.v3.git.1708983565.gitgitgadget@gmail.com>
References: <pull.1662.v2.git.1708658300.gitgitgadget@gmail.com>
	<pull.1662.v3.git.1708983565.gitgitgadget@gmail.com>
From: "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 26 Feb 2024 21:39:20 +0000
Subject: [PATCH v3 09/14] fsmonitor: return invalidated cache-entry count on
 directory event
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
    Jeff Hostetler <git@jeffhostetler.com>,
    Torsten =?UTF-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
    Jeff Hostetler <jeffhostetler@github.com>,
    Jeff Hostetler <jeffhostetler@github.com>

From: Jeff Hostetler <jeffhostetler@github.com>

Teach the refresh callback helper function for directory FSEvents to
return the number of cache-entries that were invalidated in response
to a directory event.

This will be used in a later commit to help determine if the observed
pathname in the FSEvent was a (possibly) case-incorrect directory
prefix (on a case-insensitive filesystem) of one or more actual
cache-entries.

If there exists at least one case-insensitive prefix match, then we
can assume that the directory is a (case-incorrect) prefix of at least
one tracked item rather than a completely unknown/untracked file or
directory.

Signed-off-by: Jeff Hostetler <jeffhostetler@github.com>
---
 fsmonitor.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/fsmonitor.c b/fsmonitor.c
index 2f58ee2fe5a..9424bd17230 100644
--- a/fsmonitor.c
+++ b/fsmonitor.c
@@ -253,11 +253,20 @@ static void handle_path_without_trailing_slash(
  * same way and just invalidate the cache-entry and the untracked
  * cache (and in this case, the forward cache-entry scan won't find
  * anything and it doesn't hurt to let it run).
+ *
+ * Return the number of cache-entries that we invalidated.  We will
+ * use this later to determine if we need to attempt a second
+ * case-insensitive search on case-insensitive file systems.  That is,
+ * if the search using the observed-case in the FSEvent yields any
+ * results, we assume the prefix is case-correct.  If there are no
+ * matches, we still don't know if the observed path is simply
+ * untracked or case-incorrect.
  */
-static void handle_path_with_trailing_slash(
+static size_t handle_path_with_trailing_slash(
 	struct index_state *istate, const char *name, int pos)
 {
 	int i;
+	size_t nr_in_cone = 0;
 
 	/*
 	 * Mark the untracked cache dirty for this directory path
@@ -276,7 +285,10 @@ static void handle_path_with_trailing_slash(
 		if (!starts_with(istate->cache[i]->name, name))
 			break;
 		istate->cache[i]->ce_flags &= ~CE_FSMONITOR_VALID;
+		nr_in_cone++;
 	}
+
+	return nr_in_cone;
 }
 
 static void fsmonitor_refresh_callback(struct index_state *istate, char *name)
-- 
gitgitgadget

