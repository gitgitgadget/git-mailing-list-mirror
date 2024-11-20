Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 847BE1A00ED
	for <git@vger.kernel.org>; Wed, 20 Nov 2024 11:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732103956; cv=none; b=Tbb5AsM3BBerB3Rr/+6DDTP29fR+HiGrJaxiZIsujU6GAPQ50ZFYR1AfbuE8Le3de82K4jsZptVl+vYgCkoNEZsPyCPK9qkA4vGKmwYiF80hYzeQdicVZtRPogWZ528s7T/KBFgNxGm/gjxcX+U+Omoy0suwE0GpQgHdqXLjeHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732103956; c=relaxed/simple;
	bh=oG7OG7jwi7aWn+foeHKxNdq/mAWdlMKJk2+4uf0ZqW0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q2WvrUL+aAGKBkHmb01oNWHMux90GdfyXR/GznOPm0JZq5Ml+MpTXUGD0tojxrHuKA76jJKcN/r/lPxU5bfycRPtFBi84HGKSWX6vS1UCxmDV+MqN9QSJ9T4rShqav0Vvn4YUEfqF3GTG2AKghyFQx6pGhyWuyiFuLDBeJgi7xI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NaCTZPGf; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NaCTZPGf"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-7f809332ffcso583889a12.0
        for <git@vger.kernel.org>; Wed, 20 Nov 2024 03:59:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732103955; x=1732708755; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sCXnHwHYG0YjTKEUGeR4NfPvQ43ngSQX/OJ95wC5pss=;
        b=NaCTZPGf87U3ahoKCLAbra/+l1CPAy5dyts+IJD43PhJ8/6pe1OVu2pvKOacjIZGCf
         l4Zf99Llsm1aIY6AfJw+6TqXxRJK8DqA75yPyX0j1ZjLHly7IsxVUH/JwISrQKIfKwHe
         YcZr2uXk7DI9uyO999J1wIhloV2PPjRbs1juCUUrqIZczhzqw4UXlj+S0xQ88hiUv75r
         ovBB2B7k9cIIMTXzkUqkxUaWoVakVEjJmpAfMtOSinZSZWLdB0y52jP7p5q6TDPDW/Hj
         T3FH+s78I14eZQViUTlZ1foAwRgN/XeDySlGlI0Xscx1lHkmDyA89bWpV+qxzvV6R0+l
         c0tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732103955; x=1732708755;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sCXnHwHYG0YjTKEUGeR4NfPvQ43ngSQX/OJ95wC5pss=;
        b=O/x7j8fqedidHK/dS6U8Wy1rrPOa5UnHOW6hNvywmt/gcj4LhE+pK+qedVb+lweSGf
         HqaaV7Xe5/m/G5opOy82T6XtUWfWoPYFG6e9+88SC0gl+pvtwBvnpvht3o7SxClHnciq
         TrOw5VFx9wvPqYoKUTaogKDlKOP1gishDu+wjXtGwQN9nmiH0pe49vNKqI3X+4uNsF4x
         It54m8KqABuV4Uai5hHpubSFHYNgI8n7JHJ28658u76L6N1IPUILeTk+CKkqCRuBForM
         uZuc/S3OGFSxMK0fMfLF7H+fAwlzh2G/MQ+EWBmwWblimIl9oVXDtttv3fEKRh+zZgHm
         q7Fg==
X-Gm-Message-State: AOJu0YwA+a4gAGKhwTuqOCMOvL612UvfHmRakPpc8oPkFnbWBiofJ3bi
	dlhxdmXRRf9VPsZTSd3WpGcUSI5cV0lxO+rn9Hx4gRMYRrIQvMiU
X-Google-Smtp-Source: AGHT+IFO/Ecf40y6i8I6ylAQl6LybkikppwN5CKvRZZoccnwMu1eqOYrgU0P19jOih5x4HTe6MV8Aw==
X-Received: by 2002:a17:90b:3b48:b0:2e2:c2b0:d03e with SMTP id 98e67ed59e1d1-2eac83c4632mr3837980a91.5.1732103954724;
        Wed, 20 Nov 2024 03:59:14 -0800 (PST)
Received: from FWC02J2WN1.office.atlassian.com ([122.171.23.84])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211d0f348e4sm88276345ad.125.2024.11.20.03.59.13
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 20 Nov 2024 03:59:14 -0800 (PST)
From: Manoraj K <kmr.manu535@gmail.com>
X-Google-Original-From: Manoraj K <mkenchugonde@atlassian.com>
To: burke.libbey@shopify.com
Cc: git@vger.kernel.org
Subject: Re: git-blame extremely slow in partial clones due to serial object fetching
Date: Wed, 20 Nov 2024 17:29:10 +0530
Message-ID: <20241120115910.45681-1-mkenchugonde@atlassian.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <B010051F-B182-4DB8-9469-AA2F53781968@shopify.com>
References: <B010051F-B182-4DB8-9469-AA2F53781968@shopify.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Burke,

> When running git-blame in a partial clone (--filter=blob:none), it fetches
> missing blob objects one at a time. This can result in thousands of serial fetch
> operations, making blame extremely slow, regardless of network latency.

We are also experiencing this issue with partial clones. Have you found any 
workarounds since reporting this?

Git team - would appreciate any insights or suggestions on handling this
performance bottleneck in the meantime.

Best regards,
Manoraj K
