Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AFC319D090
	for <git@vger.kernel.org>; Sun, 16 Feb 2025 16:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739723839; cv=none; b=IyCeAmayRd07YaOSEour1mDKyp914euKIy7kYmhEZDcgt/qlY74UAJkN7mrxz6OzI/LPze3GYSPDrV+6MXAAhIEKjtsfcuqu1/dXATzxin45Va4Z2HpTv4yTVeSHam8+4E62u+wf43q4rdnbTV4TBU5r5yDDb52lPgyQDA9W7XA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739723839; c=relaxed/simple;
	bh=fsb00xLpOxRrgT/DgrF+Cf4vGKMmdw1Ft/tXfKOD7cs=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=dIfbcehbSeLQjMDrk/sdsUypPHlFEnuVtg+O8O7Dn3z91MCuXlewb4JmvPT7JGt23C1rVSTJrUYcxqXv/x3BX9Yc+0Zao0D9xuGg3Enbc3lawgxHCg8VgOiye/TnBRDUkZqEUWTcb6eCrGwHnu/VqzImEIPbmAJnWueiVirrnHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BDQBO3Ob; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BDQBO3Ob"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-38f2b7ce319so1876955f8f.2
        for <git@vger.kernel.org>; Sun, 16 Feb 2025 08:37:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739723834; x=1740328634; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nykryX9gYlil/AYXBT+DOOFcMiqRnFeK+MsOWuNjDGI=;
        b=BDQBO3ObabN3j+szd3B73ZHxczEeajhPcNiIVLq1XeOS9AZIui/Syws3/Fgc6yaE6S
         DASE/cfRkyep+QhXsVWyeoHWNNfXu1cYEvaYK0tFICTRCmWXX/Sa+7u7GCWj5itTcWsI
         zFS8BCsYagQ4JBSzByiN3p6B8aitOgDEHgqW9ddue4AXs6FK8kKb8QMh2IYbRxgAOEwI
         zvWSrl+x87BFjjAbZXdZPd3qeLxGZdNFFqckVbZh175BQjTk+6f7Gw/6vQhpFKAIIrN6
         Ws1NIQZMC6gPLA4549hJv6QMnJR+gfEFWnCXVE7TZNaLnLOz/rx3TNcFZPVWlRAo1oZa
         Jxtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739723834; x=1740328634;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nykryX9gYlil/AYXBT+DOOFcMiqRnFeK+MsOWuNjDGI=;
        b=UKZslsjg6XNj6d5Zmx6wzKtLO7NxijSynC46/1jl5aYU8zJe0WOHQLEmL41xaYvMN5
         cLn/Bz4x/S2UVqvLXqyJvvUPkdbu1usHdVNaTLjfv9iknQh0iXmihhM4/IaNfZWrS70m
         RAZQ0n9KByO0tNddgMQODQ0DQ8khTcVsWEhrbEwV3jH6BbkapRoYAVeOr4Nw+ll6Gumu
         9TLeSjKUObDRYJcFeiZltcF1XZ60cTrVwS24c1qimLMRJfkryVklcS4fmMLjFZ4juDQT
         5czZ6AoRVBsMYeP3dsHm8TpG9E6mNEVrRtWb2qy4JOUk8Op4V7bf9MdvmPp7BWECqCMt
         E+jA==
X-Gm-Message-State: AOJu0YwjvhPh7wGlsVlkPb0uJD2sNgtM/nL24yCaAM6J9dEGG2o5V64j
	/0iGS0dJTXNo1Qw2nOHfAb21rJlTz6Li51CipLtIT37K7dISAwvvvRKUVw==
X-Gm-Gg: ASbGncvs7sh0uIpOD18GcqpsO9+LFj9P/xupmZUdhp66FoGS2/0LzfJAi3HO5M4i55R
	nNjhlPw//4DmWrwb/SoWAP0G50/h3HStLIJ24pj83VMcDnb5hg5RCuP8+gOCk0XzE2UsJAbiZGE
	wmhyyAvC5j/J8nqik2J27ghcHjjjEK3bF35Kger0AyZSQuhG60N3RSL0G2S+txDgTGTIsZVBM3x
	liUCoH1N3s+v5uXVeZLp1K/wFOP3X9GP4yVWa3dqzExxTed9zV8ERaceQKIhdEqVdVBT2ikFlDH
	eLQAIoQaoww+Oiiv
X-Google-Smtp-Source: AGHT+IEkbFyTtcOPGUTxVgKZ9HE+hNIOPZsUWqD02GrLDEUkPL2cU6Svyt4dRfo6wGlQPAlGs2p2EA==
X-Received: by 2002:a5d:4c82:0:b0:38d:dffc:c144 with SMTP id ffacd0b85a97d-38f33f5be49mr5377145f8f.55.1739723834043;
        Sun, 16 Feb 2025 08:37:14 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43983264ef8sm9712515e9.4.2025.02.16.08.37.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Feb 2025 08:37:13 -0800 (PST)
Message-Id: <bf1dc603a153ed9e8a3e7b708ec99877048ab3e3.1739723830.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1862.git.1739723829.gitgitgadget@gmail.com>
References: <pull.1862.git.1739723829.gitgitgadget@gmail.com>
From: "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 16 Feb 2025 16:37:07 +0000
Subject: [PATCH 3/5] merge-tree: only use basic merge config
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
Cc: Elijah Newren <newren@gmail.com>,
    Phillip Wood <phillip.wood@dunelm.org.uk>,
    Phillip Wood <phillip.wood@dunelm.org.uk>

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Commit 9c93ba4d0ae (merge-recursive: honor diff.algorithm, 2024-07-13)
replaced init_merge_options() with init_basic_merge_config() for use in
plumbing commands and init_ui_merge_config() for use in porcelain
commands. As "git merge-tree" is a plumbing command it should call
init_basic_merge_config() rather than init_ui_merge_config(). The merge
ort machinery ignores "diff.algorithm" so the behavior is unchanged by
this commit but it future proofs us against any future changes to
init_ui_merge_config().

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 builtin/merge-tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
index 3c73482f2b0..3ec7127b3a6 100644
--- a/builtin/merge-tree.c
+++ b/builtin/merge-tree.c
@@ -576,7 +576,7 @@ int cmd_merge_tree(int argc,
 	};
 
 	/* Init merge options */
-	init_ui_merge_options(&o.merge_options, the_repository);
+	init_basic_merge_options(&o.merge_options, the_repository);
 
 	/* Parse arguments */
 	original_argc = argc - 1; /* ignoring argv[0] */
-- 
gitgitgadget

