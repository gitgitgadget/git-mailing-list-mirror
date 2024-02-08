Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C60D6763E9
	for <git@vger.kernel.org>; Thu,  8 Feb 2024 16:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707409545; cv=none; b=nuOv0Nth21eGIvteMy1kJtdI5LobHV4wUOk4ipTU/sKhwW5YyhGLTXJB+7AqdISJO1p0uZYJ2s+oHBrHFPu4pNLMl1icL9l/chL6afXOAfaEpDyACjd0c477oR0zVdA59WmJK4TRfMc7QNwrYTTDz2tIY0yF44xH21PCtljsYXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707409545; c=relaxed/simple;
	bh=74MiM0lb2lJD5dEA/E3I60lw+MR3rjmrnrfJK2bA9yE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HBIZqnog226NKWAhWiDf8t7b4hpwRuKCiKHPVK+cXO9tc3AT2CzGQXg9MEzv25CAg5vQHPGW90Qy7EV64ElTux2VpqF5TlOIe6DpXsyBaNows+9pSjBw4EECRgT9GvtANULXML/C8PgRgQD2LfShnz05f9BpXVpWZrfLzNoTHvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M3VFPTLI; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M3VFPTLI"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-55a5e7fa471so58248a12.1
        for <git@vger.kernel.org>; Thu, 08 Feb 2024 08:25:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707409542; x=1708014342; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+96kxsrbHnJfRk+hI7ZESobf/0H2fu+Ra5pyUPFhOHQ=;
        b=M3VFPTLIrmdu5njgzlPLV2fwk11yeEkynIT/ky638+NPSiActHxvnnvP1vcSqONYs+
         nS7P8OZ3MXGReLo4rMaXRyAtmyzAYbV3xUE74HH+qz+9ZZdvPEChyre0zpcs2QwKOfTK
         dcgNF2psv7Lx3zb3YvkDLQiuiPZIeJY0cvcoCxDcxTjATcAfh/C+CQqwgw4/q7E1TLjb
         XaNF64YTRqokyHy8nBeQyFuEyhvbqFL142uJHO0kSSU0miZ44vRr0lWzbnf4TyQkgV3e
         KAVMvDcxiA7XISDl3aMiIPC2Y4fsWy0ttAvyTCjn0cvh547MG5mTtpcW6SaJv2Ej+Gnm
         2vgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707409542; x=1708014342;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+96kxsrbHnJfRk+hI7ZESobf/0H2fu+Ra5pyUPFhOHQ=;
        b=GpV1mg27uMcJzvuG2Xw1bhp/Ntxdlx+j52mWt2Zez29u4NfmCarg6CzRSJjjhgHVmt
         mEBp+Mc+e3qaCDMTzb6pGF/tIQICCYv8AdgE6J9pZcrSuTN/ej05O5ebjCJhFH0N+MAg
         psBHbH7/zYvG2Lb/WiDnSjR8hnLiXMAMIjE0G4ymSzWjG6Vg6A7/8YgRLvqWjgD8jOPA
         VSOwgTESw1xzEtp0U8/ln6OBl/ygBYZlVghTBTXCYn0X5UGoSjdTVO8eex0gbkNScMqt
         yJWxh0D88LozvtYmEvywix8+99rs5BquneYecvTXgWpOP6DS+9lJyZZnwD5mmK+a7XfX
         5dxQ==
X-Gm-Message-State: AOJu0YwLIfdAMcUu4afKbcE+OFy3/eIDrvp7PgRGtdJq9sCA3ygEWUl6
	UOSfxI/RFBZItwM8R9Y8f+buAVh1G47IgzucXjSD9jEatdxlTlhzHasdLzdz
X-Google-Smtp-Source: AGHT+IEZcMRgZ1RuQ5FHeDArwBQBboGpL6NE3IvxrqKk1ZXdR0Hc40liGuGXPfKdzpSv+o7pIzvuEQ==
X-Received: by 2002:a05:6402:31e1:b0:55f:f175:f2cd with SMTP id dy1-20020a05640231e100b0055ff175f2cdmr6874100edb.24.1707409541936;
        Thu, 08 Feb 2024 08:25:41 -0800 (PST)
Received: from [192.168.3.191] ([92.173.128.58])
        by smtp.googlemail.com with ESMTPSA id e2-20020a056402088200b00560b1176afesm973839edy.4.2024.02.08.08.25.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Feb 2024 08:25:41 -0800 (PST)
Message-ID: <02a018e7-1c6f-4fa0-8a19-0c1fdc202eed@gmail.com>
Date: Thu, 8 Feb 2024 17:25:40 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 22/30] rev-parse: add an --output-object-format
 parameter
Content-Language: fr
To: "Eric W. Biederman" <ebiederm@gmail.com>
Cc: git@vger.kernel.org
References: <878r8l929e.fsf@gmail.froward.int.ebiederm.org>
 <20231002024034.2611-22-ebiederm@gmail.com>
From: =?UTF-8?Q?Jean-No=C3=ABl_Avila?= <avila.jn@gmail.com>
In-Reply-To: <20231002024034.2611-22-ebiederm@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 02/10/2023 à 04:40, Eric W. Biederman a écrit :
> +				else die(_("unsupported object format: %s"), arg);

"unsupported object format '%s'" already exist in translated strings.

One less similar string to translate.


Thank you.

> +			}
>   			if (opt_with_value(arg, "--short", &arg)) {
>   				filter &= ~(DO_FLAGS|DO_NOREV);



