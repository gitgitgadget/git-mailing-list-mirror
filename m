Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58D52657A3
	for <git@vger.kernel.org>; Mon, 29 Jan 2024 13:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706534892; cv=none; b=HXQAhfAsRPFlroQBfp8WeQT8BCRkNTpMD8Kgmcm0bgGFWHsfIw3gboES/sBF0Z4jSCMpLAy3/c3qq/CKSuhPsXl54m+nOQ8RNLM+t+eH6eLcb83eITO1EGPkRsMi/qr9bOA1NprUxk1RlY2Xw/MWqc9E9Dql6C3N+gOzrHke2eE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706534892; c=relaxed/simple;
	bh=2vtrJHbRnX+npVfLN922a7kuIY3hHTq3L1bsZuVpGTg=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=hVDrd09fNt1fpJF0409mPNwNQEuw1F0NBGZvUYOS5+a5FbH7xKRilV8zR9IrnBGJ3L2D3thJtD1hGTcRn2Sbx6WeZL9vtngj9gP9x1/mLv9xA57A3do3956mq39KhwMhzRkIVkzPDtTWY7/Xgqx5ihIIjQTNbWJSAbUFb5JwPU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EfKS/Uiu; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EfKS/Uiu"
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2d04c0b1cacso10602221fa.0
        for <git@vger.kernel.org>; Mon, 29 Jan 2024 05:28:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706534888; x=1707139688; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5dEGWprWWUyitE72gJhxPCNtNyO5AFJdA4Ck7/jeXsY=;
        b=EfKS/UiuYuyBwaeCfwxfN9R/E0VH8CXvjFd5eKReVY5KLSvdiGhaNJvIn7X6cJFEra
         UVfvUaIUIS3MMAUBzyspSuAELHGaLEm/CiV+0jgNwG9fybmOPl+NT5zlt1rBUPjXgJYh
         nX6BD4RyVUYaG/TJyNHxSU7mh8GI3t2R7P7aJaa7j8fmPIoy6LfgxHBDlZX9SgNas4MI
         G2jWqjAL3mT3EaM7NWcDMshFscp/fo4Ij3heUs/7jpx1O0tvifOKGA2Ptd8kTPZANdzh
         3ch3dlM0iF79U3NbBTNCBKTq9TIcJe+tEMv22ylP0DTV1czBExt4x8xhDLdF6IZC4942
         UpCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706534888; x=1707139688;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5dEGWprWWUyitE72gJhxPCNtNyO5AFJdA4Ck7/jeXsY=;
        b=Ipkkv7RNyaDDIhGc2mRRQhN63Y6KchzIQ7VtVeNHtzfE1S6wjTme3JgF/pqIK0PFz8
         v7KKa5J/S303LHDPMfYHq54Oi/V6RGkYGeLKlV6WDofHS8mlsu1/IwUdBK6z8EnL/1Bs
         w3Q+Z+6AMWPhRT2/h6/R+YXyPoMUNkIX3VQHedkqv8WtCTD6sFvWSZMWj/0q+7zJ70AP
         gsrESl40YM4MpPMeRz2TpKISQeQy3fXoByk57DBQ93Tl75/Juo1KIC4Vcn4uBaORrH8z
         ET7D/UM5lsT8xbkxA4SssZsifo0cRCCpLQR/FFTnqKtmMm8p9+ZGskCse8SWwWnO0P9l
         zYYg==
X-Gm-Message-State: AOJu0YwS5FPl/vBba6QvRbhtqvlRIh9SzlDFnGp/1DprLmWFH5OnDnKt
	XwJmLslGNoElT50lxrWuYOfo3JxjOgzRIIp8UTCvrQpy0ia6DkUfYTLVervz
X-Google-Smtp-Source: AGHT+IE0uWEnInhIqkGE/yk/nTbNuofcHxqcqYboVtWbp/R8fSkiJ27mCXOl7PFJWQirOwlWNRgwPw==
X-Received: by 2002:a2e:8896:0:b0:2cf:2fc9:9a08 with SMTP id k22-20020a2e8896000000b002cf2fc99a08mr3727969lji.24.1706534887493;
        Mon, 29 Jan 2024 05:28:07 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id bp19-20020a5d5a93000000b003394495566dsm8219605wrb.22.2024.01.29.05.28.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 05:28:07 -0800 (PST)
Message-ID: <d442a039b27820dbd44e604df75ec026b8243d47.1706534882.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1660.v2.git.git.1706534881.gitgitgadget@gmail.com>
References: <pull.1660.git.git.1706472173.gitgitgadget@gmail.com>
	<pull.1660.v2.git.git.1706534881.gitgitgadget@gmail.com>
From: "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 29 Jan 2024 13:28:00 +0000
Subject: [PATCH v2 4/5] builtin/help: add --config-all-for-completion
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
Cc: Philippe Blain <levraiphilippeblain@gmail.com>,
    Philippe Blain <levraiphilippeblain@gmail.com>

From: Philippe Blain <levraiphilippeblain@gmail.com>

There is currently no machine-friendly way to show _all_ configuration
variables from the command line. 'git help --config' does show them all,
but it also sets up the pager. 'git help --config-for-completion' omits
some variables (those containing wildcards, for example) and 'git help
--config-section-for-completion' shows only top-level section names.

In a following commit we will want to have access to a list of all
configuration variables from the Bash completion script. As such, add a
new mode for the command, HELP_ACTION_CONFIG_ALL_FOR_COMPLETION,
triggered by the new option '--config-all-for-completion'. In this mode,
show all variables, just as HELP_ACTION_CONFIG, but do not set up the
pager.

Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
 builtin/help.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/builtin/help.c b/builtin/help.c
index dc1fbe2b986..dacaeb10bf4 100644
--- a/builtin/help.c
+++ b/builtin/help.c
@@ -50,6 +50,7 @@ static enum help_action {
 	HELP_ACTION_DEVELOPER_INTERFACES,
 	HELP_ACTION_CONFIG_FOR_COMPLETION,
 	HELP_ACTION_CONFIG_SECTIONS_FOR_COMPLETION,
+	HELP_ACTION_CONFIG_ALL_FOR_COMPLETION,
 } cmd_mode;
 
 static const char *html_path;
@@ -86,6 +87,8 @@ static struct option builtin_help_options[] = {
 		    HELP_ACTION_CONFIG_FOR_COMPLETION, PARSE_OPT_HIDDEN),
 	OPT_CMDMODE_F(0, "config-sections-for-completion", &cmd_mode, "",
 		    HELP_ACTION_CONFIG_SECTIONS_FOR_COMPLETION, PARSE_OPT_HIDDEN),
+	OPT_CMDMODE_F(0, "config-all-for-completion", &cmd_mode, "",
+		    HELP_ACTION_CONFIG_ALL_FOR_COMPLETION, PARSE_OPT_HIDDEN),
 
 	OPT_END(),
 };
@@ -670,6 +673,10 @@ int cmd_help(int argc, const char **argv, const char *prefix)
 		opt_mode_usage(argc, "--config-for-completion", help_format);
 		list_config_help(SHOW_CONFIG_VARS);
 		return 0;
+	case HELP_ACTION_CONFIG_ALL_FOR_COMPLETION:
+		opt_mode_usage(argc, "--config-all-for-completion", help_format);
+		list_config_help(SHOW_CONFIG_HUMAN);
+		return 0;
 	case HELP_ACTION_USER_INTERFACES:
 		opt_mode_usage(argc, "--user-interfaces", help_format);
 		list_user_interfaces_help();
-- 
gitgitgadget

