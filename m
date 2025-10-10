Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11C5F214A8B
	for <git@vger.kernel.org>; Fri, 10 Oct 2025 01:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760058855; cv=none; b=nN3lCi0GuiDM3ll1ywxd+iBFC6oslYrHZCXjWMKzXRmZHSLE9c1NaAosK+62byOjoyOWf2cAXUl8vvmE+XsCpmLgMfFlTulEIQK8iVeXG8bOIbfSM1oQWnKq3uz8qHScI5YswGplYeXmo5h+E6n24VRRanCsXsuYvMEbEExV7K8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760058855; c=relaxed/simple;
	bh=fuo/O3ro1nnU4v/tk5w49abhtxOwHb4IDzgTMnuZJsU=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=pOjDWfHw074AGxb0HCPZKFu0qV6zOpP9dyAFR+SeIexEUogLwGA//Q8b1EQ2UVhI+t/i3xCptaYCry7tqZYpNUADMRCVETn1fy51wHCJO4h2ufKyWwgn7iT8UdquC0d2mrH5TLpwArXJ4XgPrDAr1nmzQXvEvb/BApRpC8E6JvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dPexq1zE; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dPexq1zE"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-87bb66dd224so14499956d6.3
        for <git@vger.kernel.org>; Thu, 09 Oct 2025 18:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760058852; x=1760663652; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kr/fXpanbKvKt9ChR4oFkPtwAv0w2yuLwmhHiNIOxWQ=;
        b=dPexq1zEt9pmej8tcFwpVss1X5KBW18ygn2zqbleTgx4l2PhuM5+E50H+i6oKcizgS
         cQzdXuOeyVRFRxXPfQ5XTX/Kfa+RuayiLUECmuRq0XiVEo5ivIUABPDfHsEjo2k+vciS
         BRMnqahxPvuS3ex5EzKyDziXsLZsKuWFkR1DuMEce6Dn6mv/4r3Qe/96dyMojGj/jdXN
         GiPOdotLzdUEPTFv2vkW9vM958ls+skdurB8Sr8FHR3QEsFBwWvoa+Ogj9c0cltJMmmi
         FOwVHaWnO/snnDJhZ6kD2pDHKF035yvp40lC49F4xJ7WbDg1nEWk8kXRPYr5WfG0IuXx
         Gc3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760058852; x=1760663652;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kr/fXpanbKvKt9ChR4oFkPtwAv0w2yuLwmhHiNIOxWQ=;
        b=NwDsDFx1mHYnYDSt/6eZN+SYUjrI+BAjLuDVl4QitJnus3bnDhX/HwpUO4OtdvHpTa
         cv7RWZlP/BmMIpS6Crf2D8HrkBT6pO4N9UzUnUbKD3QnoWsvR3tE/rkRv5twoe2DVuv7
         6GrhpUm8G7VnNEhxNAviNaEjEFsIqUe+nwNd4g02qAoPjWHHdsv4EZzey6Jc2JGP0GpB
         bAk9cmZwEKK4SQrcEmjVzP9yY+G+5aPitSuAyhRYItI+kwLmg7kDohDeWFh/5bkJ2dlp
         5U/BjHQ/A75TwJvAW6tvkdCNNPZlASaUVDy0okr9JZIaKYXU7mmS2ZGN4Htl21nXQamz
         w5Nw==
X-Gm-Message-State: AOJu0YycBgqApvnWGOVXSR/AdoK3zEr6hB3ZYKWowSuZY6+7HoElAI+o
	TFLciBj2A99CF29t8PAje0pryjYjHuQnTlIO9q/DYOfyVYMNSm6A1aCW7lGOVA==
X-Gm-Gg: ASbGncsNEOk/7zRLNzQ2mZj+zBRWxhFKT+aX54rFpl01ebHyF00OJC3pieskhYJNeC3
	Rc2tMBEVFVFntGC5gCeSVnxCTKiVG+eEuo5A99N2eI+tkqRGOw59JZgGvgYjijnHCNVt+F8lWtW
	lt6FkCStfw3N5dbit2jgucprBi2OfupD0O57zKb9xPofP9jHSilgHojwtoPuE68NGN0w9K3qD4e
	vB1dqPz9MVL0Dh5XM1f+GMksL43JmfpKiuIm5HPoUzEZWBQkYdkCsMDGU0KLBwi/q6jFn+jAce9
	52H3dUGgKwy6N461ZKXZBXHJfDSr7mdqxhUxouR9X5fkSWaj9zRBbw4LTFtjdWLuu6pJ9O3t0hE
	Imrw1Y5/vF4WSutgOONQO7yAPesdO2ZVE0VJGHkpJwu2IpyNHgIKVd1cOAQ==
X-Google-Smtp-Source: AGHT+IEJtRiO/uA9AVuBpRiuBbATccIhpjSpn/XTVQXl1WVobmFLV9y4+DIjo+SvPq+rf4vkpUuG3g==
X-Received: by 2002:a05:6214:19ee:b0:87b:c1bd:87d with SMTP id 6a1803df08f44-87bc1bd08fbmr32603256d6.63.1760058852491;
        Thu, 09 Oct 2025 18:14:12 -0700 (PDT)
Received: from [127.0.0.1] ([20.161.60.18])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87bc35951a4sm6212536d6.55.2025.10.09.18.14.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 18:14:12 -0700 (PDT)
Message-Id: <d2167a81d31defddbcdda06726b004e44a192f8d.1760058849.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1938.git.1760058849.gitgitgadget@gmail.com>
References: <pull.1938.git.1760058849.gitgitgadget@gmail.com>
From: "Delilah Ashley Wu via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 10 Oct 2025 01:14:07 +0000
Subject: [PATCH/RFC 2/4] config: test home and xdg files in `list --global`
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
Cc: Delilah Ashley Wu <delilahwu@microsoft.com>,
    Derrick Stolee <stolee@gmail.com>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Patrick Steinhardt <ps@pks.im>,
    Delilah Ashley Wu <delilahwu@linux.microsoft.com>,
    Delilah Ashley Wu <delilahwu@microsoft.com>

From: Delilah Ashley Wu <delilahwu@microsoft.com>

The `git config list --global` output includes `$HOME/.gitconfig` (home
config), but ignores `$XDG_CONFIG_HOME/git/config` (XDG config). It
should include both files.

Modify tests to check the following and expect a failure:
  - `git config list --global` should include contents from both the
     home and XDG config locations (assuming they are readable), not
     just the former.

  - `--show-origin` should print correct paths to both config files,
    assuming they exist.

Also, add tests to ensure subsequent patches do not introduce
regressions to `git config list`. Specifically, check that:
  - The home config should take precedence over the XDG config.

  - Without `--global`, it should not bail on unreadable/non-existent
    global config files.

  - With `--global`, it should bail when both `$HOME/.gitconfig` and
    `$XDG_CONFIG_HOME/git/config` are unreadable. It should not bail if
    at least one of them is readable.

The next patch, config: read global scope via config_sequence, will
implement a fix to include both config files when `--global` is
specified.

Reported-by: Jade Lovelace <lists@jade.fyi>
Helped-by: Derrick Stolee <stolee@gmail.com>
Signed-off-by: Delilah Ashley Wu <delilahwu@microsoft.com>
Reviewed-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t1300-config.sh    | 65 ++++++++++++++++++++++++++++++++++++++++++++
 t/t1306-xdg-files.sh |  5 ++--
 2 files changed, 68 insertions(+), 2 deletions(-)

diff --git a/t/t1300-config.sh b/t/t1300-config.sh
index f856821839..5fa0111bd9 100755
--- a/t/t1300-config.sh
+++ b/t/t1300-config.sh
@@ -2367,6 +2367,71 @@ test_expect_success '--show-scope with --default' '
 	test_cmp expect actual
 '
 
+test_expect_success 'list with nonexistent global config' '
+	rm -rf "$HOME"/.gitconfig "$HOME"/.config/git/config &&
+	git config ${mode_prefix}list --show-scope
+'
+
+test_expect_success 'list --global with nonexistent global config' '
+	rm -rf "$HOME"/.gitconfig "$HOME"/.config/git/config &&
+	test_must_fail git config ${mode_prefix}list --global --show-scope
+'
+
+test_expect_success 'list --global with only home' '
+	rm -rf "$HOME"/.config/git/config &&
+
+	test_when_finished rm -f \"\$HOME\"/.gitconfig &&
+	cat >"$HOME"/.gitconfig <<-EOF &&
+	[home]
+		config = true
+	EOF
+
+	cat >expect <<-EOF &&
+	global	home.config=true
+	EOF
+	git config ${mode_prefix}list --global --show-scope >output &&
+	test_cmp expect output
+'
+
+test_expect_success 'list --global with only xdg' '
+	rm -f "$HOME"/.gitconfig &&
+
+	test_when_finished rm -rf \"\$HOME\"/.config/git &&
+	mkdir -p "$HOME"/.config/git &&
+	cat >"$HOME"/.config/git/config <<-EOF &&
+	[xdg]
+		config = true
+	EOF
+
+	cat >expect <<-EOF &&
+	global	xdg.config=true
+	EOF
+	git config ${mode_prefix}list --global --show-scope >output &&
+	test_cmp expect output
+'
+
+test_expect_success 'list --global with both home and xdg' '
+	test_when_finished rm -f \"\$HOME\"/.gitconfig &&
+	cat >"$HOME"/.gitconfig <<-EOF &&
+	[home]
+		config = true
+	EOF
+
+	test_when_finished rm -rf \"\$HOME\"/.config/git &&
+	mkdir -p "$HOME"/.config/git &&
+	cat >"$HOME"/.config/git/config <<-EOF &&
+	[xdg]
+		config = true
+	EOF
+
+	cat >expect <<-EOF &&
+	global	file:$HOME/.config/git/config	xdg.config=true
+	global	file:$HOME/.gitconfig	home.config=true
+	EOF
+	git config ${mode_prefix}list --global --show-scope --show-origin >output &&
+	! test_cmp expect output
+'
+
 test_expect_success 'override global and system config' '
 	test_when_finished rm -f \"\$HOME\"/.gitconfig &&
 	cat >"$HOME"/.gitconfig <<-EOF &&
diff --git a/t/t1306-xdg-files.sh b/t/t1306-xdg-files.sh
index 40d3c42618..0318755799 100755
--- a/t/t1306-xdg-files.sh
+++ b/t/t1306-xdg-files.sh
@@ -68,9 +68,10 @@ test_expect_success 'read with --list: xdg file exists and ~/.gitconfig exists'
 	>.gitconfig &&
 	echo "[user]" >.gitconfig &&
 	echo "	name = read_gitconfig" >>.gitconfig &&
-	echo user.name=read_gitconfig >expected &&
+	echo user.name=read_config >expected &&
+	echo user.name=read_gitconfig >>expected &&
 	git config --global --list >actual &&
-	test_cmp expected actual
+	! test_cmp expected actual
 '
 
 
-- 
gitgitgadget

