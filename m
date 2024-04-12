Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E59414C58A
	for <git@vger.kernel.org>; Fri, 12 Apr 2024 17:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712941545; cv=none; b=DHYdB9ain7j6iu8HkiROJG2Gy0FUl/NQ1ffp5lkZFXaga4gNIYEmmlWbp6AW/PsGSG8qlZ431WgP1G0rzZpv2u2Rk/wwX9hCi6f1i0bj1lhLUyxCFXlR057lxKDljs7qMIeG/e6yk4EaYvlHeuVv+HOpx/02wWrJ1y/wpEypUuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712941545; c=relaxed/simple;
	bh=FILHa6jnvl0HIpt/oolnftSh+860/k0pB64nWztgqJo=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=QRm83Z+myHHnd2pj1y6UlnPcy/ebQB/FtXAsPBXXagE0+N5CHfOGi5hoF4ljPWSahLA4G+mY45sb75IAPUmCl4DZaUOVgVwpSeWxqRdtLhLpVWiPXgQ0caeedfVJ5NkSPdF8VmkSh/OzWujXyHuSBF4xYi726Hgc8AfOpKYncXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WZAwOgmi; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WZAwOgmi"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-343cfe8cae1so686531f8f.3
        for <git@vger.kernel.org>; Fri, 12 Apr 2024 10:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712941542; x=1713546342; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DZtcAHAvXbwHOCJH2rpWzwci7ZDQodYg5Tw63u4joQM=;
        b=WZAwOgmi3IrShj93tmZvTBPyLY0R2oG5DSyxC4R/4cBlwPP5gstifF84gClu7jjuxV
         /NASOegA1keE0Ia1+Ocprz+QVuUabNuSEMigmdDwgIr/j6CgIHzWo6Vs6ayLqm5q+uqJ
         MegDPpt6fbXGLsJJBpG25KSN/ywdRX1ZWlbNFMRzHSSLOlPJOE46R1ZRzFb4RXKnqAbm
         NCEYBfbqyIwYeycmDzFaLX5FLm3bJUVO2Skt76TGX8Fb1oG26JW1B80JTPEr/U27t7so
         717Z3KfrLDpQ59EqACsCF73MlzSd4lWqNHRgL4TlXowjOBkmDJ90M6Dz9EPMKURGVxSC
         CP3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712941542; x=1713546342;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DZtcAHAvXbwHOCJH2rpWzwci7ZDQodYg5Tw63u4joQM=;
        b=XZSpOA7k2/no9YC+QjQBeEcSNbkkoyGkVvUb4dUVDb8Byo8ZdNV/UAADw5/DSmQE/+
         MWcOwLItEzPzhEA/yzdBd26fsSLQfdzgHG6sCqDHfvOPpVS6Bj3i7GagFxkP4DTsGPEG
         7yNF5szkz+Bv+nMfzQhH6i42MLOY6f7upiX1tvqctzFooKRb6Qtct/VtmneKsnj5H5eD
         wU1SXHVWYEXueSlBCpZF3bYFEiZU4ojb6RPr9gtkJY9lXsMvyQbNU5o7fhNpKm9o0UAE
         rVzcyPSsPC2R2v9LmflcIrFzo0jJ3q/GFtgpeg/USOsf693MdE4HZdq0FSuB8Lw9yBsC
         xp8Q==
X-Gm-Message-State: AOJu0Yynwe5kwQ+QnaYqWmfDpM/jgdUPjRq7mOxGm6v7UdaxFrJjh4/r
	do6EA7uRBHiHpy1TOL9rmy3USwLmGZGzJCtSjdZ3XdW2cU84WtcCyc2zdw==
X-Google-Smtp-Source: AGHT+IEoxPX58Fl6T9mJ8Jd/rJfXOkW0iupn35idRZHV9PP16QyvsH72XnxRwqFO9X2BHM2f7LfKIg==
X-Received: by 2002:a05:6000:18c1:b0:343:7cef:993d with SMTP id w1-20020a05600018c100b003437cef993dmr2142577wrq.61.1712941542499;
        Fri, 12 Apr 2024 10:05:42 -0700 (PDT)
Received: from gmail.com (188.red-88-14-41.dynamicip.rima-tde.net. [88.14.41.188])
        by smtp.gmail.com with ESMTPSA id o18-20020a5d6852000000b00343e8968917sm4697053wrw.1.2024.04.12.10.05.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Apr 2024 10:05:42 -0700 (PDT)
Message-ID: <ccbd77a1-d334-4d8f-8de0-b542c79330fd@gmail.com>
Date: Fri, 12 Apr 2024 19:05:41 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v3 0/2] launch_editor: waiting message
Content-Language: en-US
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
To: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
References: <e60c1217-aeb6-48ce-9aa5-7c0b13396e33@gmail.com>
 <96bef5f9-1286-4938-99ec-6beed13ee68d@gmail.com>
 <0258a583-a90a-4434-bb4e-a1672d574b9c@gmail.com>
In-Reply-To: <0258a583-a90a-4434-bb4e-a1672d574b9c@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Improve the hint message we have in editor.c.

Rubén Justo (2):
  launch_editor: waiting for editor message
  launch_editor: waiting message on error

 editor.c | 54 ++++++++++++++++++++++++++++++++----------------------
 1 file changed, 32 insertions(+), 22 deletions(-)

-- 
2.44.0.771.gbd07cf668b
