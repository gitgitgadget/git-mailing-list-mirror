Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5658616408
	for <git@vger.kernel.org>; Mon, 30 Oct 2023 18:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="AG/QrPN3"
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com [IPv6:2607:f8b0:4864:20::c30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55F07C1
	for <git@vger.kernel.org>; Mon, 30 Oct 2023 11:24:23 -0700 (PDT)
Received: by mail-oo1-xc30.google.com with SMTP id 006d021491bc7-581de3e691dso2778840eaf.3
        for <git@vger.kernel.org>; Mon, 30 Oct 2023 11:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1698690262; x=1699295062; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=F1mSmgoCDfib66rmVubgH5eYXN6J6TqiHxMYQCt+ZPo=;
        b=AG/QrPN3FphDPu956joTHKx+zxdM8UCcSGIF/OadReSkM/d/xrLhqRiZdE+ceF4mIg
         TnGZPUz+VlNxXMymsw8+uUxBYqfywD5uEOhmqRNNDr1qlk624mMYsUv8S67/wbxrH9gZ
         v7PgrVQd3kdB+BQc12pyH6z81x/9S9RM378yaYri0VlmNXiV+EiyromSdbXhbvGwLSZb
         VMO0wLa4OWYCUyay6K7+ODLclk8gxa+WzIOC7XI11TMXeKTh2Jkes9UxfakaDqUKgC/l
         sIWufxT1t/wRUENVH3S2HLCh+WsI0RFq/F1RU8x3wTnJTJc70zELOvLp8t1PMkHbTu4R
         5FGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698690262; x=1699295062;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F1mSmgoCDfib66rmVubgH5eYXN6J6TqiHxMYQCt+ZPo=;
        b=rVuxu1iAMBHij4ZoRZp+vvXXDe/r7rOm/1fsTMyfVi8LlTVTA+fKVuiz2F0IemLEJJ
         LWQK90bBxwQDY+uHAE2IOmyYjxIzDhMWjBdMSCSXg0X4ZxZYWNa3rNIH4zw7BdP3R1gQ
         i2P54XFJI+Owq/Pqr0SKAoby2pXreNM/JmhWazO+U83zfant7kH4Rtn0DjYtFIyToxKr
         vKwvjTCr6Hjw2B/sQAgTU4Qx8PO13xzQiWZVLqpFXViWj+tYq+CCjE2FDjlz6FE23wQf
         7VVgEiCeXg7HgQ+OaO2caHuu0F59W+rms3570Vcy/6oxyvX1GOH0CFqU45Y5BICt8uML
         uUnw==
X-Gm-Message-State: AOJu0YwUfyXUJmLywlVJQco2nsCzoNvEkJ1JAp3W85oIqGekMM8H/dN4
	DmrOI2TMx4CskoH08GQPeAT+Iw==
X-Google-Smtp-Source: AGHT+IHlWrtulRxTQ0m0DVaS8OlM/ZduFQ32SXaiVe3IDzI5i0kBedtmbiAzaU9EZ7VUs6MNz8y4Tw==
X-Received: by 2002:a05:6358:904c:b0:168:dbac:b94e with SMTP id f12-20020a056358904c00b00168dbacb94emr13546851rwf.32.1698690262587;
        Mon, 30 Oct 2023 11:24:22 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id cs11-20020ad44c4b000000b0065b29403540sm2399575qvb.127.2023.10.30.11.24.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 11:24:22 -0700 (PDT)
Date: Mon, 30 Oct 2023 14:24:21 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH v2 04/12] builtin/show-ref: fix dead code when passing
 patterns
Message-ID: <ZT/01cjmdWrSXs+c@nand.local>
References: <cover.1698152926.git.ps@pks.im>
 <cover.1698314128.git.ps@pks.im>
 <87afcee830caab2782ce693c1f961df6fea6e7b5.1698314128.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87afcee830caab2782ce693c1f961df6fea6e7b5.1698314128.git.ps@pks.im>

On Thu, Oct 26, 2023 at 11:56:33AM +0200, Patrick Steinhardt wrote:
> When passing patterns to `git show-ref` we have some code that will
> cause us to die if `verify && !quiet` is true. But because `verify`
> indicates a different subcommand of git-show-ref(1) that causes us to
> execute `cmd_show_ref__verify()` and not `cmd_show_ref__patterns()`, the
> condition cannot ever be true.
>
> Let's remove this dead code.

Makes sense. Let's read on...

Thanks,
Taylor
