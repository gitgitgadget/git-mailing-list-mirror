Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1883217ADE9
	for <git@vger.kernel.org>; Wed, 20 Nov 2024 10:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732097969; cv=none; b=QnRzF620ffPa69kdm0LZlYzmPqTwHqE2AS/xN0/GU6D6NQq+HDaYS9rAP7K1C8c8YAt9xjQjYLeHctRwou/pJGD7NsSpbIcnsA/DxNIe0u/yFLmW0axUH0/3hauLlpn4eKhqopAOGluZ8Yc5b6AqD7nKYVDpO0Ilj+LgmsjAzXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732097969; c=relaxed/simple;
	bh=ctgtNKqIQwGMaaDlYSjiLPmW8TPbURGkVnq456h1yy4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D3MGGu7Gdb7M0niYatBs9QBf3ZprREalaVbbysBsaoldTLKC/wRvO7jv2flOpWjnBPu3rhtg+nJnBXVDfjvk0wchYEqP3rusrrKgLVeVMO+fnIBFKPkvr4uHV/hBtbpxS5ZI/rAt3/k9frkGHMtK9GMd22G5tovAHlbWeSg25ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RmYan4oH; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RmYan4oH"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5cfddc94c83so2587560a12.3
        for <git@vger.kernel.org>; Wed, 20 Nov 2024 02:19:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732097966; x=1732702766; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/JETX+WAqXAJRgzS52x+ZkgjLL2kIJ5u+pmLwPtWJAM=;
        b=RmYan4oH6cJzyA0fs4eayWKwJnR/UJsge89kla4fe0+krvc5ZHfKHXsr0rq1ypZ3mf
         jwevxKEju2H8XJHIYG8oYEt30DvUE4uesk35ZdUBQyu80y3+sM8RfHexdQk5tyfqTsDs
         prf0ZvQi/cKHtWrV3RkSkEC/39cM+icjSz+HUbnAg3qHD5vuHTxBAvb4NN68jvDGD1Ae
         PP2Sb0eqrQL5nuxhOFKmCzpyXgVkkR7ts6jNkm5V8vCaiQv0o8gNQ+nWQRpfLqrS5huM
         +4kKbVsqDnYedYsERmhDtFlNvYBWQa5VizhwGkf1iXAr8Z7acDM76XOtZpm1iLdXDXtc
         +2SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732097966; x=1732702766;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/JETX+WAqXAJRgzS52x+ZkgjLL2kIJ5u+pmLwPtWJAM=;
        b=LyjjeKaXNn7JIoIf3uyo84MWUJCjILYhHNc0dvAX/LmSVm+ePfcJGn+SceEOMIYtKd
         BK+GVYeAJpM8ViAImV52cPp6HouCU6h/wT/QIrHYwoli13bP2ivMV1X6il0ujD/V2jVN
         OZfXnouW9o6KxRJ9KUz5feTfIfROpHNypsNWFVSprmyUS6FcSUM+8xH/+jl55BYSZIIC
         r19E/UIDH9YmC0dOpx/3KsjU/4iNIdxJIasz+O0pDOiiOeEmvDg+K+eBX/2J5eGiR0lR
         MEi0zRb3g7eJ+eRGpuIHGdTG5vffZmmSgDFWsr6S7qOYU2x5QYjqK1KyknIzIW8LO17t
         /Iaw==
X-Gm-Message-State: AOJu0Yx9KOvZNBQVmARRu2ywi0TKVjhY1wrnqcl9Y9wGj6P1QlfeIAhs
	iQnLQ2kR4D6LwxfB+aZ0ZtwgGOl5Irs7/D0F74+SvJ9RNS7DVs8BXQ9IgctQWtWTOTWTMAY6OiC
	PVRbQv4rsl4t6f0Zl3d1FMRqpmZY=
X-Google-Smtp-Source: AGHT+IHL+v2WISlBDfqOf3362cXmYzUFjVTq0CTtloAIwns3l8crtVp11jgNKnK6mitWnikXJt8iHorsN4KfQLNeSCY=
X-Received: by 2002:a17:907:708:b0:a9a:c03:ebc8 with SMTP id
 a640c23a62f3a-aa4dd721236mr188016766b.37.1732097966109; Wed, 20 Nov 2024
 02:19:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241120-pks-refs-optimize-migrations-v2-0-a233374b7452@pks.im> <20241120-pks-refs-optimize-migrations-v2-1-a233374b7452@pks.im>
In-Reply-To: <20241120-pks-refs-optimize-migrations-v2-1-a233374b7452@pks.im>
From: Christian Couder <christian.couder@gmail.com>
Date: Wed, 20 Nov 2024 11:19:14 +0100
Message-ID: <CAP8UFD0xMcqfJT+JnqqFSSiN0QOzsJ7pvQmZ_SXtxz3f5iJVBA@mail.gmail.com>
Subject: Re: [PATCH v2 01/10] refs: allow passing flags when setting up a transaction
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, karthik nayak <karthik.188@gmail.com>, 
	Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 20, 2024 at 8:54=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:
>
> Allow passing flags when setting up a transaction such that the
> behaviour of the transaction itself can be altered. This functionality
> will be used in a subsequent patch.
>
> Adapt callers accordingly.

From reading the above, it might seem that the change is only about
adding a new 'flags' argument to the ref_store_transaction_begin()
function that sets up a transaction. When looking at the patch though,
it appears that it's also about adding a 'flags' field to 'struct
ref_transaction'. It might be nice to mention that in the commit
message too.


> diff --git a/refs/refs-internal.h b/refs/refs-internal.h
> index 2313c830d8facaa17b0b4b073df0de958023062a..dbc6360c5a1d410c192e7eee1=
bffb1d423e1f9ee 100644
> --- a/refs/refs-internal.h
> +++ b/refs/refs-internal.h
> @@ -193,6 +193,7 @@ struct ref_transaction {
>         size_t nr;
>         enum ref_transaction_state state;
>         void *backend_data;
> +       unsigned int flags;
>  };
