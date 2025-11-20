Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CBCD1C3C08
	for <git@vger.kernel.org>; Thu, 20 Nov 2025 22:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763679025; cv=none; b=fEx+bNEbmk7bk1bTS2QiAKIzzdC8Tveb+6q4GjZlFdcfyM+RZXfCGHr+eYqkiHgAjJBO0uBQf6AxKY6rfCn4sUBWJ2MCFTJv04LT6FTOgs8ewhHLyDBlv/u+yGIF65+qbmg1ixQ3CcATXb1dOX3jqYS8Yn+rz9vyDxHotsIGizY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763679025; c=relaxed/simple;
	bh=cNSr01dXOI4C+5VqdDRxKv+Cded0a80cpLTMYniIVA4=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=ZdglWv54PVgcxAqKBOhik2+AgSzJ3ECFB9KnvOb201eYoFAoMKcdSvjALj2U/Hwot5Odcg+kXoIe1v1SW8/ZLZNKZBNjfIcWL+ucpHEt7OXQQN/p3M1ZC/ih2dzMdpKY8jwmZm9+NgHFVPZmrGrO1DoMROL+WP5NMxpN0ITabNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N0YjvlXl; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N0YjvlXl"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7baf61be569so1638022b3a.3
        for <git@vger.kernel.org>; Thu, 20 Nov 2025 14:50:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763679023; x=1764283823; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cNSr01dXOI4C+5VqdDRxKv+Cded0a80cpLTMYniIVA4=;
        b=N0YjvlXlwE0rJRJ+n6RINJbTiANXHtxFu+s3lpKmoz89vaiAqPnKBKPCwDu5OUmpyB
         NW+tIiAj2PciSnG1Ju/EUx7AxTbeLBiBiFBx9xwQxUOLb6yA8i9uKWaZAjnuM79vXkpe
         qHwFAYXtdzB7DQc/cOViQSRs4zLdeI2q4HR5q0gzhsb6cUtqDnt/opiL7hnjm0ziPt+E
         /qcFc1Lwya+Dc2ipjCjN8vd4kNYrsrMUMvVoV8U+rh5+yjUhE1K5oTb06UumTyCKy/8z
         SpzTRKHqx4rHk7/8lnTaov9vYihNo+HI81FE6ZnUpWJfh3Lg2iyPFb/cBJ1c5RCvf4yr
         Brzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763679023; x=1764283823;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cNSr01dXOI4C+5VqdDRxKv+Cded0a80cpLTMYniIVA4=;
        b=ji8kVshUBMVWiJdbbRdFaRFSoQJLbl4jXDvB6Zklh+dFb94lLrhRfojaZwvzSYr+TX
         SAKRwiOGsCdEFrDW3h9dYEJJtb3K7PY6l3IL4NVom4s8i8de2ubanBW0iGjhPXP6mxWZ
         K7CXWkloYvz1vmXH8zCEpqjhzEIeyLjsCKmy8zGfMHI1wrkwNsS+VSh7IFJJCujVf4L/
         456ZQsBjq5palEGwkacQtON7aB22m0SRDe7WcNk9QJZXgQc+hA/DFDq166UqXrsPo4Pf
         pIGt3tTbuYAkRCEzraBa66ks3NXj2tJbIcemA8l3HVmHtsvrIFtK7b8ZMBsKp37H01c+
         v4Gg==
X-Gm-Message-State: AOJu0YwdyfumZYu0d5mNz6mwFXBlqLoXdxiMAne1AcOOVRSA+nXlbaxR
	4+krhzUf38niMOPbptNFQBlZAsIJ8xbNXrvF8zNrZZi6SS+nuio/i3LI
X-Gm-Gg: ASbGncvFiUjaWfOm5y9E5x2zjc5oMJeQpoIbxOR3E2UeFNe2U0LusQTsozR6WdAZQpA
	UHwqUl2k8hQ4jVgxmT0kOsJv0hKfHNPmIYDZpuSAnqpw66a3txiiy32dtJxPYje63C4xXs+8R5f
	JqcmfvBaCwopxvvDKZPxmx3E2uffpxtFJDe6FiYdL4LoQ22IQN2RjbOkJxipRjmi5AUVH/mAfWH
	Ql+4unqn4rnk/TDDFZ9bJekaAwuooRDQxyEQ+/d9NKBtl5JPGxZqfGwYHGWUuF7plH7bg73ctwN
	JimPKFKwwMTQlfB7oODuWbxBnKvVEAaTbBJaApMwccoTaGz1eOCORmYjFNL19AJx7Rhv5T38IQB
	3OLLZsh4VKlggLvNiOAfazCe26FfRB0+BrQAxbehqyrD3mIC7OIJXGPvzG2OE8DIQlqezkN1OgQ
	rrBrnE+4/sDNwgGpVj86OjLMQ3yls1kKGxdgMnfvWx1h0hANqg7r0=
X-Google-Smtp-Source: AGHT+IFnI6HeEmrECvc+jBNZOvRn3hjYtqvkFNxVDyLWrpy+HVAxPqR6b5cTYfz8fznyRmSv13XeFw==
X-Received: by 2002:a05:701a:ca0c:b0:119:e569:f273 with SMTP id a92af1059eb24-11c9d8538d5mr40899c88.28.1763679023498;
        Thu, 20 Nov 2025 14:50:23 -0800 (PST)
Received: from smtpclient.apple ([177.103.85.82])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11c93e3e945sm14778933c88.6.2025.11.20.14.50.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Nov 2025 14:50:23 -0800 (PST)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.200.81.1.6\))
Subject: Re: [PATCH v4 2/2] repo: add --all to git-repo-info
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
In-Reply-To: <xmqq8qg3do99.fsf@gitster.g>
Date: Thu, 20 Nov 2025 19:50:09 -0300
Cc: git@vger.kernel.org,
 sunshine@sunshineco.com,
 ps@pks.im,
 karthik.188@gmail.com
Content-Transfer-Encoding: 7bit
Message-Id: <5F1F88D3-7EDD-4576-B692-4632E0086E8F@gmail.com>
References: <20250915223618.13093-1-lucasseikioshiro@gmail.com>
 <20251117151844.14802-1-lucasseikioshiro@gmail.com>
 <20251117151844.14802-3-lucasseikioshiro@gmail.com>
 <xmqqh5usiizp.fsf@gitster.g> <DA3814BC-D6A5-4EF1-9A2B-9687D1B6C26A@gmail.com>
 <xmqq8qg3do99.fsf@gitster.g>
To: Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3864.200.81.1.6)


> If you use "git repo info" only occasionally, wouldn't "git repo
> info --keys", if supported, be a useful way to get a more focused
> help than "git repo --help" where you have to scan the entire
> document and try to find the list of keys that are supported from
> there?

Hmmm, ok, makes sense. After sending the previous message,
I also thought about it being used for shell completions by
fish or zsh, for example.
