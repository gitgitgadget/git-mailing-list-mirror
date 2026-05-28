Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D6E3306B37
	for <git@vger.kernel.org>; Thu, 28 May 2026 02:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779937026; cv=none; b=sxafVwaAhzTxM1czibzAp0MJCdqJrwhz08G6oWkHkQFT8+BR/cDBrU0zRbkZmUVFxhhDVdQtIwbjbNL9CFDF+OVkIwuINdmeWPl8erOhag9lRG7y3RLxPPrLIeF7kOs9ifUReGETcDW75VER4XIH3HOCoBWfhmJWnEeFbHMuQ2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779937026; c=relaxed/simple;
	bh=PZdmn2UcRkgPDrEYR+osPrmeMA137gYmKZZVTR0k858=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Rf0RGCpVkHc9Fn494olwGbPRUobnoKggS0sTzvsE3JOzp1HpkwGthpcOUNn9mGJJPqpSt1bNHc7ayfTk7sCY2In2WRoG0dw3Jv1T6aFzkAfj6ZfxK7QZll6hKf5kr19Vfd4czwfBy7GJY93XriwheD9R0PZEqPWCVkI4spQpM6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N98f4b46; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N98f4b46"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-913cc4d7c71so1349547185a.2
        for <git@vger.kernel.org>; Wed, 27 May 2026 19:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779937022; x=1780541822; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lc0oeybmfOqK+rwhDo/k1Hjo6mvMEU+S0BNNf1Re8Tw=;
        b=N98f4b46l1ilZcqH/OChL3Il3P0W+Ehv9Bi617DqUx3iba3Bo8DHAuG8oHgBuz3Of9
         KXOehE0Kk+usegTx/31Sqws5RSK7q3+uogEwoXlR5wKKE2MOFM5fk5wHhSt1cDYRvQUr
         AV0LZcrLbVULaspDi+rGQYQJWa5Q3cs+fwrRvOKmzSHvn3Ye5T4mF0Y3x8pMmDJSrCaL
         2uUjbm7Re8/8B8tXJaPBjMeUIt01zlS6sel2xpAQfb9oJAWoQY/OMYcr+VmM46v3rjfp
         JouavHG7IP0ysPQ53Uh6zWc2xLTBbUHIuyApgIE3IsOILafwiRBbaFjWbWNdFU7bhIW3
         TXzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779937022; x=1780541822;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lc0oeybmfOqK+rwhDo/k1Hjo6mvMEU+S0BNNf1Re8Tw=;
        b=XGF7Z3Z56wG6i20eBDCXht3/ym+HKN05102aG3M/u+VGJew6j4DUBSFeY54u5qIB4t
         OskiXhGjNNDYM+1vEzBW6aj/txttUav5Sicj0tCC9DTJrqPETf/KwjXKSSgKwMFhVzzn
         DYqxBnv2pV9ElWkgRe7M3fpjyZgB+z0C0QIyI1OxTar15BT/FxfKq3qVQuu99kyybLT+
         SgPNOPcE1egux/d3a7PW7N/JnFZdGWDFkunKRnpSHIjlssvTrcP8g/4mAYztNHEZ1CuC
         vV6l45gpgYSJ3g+Utysf5MuHg/h0IlBJNby3FSjUWT8FDX920pYyt4Tasj4Wd0k43+0R
         XZ6g==
X-Gm-Message-State: AOJu0YxPHAOM1ZbNexNB5191pXmzhWx6snG7MtQ3Ui4mYypDZMQje62i
	rpUmTxlcLsVHYnFF/DCQwRLr73BtBBiNhaM20ISh/JsAhCxGGfsuDmbSM74YBw==
X-Gm-Gg: Acq92OFhnK+3Qrw5NsK0OtdVO3EVUQCnEtrTGYuW5zNiQR+RL4HXf1Wci464XBmQvrB
	oRiW6mZm+GlkcHdgXOORCMMReVsm6oVckE6wb24ZMvMnkkoOPicbSZ6fYBdPXz+eZ5DDAF9ACO8
	HFYMKobu35MJawx+0xqjU41vFncvofoY5Ndf5egfOk/v7MTT3DmKRzzzdE0MBaa1HUiIrxdwUe6
	jJKQJLzkB2SchvkjM8xzDGpeXfp8R/mQEoqxJtosSxlZ/O6CxrKvvit7aJtM9e+RbHtThAafzMp
	1CrrUQzuDI4y+5Tl7SLtGh1yTjq9g6rDtIDIyvGrrR00wnGQDGUdxHrOlCLLyIj2hFj8tdY4bH7
	tU5PjxDiw2S8S50SOsuKudJWXobH/sBZWqFzkEwcC2Nsu14ByhELqYZj5AqIwBTO9x8FDarly7V
	vDgaWFiQvDfVdJQgDxZkYUinycZklpg2EEVK9y
X-Received: by 2002:a05:620a:3724:b0:908:c3fe:843b with SMTP id af79cd13be357-914b4a22cd8mr3862470585a.59.1779937021819;
        Wed, 27 May 2026 19:57:01 -0700 (PDT)
Received: from [127.0.0.1] ([74.235.126.66])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-914f8820fb0sm664668685a.46.2026.05.27.19.57.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 19:57:01 -0700 (PDT)
Message-Id: <4e742940711c71da755528ee0f4669125218aa66.1779937016.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2300.v3.git.git.1779937016.gitgitgadget@gmail.com>
References: <pull.2300.v2.git.git.1779905911.gitgitgadget@gmail.com>
	<pull.2300.v3.git.git.1779937016.gitgitgadget@gmail.com>
From: "Sebastien Tardif via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 28 May 2026 02:56:56 +0000
Subject: [PATCH v3 3/3] daemon: guard NULL REMOTE_PORT in execute() logging
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
    Sebastien Tardif <sebtardif@ncf.ca>,
    Sebastien Tardif <sebtardif@ncf.ca>

From: Sebastien Tardif <sebtardif@ncf.ca>

REMOTE_ADDR and REMOTE_PORT are both set by the same code path in
handle(), so when the existing REMOTE_ADDR check passes, REMOTE_PORT
is guaranteed to be non-NULL.  Guard REMOTE_PORT as well so that a
future change that breaks this invariant does not pass NULL to
printf's %s, which is undefined behavior.

Signed-off-by: Sebastien Tardif <sebtardif@ncf.ca>
---
 daemon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/daemon.c b/daemon.c
index 103c08d868..78cca8673f 100644
--- a/daemon.c
+++ b/daemon.c
@@ -753,7 +753,7 @@ static int execute(void)
 	struct strvec env = STRVEC_INIT;
 
 	if (addr)
-		loginfo("Connection from %s:%s", addr, port);
+		loginfo("Connection from %s:%s", addr, port ? port : "?");
 
 	set_keep_alive(0);
 	alarm(init_timeout ? init_timeout : timeout);
-- 
gitgitgadget
