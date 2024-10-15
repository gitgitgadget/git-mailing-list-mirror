Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3F5F4A23
	for <git@vger.kernel.org>; Tue, 15 Oct 2024 00:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728952580; cv=none; b=GQZar1WK16PIrOlX56WEW3crRnWFSTc9qRchrBkEKDbKXQQWWhUiVOawHu0dHWUqvjg/p/Nfo8/cP2/kqMdCJbifdwJn6wzw0jyu0yOw1WqFPN9ERT3MWolkAKqEgIjALLlYOVFDrfLrvpuooZqW2NPIvUvE8AEXoCWlRkSCmOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728952580; c=relaxed/simple;
	bh=mJ3sRJjXQRzqPdiHDGM6RIvvKCWWr/rt0+1bCxH2+PM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HgEP+NsaJKdc2bX0IrMrBjzQbMHNHgUw/UiahDTPXwHtvHTTXZMOUsP4RwMT2rT9ofzrDMXMfb5vuT5rg8/I/18OMEePgd/T2OIq5heK8mbMo0DLOrT3WA67Ub815P34ce55sM44xwTTiSyK2a2ysvEGCzR88YAvsNvHVQP8zco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=vRJwd5yd; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="vRJwd5yd"
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e291f1d659aso2824272276.3
        for <git@vger.kernel.org>; Mon, 14 Oct 2024 17:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1728952577; x=1729557377; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mJ3sRJjXQRzqPdiHDGM6RIvvKCWWr/rt0+1bCxH2+PM=;
        b=vRJwd5ydCXr6DZoCdj3sa+ka4IwAMblXAfYp+YcFAspkynSbZJSxNB+bdJFVn/ZlVQ
         b4Q2+rBFsVAVhIZZVNHgDjArsVKyzCq9LTFMwPmL7MbvNKU18jraR643jgeGtXyX1j9d
         tsScQB1xT0m2ncqQj4RU9b+k4Q7fyJopSgvGepx1zyM9pl407FxtE8mffHkKJ+u10ixp
         G0A2R+mDSF6LfyMxPXUIGqE0cqJ6gkktbpW1suF33b9BmtlAr2MY64I/ysCaCMJ4kCI9
         96iqndA0sdFhePrIbGhX/i/tK/Egt9tETii13ZNyxSBl7t8V5w+jolotZdhcffEWBfMd
         8QXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728952577; x=1729557377;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mJ3sRJjXQRzqPdiHDGM6RIvvKCWWr/rt0+1bCxH2+PM=;
        b=Tc0Rf6Zw2TPGHwsOoVmZG3Mzcxg4OJJ7r0RzSk9StEAzAVKcP9N6Ni6ur18tNTTg2F
         wHQ6XzNffrp5osx7EXXHoxyeHcyJ0jx7jsL5erWiQLToLSLwMyABxRMad4wea/s9syJt
         4NxrwXP5HsWYLFEoD4+FCv8WJ7oW73XV2zJlDzlr+Uu3J7zxWdkatU+/+MWSDkdHLPom
         +dcIW+3MRif/pdruz4JeB4zrD9x/+2KZp1LodJO3RbkLhA3Gk8mwIfVPqSSbq+8rbXmJ
         wHwU0ELKbUFv8l6xYDqjvNfFg/UbDO8nrp8LOxRCw2gn1aUX6Sc68RqSMvGonoFI2meu
         HOJg==
X-Forwarded-Encrypted: i=1; AJvYcCWuj5Gj1/+ItEdOR/COlhrSLnE/vtweF3COhP/MdLWVB8AZBmah25wIKxm7p6exKEnQMhc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfJaxtqMX4Abor77VFfWPeicOlAjuJDXjAwJYlbSjq+6l5CMT/
	Zp+PZ1jxnZFEO65ilSBgQGKJqXnqnOAxjkgGosnbknOlkgETGRfKu9JY2k+wDmE=
X-Google-Smtp-Source: AGHT+IHWmcRASNWBnG4F5DnezmcRIZ8N5BPQR9BTspLnz1Z89cJukT+/jdri5036U8SqAeVrL2ThHg==
X-Received: by 2002:a05:6902:2e0d:b0:e28:f2b3:1a3d with SMTP id 3f1490d57ef6-e2931b15419mr7038967276.6.1728952577608;
        Mon, 14 Oct 2024 17:36:17 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e296d050905sm42438276.45.2024.10.14.17.36.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 17:36:17 -0700 (PDT)
Date: Mon, 14 Oct 2024 20:36:16 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Shubham Kanodia <shubham.kanodia10@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH v3] builtin/gc: fix crash when running `git maintenance
 start`
Message-ID: <Zw25AKpaZO0w4APv@nand.local>
References: <CAG=Um+0mJW-oAH+YLC3dWEU64JwS-zMkkTiFWYBe4g6HMbe-iA@mail.gmail.com>
 <a5b1433abfd84cb627efc17f52e0d644ee207bb0.1728538282.git.ps@pks.im>
 <xmqqcyk7lwa4.fsf@gitster.g>
 <CAG=Um+3=SQ7bZYvr4BNxWgMBNreQHgfs-0VQwkzBq=HW8Zxf=Q@mail.gmail.com>
 <ZwzYk9dq1H9QGXBG@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZwzYk9dq1H9QGXBG@pks.im>

On Mon, Oct 14, 2024 at 10:38:43AM +0200, Patrick Steinhardt wrote:
> I'm not sure around the timeline for Git v2.47.1, and Junio is going to
> be out of office for two weeks, so it may take a while. I'd recommend to
> backport the patch for now.

I'm not planning on cutting any release while Junio is gone, so I'd
expect that a hypothetical 2.47.1 release wouldn't occur until the
beginning of November at the earliest.

Thanks,
Taylor
