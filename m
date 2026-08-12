Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE7E63ACF02
	for <git@vger.kernel.org>; Wed, 12 Aug 2026 08:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786521812; cv=none; b=pWMnewop0Fv3QExgn3ogy54PxPuzu8kvIgIGza9RgHf8nRKXyY3TFiWfsi4/zVsc8CwPk6AUHPN/kLhkKPv47yh0kdGSwd1IOo4FXO9MnLRCl8lhEgNrFwBKxMDkQk68Dr2i/uX4TTGHCZLvqowpC48uqJVAySzBHbZ/eauksRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786521812; c=relaxed/simple;
	bh=hBcXB4/MZ2qiandxi0tb5lmXZyTUNl0HN3iRN+0u4o8=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=AY6pOZdPSMGXfVcsUcw1fhvl7ZUseL8xo5wm5X7qYRzVxHGbPb4LVyXxDecAZf+HrRYiic8mfDKGLtTRMzMjJwHfhr1cFx7cptzf29b3tRMmvuCDn/mgbLqyblKsL63mS05PNKZE+ghmEOUmt69BGYgJ5wnZhuaqKFjHICYpB10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yq6Lp4sg; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yq6Lp4sg"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-38511175ad3so556933a91.2
        for <git@vger.kernel.org>; Wed, 12 Aug 2026 01:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786521808; x=1787126608; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=1lmKKOy9qNJlPi0r5GCaMfQJVRWGA7FF3QlA6yt/sNw=;
        b=Yq6Lp4sgZ/sQBlgZdzh9XO1RPreSYgr4/4HKq8+bpPNvMNYfcxO+bLtFXi0iyrJe9M
         +7YuUvbPHSY1QcLu8fk409rEsiqm58VoGjwSBak9SrH9b/85UzyvcebBKRu+xBzqfug6
         24C2GvtxfSPWnddTV0Mxaaor05H//mhGPcjaXgCnzA03IcnIYB1/RoXYFobBzzohwSs1
         da3DqnFC+WYbnxsZS22XZfwXqa4Nf41arGZMLvXBZvntXvYgex34UBWZEp6O9nJnYSPa
         kWT2dbtC1TZcLg5TN0nIDnz0dw3xnpyW3qZNzYosq4heyWkkI1zgOzZorQNiskfJWtW2
         5Qzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786521808; x=1787126608;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1lmKKOy9qNJlPi0r5GCaMfQJVRWGA7FF3QlA6yt/sNw=;
        b=S7xDzSYT6qe53LnEaTdKgmx5nJI3KQQi02GHwVjiACj/dzJ1DK5wzY+IoOFs/0b4Su
         d/L8vIa/BYQNjiNxNfG6dAcn5hTp7Z+23+NCb4ZGqDIdrc0Va7D8Zq7V29I3/p2nFHoJ
         hnozWqhVioaPQMQQzzZd47TWJzO8/8lqEay493G1XjFvS97hQJRMbANQI3c5quxE9Erq
         7U7MWBdfZ7isVdy3UcHwbF+fiYxgBlGZaft1o2O+CjGiw6rvS7i6FuEMmGf/m0jcsMC0
         6yObINRAnUy/Uqe6Via691CthAhD1i79QflTYnKICPs8mzB8LbECgBgAr0oLTBdkUQH1
         c1OA==
X-Gm-Message-State: AOJu0YzJPcmAd7XePjz0AY96SiGEhNZM3gr5UgHUgxNbht0VDXdTOyix
	HC4sNOAiq2Ks6nbI2Z2dOygnX6oLmWX9lrk66oZLiQHST/oxsE5qk2dQ59NU9TEA
X-Gm-Gg: AR+sD1079Q38TaCNkmFD60kh5rma8/uEQe5FN3uc8PXGhPnrx7fgkDSiWPIOuzwqMY0
	YwhY8Ofd9EmA5yi4loF40ijPuK41AOyL3bsjSE9C9NZ50QpL4bQTeJbSITNjG7zNxS0jG9sqSiG
	ZpIvGtTjtxgjPMVeyMukA8w2gzVuvMxsq1exvGBFYdxV/SBjE3zRqwjaJROMGuI79L1I41ATkCV
	S0pHkQDS1epzrPS79rKiO93zVO3kwwEQujhWHEpsl/lk2gMLTEsixcE1mEABOk82jLuimAFL3CK
	faWc/Fj6r5gycy/+xvcNoGh49In2flmWeK0QiGdV/OkHCPG0HznqEZeydvdaUbTw2J5xI1CBn7d
	JqwmvkLiHwhloxW2STAGB5UXS7cqT345BOoBgyZob/gz/jCBb+E3GI3NQg+UlRq2Gj/NaYV7Esx
	PHO5+O9YLxqmCRaD1FYxovfb0ESq2MTl4HJlu3e026zGOCZIwsMFdG1n4KDWXz3g==
X-Received: by 2002:a17:90b:164c:b0:38e:740f:9764 with SMTP id 98e67ed59e1d1-393016a76cdmr3368077a91.18.1786521807999;
        Wed, 12 Aug 2026 01:03:27 -0700 (PDT)
Received: from [127.0.0.1] ([134.33.71.70])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-392f908a82bsm2634241a91.0.2026.08.12.01.03.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 01:03:27 -0700 (PDT)
Message-Id: <0692704d45060a62579b50dd7a2f07da04f435c8.1786521801.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2179.v3.git.1786521801.gitgitgadget@gmail.com>
References: <pull.2179.git.1784069325.gitgitgadget@gmail.com>
	<pull.2179.v3.git.1786521801.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 12 Aug 2026 08:03:10 +0000
Subject: [PATCH v3 02/12] config: propagate launch_editor() failure in
 show_editor()
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
    Jeff King <peff@peff.net>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

show_editor() calls launch_editor() to open the user's editor on
the configuration file, but discards the return value and
unconditionally returns 0 (success). When the editor fails to
launch (e.g., $EDITOR is not found, or the editor exits with a
nonzero status), the caller receives no indication that anything
went wrong.

This affects "git config edit" and "git config --edit": the
command silently succeeds even when the editor could not be
started. In contrast, other editor-launching paths in git (such
as "git commit" and "git rebase --edit-todo") properly propagate
editor failures and exit with an error.

Check the return value and propagate the failure by returning -1.
The two callers (cmd_config_edit at line 1315 and the legacy
cmd_config at line 1478) both propagate this return to
handle_builtin, which translates negative returns into an error
exit.

Pointed out by Coverity.

Assisted-by: Claude Opus 4.6
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/config.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/builtin/config.c b/builtin/config.c
index 8d8ec0beea..1307fdb0d6 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -1313,7 +1313,10 @@ static int show_editor(struct config_location_options *opts)
 		else if (errno != EEXIST)
 			die_errno(_("cannot create configuration file %s"), config_file);
 	}
-	launch_editor(config_file, NULL, NULL);
+	if (launch_editor(config_file, NULL, NULL)) {
+		free(config_file);
+		return -1;
+	}
 	free(config_file);
 
 	return 0;
-- 
gitgitgadget

