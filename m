Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA1A823767
	for <git@vger.kernel.org>; Sun,  2 Jun 2024 08:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717318552; cv=none; b=TaHcK9Nes1oSfkQ96huFQjJRk3scr9BZk2BMsFhwm9WeLXBq2eiNZxy78ZFuUOG5KzuonfN5921HGsaF49fKh6XsvjcPpGcNcwusVpefKveGPFDCfXYcjnim9ykRjvR430laWZIXLjyrz6ll+kgBLX5gyaIe5NS5d3QTnm7bkUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717318552; c=relaxed/simple;
	bh=6ETkSKiOpYuoXV6trxze3n3O0vDnerIXKFTBVqz6va0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wx9+gWFcU+fzjYeJWiZ8n1/gUoaPoRP3dPbpN2mMSjx3T6MIqG5kUkZZfVMe9eYsfUL9NLMJf2UX8THrEaBhOVI48PpE6Jg+lfwnLiylZAkt5j/ou80KNDxq0BMvk339rD02kbFlMxI4jTs/VRfrsKUCjh9mtKQ6moTKtPrz+Ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GBt/oD8x; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GBt/oD8x"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6f4603237e0so2275286b3a.0
        for <git@vger.kernel.org>; Sun, 02 Jun 2024 01:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717318549; x=1717923349; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ancdQgxP1U0LaPyeTAmlMQwTC3teQbQfK+FhvQVqmEo=;
        b=GBt/oD8xK+arh+dNZWZTIVC6iOtJHkR4gk8Kw3LUN2AiUeRHc+oK3sz8k1XbbSQ/W7
         vieYrMqdCerAc0RQNPf+Wyu8Ql1RooVWfW9z0/7a2pC7+UlBppTSoYH0nPgeYh2P1aHI
         BbTIyPFRnVlvVf9E7F54A+mtsrMBhzZ8b4hnY/Az4+abPJmvu0J1GE67jU6kYUXdswop
         jslA/hMNV68sJ2qoTWQ1eQ2+0Ovw2kKgLN87F06PZVGmfvQz1ZgrnRo1vKrwhmS/Qn6f
         ecUtCppXrwxUMs6vn44bxZPIDF6J6EwV63yfhISFXIDiv9M3v+cJQWytiw5N6FQx6IIL
         s5yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717318549; x=1717923349;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ancdQgxP1U0LaPyeTAmlMQwTC3teQbQfK+FhvQVqmEo=;
        b=kE8aq2wz0J3cENkf5YNA4F40FirU0HweYYTx5Fpn8ocMU6RPrnEwYRqXqbe+gOhpB4
         cLw7UljBruVZ7pJatNWIpogZv8Z6fEOH2DEViSXVL+a3F1AsUhkVqhUpkP7Eawvhn0zg
         1vfKs4AxmJ15Af+1WI6pr0sfoJUECCGKbDAKg9NDUyWg6UiCfJZt7v135UQBJLTjdvI/
         HGizeS7UUUICjX0tyPoIXDWwr8V3a2YOLchXGhrZG0xQM1UYzv3hf75otYd49tZGDjAU
         /KpQStiI0PfE4FSsVl/8jHEsrqAeFjFhBqjGYWS82F+C5s1eh8n9PolFoh9cfBf6CY96
         vN8Q==
X-Gm-Message-State: AOJu0YxxGZUH5ZjFns/0DPGa1S/WnIH1TFmikhxCaNqoh2lMaWTx71lt
	70z4Y9wmefxxu8i2sw+t7PdRGzsVPDXeW54u9otjm40wMuUf+axERLbPgw==
X-Google-Smtp-Source: AGHT+IHQEpNzdX/Deo7v7JcVvX9cRAkZeTNcdhwO54lxyKTLWT2p9VdAip5j1GUxVhxyhUYF3+9cFg==
X-Received: by 2002:a05:6a21:2729:b0:1a7:23ae:4421 with SMTP id adf61e73a8af0-1b264d5fd02mr11629199637.24.1717318548716;
        Sun, 02 Jun 2024 01:55:48 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6c35984763asm3120913a12.58.2024.06.02.01.55.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Jun 2024 01:55:48 -0700 (PDT)
Date: Sun, 2 Jun 2024 16:55:45 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [GSoC]: Implement consistency check for refs blog
Message-ID: <ZlwzkXPW7KhYEVHu@ArchLinux>
References: <ZlQ7j9HYVOpP2Xga@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZlQ7j9HYVOpP2Xga@ArchLinux>

This is my GSoC week 1 post:

  https://luolibrary.com/2024/06/02/GSoC-Week-1

Thanks,
Jialuo
