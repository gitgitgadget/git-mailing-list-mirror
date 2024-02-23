Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B76AE1170A
	for <git@vger.kernel.org>; Fri, 23 Feb 2024 03:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708658315; cv=none; b=IiWzlV9NzBsEN8glKwRupAqO+3iUtDuyJCUfr2eT/HTF10t3Cz1bAmdtiyGW0YWhfx2SY2halJ2yVCkHI9V6jGZLrFvzAZGYUAvgJ3fNqNOo1gswzIL9gqz5vs5ctwNlU5w1dsgvqMxrM3dw2BFMiAEDJFX3M6Sl/jsZHnreO7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708658315; c=relaxed/simple;
	bh=FO2b0yim3Nlg5M5KqxmDX/ArS0hbUoaoFBZF9hZLt/8=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=jZB+IUjyTPmOasVBuo1HXqiCYL1QdtGDkIv4VOW3ftlELxoxvk8zjGNk5Ih/UtR+HnxssV8fo0dP+9TdDyTcHrEA65RDhy3ap0ZbaDyVEMeyBhMdks9YbE1/Z9eHY6oP2DfzcUu2xVZHVWb8KqZPuyQR7fjlRsQwlmI8PH08QkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dgx4wWgF; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dgx4wWgF"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-412698ac6f9so9262125e9.0
        for <git@vger.kernel.org>; Thu, 22 Feb 2024 19:18:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708658312; x=1709263112; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p28naUfyzbNrl0Bq490tpwa3bMingF0uwBZIP3yLO8E=;
        b=Dgx4wWgF7BejsW7hMwU9A0MN/jAdSS5cKpRycLImBnsbfEcNUzgJ+YWnMCHcKiKJUn
         PD0kjiIZxcGcswWyMSBy/Ye/DSiDG43aD/6OPH2DCNEl4mwJPapCVDO5qp/CEzOkDRj7
         lqzXxfZtV40Iqf5tJHzjvWGx5cexwweMFw29VKMBoc3QTfC6aCptg2dgM62H77sjjZih
         fZDHoh9y03H23XEokauyN3NHOFwbCPncqAyvEz04JAyAPMQkfgqjHHg3x3+YA80gSzvq
         ZY3n8z1vU/m32DQu+TMuD0kLLa3yHY0sG0td15Se8egRYoCAhECFljWC+VEK1CzQx9Cv
         bdfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708658312; x=1709263112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p28naUfyzbNrl0Bq490tpwa3bMingF0uwBZIP3yLO8E=;
        b=rpEh8z6kl4ZMBQoQDnklPbu2wO2xbWtV9lh+AviVAGU4BOmBB/sNnp0HGzHQTRB+sU
         W5URtGk/A1FC6YfaIFxQkM7oVtmSjKB8sm6xShqwUmqEsrAsj7l8Urn0hdwTmLn01+xn
         6MmRnUtEQTiOrTB7ae+SnXxwGnzdpUGP5tFRBFDfcG46/jjRU3ytTGMBQjv+sKbtYwTq
         ZcnN+vkDQUKlFOW8KAb0WDld+b+oo12BZzQO62lkilb1uw211QwKxqjlWpg84V/pb7+g
         VKYH87YAwjIzi/JMOtLOoCMOpGlocjb9AU4P8t3KAtQEfAE0KVSzhlZDh8El3crxtxPt
         uU6Q==
X-Gm-Message-State: AOJu0YyI+GUrP/u8Y70LqxgdkMHfvTc5B1KW74l6HfBg0l5XktqtgNu8
	XfYUiMgd0UgSo6MpnKGBcAeQYNZlnKaUHar8evIuV1V90UWdldaf8zrc7Ry9
X-Google-Smtp-Source: AGHT+IHD0XPrvJsa6XzU5Ruj1d/5DKZ5apfuS8o4pOxfxvv2kaNc8aKOnTm1wMUoVWdtwxHp11c4uA==
X-Received: by 2002:a05:600c:4706:b0:412:5652:138f with SMTP id v6-20020a05600c470600b004125652138fmr569305wmo.16.1708658311970;
        Thu, 22 Feb 2024 19:18:31 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z18-20020a1c4c12000000b004120537210esm573903wmf.46.2024.02.22.19.18.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 19:18:31 -0800 (PST)
Message-ID: <623c6f06e21c04c55576d1146944b5ff6be66429.1708658300.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1662.v2.git.1708658300.gitgitgadget@gmail.com>
References: <pull.1662.git.1707857541.gitgitgadget@gmail.com>
	<pull.1662.v2.git.1708658300.gitgitgadget@gmail.com>
From: "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 23 Feb 2024 03:18:14 +0000
Subject: [PATCH v2 10/16] fsmonitor: return invalidated cache-entry count on
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

