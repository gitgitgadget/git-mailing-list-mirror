Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D9561DFD9A
	for <git@vger.kernel.org>; Fri, 22 Nov 2024 19:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732305029; cv=none; b=MJXJIpAps3f5TWh4hQ1cpDuPvT+HGUWAUnj1+vQrurXHtkVpD7OmogX7KcICGeeZeifoRuptgJxrj0r2K54CH6pDGu41FFYpj0LfnnoP2FVGhkLx0aO+dA/D2JiAdMvAtgzRHNqAQ/5TG1PyRxl0kHWNx/xxYPSpt0Ag6qESk1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732305029; c=relaxed/simple;
	bh=ZxB0Pds/72H1qGrM0vIfgtVzxwiCkOcCHGBxt0XTWHs=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=iPcg9NzTxwxRhvmM0S3jZuM1R3yGF6sdrWjaM11Dr7tKsYMuFAQDrH4qjmenml0L+Z8f/NEavyxN7k0mMn1RJ4/a8OYcYEsF1P0jcJNoWUWAgKxPOqUWxdvjn7vX6B9eW2vS42UHaHFALit9fA1m2CzMJPEGy3ATX0GFYXhYpck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IJEkpdCf; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IJEkpdCf"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4315df7b43fso22430575e9.0
        for <git@vger.kernel.org>; Fri, 22 Nov 2024 11:50:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732305025; x=1732909825; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FMZd6pL9I6cFzWwxp9cEAWDcZJiylGuDq1ibIm0UmaU=;
        b=IJEkpdCfF2SD9w/pZHNvyC5vL161sHqI8LHfgGVZuJoRMDLsCtT6qALIfDRb9M7nLA
         8wujeqGxjuvRhlmkzTHY4Me+88QrZodr1KYI2vKMjas+BJVzF81BY3SvIAD8ADRZ2sro
         dM4pS8cyJfNaWpO9yC1uRef+NyW00WHxSaA5R/ue1xTWvoGotcgrFLdVd9lbYyqTlODJ
         oKqw0tLwWblJtv3JOVy7tKuEOFS/jOmfnNuNYxcyjJpRLFFKWN9WqALpOQHeYKjPK0kF
         Dd/+uPmZlra7UAd2lPuuTx0kHQaYO6GC03XUtJiskWDf3WNatoLS044KlYPrDST2re7I
         79pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732305025; x=1732909825;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FMZd6pL9I6cFzWwxp9cEAWDcZJiylGuDq1ibIm0UmaU=;
        b=RtORD4PLrMRlXkMjfHla3D67pgaxDzdQjs7ztw46ZMVAsWzCZ5yrbdMQwOag6hWddA
         vM/7GrkYtE3Tul1bHoW3matBE+/A0KjtEp0O2maQJfwbtrpr85XDIZN10qKnJ/jrmy2r
         CgGOFpak4hi0vwBpifRYrS/tfrZGmPFmNmJf09uOGnvj9veYjqEcMWeu3TJnsmYrVqho
         CBozpvaF8liY03sSSarAoTZ3QFSk8KU82KB0W7kWizKXGer23hbzrUd1ZbCRT6qlcIWK
         tOIWLgnKaKdguuFlUaI9Jd8eYVZjiM7eOjMSBGJDty5GbiqrzWj3yOY/opnK7ZfGHWoC
         ebCQ==
X-Gm-Message-State: AOJu0Yw7ENCiuPgxmaUOt+DJjzcVDOvOSegrVXCIsowv1D7DOdzuMuM0
	ezFffX4qCO6yf9M8SsIbzpBs7J6ovYTz+UDl6uiUkxZc2wQaAvm9Ywe1lw==
X-Gm-Gg: ASbGnctYt6UBCkV+gHUOZ8mp9+5Okht3Ew6bv8ds8ISCyaXavMj5NHaNLMH9SSoRGN1
	PLL1un0mksGUanmsN/3jEXHzK70Y0zbx9gYu35l9P8OWE9nR+DGdcRO/YDb8UbplUPI74z/IBiy
	kPUjb9UwQ/XJ2b7TwCAzwFq7Rkht1SH6JGM6n9Zu+9Z7Gofidhi+TZWRzMqX9H12LxNwQGm1M5j
	ipoh1fleQ5JadXQgqGD55TLbB0MWbE0yMR+VYvFRD2+bczi2m8=
X-Google-Smtp-Source: AGHT+IFOM/+bJ12vK8FSPFfmDTipEn8TqsAtvAy1qcvbnoNfGo1apvXhLKUgwurGoB/eZYmj2Qk77Q==
X-Received: by 2002:a05:600c:510b:b0:431:1d97:2b0a with SMTP id 5b1f17b1804b1-433ce42875cmr41389175e9.15.1732305025258;
        Fri, 22 Nov 2024 11:50:25 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-433cde98b5bsm37542945e9.44.2024.11.22.11.50.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 11:50:24 -0800 (PST)
Message-Id: <24933ba71305caa97fe1f756aef770d40f39fbda.1732305022.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1827.v2.git.1732305022.gitgitgadget@gmail.com>
References: <pull.1827.git.1731459128.gitgitgadget@gmail.com>
	<pull.1827.v2.git.1732305022.gitgitgadget@gmail.com>
From: "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 22 Nov 2024 19:50:18 +0000
Subject: [PATCH v2 1/5] completion: complete '--tool-help' in 'git mergetool'
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
Cc: Seth House <seth@eseth.com>,
    David Aguilar <davvid@gmail.com>,
    Johannes Sixt <j6t@kdbg.org>,
    Philippe Blain <levraiphilippeblain@gmail.com>,
    Philippe Blain <levraiphilippeblain@gmail.com>

From: Philippe Blain <levraiphilippeblain@gmail.com>

Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
 contrib/completion/git-completion.bash | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 3d4dff3185c..b3b6aa3bae2 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2331,7 +2331,7 @@ _git_mergetool ()
 		return
 		;;
 	--*)
-		__gitcomp "--tool= --prompt --no-prompt --gui --no-gui"
+		__gitcomp "--tool= --tool-help --prompt --no-prompt --gui --no-gui"
 		return
 		;;
 	esac
-- 
gitgitgadget

