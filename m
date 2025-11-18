Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E98835E545
	for <git@vger.kernel.org>; Tue, 18 Nov 2025 15:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763480551; cv=none; b=f4G14ZB8wfAJQw0xhngvwkXQdRSf3tYM8k/+zeMgW50MEdi2HajdQ21EwWtW98KSHefGthVCDGtu9YFF0go0DEi3nFRBrWtG7Kqv1BvIvZBUi+BSDoQmxQNhTZSnw0CquRoaDtYqtFCO7TEXrlpeCmwPOhF2hIoJel5uS6Tt8wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763480551; c=relaxed/simple;
	bh=T+Y2fxJVhm4uLVbaq+06vsXKL7Kuju9rza6k9nKa9v8=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=JvOzIaqK++Yix/v7M+5wl1uqY55jKbMZ799Zq+E15Z4DTu6gIzS1MVtG8S0AJS/kv4UeUJ98gL6pSocHRj/Z2kCQw3Ok3oTc/4W81HL1+6WkYIWiMNDf07f0IfcLS5I+uZURmSMEgXu16MELEOIIUVqq4+NxGKO8mRhUni0mUwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZpnKm4Cl; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZpnKm4Cl"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-8823e39c581so78679226d6.3
        for <git@vger.kernel.org>; Tue, 18 Nov 2025 07:42:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763480548; x=1764085348; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=INEmxaCTOtID26w6OVyR/OTZPpusglqHlbXbmvFPrDg=;
        b=ZpnKm4ClM7ZpwZ3E+4/pIni5/UKooZo3xRa6a/B4jRAltbTgidVmMjbEKpfe398smP
         Rqmcq+EX4XDHrvxcInWyGuW4ujHrrD6Rlt8iAxxbGpMuO409G7LEHzNCRqd5l4vPsKOb
         PvNe274Z6JvU7Vg/ktvvV4QFXqc+efGY+gVNW22h3qrGoZooenx/0xUB1dqpA8/JxSC0
         F5Ar0/0ACXhZeTwEGRCV9DPs4LizS+yt1L8JSfMKou5EBslXamIsJtTiTtBM2b6S58sj
         G3bQwakPzl+OM8lkOjzhVJJxSkxoO06xlXYuEtBEDXIt0vdWW5R/nyIi/Cw7zy5tfy3y
         gcCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763480548; x=1764085348;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=INEmxaCTOtID26w6OVyR/OTZPpusglqHlbXbmvFPrDg=;
        b=idCK/PND3CHT3QqxRUuad9lWogbJ63B7ChYskB4hGvRumxvsbkhEKr7C7rZu7l7kpS
         eZxD6ea0jK4wGBBnYDfnxLYoYia4UW3ywGEDtvRhN6bMFozyTiLtyfKRVQfNk37LquHp
         kApT3SpsSCw21L3hFQGad26ctGG4WCCV6zQCd2Ae7L/tw8aYqrR2FVX3cFQAxWZLAegy
         Sfv3NBHy26eDciM1ouJrWFIe5fUClH2Vuzn8FxoQvZWCYqKJ0NvDAI3IzKlDcOFhDt2f
         upqnC2BzLanPCoqeqQ2XPo52I7kCsMWHVHF8IbYrYh15o7I7wrIMB6HVj266jKggkjfN
         EN4w==
X-Gm-Message-State: AOJu0Yx7AKBaa2vcv/CFLdzByl9Qp2/w11iXcdhNgxkU6rP9YS8fgWhJ
	Gceb4m8z6hjpAc6a6YzlpPYGG+uJ8+9aPT96MrfXgEB+Y+EmvaVdNx4etIikUFy9
X-Gm-Gg: ASbGncs/fppD5K7YPE/By1A6Z32ic/ZpdMTl3UuO/yqVRrUnOM3i8YeaoDT6n8e4TAy
	BrsKxSw34XrwgunsI6XFc1aHqXoqM77eD3ACOovR1qD5JdP6ZCVMhIf9ZyZTNGdNtgmpv2bmmlM
	ZDNOG3cA2Bx3LqNeDNprZVzbpAALLA5OC48Ku4lI9mYXtQU05X9l6ijf8B7gHhIf6r1sDdmb88S
	2i2Wg0PTKTak4uJIWwqJKqAFKo5aehMDQ753fYIvpY4gLnsliCqZJnspnzzfdAxN220PqDC4XkM
	mE2DZuf7AasywNuOuYgUiLuSwMlsKrpwqMrhD36wl2Rv2DcAc0k9KB9Swq6l6rq6AAtg4BPfDt4
	H3z127VbTCq5A+MuhONv9YuYotNuqXxOGOuIT8LQVUd04a/05a4ugp9br1diB++GvDchv2Ztegi
	IVXGyIFJKtdHnr
X-Google-Smtp-Source: AGHT+IFGjNAXaf4pU9EfrcS2UPX5d5yM0oS621Pg1iUq8o3BEviu8fJcqoJ1XQy+sQ3g2eevSToFoQ==
X-Received: by 2002:a05:6214:1244:b0:880:56b2:1fc2 with SMTP id 6a1803df08f44-8829271f260mr282460726d6.52.1763480548005;
        Tue, 18 Nov 2025 07:42:28 -0800 (PST)
Received: from [127.0.0.1] ([20.55.223.180])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88286558347sm115470436d6.40.2025.11.18.07.42.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 07:42:27 -0800 (PST)
Message-Id: <pull.2103.v2.git.git.1763480546981.gitgitgadget@gmail.com>
In-Reply-To: <pull.2103.git.git.1763427599300.gitgitgadget@gmail.com>
References: <pull.2103.git.git.1763427599300.gitgitgadget@gmail.com>
From: "AZero13 via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 18 Nov 2025 15:42:26 +0000
Subject: [PATCH v2] win32: pthread_cond_wait should return a value
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
Cc: AZero13 <gfunni234@gmail.com>,
    Greg Funni <gfunni234@gmail.com>

From: Greg Funni <gfunni234@gmail.com>

This value is not checked, but it must return to match POSIX

Signed-off-by: Greg Funni <gfunni234@gmail.com>
---
    win32: pthread_cond_wait should return a value
    
    This value is not checked, but it must return to match POSIX

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2103%2FAZero13%2Fpthread-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2103/AZero13/pthread-v2
Pull-Request: https://github.com/git/git/pull/2103

Range-diff vs v1:

 1:  643a9b7eae ! 1:  a2d9ec97f1 win32: pthread_cond_wait should return a value
     @@
       ## Metadata ##
     -Author: AZero13 <gfunni234@gmail.com>
     +Author: Greg Funni <gfunni234@gmail.com>
      
       ## Commit message ##
          win32: pthread_cond_wait should return a value


 compat/win32/pthread.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/compat/win32/pthread.h b/compat/win32/pthread.h
index e2b5c4f64c..000604cdf6 100644
--- a/compat/win32/pthread.h
+++ b/compat/win32/pthread.h
@@ -34,7 +34,7 @@ typedef int pthread_mutexattr_t;
 
 #define pthread_cond_t CONDITION_VARIABLE
 
-#define pthread_cond_init(a,b) InitializeConditionVariable((a))
+#define pthread_cond_init(a,b) return_0((InitializeConditionVariable((a)), 0))
 #define pthread_cond_destroy(a) do {} while (0)
 #define pthread_cond_wait(a,b) return_0(SleepConditionVariableCS((a), (b), INFINITE))
 #define pthread_cond_signal WakeConditionVariable

base-commit: 9a2fb147f2c61d0cab52c883e7e26f5b7948e3ed
-- 
gitgitgadget
