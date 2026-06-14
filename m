Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF9CA3043C8
	for <git@vger.kernel.org>; Sun, 14 Jun 2026 18:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781463570; cv=none; b=AQzEdbQ2DCi0eJn8PA8lThr/8SkRPkvRazPi0jhMq/I+2l07VYYjKRP8raHimzOciOrX4LSugwmMYB3JeoRf89uh6DJ5+rwm/DY8lVjxkJfG7oGd1oZ/v8eOqXr3OnSJ7GFMwIZ27jeTZkwmMoMMJfIJnW6QN7rrvvKg4wxLCTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781463570; c=relaxed/simple;
	bh=b63FwAXWj671Jz5W7et9R08DCR2Q6v32Cdt4VG5jdc4=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=liHU5OgNUQ0JvqC938ynIYwHQgFtrOCTqdIrHPcWIYSeS7SHbiMsweD6fUG1yjV7sjLa6hvswzMmeEJ+mUCSYjHDgBwD/yODMK20fgzDznT4Y2tFd3EzcaBMaTq95CADuv2e/LPSc2Xvs42CP/1edJfAoP2s+ApfhUWqc4eMvds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oFSC8HF/; arc=none smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oFSC8HF/"
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-30749947917so829174eec.1
        for <git@vger.kernel.org>; Sun, 14 Jun 2026 11:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781463568; x=1782068368; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QGhPD4wlK16cfPJHf0ZO8q+VJwE3VbJ4mUgT7ZSXaqY=;
        b=oFSC8HF/a0Y4keBEhWSwBYCGyK67iK0oVbeilukTLgEPzy3znmHELNHENSd/6FxD+s
         lM5ghRKKmc15+Ue5mH+Ft6EaDpuOaF3XYxaSxhhYQyvV40NHsIVLEPggyrplm1z50yrk
         9blAgdVsyR4itfW9sq6IHgkwEvLov81fjeS/xQGBPi+TGnVVg+Pc4+1gqfYAO/ATffdZ
         9G4l5sz+xwIlyyelnnvQEq+uBXjvZ+QW7Jc6F+4XPvx6JRQsb+6ZGdZ7o/DCBjZfSr2K
         8Rf7AeRTtENSfy/Z1rSnBX6VTxGEt5asbbtsvYXgTJOffhD9RI6pMIFo7aPaSFJYKTk/
         +ttg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781463568; x=1782068368;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QGhPD4wlK16cfPJHf0ZO8q+VJwE3VbJ4mUgT7ZSXaqY=;
        b=X0oPdosMU48BiDnX1oA9rHzYiay5zDmqVoVRHKVIQjmUhtcQYXGuuL2EjrfgpiqYLW
         GvkEtA1EARsAGns0Pp7oHXt/ZgHsX7mesHTNoDaf5ROUwx9PhulBwVopGGGp3RQRR+WQ
         zApoH+IBJ5edRQBc09eFaFxbGNxBbm2BQYLjKJSKFOIA449YSAClzSllJ7haqdQ1E6Qp
         ZtG5Co1I54yx+bHjg1fjKfj2tAgyHnT+hmqG72mQs3GZfMifJqPbTkK4vtOehi7cgNcO
         rpSW/++DNHJyMtD94E4kYSwcB3XHXra95EU4Y6/3fYvDlOvLlWUqjgGqH4tyZwyBe0u+
         5C4A==
X-Gm-Message-State: AOJu0YwRh8aVXSUlPY9RnG7N7PV9xXLl43H93tQmm9H42/Qzt5CvhJSW
	HoxqISAc/dm2YkwLM/P7JG60nIrjO93kESrbWVjzAoJcheH6MiNOQiTSqpi7ZA==
X-Gm-Gg: Acq92OEYdI6le0XrrIjYJgrfDvav5AVpcM8E3ShaEkRuvsfpxDWcPCe0MBz0r27b7HP
	XAwGoYDPgQNjeYfNP38D0I780Z39dsXvpDaQ8ZDH3JejPlnTmDNWoLueGH1GA+YWhk9g2RgPYYS
	eZq1kUsBrgj32UQdhPfdof5jRXyeHV/WpPTANU++pPNOAYguEg3KGSAO/4W8yIXL5v49xcUWpeM
	M6UC3I86yjfFNHUnKOM9yjowJsTJ7XORyhjg00dkknmkhMNJgdAmH7Y5r0HXlZpcngcnXit+Zb+
	ML6A4khvcE21PdAS7niB1DOARz/FPzcoPCzr6WvszIDoklFHWIkvt9OQElyhdEuFcQ1cDfkQ4Oj
	ycC6z53U2KSfdtcSjoTpOcQPVmTQCa4vWL6hGR4DBK61TSiODY3H+h3o7fCJb9aG0XPy1Gxfw7I
	QVC+W5cElV9QheKPobi5jW9zOW
X-Received: by 2002:a05:7300:caa:b0:307:140f:d511 with SMTP id 5a478bee46e88-30941e49533mr3808527eec.33.1781463568192;
        Sun, 14 Jun 2026 11:59:28 -0700 (PDT)
Received: from [127.0.0.1] ([20.169.53.52])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3081eb95450sm14412338eec.28.2026.06.14.11.59.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jun 2026 11:59:27 -0700 (PDT)
Message-Id: <30617ee17b4a53c08e21757620c9f75e1e78eb05.1781463564.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2120.v4.git.1781463564.gitgitgadget@gmail.com>
References: <pull.2120.v3.git.1780087700.gitgitgadget@gmail.com>
	<pull.2120.v4.git.1781463564.gitgitgadget@gmail.com>
From: "Michael Montalbo via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 14 Jun 2026 18:59:19 +0000
Subject: [PATCH v4 2/6] userdiff: add diff.<driver>.process config
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
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
    Michael Montalbo <mmontalbo@gmail.com>,
    Michael Montalbo <mmontalbo@gmail.com>

From: Michael Montalbo <mmontalbo@gmail.com>

Add the process field to struct userdiff_driver and teach the
config parser to populate it from diff.<driver>.process.

Signed-off-by: Michael Montalbo <mmontalbo@gmail.com>
---
 userdiff.c | 7 +++++++
 userdiff.h | 2 ++
 2 files changed, 9 insertions(+)

diff --git a/userdiff.c b/userdiff.c
index b5412e6bc3..7547874aa2 100644
--- a/userdiff.c
+++ b/userdiff.c
@@ -509,6 +509,13 @@ int userdiff_config(const char *k, const char *v)
 		drv->algorithm = drv->algorithm_owned;
 		return ret;
 	}
+	if (!strcmp(type, "process")) {
+		int ret;
+		FREE_AND_NULL(drv->process_owned);
+		ret = git_config_string(&drv->process_owned, k, v);
+		drv->process = drv->process_owned;
+		return ret;
+	}
 
 	return 0;
 }
diff --git a/userdiff.h b/userdiff.h
index 827361b0bc..51c26e0d41 100644
--- a/userdiff.h
+++ b/userdiff.h
@@ -31,6 +31,8 @@ struct userdiff_driver {
 	char *textconv_owned;
 	struct notes_cache *textconv_cache;
 	int textconv_want_cache;
+	const char *process;
+	char *process_owned;
 };
 enum userdiff_driver_type {
 	USERDIFF_DRIVER_TYPE_BUILTIN = 1<<0,
-- 
gitgitgadget

