Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 941B519AD7F
	for <git@vger.kernel.org>; Thu,  6 Jun 2024 16:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717690714; cv=none; b=Z4lRcRTDF1mC+fVW1VrQTxon5Poe9WjMfa0i30I4OqNK+El/mL+v+rbmH8UulmVs7yxHVsH5HDm3Mi1i9GC51HxbkOjhM08rHeUpQ9Y0KGUhP4Lmk37+385EtbH5VbTKQixaZK7Z630e4cXYTvsRNJDUe5cYI6GCZmSq9YFu/SI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717690714; c=relaxed/simple;
	bh=X1sk5bOkEB0IVGz7U7sx/o2LIMSj60utRTcUqYoY7nA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BTmoIrJZ7MPblmXRLopfCh3/lB2GJiblNnrSbvYRh3SMqUIbLUG56z+HINky5zgrsvM0tPDRqaVZgEWGAJyrOAX02znacmzDtlTgD/mj2z7Ob4VyUQ/K2hD3dcg8Re1dCij5zXn1pudhwS8LrvN7BES6M7kPf5xevUEa/g+pQyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AWIv96dV; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AWIv96dV"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-70244776719so915836b3a.2
        for <git@vger.kernel.org>; Thu, 06 Jun 2024 09:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717690712; x=1718295512; darn=vger.kernel.org;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pHFrF7/uq9Xa/jOaaeFFU4YMbYHsmp1XBbWNJgf+qCE=;
        b=AWIv96dVj1l2LGP6mSMJmpArJsVWMqFzX8qK5TKIZwoVlUoDMz9wtGpLp9O9S6slG7
         wWHn+UDI/+AICodUrr1cLgmsYGPPxqjIEvxigPyg7unKZK4duZ2u9bTK077WzkbRXm3k
         bO9Ya0SiVvjKZFmuViPJh9sabCkJtQpG9s52qIZCjpgW9M9wXWWLDKmhsZxqXS3AA4Ap
         pppa0OWFviKVI6TALCJTdTQmOfzexyG3nHt7Fx8dcrxvlOK9nGR9DQHV0CSff+PRNreX
         Vj/8i6o2OFoNDG1yaEpNOtpQ8JMMSUf5hzYYcaQx8Ch0k+D4M3RPulpnull3wveOTe87
         F0Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717690712; x=1718295512;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pHFrF7/uq9Xa/jOaaeFFU4YMbYHsmp1XBbWNJgf+qCE=;
        b=nUiniyRVePC1lWbFozS8nAO461BcLsJe8lW2bpqDnN921xVMW9I0QNYnoXE8nUrxHo
         nR0Dn88N+0jTUOv3fyR3s5i4oHjzUJ4KUgnkIHSIMPN5pxCd8ZeBJLDC1bPDVO2k8VJw
         Zz2Efb5zt6Z6Bc+hJorWPrZlAskhagpAwM5ACOld3Eh6XAebqE6zxqJpPaR/YziN684N
         N6ri7S/2M+8FiuVegjim9Wq5VkdMUG3YuVTq2tYxP7/iSJlO9ylovVcIwkahC2FdF/e7
         un1V2G2ci1YbTF0W97tT0XGWFIKazise+N9LR0fSuYFiRflGBzQdiN4MXJTJXtjtC8Xn
         XeRQ==
X-Gm-Message-State: AOJu0Yx21ws/jbiXn1aTUAXxjVxgOUhnsFuSuiib677QN1Qu6VjEHcjH
	CtpZi7IuhlwTUziyIP6PYBJeG7c1QbncLhIFWAtYmGYS1uJuyUQ4
X-Google-Smtp-Source: AGHT+IHHdVfvagan355QovXQ5WYMj7nwwuSdWEIjnWmJX5HqK/jiOtfoIquqIcLu7+vp/E5yPFJGmA==
X-Received: by 2002:a05:6a00:1d07:b0:702:2e33:af1d with SMTP id d2e1a72fcca58-703e59548f6mr6463605b3a.13.1717690711588;
        Thu, 06 Jun 2024 09:18:31 -0700 (PDT)
Received: from localhost (201.204.125.34.bc.googleusercontent.com. [34.125.204.201])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-703fd507615sm1321264b3a.173.2024.06.06.09.18.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 09:18:31 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Eric Sunshine <sunshine@sunshineco.com>,  Ramsay
 Jones <ramsay@ramsayjones.plus.com>,  Justin Tobler <jltobler@gmail.com>,
  Karthik Nayak <karthik.188@gmail.com>,  Jeff King <peff@peff.net>
Subject: Re: [PATCH v5 00/12] refs: ref storage migrations
In-Reply-To: <cover.1717649802.git.ps@pks.im> (Patrick Steinhardt's message of
	"Thu, 6 Jun 2024 07:28:52 +0200")
References: <cover.1716451672.git.ps@pks.im> <cover.1717649802.git.ps@pks.im>
User-Agent: Gnus/5.13 (Gnus v5.13)
Date: Thu, 06 Jun 2024 09:18:30 -0700
Message-ID: <xmqqed9aniy1.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> Hi,
>
> the ref storage migration was merged to `next`, but got reverted due to
> some additional findings by Peff and/or Coverity.
>
> Changes compared to v4:
>
>   - Adapt comment of `ref_store_init()` to the new parameter.
>
>   - Fix use of an uninitialized return value in `for_each_root_ref()`.
>
>   - Fix overwrite of ret code in `files_ref_store_remove_on_disk()`.
>
>   - Adapt an error message to more clearly point out that deletion of
>     "refs/" directory failed in `reftable_be_remove_on_disk()`.
>
>   - Fix a leak when `mkdtemp()` fails.
>
> Thanks!
>
> Patrick

Looking good.  The use of strbuf for mkdtemp() template and relying
on the fact that mkdtemp() makes an in-place modification of the
template string made the resulting code easier to follow, I would
think.

Let's mark the topic ready for 'next'.  Thanks.
