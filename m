Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66949302746
	for <git@vger.kernel.org>; Wed, 13 Aug 2025 22:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755123894; cv=none; b=dTLfnj53y92H5IThF6EHtGmhnEwb1KTzTnsopm/mK4ecvwi7IgKWfkzR3cXQd+GjQlHZiIwSE09Q/shMev63PFep3PgEEtCAYSIK/gT+t9oEnyJhgDC9wnQFKYu5nmn6ZKuWs8MLd3znWQkNSKaSiv1BLWdyNJp0Wojovt2tuJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755123894; c=relaxed/simple;
	bh=t5KFY6MHIhy5TyGGE65/Lca6Ve8GH7SnMk39qdU7LrM=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=moDswPyP93rrQq4x5/GjY9N8RzJ0m1bln4BN4Z+YiME8Pof5ynOLAKc7RO+UOkDp5bDQkA8+IUq7FPQSbPMk31nSgLQ2xJ+TRSWgPs9buA9+jb7DwmfIUskJcze3qFuyX1wT7KPoNr0Ewnu0J0XST5UAwxXfi08vLOj3k/uBoIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k7A+AwKw; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k7A+AwKw"
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-53b17194b1eso330115e0c.0
        for <git@vger.kernel.org>; Wed, 13 Aug 2025 15:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755123892; x=1755728692; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t5KFY6MHIhy5TyGGE65/Lca6Ve8GH7SnMk39qdU7LrM=;
        b=k7A+AwKwlvxePnn9KRgFVhhn8R4F5N/NtfmO1RlygiqP3Abdy19qd4sNa94xwN3/kb
         V+j1/azSoBEH2kd+6xgKY+nw52JwbP9sTOXuBH6R4eKRqLIqGLusNYxJSFqrohQ5Ffdz
         eP23OOYMKJknDh6k0QljMncMipFSVFtNEgWiMsfURqtv4oNXa4lCdO+VaugdeimCnKLh
         fffwkd4ke+Geu4c2Zz4kMcPRmUyorWHqkT2BADn3qzBM4q3qqNUbCGW9O4uwxXEKQDCP
         vfymd7Q75VJ62AoTrl1Q0lxcEC7hImOAQO+sGt7OB6TueCa4kl5gt1hCBRcuJd2R8aix
         wM6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755123892; x=1755728692;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t5KFY6MHIhy5TyGGE65/Lca6Ve8GH7SnMk39qdU7LrM=;
        b=qncUEY0ZjRWQTg4kvLKKOAzl+fftP2mnkG/LRz6B5A7bK/OHriPjPoW1opGC21Fkp5
         gHwqOK9jJQM6FPfE/LINa7ep1Ljb5VvHsNwFH7AIza4C9A9JDdCcvYLmmo0x+39alIv6
         nAC0TIp4JvGhFrBPf4h7z5xZBqgiKQ5g8lJ9KhwHbjqaLTRw3q6wCjvbUS3nB019p8Z2
         MBeVheNsBVGBuojqlBTNI5t5DjaikKJX36bGJV2qfXq//X306c3ZDxccuGecGP2iIQM6
         0QUNnuB5sQvUYNiRHEjZ3muYfa7fbFzj21TdWtsIh0V0+4a5xHISgbjBGZDu5rVGz4Gb
         NqUg==
X-Forwarded-Encrypted: i=1; AJvYcCVrtQPZynsOjCmu3lZiMSk2ODAMtLI49D7hEFSfnVGOoQQ4YNqe5o5NRmEhwMvekJ2kztM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUv+1vv08TWTY7WzYXa42iNAmnGxQawzOmFyxa7xz3zPHA4JNL
	2CUUywa1RWq2jcnsCb4LXlRrdqQ0lnA88N7Cz+XwWvTK+Ep6haalbngF
X-Gm-Gg: ASbGncsB3FAhR1sSTBCfEZuxqnZ4nTCPqtmYM0RqjD428uZ9s+vcPPTAbvFvTICYBU0
	oCg1EXaYd0bqSgItK0FsjoYqzbuz33SSG0Makvjrvv82prGgfbddbgn1j4XL7HP6stoKePtTmh0
	THhMMZ6yDdvGoqxV0jhHcRHkzLrbUH+elJJIn/WEIF4MU0ic+zitaIxFxItZPO39ey+g9YnFmLj
	oN+O+qLrl5MsE6koX09Sqy+Q067qeHRp/ncjij2Uf4pawPTsvap3M8m+J5YweqfjE8U63ZXtB5K
	M/0Rl+XmOFk6xz9ql3E4odYMsD/Qyf4q7stHXXUSea0+e52zdsC/jVssLPChkMHcp/YD99yyKZX
	KkVb8QnDUqw0PrVytsNarvkjgGE8nMHEaa205iqKbnPzI+GgP/KhNjDBCh3uurEz/jS8=
X-Google-Smtp-Source: AGHT+IFb4o6xX9QTmTw2EkshVT7f8zNolmvcwJtqTeasFu53G0UyHnWGjylDxEVM+l2FEw80aTdNPw==
X-Received: by 2002:a05:6102:5685:b0:4f7:c5ed:209c with SMTP id ada2fe7eead31-50fdfde231cmr397531137.7.1755123892328;
        Wed, 13 Aug 2025 15:24:52 -0700 (PDT)
Received: from smtpclient.apple (nat.ime.usp.br. [143.107.45.1])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-50629ae5cdfsm2945044137.6.2025.08.13.15.24.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Aug 2025 15:24:51 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [GSoC PATCH v9 2/5] repo: add the field references.format
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
In-Reply-To: <CAPig+cQUuXxz2gMMA200D39dqWi6wpu6z43Wkr_trbCwuvTKSA@mail.gmail.com>
Date: Wed, 13 Aug 2025 19:24:37 -0300
Cc: phillip.wood@dunelm.org.uk,
 git@vger.kernel.org,
 oswald.buddenhagen@gmx.de,
 ps@pks.im,
 karthik.188@gmail.com,
 ben.knoble@gmail.com,
 gitster@pobox.com,
 jltobler@gmail.com,
 jn.avila@free.fr
Content-Transfer-Encoding: 7bit
Message-Id: <9A8834AC-0AC1-4AE8-B430-4DE12F9079F9@gmail.com>
References: <20250610152117.14826-1-lucasseikioshiro@gmail.com>
 <20250807150239.6987-1-lucasseikioshiro@gmail.com>
 <20250807150239.6987-3-lucasseikioshiro@gmail.com>
 <f97b712f-95a4-480b-8ed0-174e4f45ff81@gmail.com>
 <8A30D2A7-3290-4E7C-BBF5-A51AE5AD19F0@gmail.com>
 <CAPig+cQUuXxz2gMMA200D39dqWi6wpu6z43Wkr_trbCwuvTKSA@mail.gmail.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-Mailer: Apple Mail (2.3826.700.81)


> The suggestion you cite has relevance only as long as deduplication is
> the chosen implementation scheme, however, Phillip is arguing that the
> deduplication and key reordering logic should be dropped, hence, the
> cited reference isn't relevant in light of Phillip's suggestion.

Ok!

> However, Phillip has presented a good reason to prefer
> "output in order requested, no deduplication", and I do find his
> argument compelling.

I'll do that! Thanks!
