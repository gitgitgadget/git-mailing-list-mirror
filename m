Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B16629CF8
	for <git@vger.kernel.org>; Sun, 21 Jan 2024 04:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705810078; cv=none; b=Lhbw5mbB7edIuSvQVBMRz/fV5aYDReDtyCjeRdAIy1FideFIrn+cEiktQnvuLv+BrwS4Sem6be1/A+HN0ecswbIWBgi420TUi94FZkG3QZzVRBcg0HZTNyz11UJvEHpuFek6veQcnykdBnZTKSV7bvDpOhoMhtIoaXmnr83TmGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705810078; c=relaxed/simple;
	bh=c/bB7tjcDxnKR1tuy2MlLhfV8gj/nnfEXfjdMpzHotM=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=XaOHTge7r+fUHn+ZphwgrTExRdStpf026k6TehvBVFxfpKwB33ch4eK0LAsWwsgiFlKVfViFaAci43o4VEyOuzskTExsRdDwCcObdj3T0lxb2aJXUGSyti+rxoDw89AKfKu/uqNuNjDV8Nocj2NBlLNyuiCHcv9F8dIcmNABkA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FxRhMRoX; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FxRhMRoX"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-33921b95dddso864382f8f.1
        for <git@vger.kernel.org>; Sat, 20 Jan 2024 20:07:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705810075; x=1706414875; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DDkWYUJH7PcUZl9DwgNazbDSyev6mSN8X6ZTjE1gPJs=;
        b=FxRhMRoXl/FCLD+2DxVw1PWgjGfm2Ys7muXuLLN2jbHR4JQYSeZlXo7BUFrttbpMi2
         R8j7ZMa52MaJN+jGiWhKG6hY1HcWDNqPy/g0SgIMDmKnfKiN2GrVyJjCvoECdHmgsVhE
         1xNV5pzLKCc7aosUVHmugncAm3FkCi2WjqfuKgSD3gaoXSvpU+WNGBrSvWtxbkGFUIUi
         49MRuMBXwcfcIvPH0DrtRGY9Rqd50g/QbaC/Uhs9/yvnqxJpMCxehpP1KVajuzABuEo0
         y+DCB9S2KrsNTgqVc6HrkgR4YEAdw93+k5ZbNnhLaL0PEoi4uLsDrzXo5NG4bmxTRrDu
         A2rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705810075; x=1706414875;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DDkWYUJH7PcUZl9DwgNazbDSyev6mSN8X6ZTjE1gPJs=;
        b=jfHEAoQF2DAWGAc0/XkM8G/SBPsJxxH+Kyr28+Cgy7DF6eXzcnYFmKMbB8lD2t1OZm
         Unq/sfIPYhC8nByvIiLl9B/ODka9JqDQUrAVlmuTul2/rFthloJYeEMfejTHyvLk/HxJ
         ABRs+6OBS4+pBaR8/3IBObM+QaIBq4FYrGUIpky4oGyi1WCzOy/iVsGlnIpJ4/EU9KRy
         jBrWvwIVqJc2wKjOl39GGYld9cGxANXG3uJ6FlEmOkz5KY2v4gXdeFbvoXp1zoC6xvwh
         zmSEeVdLK1rzJ/Zyp+a96WO5Exe6T0T3HpYrxfu0ft6wHYfTpjsG0fWLymIHHTKW7NIA
         Jyxg==
X-Gm-Message-State: AOJu0YwbuAIpnWQPD9S0oph0PIjW2SD70cyQA85JsRe0FmrSjLgJ+NDY
	vQI2mx9VHmT1AGNUtSolXn7Mw+Mak7icTvhBpbgvXCuY/1oNwUFBLTTDdy/s
X-Google-Smtp-Source: AGHT+IEmw3xmdcKX2kyJEn4nCu/PUScIxDr2fOeiHFrMNO3QReUfERkrOUHsr56LeKVz7lZOPl3d2g==
X-Received: by 2002:adf:ce81:0:b0:338:c276:d78c with SMTP id r1-20020adfce81000000b00338c276d78cmr1716516wrn.1.1705810074551;
        Sat, 20 Jan 2024 20:07:54 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id cg13-20020a5d5ccd000000b0033927ccc725sm3104643wrb.50.2024.01.20.20.07.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Jan 2024 20:07:53 -0800 (PST)
Message-ID: <1debe2fe18eec7f431f355241117afb0a5e2bf5f.1705810072.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1650.git.git.1705810071.gitgitgadget@gmail.com>
References: <pull.1650.git.git.1705810071.gitgitgadget@gmail.com>
From: "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 21 Jan 2024 04:07:49 +0000
Subject: [PATCH 2/4] completion: complete --patch-with-raw
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

Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
 contrib/completion/git-completion.bash | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 6108d523a11..ccb17f4ad7b 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1807,7 +1807,7 @@ __git_diff_common_options="--stat --numstat --shortstat --summary
 			--output= --output-indicator-context=
 			--output-indicator-new= --output-indicator-old=
 			--ws-error-highlight=
-			--pickaxe-all --pickaxe-regex
+			--pickaxe-all --pickaxe-regex --patch-with-raw
 "
 
 # Options for diff/difftool
-- 
gitgitgadget

