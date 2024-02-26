Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F32F133280
	for <git@vger.kernel.org>; Mon, 26 Feb 2024 21:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708983582; cv=none; b=VOKOehjYD2lDbWRkoopfwpdMW76aUHlN306vClN0rEjVKsINodM4xf2cbvGlbK5Jrv33mU4TGfksOn12HyKZWGlsdZ2tufrSpIIJ0GGTWTEVa3PNpO/2C0QfAgCVYDHjqEViPYMvE/nl3acdTMzgO0bK2G1v81zVrMusPY5pKpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708983582; c=relaxed/simple;
	bh=gRRNilQ4NfzviUPgUWCMC/cGQCPEDGiR5nSDcgst4XM=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=J9oNeCCqwf65JXSU4Q9LHSmjPv8wuv3nb/P1Ay3H4S980Q+9wX34K8sRA1fmbHHS68OwtfvFBlIno/jzkiHEkMqHFqedq61lSeyTkGXF6P82kjxQTh634BGZM+FvToBnQlufvtjN7gG3LsMCvXx65WZtarmx8wGkUiotD6BKwKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rrsy+HOe; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rrsy+HOe"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-412a9f5f797so3342285e9.3
        for <git@vger.kernel.org>; Mon, 26 Feb 2024 13:39:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708983578; x=1709588378; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9w5F+ig/Qh8/Pg1lF76hwLePYUCXgzP2kcrmcuAjXiI=;
        b=Rrsy+HOeX9B67S6zQNZXUccIzP5CFxOs0D88Xwq+tkPf4GiNOSof951ONMhV5TfY3M
         6oVqY01T9FZHsOWUb5Isbezax3ytzczE7/C9Q7xOVsFKlrQv8jqTBRFb0vcHzP5yed1d
         ddRDO5rVa4RwKSxYFF4zh3LHvWcRs0gM8fpXG2nsSk4xWcK9H42XEX2k7r0tIZkgRVBI
         PmSQMDWv9jUbytbPgnK71FCoegLNJamalwsCDdClhb/iHC6Pprl5cebhFK8WiqWODRtd
         8IlGW6hRaRVW6uDBcmEf+fQnEL/V4C0vITCmlLJ74II+0DKIHXTAruj9L719JY75HLEa
         lX+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708983578; x=1709588378;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9w5F+ig/Qh8/Pg1lF76hwLePYUCXgzP2kcrmcuAjXiI=;
        b=EEnGb1MzXQZAZ5JxrC2WRcoT575rrfw58Ve1i+iChicVKx171xlUProDsmtSBRqXuv
         YjarWodQz1qHiNp/VBl2745CaZ52cJSIGefA4/iVeLJgCKySvAU17nLW321w4CnOJThP
         akvcQyD0/xDKGaNux7aZhKpNP0DI7oYsKrllI8lPxjhed2FSnW5sqgk4/Nl/VTASwTyt
         vc1yBHHzxHS9WF92iVlF1r7KRltjDa2DjnPUk9vyvo58iV46+UmC6uqm4jv1Sw809qqf
         i3035wJDEfIHOC6f23CoZQ7FAPvX4M6PngeAA5Xl4jwk/xsJxSOS3dskVKrP9DkY7NpE
         1UFQ==
X-Gm-Message-State: AOJu0YwjD7S98N0f/z2oeSLNsTxGZUD4NEQfKnKefTFtwnPDhtXlqjYg
	IvpUXQjGVh0c/EcHcY1XZ6U5snR6nySxTi2nYBzZid2weq5ew9Fx9HBiMG1y
X-Google-Smtp-Source: AGHT+IHMRhEISQux+omUlh5Z0FPmgHM8dUF5CIClTQeBkSw7GNiQ/g+u0JgL7jR8qwffj4qkTmVYjQ==
X-Received: by 2002:a05:600c:5114:b0:412:9830:a259 with SMTP id o20-20020a05600c511400b004129830a259mr6202151wms.25.1708983578382;
        Mon, 26 Feb 2024 13:39:38 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u20-20020a05600c00d400b00410b0ce91b1sm13073746wmm.25.2024.02.26.13.39.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 13:39:37 -0800 (PST)
Message-ID: <04867eccfcd89e4a905899f6ee5f595396a4a9ea.1708983566.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1662.v3.git.1708983565.gitgitgadget@gmail.com>
References: <pull.1662.v2.git.1708658300.gitgitgadget@gmail.com>
	<pull.1662.v3.git.1708983565.gitgitgadget@gmail.com>
From: "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 26 Feb 2024 21:39:24 +0000
Subject: [PATCH v3 13/14] fsmonitor: refactor bit invalidation in refresh
 callback
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

Refactor code in the fsmonitor_refresh_callback() call chain dealing
with invalidating the CE_FSMONITOR_VALID bit and add a trace message.

During the refresh, we clear the CE_FSMONITOR_VALID bit in response to
data from the FSMonitor daemon (so that a later phase will lstat() and
verify the true state of the file).

Create a new function to clear the bit and add some unique tracing for
it to help debug edge cases.

This is similar to the existing `mark_fsmonitor_invalid()` function,
but it also does untracked-cache invalidation and we've already
handled that in the refresh-callback handlers, so but we don't need
to repeat that.

Signed-off-by: Jeff Hostetler <jeffhostetler@github.com>
---
 fsmonitor.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/fsmonitor.c b/fsmonitor.c
index 739ddbf7aca..3c87449be87 100644
--- a/fsmonitor.c
+++ b/fsmonitor.c
@@ -183,6 +183,22 @@ static int query_fsmonitor_hook(struct repository *r,
 	return result;
 }
 
+/*
+ * Invalidate the FSM bit on this CE.  This is like mark_fsmonitor_invalid()
+ * but we've already handled the untracked-cache, so let's not repeat that
+ * work.  This also lets us have a different trace message so that we can
+ * see everything that was done as part of the refresh-callback.
+ */
+static void invalidate_ce_fsm(struct cache_entry *ce)
+{
+	if (ce->ce_flags & CE_FSMONITOR_VALID) {
+		trace_printf_key(&trace_fsmonitor,
+				 "fsmonitor_refresh_callback INV: '%s'",
+				 ce->name);
+		ce->ce_flags &= ~CE_FSMONITOR_VALID;
+	}
+}
+
 static size_t handle_path_with_trailing_slash(
 	struct index_state *istate, const char *name, int pos);
 
@@ -219,7 +235,7 @@ static size_t handle_path_without_trailing_slash(
 		 * cache-entry with the same pathname, nor for a cone
 		 * at that directory. (That is, assume no D/F conflicts.)
 		 */
-		istate->cache[pos]->ce_flags &= ~CE_FSMONITOR_VALID;
+		invalidate_ce_fsm(istate->cache[pos]);
 		return 1;
 	} else {
 		size_t nr_in_cone;
@@ -297,7 +313,7 @@ static size_t handle_path_with_trailing_slash(
 	for (i = pos; i < istate->cache_nr; i++) {
 		if (!starts_with(istate->cache[i]->name, name))
 			break;
-		istate->cache[i]->ce_flags &= ~CE_FSMONITOR_VALID;
+		invalidate_ce_fsm(istate->cache[i]);
 		nr_in_cone++;
 	}
 
-- 
gitgitgadget

