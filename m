Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBBA96E2BF
	for <git@vger.kernel.org>; Thu,  8 Feb 2024 10:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707388139; cv=none; b=ocAboQsEhJfqf9RaNC1WvhpwFh+Bp86ZPJV3LXgwVmfrgnWNi3f/UcpWHV0avBfqEyljR1HUlGKYWGhlsIH8JEZb7PqNP28/mZs+soSM7wcQx9vVFNUwXgnvz7FQZP+HR6htPeX3UOyfRne6+WVvvwzgu3+6W5RQhutVJxaoEkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707388139; c=relaxed/simple;
	bh=647NQqya0Zu8ceocSHGOEQ3GBryu5muUmgq2Wec8cUk=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Fs9S9SkJU6YLWtWTg1POoci3OvEvawEsjxhgrVVIv2a8Ibx3n3XYN68f81WR6ktKS4GZoaNxzau+uzZpHgUN7qmk68ute764h07R6buTrIO1qO5foezOizIDvwgkz+jqfd97qjkpvrjjfga9nFfA+kJvf0uRygiPqHiC1AcZKS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=diEcGHKE; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="diEcGHKE"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5116ec49365so417457e87.3
        for <git@vger.kernel.org>; Thu, 08 Feb 2024 02:28:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707388136; x=1707992936; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=aeDgKBPIOwys7NO1D2q2mZvrPHTtAc8jRxLkQRNQSjs=;
        b=diEcGHKEA0R/Y7raqWdT1xNTSgUEI/h7n6zwLycNGEzC21MxYb7OSGlXjhzAmIgm9X
         ksC0PZc8+xB3lC/kre5WmMiF7hYqEFbP6FuSxqo18ciZ5PwCW2siQaR0wPngjpppF/uw
         crbZ1axUnUWEn/WD/MBOIKV+65al8KgekWmrwlbp85vcazxr3PXS80jN2tENRbVpPgsc
         h8lD4DPDSxRHGaSFQz+HMq35gM+IwIgZWYJzTB5RuK+T8PELo9yVGPq5LJEfxg5rKhsd
         zIUOeuzycl0ZqbbBKL5FV4A8y2sNeezSTpr5yRCjK0dgnFEshcqMnc4IwELN6zwodDP0
         YU5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707388136; x=1707992936;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aeDgKBPIOwys7NO1D2q2mZvrPHTtAc8jRxLkQRNQSjs=;
        b=uAollB82kx2szjYavHBsQt5Q6ET5+M7NXu6vxgqvaQVTwnf5P2LLQo7HPECIbooCNc
         YJstX5+vWhAmqH12rnExzsr6n6+KbSiHhBwpAZ6HULgwutCLaSdD96Pgc/I1Gzanvz7G
         3W+e2k2RwaRy3UWDuiinbJmNNSOmwvHAP3YPoHRT5iZiFmAwQ5W99Se8TmZhJ8u5YX2X
         sdg2wsjMIszC4OBOKtXAPW+Y3rNCzYT6VACVPUP2NKBAK+B+qfLyedz9oTcO0Kdt7QpX
         78G/4B9ZgyRUMxi07HhqKC1x9fsUzM5iAq+9BmfJmisxf+CKytbP+hNfVXQ2kbD1pemj
         Z9rw==
X-Forwarded-Encrypted: i=1; AJvYcCXU9ZIzKzMs9zTqLTJzwqy51iB9OEfCUGyYfUU9Zkx26ZrwduahDeQO7VnZH+sHMVvpnUV/AIQwbk9dfdJ2jbVz+uiU
X-Gm-Message-State: AOJu0YzFiQK/EmbxH/90O4VJm6aJnXq51MsBSkAo9l4zQ1yOJ4KblwxC
	s5GK9j8b0eEZfBy5Wn8Ozj+NL4Yj7tmfq+6d6mW7jm6b6jShOzu7
X-Google-Smtp-Source: AGHT+IH5ZXNAcILvGosXNOHZ7KrJmYzLexxL0zm9l/qHLs1yLembuS2RiMxca1vrHBHQU/huTIbDaw==
X-Received: by 2002:a05:6512:1107:b0:511:6458:4c4d with SMTP id l7-20020a056512110700b0051164584c4dmr4365239lfg.43.1707388135640;
        Thu, 08 Feb 2024 02:28:55 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVMAl8UD+Psc6p0T6jf4BjOzZ8jwq0zI6rv9us7FZbbQm0ZoZo7P6Itl51WTNOJtbxobEUd2Lc836tm+poTI+sFESnx/z7tqleHsfidfnhW6MHXyFmvzzOlbZz8DpT/H+IAByz37w==
Received: from ?IPV6:2a0a:ef40:62e:a901:386f:d8d1:628a:e68d? ([2a0a:ef40:62e:a901:386f:d8d1:628a:e68d])
        by smtp.gmail.com with ESMTPSA id l9-20020a05600c4f0900b0041004826669sm1179175wmq.42.2024.02.08.02.28.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Feb 2024 02:28:55 -0800 (PST)
Message-ID: <613b85a3-677d-40d8-84b5-69dd5c27cafe@gmail.com>
Date: Thu, 8 Feb 2024 10:28:52 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 4/4] for-each-ref: avoid filtering on empty pattern
Content-Language: en-US
To: Junio C Hamano <gitster@pobox.com>, Karthik Nayak <karthik.188@gmail.com>
Cc: phillip.wood@dunelm.org.uk, git@vger.kernel.org, ps@pks.im
References: <20240119142705.139374-1-karthik.188@gmail.com>
 <20240129113527.607022-1-karthik.188@gmail.com>
 <20240129113527.607022-5-karthik.188@gmail.com>
 <98d79d33-0d7e-4a9c-a6a3-ed9b58cd7445@gmail.com>
 <CAOLa=ZR=_tt=ppphGMkxqj_YB5G+YkTMWGzRzcHTbrZz4ysb5w@mail.gmail.com>
 <92ba680d-0b48-49f0-aafc-f503e5a5e0ea@gmail.com> <xmqqle7xjzic.fsf@gitster.g>
 <xmqqr0hph1ku.fsf@gitster.g>
 <CAOLa=ZSZJ=_VCppHXcJeE=Z61go4_040xyc1NBTu-o=xysLrdg@mail.gmail.com>
 <xmqqcyt9fdc7.fsf@gitster.g>
In-Reply-To: <xmqqcyt9fdc7.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Juino

On 06/02/2024 22:16, Junio C Hamano wrote:
>   - we do not want to say "pseudo refs", as I expect we would want to
>     show HEAD that is (unfortunately) classified outside "pseudoref"
>     class.

This is a bit of a tangent but I've been wondering what the practical 
benefit of distinguishing between "HEAD" and "pseudoref" is. I don't 
know the history so there may be a good reason but not classifying 
"HEAD" as a "pseudoref" seems to make discussions like this more 
complicated than they would be if "HEAD" were a "pseudoref". Would it be 
beneficial to loosen the definition of "psuedoref" to remove the 
restriction that they may not be symbolic refs or have a reflog?

Best Wishes

Phillip
