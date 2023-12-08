Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="ywjYr/aG"
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8558C3
	for <git@vger.kernel.org>; Fri,  8 Dec 2023 13:30:04 -0800 (PST)
Received: by mail-qv1-xf29.google.com with SMTP id 6a1803df08f44-67acdcb3ccdso15679606d6.1
        for <git@vger.kernel.org>; Fri, 08 Dec 2023 13:30:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1702071004; x=1702675804; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RFy4p6eIb1BQGprsTO9gXBWf2NHePhALxzEJQ1RIu28=;
        b=ywjYr/aGma6ows4Hq2jY2lvMXBmnTyTLetQqOZ6tHmlgeYK9VvTNZrJ7Ubay6yrcU5
         GVkTSlNdvQFj7cpdcbGdO8XL96uC9eNkJ9YO1sg+lCWGyYVSe37h1LtxTEc7uChtaerl
         u2tO30tqv4VcvzDWGwG83Smo1W6PVcPQj4M3JVmh09rt8Nvl6s24PCAn1eVLmgSUP5E9
         NbzOnDKWPvQW7ohN+ULNcTU1a+0NtErxj/2uhzL9hDwLqfClnQ4pleM724U8ejurj1Nk
         v7PRSLpMl+Xckz/Lw7j5jAuB1rD+7MxA6z057Ksc0gHIjw0tlwRiMYJLpaeiqctI801D
         jQuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702071004; x=1702675804;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RFy4p6eIb1BQGprsTO9gXBWf2NHePhALxzEJQ1RIu28=;
        b=iTCMX3kTpAGyJCmjBhfE5TvGw0sfbdF3puNfdBt69pa6pyjeNLRXahErWtdptYq72K
         IFYgNeF6tsg3+ayoC89SbY4NiKGBxj49h7qvK+IplRbLZ5uYo7izFIMlXzB7mCiPOjc9
         uL395wR6IFPKRPt+EsF4icobTssf8eJGXaZwksrAVfJFEXed7+hXTdpkvoF5CHRXUucN
         DTTnDxVOo9JGPdPyxwjKrtTU/j5YnWlU3MBr3OVSoJ+hIqizDLLFQKfAgzVsD1Vpcxfl
         CnSvRiaN45lAatc+lZdNp6ywRgdEwbrw3BBDkhdixOGKUNqnvTRMX1aL/mgeZQu5JG9Y
         0p3A==
X-Gm-Message-State: AOJu0Yx3DYWdTV+N+9cEZILuVGEGkXJWk40v7MmZgPm0fsMWi8S4naPZ
	/KaHc8pP8heWAIdrHNmBdDz+Sw==
X-Google-Smtp-Source: AGHT+IGjaqbIdJPegr12Nh0hsQV6Pr9tItuySpLXje2ui0sGukVSQD56GhlgTA+qMXXsZX6dBKcbIA==
X-Received: by 2002:a0c:e58e:0:b0:67a:8ff2:34de with SMTP id t14-20020a0ce58e000000b0067a8ff234demr685807qvm.6.1702071003858;
        Fri, 08 Dec 2023 13:30:03 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id d17-20020a0cf6d1000000b0067a18167533sm1093715qvo.83.2023.12.08.13.30.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 13:30:03 -0800 (PST)
Date: Fri, 8 Dec 2023 16:30:02 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2 02/11] reftable: handle interrupted reads
Message-ID: <ZXOK2o0jTgLmxPWZ@nand.local>
References: <cover.1700549493.git.ps@pks.im>
 <cover.1702047081.git.ps@pks.im>
 <b404fdf066e802328bcbcefeb9da7c996738f840.1702047081.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b404fdf066e802328bcbcefeb9da7c996738f840.1702047081.git.ps@pks.im>

On Fri, Dec 08, 2023 at 03:53:02PM +0100, Patrick Steinhardt wrote:
> There are calls to pread(3P) and read(3P) where we don't properly handle
> interrupts. Convert them to use `pread_in_full()` and `read_in_full()`,

Just checking... do you mean "interrupt" in the kernel sense? Or are you
referring to the possibility of short reads/writes (in later patches)?

Thanks,
Taylor
