Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 606002F56
	for <git@vger.kernel.org>; Sat, 20 Jan 2024 20:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705781060; cv=none; b=STpMT2zSglMAcKZzLGesxS2efrdb3H8H59A41bpc3+1EBPYzdv2endHr5wrJ6AKus4mjsm1AlvmtA2F/vsmIbao6a1NQRaxxZElrte0IwkOr0HfRYK82plrmoVg0CACajsYtkPML19F1HfKnQMe7NJWV/3stsGxvyfnmaheGG6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705781060; c=relaxed/simple;
	bh=5Vlpd9b4Hma3CbIjI1RN+SppNOMTdwVUp9vRqP5yu8w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SqKCk1x/O48hvHTmgTCEjeZSkzww6E4gigrPgHdVE/wvgsh9Vb6n3Pwg0msI2JRMdIuJXu5RFOwgGR+psW4hBL5ITbUA6XWWbnzZ7PCLOLdGKS2kpMD2ugaufh2vEHCn/mmdh5jts8BQGdXOndJe1U6XhcQCjDOjLDdmJqslQjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UKXDElhI; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UKXDElhI"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc2358dce6bso2136985276.3
        for <git@vger.kernel.org>; Sat, 20 Jan 2024 12:04:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705781058; x=1706385858; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=BfV2fKTlzHSBtTRnIQ9jdvGIvkXz+NqzgjbzfPMNbeM=;
        b=UKXDElhIKP8XPUxloL9gAHzlfz9Fs/b9Br0g1Q3qQb546JeI0SAfRl1QOh6n5xLNI0
         nDtybE/CLv0GasHR1G487nIgCXGazmGjGhU+uIII/VswR10mpKG97KPLSVU7Xh5FkLRY
         jCHVZnBWHVq/RGj5+4YJR4NqicbJvb9kYb2POwgnnuvZaxPcAq6xyFJAkUPH34U651ua
         lN+n5fVK1xanaSJuO3WbsOK0RQx/xQo0BdsVa8gXGVW4KVxDokSOeCbob+J8icOdXm8i
         H9cdpiT8JjilEtFOaHhcB47wiDDr1XJ0LRGhUt2pcToGV/u0tO8E2ScxT4Rcz5TqhtHY
         Xklg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705781058; x=1706385858;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BfV2fKTlzHSBtTRnIQ9jdvGIvkXz+NqzgjbzfPMNbeM=;
        b=GwHgQ+FH/RywwKYsk1XiCk1YOpSCMtvVL6EjQOgd2qxCJcrpHvaM/31IQCJ2iWc0Pc
         YwyQMBSy2wUvfAJC30QVmduARyRsiD86YCxBXW5gWtZVSiZZRK2fInUxKJALMONxAuKQ
         3uPyyHD52LN1fu8GIetCFcmpeYElVMDhXsRqD0/bXsAQWWsTddQNZ3z+vslZgRtNw0dN
         i8OQWzGyTMGpSy6DUqyY7DT22MelzvMZwK/kxZJdRx7d9owtYSRjwgHOzEt+2Y4EwSh6
         Vcxh0XTgmbPy7UOK+x1EWR0pn2ouz6UroVyEq72AyVA1Lidiw2zWBW5A8IOsYo2edFvb
         th6w==
X-Gm-Message-State: AOJu0YxQn3mlHnqIYWhbCbr+4+JGYjjrYscnN/AjVhNsfoXk6YLblVjg
	D+HvHoe374OVy3TNS9Ws9SZ7DBw8ywZV9yqfDyvDqsXkzUitNXzNMrMBN8EoxuMxZnuJAUePBaw
	QmA==
X-Google-Smtp-Source: AGHT+IEsYJCJPqGSVAJtUnyY+lY36Uu8EPXbBf6fu6dELj0XcoHpRkCl1tF5vMp8HZjaBlaxQdfwEQKVJeQ=
X-Received: from fine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2221])
 (user=linusa job=sendgmr) by 2002:a5b:90b:0:b0:dc2:3619:e94e with SMTP id
 a11-20020a5b090b000000b00dc23619e94emr157127ybq.6.1705781058395; Sat, 20 Jan
 2024 12:04:18 -0800 (PST)
Date: Sat, 20 Jan 2024 12:04:16 -0800
In-Reply-To: <xmqq34uunoag.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <pull.1632.git.1704869487.gitgitgadget@gmail.com>
 <fd4a9d54d9522973a4c22e43cb1d7964033d4837.1704869487.git.gitgitgadget@gmail.com>
 <xmqq34uunoag.fsf@gitster.g>
Message-ID: <owlyle8jhiv3.fsf@fine.c.googlers.com>
Subject: Re: [PATCH 05/10] sequencer: use the trailer iterator
From: Linus Arver <linusa@google.com>
To: Junio C Hamano <gitster@pobox.com>, 
	Linus Arver via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Emily Shaffer <nasamuffin@google.com>, 
	Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

>> From: Linus Arver <linusa@google.com>
>> Also, teach the iterator about non-trailer lines, by adding a new field
>> called "raw" to hold both trailer and non-trailer lines. This is
>> necessary because a "trailer block" is a list of trailer lines of at
>> least 25% trailers (see 146245063e (trailer: allow non-trailers in
>> trailer block, 2016-10-21)), such that it may hold non-trailer lines.
>
> OK.  This would change behaviour, wouldn't it, in the sense that we
> used to yield a non-trailer line from the old iterator but the new
> one skips them?

I think it's the other way; the old iterator only iterated over trailer
lines, skipping over non-trailer lines (see the "not a real trailer"
deleted bit for trailer_iterator_advance()). The new one iterates over
all lines found in the trailer block, whether they are trailer or
non-trailer lines.

The function insert_records_from_trailers() from shortlog.c uses the new
iterator, but has to be careful because the new iterator goes over
non-trailer lines too. That's why it now does

    if (!iter.is_trailer)
            continue;

to do the skipping itself.

> Is that something we can demonstrate and protect in
> tests (presumably once we conclude these refactoring, we would be
> able to call into this machinery from unit-testing framework)?

Yup, that is exactly what I want to do once the dust around the trailer
API settles down after this series (and also the larger series). :)
