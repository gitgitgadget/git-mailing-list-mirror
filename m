Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E13002E62C0
	for <git@vger.kernel.org>; Thu, 18 Dec 2025 18:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766083706; cv=none; b=pk245sWO2sm6rdyoexme65x3FVdbysYK3AE1iGzvWiccXe+FLiAfTA7s4lKPsxuvSB8GR7HF/gIQq5qve0Y5USi7VvjPqu3Fd1tWegsxRaDoKY7lrOFyVhHA5hAgTNyDtJNq82IKmqx9dCXEOur+LLPYvfY1nhSxFBWcIaxtJ5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766083706; c=relaxed/simple;
	bh=kSZtcgSd/cQPG9aX4eTY4VkxRPzFDX3NyIJ5t8iS9F8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OzlZAcCu7x0Jk52vt7iynsZZhQdUk+ebGWtn1pzAhJagfs6FeGRaLGrzVCXd734bSwHqKeCo02ZhesR0bwAfzxtnE/35hNDeXm5ZixbDPU08ZGoAISYfoYJ9HzhF/vtDEooIquJitZeqNRDNqc7Qm/3G2UNn7nWgW+ZlztOelcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gngomt8l; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gngomt8l"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-43106d67728so118532f8f.0
        for <git@vger.kernel.org>; Thu, 18 Dec 2025 10:48:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766083703; x=1766688503; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SynUBBI9SFi5KVjiL0zaCQ3zCq2T8uG2WB+YneMMCGs=;
        b=Gngomt8lYCTKIs8JHhPQatQ0G4CZ4oWi4DbHn/A8F6cwGE6AEsR+2gCW2fYTNcxx3z
         VmDp3UxUL6X/aYvkWIUboFuO73v5IyiimhaW86PzO3Od4UoEZuSNX589CzU+NYFcUZiR
         jUaBZ+HnjKFW02OUWeYJxiEtm4iJDd+F1CEEFst1qp1WvaI0xlNoNaV/MVXtwRrs44At
         hliUdEJRd08qUzO/AKvVe+SxZj53n3QKtDYF3TYMcClFpxpton2jNOIg/4rornJaHw6o
         ZkoyHUYSiuolwVBlcSjnB/X59Mpov9qW20+i3Aq6cChH8iKfJIdFpAp/k+3loxDIkEXu
         eihA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766083703; x=1766688503;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SynUBBI9SFi5KVjiL0zaCQ3zCq2T8uG2WB+YneMMCGs=;
        b=F0UEd48KIKF+wbQbh73ucUynsHoUPIEzmUIyBKfcvKUTIp8al9C9Mn3PQ4N4z3poUO
         xxuOu2V12a7atWz8LfCo5wIQBO6+IEKkkIehyd3XtL+kQxWcWprf7BE5adjJVfxIr7Vs
         vwwt9xCJqd0DGs8lIfdHskaVEvz5T4VOBGOH6ogtRc7prJoERUdBjjBnxbBMX7MYJMaM
         eq+K+hhuGMZBJKph4rPrgl7K/9vyXaImZMB4WG4tJ03v8aVANhF9ke8vQqMCzIosOmZk
         MIgvKqJjNwYs0ZVfiYF4Wr4FPxe/8v6jUz0vbUqGJaxa5YZ2X4DA0+IRPJHib9TxCXPw
         Es6A==
X-Gm-Message-State: AOJu0YxPST+j/316o+BtRcxiJaLeGsdmolO8NsyPYyprK4pvNciDdG53
	ehpg2jxR3eByYhbSnPC6saFTIt89R3Ri/UjGspS27D0AJx38N7YwzPj20hIcNkxI
X-Gm-Gg: AY/fxX561ec20v1szDQreLpYMVDVKRM2KqxE1rjxBBQIlQAvOAwVRzkCCQ7zqSSpChh
	naP6bzhEpESHc953xf9cylwtk1GTISGIYXcYR0jLDsdObi8YW/fLFzGfd4cL+MgZuxTL44GrqMP
	M5wLB+qg4QTxYX6jo+NLSDTrVk+WEcZmi2NHk8v0rWLpO+LkRl4WjTCT8ctfmowyh+h1zTUsChS
	A2gNNzs7+R46TIatTYl6xnZMA8MawbLqU6dDdvSoGSHTDjhZnfHqbVK8V8P2OSZgDttA5ESvaeA
	zhnyRqiZreLlQMdAtO0KBoFIH4EZXha6CHj/aBCELpvy+YWBtllpL8vkEXifMfE2CEeC++mcRnm
	0Hw2XX1LlGVgSmln/6HTHpnrateyPpTHONXRKzbpz9kD+iYSe6WyeQVS/JYZYOx3LypaPFwA4+b
	f0mm92gjdbXdhHHHI=
X-Google-Smtp-Source: AGHT+IEes7M9yrvBt8J53IrwDa8vRZNqcNkENy6YL7Y+uNzwijY8mEqaoIRHsXwJ62qYP8BHKmZ44Q==
X-Received: by 2002:a05:600c:444c:b0:477:9dd9:ac57 with SMTP id 5b1f17b1804b1-47d194b0c60mr1310115e9.0.1766083702679;
        Thu, 18 Dec 2025 10:48:22 -0800 (PST)
Received: from desktop ([194.127.199.104])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47be27b28a7sm55716755e9.12.2025.12.18.10.48.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 10:48:19 -0800 (PST)
Date: Thu, 18 Dec 2025 18:48:19 +0000
From: Matthew Hughes <matthewhughes934@gmail.com>
To: git@vger.kernel.org
Cc: Matthew Hughes <matthewhughes934@gmail.com>
Subject: [RFC PATCH 1/1] maintenance: add config option for config-file
Message-ID: <20251218184751.31209-2-matthewhughes934@gmail.com>
X-Mailer: git-send-email 2.52.0
References: <20251218184751.31209-1-matthewhughes934@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251218184751.31209-1-matthewhughes934@gmail.com>

This is to allow splitting out this configuration from the global config
file, e.g.:

    # in ~/.config/git/config
    [include]
        path = maintenance.config
    [maintenance]
        # use a separate files for reads/writes from
        # 'git maintenance {un,}register'
        configFile = ~/.config/git/maintenance.config

    # in ~/.config/git/maintenance.config
    [maintenance]
        repo = /path/to/some/repo
        repo = /path/to/another/repo

My motivation for this is that I track my global config in git, so I'd
like to avoid changes in there that depend on specific repos/workflows
that I'm working with.

Signed-off-by: Matthew Hughes <matthewhughes934@gmail.com>
---
 builtin/gc.c           |  8 ++++++++
 t/t7900-maintenance.sh | 13 +++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/builtin/gc.c b/builtin/gc.c
index 92c6e7b954..257cceecf6 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -2124,6 +2124,10 @@ static int maintenance_register(int argc, const char **argv, const char *prefix,
 		usage_with_options(builtin_maintenance_register_usage,
 				   options);
 
+	if (config_file == NULL) {
+		repo_config_get_pathname(the_repository, "maintenance.configFile", &config_file);
+	}
+
 	/* Disable foreground maintenance */
 	repo_config_set(the_repository, "maintenance.auto", "false");
 
@@ -2194,6 +2198,10 @@ static int maintenance_unregister(int argc, const char **argv, const char *prefi
 		usage_with_options(builtin_maintenance_unregister_usage,
 				   options);
 
+	if (config_file == NULL) {
+		repo_config_get_pathname(the_repository, "maintenance.configFile", &config_file);
+	}
+
 	if (config_file) {
 		git_configset_init(&cs);
 		git_configset_add_file(&cs, config_file);
diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
index 6b36f52df7..baad960051 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -1024,6 +1024,19 @@ test_expect_success 'register and unregister' '
 	git maintenance unregister --config-file ./other --force
 '
 
+test_expect_success 'register and unregister config from maintenance.configFile' '
+	test_when_finished git config --global --unset-all maintenance.configFile &&
+
+	git config set --global maintenance.configFile ./maintenance.config &&
+	git maintenance register &&
+	pwd >>expect &&
+	git config get --file ./maintenance.config maintenance.repo >actual &&
+	test_cmp expect actual &&
+
+	git maintenance unregister &&
+	test_must_be_empty ./maintenance.config
+'
+
 test_expect_success 'register with no value for maintenance.repo' '
 	cp .git/config .git/config.orig &&
 	test_when_finished mv .git/config.orig .git/config &&
-- 
2.52.0

