Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10E2B44C7C
	for <git@vger.kernel.org>; Thu, 19 Sep 2024 18:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726770893; cv=none; b=Ky4yy3dvBVFBlYHD68Vmn9/cSlE9WVI9C2g58BfiSu9Zm4L4z2TGQfWK1eb5ISEwSPB8l4B4CbNksm7a894uEP4cvfX4zdBUvlI1fBCVcVNYFOT5wLViqlrp3xL21feSEbd4RhQiAGR9Z8JHLyQq6UC2tAaM0HTBeFjHLWzl6TQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726770893; c=relaxed/simple;
	bh=ABa9NtKpmtCuinVgdqxAB6PPoEwtTBm08YFY1Jt0wdA=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=GGeiklvYVTrd+dObzo6dVbzcKKcEvSgQAq+KWyr4yVdyiPSApGhVoRYexfacAE5pBx9vpNWq6EYs/Y2GsrUy7C1JDmt38u9Qv9HSyiqPM3Y25VkFNDcMjmx8mr+aVkHh+YsVTKKpqJeAbxGZXGjYPJbPfLQOjkdEtECS7B6Y+aU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gfXr5ZlT; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gfXr5ZlT"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a83562f9be9so141757266b.0
        for <git@vger.kernel.org>; Thu, 19 Sep 2024 11:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726770890; x=1727375690; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vhV1DXGvjHDdSAyUhu9WZtTuJ0AI/+HjuKKkSceFTvs=;
        b=gfXr5ZlTFpxgnukmzblQvZxG6AnY+0jlm3bGvOAHznfPkEkqqAPCIBFPwqkhWhiMdc
         RkR4VPHgHN7nqyM70AQUZVGdkMlEqI36vIr0PbXRikrn03FlebHfU4KViV8maBFI7haj
         OpH4cHq+FFL+nwqQ44Kpj4RQanb04bMj5v2lVsekTcNI1dnMidl/Yal7QAFjNC8rbEza
         svXKKmSSetN3qcWt8sDAxbMSVaf2ynPku5/jAutVSb2WebMWxkkYa2szdpxf6aZsw2ul
         /l3mGrIhYoS/1omrrO+cxdGd8Sxjno+yZbosiWtOJKT2+yh9LnwQvqAG2T0OGmLpc34K
         zRRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726770890; x=1727375690;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vhV1DXGvjHDdSAyUhu9WZtTuJ0AI/+HjuKKkSceFTvs=;
        b=mAPYgdN/HvvJL6ffgfZ1QueW4LZsRAbH8i+66SVXTx+uGzaZvAFNh9wIngCYAMwdxq
         RNb8Y0mpMH9wZzCdUVjRN3DGI9yrsGpwaREwPg9mTtxE6znsN/HJ4tFU40aAD2KOuQED
         l8cADKU59wZwFOq4wRkNYzjC9sUZuat5PlqM0xVO7oiFJAQ1OFJY/saywLb7JP3D/Jz7
         Ij0qCBgGmJm6LROpEKCn96WqXQyx/G2SN3fUQhOFWMAgBgfT14WujfWe6/6QhReqzzu0
         zu42lQuhsYbzkQzzq1xZHPORR0dB5Xf/HiEYKAUFHJqye/rd/oDWsMzJdiG5HPNfKlN6
         4ZNA==
X-Gm-Message-State: AOJu0Yym3vTcvcnNYTiEIdKbaRf3wOsphZyZRAUJlZ+oIAK9FlJurUZP
	vCm+2LdOKxAFRWr6wCgWRekLtKhwQV94ZVZpgrU5oIxAmxIpe1CNxCOv+g==
X-Google-Smtp-Source: AGHT+IF9cC6WrrzK/hIU86Ez0FQrCzeMDnXI5na/MlhYoSO7+sX6Qjd36GEowOby7k9cIUSNmdehGA==
X-Received: by 2002:a17:907:3fa6:b0:a8d:55ce:fb7f with SMTP id a640c23a62f3a-a90d5163099mr9841066b.62.1726770889780;
        Thu, 19 Sep 2024 11:34:49 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a90612b3a04sm750513366b.125.2024.09.19.11.34.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Sep 2024 11:34:49 -0700 (PDT)
Message-Id: <b7f6e81c3ddf9a6e8b9a8ba745ff7c3017825304.1726770881.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1794.git.1726770880.gitgitgadget@gmail.com>
References: <pull.1794.git.1726770880.gitgitgadget@gmail.com>
From: "Andrew Kreimer via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 19 Sep 2024 18:34:27 +0000
Subject: [PATCH 07/20] http: fix a typo
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
Cc: Andrew Kreimer <algonell@gmail.com>,
    Andrew Kreimer <algonell@gmail.com>

From: Andrew Kreimer <algonell@gmail.com>

Fix a typo in comments.

Signed-off-by: Andrew Kreimer <algonell@gmail.com>
---
 http.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/http.c b/http.c
index 6c6cc5c822a..376af88c5dc 100644
--- a/http.c
+++ b/http.c
@@ -1707,7 +1707,7 @@ void run_active_slot(struct active_request_slot *slot)
 	 * The value of slot->finished we set before the loop was used
 	 * to set our "finished" variable when our request completed.
 	 *
-	 * 1. The slot may not have been reused for another requst
+	 * 1. The slot may not have been reused for another request
 	 *    yet, in which case it still has &finished.
 	 *
 	 * 2. The slot may already be in-use to serve another request,
-- 
gitgitgadget

