Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB74114EC4D
	for <git@vger.kernel.org>; Tue, 23 Jul 2024 13:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721741041; cv=none; b=uly4rUIdXVVO3pXkiEXs7nTniU2Vy9QCrHSE86ikERSS+d6dvK6VD/ynM572WhngYW5OuJq6FnKdOPXFfPuwQ6OxDwyQLVSF65PHs12z1AKOvyGn+LToDcN/wj4jiFFUb5D14IPivaV3ZLDp7XI7e4k8NW3GcRw7AcRxCkBh3eU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721741041; c=relaxed/simple;
	bh=fXs/j2i7nF+yPglrIdNDFlOX+eQOiNiY+wST6zhb2Ok=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VIbje10ftZ2GJGKGfnTSY01PcD3wWPXg2B0W3LbBa1vA0eV0XhhO9rEUQ+zUzhFWj7lOsD/cRrpS9SzaF8oNHZccWaxPnyHQYI7hwjUzOklve5ut5dts3yGZ5pQlQDUMYSA1vsnYS1Ij6tIs+Hoa5LmaHtlIVsgJyXNr6BdTx40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PO8gwdbj; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PO8gwdbj"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-368712acb8dso2645990f8f.2
        for <git@vger.kernel.org>; Tue, 23 Jul 2024 06:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721741038; x=1722345838; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=xFUg9daVY41X3wh57k9IlX5ic+6uSdsixX5+WTo8LRs=;
        b=PO8gwdbj0By8/btjgYlfqkI8/+fx8SajYHC6z2rn63o/03SKH/zXagecFF/fRCfS2y
         4aZivFej3nB5qpn4VrpvC54gnvBwH9sZFlncZg5FCN8VdzK7YsVFXk8wn4YyXygWJGiS
         hynQTxF4LzmdXDLGLp3oxkX39fhj4cuJff+BU61fbdPIT+LzpbmN9yciDVMuuunOXUE3
         QPp/ki16OkTRDQ0oWqp40+M61MWRw+MP4VcH6WxUNZtbHsB6QSFCuYyF9pwnAKm+/xZa
         B8s+gLXW5W6kmZHnk6ZiQ4c2U0XzITpn7E8eAVuEW9s0oZHvwqyLcHfx87HOqBzcVrHh
         50Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721741038; x=1722345838;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xFUg9daVY41X3wh57k9IlX5ic+6uSdsixX5+WTo8LRs=;
        b=fZvi0IdDZ1AF4UemfKAsdIwdDNltM9X3/rgAwclbstjzIcqa5ieWibawhiTIAkJd8y
         Jd2Phe9PoMMZ6A7Gi3eaeFnbl+d3rr4qpel6wzJ1VXYiv1sEcRTrmDhrz3y32XsFkOMD
         71Yq35pd1LlX9aMX5RikUmnQxzVQBSBXPJ2Qt433hOoc2mDHweWdS3WRl8K7nxxnc+vE
         tAfEiW+JQpzP4ITlvZWZaX7h8qtTWeZ15/H6UDLxMtVTgYbiC4zbXBP7cMTSZD4/3mow
         77LaHzb2wo8LVuEbG+IhGBDnOah82dGQZYSyoMN4LCkIKJHm260SJEGIQLWjLfQSKFO+
         nE8g==
X-Forwarded-Encrypted: i=1; AJvYcCV8eWyO5P9EBnIhCfrQtThLobWaXf5nsM8I7yaxtfUz/zodLScmb+Xcg5BOKmI4DxfsObgBPKJ+D/xHLTAnr8twPeyX
X-Gm-Message-State: AOJu0YyvmoiLtMx4cdIgmGI5yw37YtxX5S8L0/z0pm/smxg8j3mNa+vk
	4c77hgIcDZdk4EKmBVNdSGHjaPHVGhgHaZj1AQe8IwPZO7FzNbCU
X-Google-Smtp-Source: AGHT+IGpZFT2guYclffscIATc0DmEQbhJFENeLz4M2jv9dpng/UnIIDeB9DC3a7gzO2EbfxFqcoaog==
X-Received: by 2002:a5d:5284:0:b0:368:68d3:32b5 with SMTP id ffacd0b85a97d-369debf8af7mr1991703f8f.13.1721741037861;
        Tue, 23 Jul 2024 06:23:57 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:600:8501:d2c6:37ff:fef6:7b1? ([2a0a:ef40:600:8501:d2c6:37ff:fef6:7b1])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3687868482esm11528853f8f.16.2024.07.23.06.23.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jul 2024 06:23:57 -0700 (PDT)
Message-ID: <d51c9764-e11e-452d-8974-7de80ac34195@gmail.com>
Date: Tue, 23 Jul 2024 14:23:57 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 6/6] t-strbuf: use for_test
To: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
 Git List <git@vger.kernel.org>
Cc: Phillip Wood <phillip.wood@dunelm.org.uk>,
 Josh Steadmon <steadmon@google.com>, Junio C Hamano <gitster@pobox.com>,
 Patrick Steinhardt <ps@pks.im>, Kyle Lippincott <spectral@google.com>
References: <85b6b8a9-ee5f-42ab-bcbc-49976b30ef33@web.de>
 <da7ed537-1c8e-42ec-aa91-49e1319e8c68@web.de>
 <b179d004-d00b-4ed7-8cc9-f3b388f101f4@web.de>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <b179d004-d00b-4ed7-8cc9-f3b388f101f4@web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi René

On 21/07/2024 07:26, René Scharfe wrote:

I'm still ambivalent about patches 3-6 but if we do this can we visually 
separate the initialization and cleanup from the main test body please. 
For example

> +	for_test ("strbuf_addch adds char") {
> +		struct strbuf sb = STRBUF_INIT;
+
> +		t_addch(&sb, 'a');
+
> +		t_release(&sb);
> +	}

Best Wishes

Phillip

