Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76FAB4E9C26
	for <git@vger.kernel.org>; Wed, 14 Oct 2026 15:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791993338; cv=none; b=jCL7xWkcu0ebRUvICHIzAtCbAR4IeStI+nflYelp3lpHqV8VPXgp5cCpeVK8wwBDi/GirwZpeETKFmQXdvOsttzrBvcXzy8RP+f2hRc+l3ehqTj/yCV8btxwoNeOchNeyjEOMOWZLuwJLmCX7qDhECW/rJYDmRsJ4DJVQBbGh8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791993338; c=relaxed/simple;
	bh=xuq92JyMI2KJKXsrbz5DF0fyqrupH9f3DQ5H602tkHk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hg7Xb9q6q+roiB5saSm4VpFU7C6AsSY2lq58b5IzjVYxdKileGyH+ecTcB7iOUKuiR0K5j6lR3s/Y2ALbaq94bNZ1OmGC3E4h69CUrLGqWZOCcxAb3PxczayFr/eud8JTt3wS76xBzHXmtf0ai1C9s2WQM75YO7QAiDx+K1Fv4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L1XrwT3D; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L1XrwT3D"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-c315869241fso172655366b.0
        for <git@vger.kernel.org>; Wed, 14 Oct 2026 08:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791993335; x=1792598135; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fYAVCkBaoOifws9LleARz1otwYu/Q7cCqAoimnPH9GI=;
        b=L1XrwT3DfDl/llJUr3f4L3VASzAznFR42KNY+ZoXvAd48XlNTbvzlCwA7PsR6ayrkq
         xhozdgvHW0LQCop8N/6HhO8nb1R8m0IGAAVeXjW+B+jiJdYYF721jXTr7ZSQbMLSgDir
         HWWvmYo9TJpL+JjgV1lj80JMuQOJZCd9WXHoJraVcffmNU63udgqVZyvbehSBGWF9KPL
         CrUWvD3S7/7O17iO2dGSOqOwxe5x1ERP7HszweYdOj9tTtQQJubZP2HG6oSeb92lnGFZ
         bl06gv7unt/Niwtei/YK4zF+FmGpztt7O3CrqiMC/Iw29ZBRq8ctn1cl4pX4r6ijzW/8
         jxaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791993335; x=1792598135;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=fYAVCkBaoOifws9LleARz1otwYu/Q7cCqAoimnPH9GI=;
        b=VMgSiWRz1UxH0l5gJRu7wiq98eA8vkAd5WUC78irOunY2Ejh+Vo5TOQXgltAXsxBgC
         UpDdoRQHfQA75IJFB6SYsGeGtYyqCMUsP6TQsfaFvkJ9pQRB+pIIztYSjozqPUmGiIWT
         oI/QEKAUXEeSC1q+3OkMoYq9JcP+QHwk11d6MzAuGanLDg0qRC3u2xPSoikkLh1H4XiF
         lDycJQGaPNJbzOiJodMOu1ZD5+pENQKvCQ14jazJUAGzv5jBNlKpC5cQILpzybL5rjlp
         vC30LtljmJ/ZHdlz4ZkgDTpz2HuSAPOZ+lOex+V9a5/1eKZ+zp6okWdjFGXPNTjbTaL3
         LPag==
X-Gm-Message-State: AFq9FYIeR6tnlBQakNfQYgdpoYexXfYyYinOZgOQmutxknoNVHuy3uT2
	p9uGpk2YFQUnNbBdG3K259DPEqywk55z09dafwD/EjjgumRoTQlL9IUx
X-Gm-Gg: AYBFou2v9zXxM8NRj2GqvuPztZk2y6/O5OHwkRPiVhMhVoG0Q/Ac1tJauce1zfoj5Vn
	sxcg9Kme5P9JYArPhRLyQrs78C2SQAr5Wn8xp7VkTwuFWmBu9+GBjuHK6yGPGq0zMI4X7tBMcj6
	/aDI8cjrNnPzOhRiOOu25ULCSLmpz7BYz+smwLPU+GQbj/IXLNfrAvDokzCQz1ky2LowiKS0Jvg
	vbxEXyNnFs4iTP8qOxl89EgqOlGA0id/5xFsqRKB+Z5zfwHFfk/A0BX14UwmNB/VG2WlY5y7vLw
	eMvqgR5t7q9yrfX/Ky8TeJrMe9iS8b1ipWYAwHVuQNEtLFgbYiQTXvBKUTeLmo9qucWZCnE+5IW
	5bNlRhdsrM0OftMgoozFi/lEWeMhn9t0bXIClu/g1BWGrXOUT5hMhhU+HR964qDCcjqEGmocss2
	yQpiCQU4GAZR5SaOO3owzH+PYJmJ8StqnLnIluyYCMBPgWYCxz0Q5EETgNjeQ+5WD+khHxmxuCQ
	nMo0NUakVJW1M3QSzy2iPLikuULhajc8NYxNrnyPMqWlrxlPdcBNaOwHETQSMqPheRaBNRrDc0H
	c7Xw0c47nVdOcj1Y51ziaWriQRpE9CAiJ6AcE2CfSN8bwDwGeXx/3KguFp6M9dvptJB+6nOv1A=
	=
X-Received: by 2002:a17:907:6e92:b0:c29:6400:ef8e with SMTP id a640c23a62f3a-c31aa0098a2mr1498452066b.42.1791993335366;
        Wed, 14 Oct 2026 08:55:35 -0700 (PDT)
Received: from localhost.localdomain ([104.28.251.98])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c3eda620c30sm435866b.66.2026.10.14.08.55.32
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 14 Oct 2026 08:55:35 -0700 (PDT)
From: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
To: gitster@pobox.com
Cc: git@vger.kernel.org,
	gitgitgadget@gmail.com,
	mail@thomasbachem.com,
	phillip.wood123@gmail.com,
	phillip.wood@dunelm.org.uk,
	ps@pks.im,
	christian.couder@gmail.com,
	usmanakinyemi202@gmail.com,
	siddharthasthana31@gmail.com,
	kaartic.sivaraam@gmail.com
Subject: Re: [PATCH v7 1/2] rerere: wait for MERGE_RR.lock before giving up
Date: Wed, 14 Oct 2026 16:55:29 +0100
Message-ID: <20261014155529.84134-1-okhuomonajayi54@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <xmqqqzhxf4uo.fsf@gitster.g>
References: <xmqqqzhxf4uo.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, Oct 11, 2026 at 1:39 AM Junio C Hamano <gitster@pobox.com> wrote:
>     Side note. Only one of the other ones has unit in its name
>     (i.e., credentialStore.lockTimeoutMS). We probably want to give
>     it a synonym without MS suffix to make everything uniform.
>     #leftoverbits

Hi Junio,

I would like to work on this #leftoverbits.


Okhuomon
