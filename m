Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 281842E64E
	for <git@vger.kernel.org>; Thu, 18 Jan 2024 20:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705610617; cv=none; b=lHbxD6Is6tpXpYHLq4k0m40rSnjdwS/AFiFbr6OCDb3oD4D440mJW++7Rx/ZkvxqsLR3CvW4KiUm4klIIIESa3oIgKDjc9gs4CoA+J0FLe5J7tjrHE3LLm82Q0m/UDPrViWIDll5LjmJvM/7LAIUFK3wW9ThL2/Iizr/7qMnuvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705610617; c=relaxed/simple;
	bh=TkljkeX5gvBAa5EBLeysst6vTyqLeXh82bvsaZ3M2Oo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V03wPZ4klLIh5Jnw0Eo8g70eA1ECohRVJO2u9c9WNq+jL1aoOMJccm+6Gdy9XPbQfQLIP3LaYkvr3IAxuAZpwyNgVOMYqO/D+25jGKGsRENdIDSlzu8osqHsemT3K66/r7iX4aWA5zC1mCdI/cKfFR08cASSRy7jwc7Mnjk1aMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b6dYGgM5; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b6dYGgM5"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6dbb003be79so582845b3a.0
        for <git@vger.kernel.org>; Thu, 18 Jan 2024 12:43:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705610615; x=1706215415; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B/fsjq47fPOg1lo5imWWwoMa7Pbx9vS/S4xcfjnkppk=;
        b=b6dYGgM5b1wkxKiNjQySXVwxHwlkWMt5uu8HTohJnS5B8vcR/Qsf9hmUCsd/EwgIUz
         LbgZv5NeKlYWKHBDZDRW5glhX6mWqlwm1jwlYKNJvsOkNTQhuUSMvNtDSxLjJjtNGKpJ
         k24WKq3l3MsJz5aa/ZPh7cUen2ZqGFYDFnEdsbmKbaqwtSJAKNd2ZejK7MSoFcoSYfVk
         9ky0UgIj94T1fQcNSkao+xF4QrePxGRETZUlar1jdFbqfClulTfujFwg7Bp0OYVxI/Ya
         she0TnA5aph9jKVDXb9DbiXXqNVptAigcWoZJSPnq05yW5ULfnf+VkbKBEe6JXEJgB6+
         2sPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705610615; x=1706215415;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B/fsjq47fPOg1lo5imWWwoMa7Pbx9vS/S4xcfjnkppk=;
        b=izRgsPqNpaRT3WGu4vxoXEEj1GM84Yc7qOR2YRSbqNBVrI1r1xjp3/uylpuzqblaqc
         ITzFJYdklkd4lxK76hj7UBHRlRFcYVCElHUmJaYyVP7X4f+eqqYcwnMPiYzcTBo1RgVP
         lWiChurk0qmek1FwlPk4M9U7TyrMOvE8qT5nRPT4jj8eWFb/1ENmnaCoksGWhS7lMSdL
         nJdm/YX9xh5eK9iyVIwN2Lero7hPmIj2wdZ+o/AeCDh+Vx/z7Tjm8Jw1q5EhRPJ5NF38
         reWU70f86Kl+MZ7qLA/rkSeFwEFeooV2dduTj7cc2nQeff9jxHaTp1sLSXuPGjq1P00T
         yTVw==
X-Gm-Message-State: AOJu0Yx5Oeq2TjTsX4Kc0X/LtxnsxuFZZFVre41nTdljOPBL+ltzyee/
	onHjp05db+BsaYuzseCeXtHx4ArzV4eiMK72aw2bsJfP6R/gqEFEk9xzLpQsatM=
X-Google-Smtp-Source: AGHT+IGJSVi6yd2AUdpq8NXxwv9JhxKWWo1fITFRiAzDXPKWgX8t8/Auu3q7jxXUtpwq1N5fLsH74w==
X-Received: by 2002:a05:6a21:164a:b0:199:da11:8efa with SMTP id no10-20020a056a21164a00b00199da118efamr4020970pzb.27.1705610615482;
        Thu, 18 Jan 2024 12:43:35 -0800 (PST)
Received: from brittons-large-Vivobook (mobile-166-176-186-78.mycingular.net. [166.176.186.78])
        by smtp.gmail.com with ESMTPSA id j38-20020a635526000000b005cf7c4bb938sm1995759pgb.94.2024.01.18.12.43.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jan 2024 12:43:34 -0800 (PST)
Received: by brittons-large-Vivobook (Postfix, from userid 1000)
	id 1776D52026F; Thu, 18 Jan 2024 11:43:33 -0900 (AKST)
From: Britton Leo Kerin <britton.kerin@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Britton Leo Kerin <britton.kerin@gmail.com>
Subject: [PATCH v3 1/5] completion: complete new old actions, start opts
Date: Thu, 18 Jan 2024 11:43:19 -0900
Message-ID: <20240118204323.1113859-2-britton.kerin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240118204323.1113859-1-britton.kerin@gmail.com>
References: <03fe3371-2b0f-4590-90ad-166b8fa4cbbb@smtp-relay.sendinblue.com>
 <20240118204323.1113859-1-britton.kerin@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Britton Leo Kerin <britton.kerin@gmail.com>
---
 contrib/completion/git-completion.bash | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 185b47d802..15d22ff7d9 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1449,7 +1449,7 @@ _git_bisect ()
 {
 	__git_has_doubledash && return
 
-	local subcommands="start bad good skip reset visualize replay log run"
+	local subcommands="start bad new good old terms skip reset visualize replay log run help"
 	local subcommand="$(__git_find_on_cmdline "$subcommands")"
 	if [ -z "$subcommand" ]; then
 		__git_find_repo_path
@@ -1462,7 +1462,20 @@ _git_bisect ()
 	fi
 
 	case "$subcommand" in
-	bad|good|reset|skip|start)
+	start)
+		case "$cur" in
+		--*)
+			__gitcomp "--term-new --term-bad --term-old --term-good --first-parent --no-checkout"
+			return
+			;;
+		*)
+			;;
+		esac
+		;;
+	esac
+
+	case "$subcommand" in
+	bad|new|good|old|reset|skip|start)
 		__git_complete_refs
 		;;
 	*)
-- 
2.43.0

