Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B38B77111
	for <git@vger.kernel.org>; Fri, 25 Jul 2025 15:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753456861; cv=none; b=O01QFC66fVQ25dZizBOTd4Iy3i+5frEc6vAilLmGm+beXP7nuLTf35CHbGboE3XKtavM0PM5jdlfenqgn5fm/EI+xVXyiOyt7h/yHT2sjfZugRj3ULivap/XAWdd41pELLvDtFwTokAGwA3L2HDHZTZ920RvxjVEh0LvHymI/fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753456861; c=relaxed/simple;
	bh=/FK5eqMSZm6w3eqNWmM2UcB7684AJw/bAYC9BjZWruM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jrUZCyBKnl6zS8lOUrcZNTReCzuSKrU3ldHcCcDj4eh0qWMToKnAgm0I/2sFZx0c/GeJbnLxV/2c03Hkpi1sXlbUfQiqM9cVfA7Cd1QH8Pj80wEMfHyQN8RLJ1HiYFsCb8P2JCx7MMWmWA5o/Zjbviy7w26RTgS5bDclMbEyvaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XhCqasZ4; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XhCqasZ4"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3a510432236so1664979f8f.0
        for <git@vger.kernel.org>; Fri, 25 Jul 2025 08:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753456858; x=1754061658; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/FK5eqMSZm6w3eqNWmM2UcB7684AJw/bAYC9BjZWruM=;
        b=XhCqasZ4bcnt5oXmBp7VOIBMrOSGEJWGr6B1lE0kUq8TI6fnv6pnRtWLioOsQU2ine
         jJZewUbsW9kI9BErYQeWUhjDzZTvf1tcqWxW2FJqMjgWC8dmzWLMb76cUDz0imZgX9Z/
         mNfN/okhIW/NHkFYLRRpVInFj7HyvaGQnYMRse0CEE+QHHtyMimnnl0+IynCVFsXXYjh
         nfACdqD36iAyUqgsd1PM5el2xvhg3yrrlV9+iqNRwJsz/6Mg5U2gkJwhGzXdLOgx4YAG
         PcQGy/QGZPUfH6XrUhq8HQGMUZWoIj+cFDDJZ7v2q7YPXY9X1WLTxDJOznVvZt/iPSVI
         ICGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753456858; x=1754061658;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/FK5eqMSZm6w3eqNWmM2UcB7684AJw/bAYC9BjZWruM=;
        b=CUEqf1PIcPztHFSO688vUzWLvx1Sx69G1CNoUtlzHpCBelIdoDrNR7F2Z896ayBI3A
         +0ao0UyaAMn+PaWz2xJaz7IT7zJgVq6hPDvU0TXp7ewopliX9lH6Fnu541uFzHR8Qngg
         F2nw9pZ4rsJd1UDgE3IjYmeQNKQXqZymB314wjGltxae1kHc299bEbwTq8bpZ14/v7lJ
         bFrn8kljGp9+gFRY42VqthQtk/ZQJ5CdmN9e+WhT5VWh+PBTQqq7zz5HSrrt2WJbUycU
         HMY7Q379eQKB2B9tbcGf5v/fCF0zflyYSpOvRAXSxZLfNVxFCLLS6pYj5kfAoDoZ/Xz1
         866w==
X-Forwarded-Encrypted: i=1; AJvYcCXYdCaN9LOPSZnHv4XwoYEJRwWp/ufNZuS214qismTaDnIVqpmrWsdcX+CrVEnVwCoWHFA=@vger.kernel.org
X-Gm-Message-State: AOJu0YynUpvg0tBovm1eQZOIvTbKbIv4QzzkiFSQAaAtAt0FLcxDox1L
	s4153A9OzjiGDAHnwfQF3IS3RG1MrUKskyyG55G5sCJTXdi/twOdkjxoacGZZH9+LZ01gTrgKjY
	t0gnMO4Xy4femOK/dFyD+afKR1DwGUWs=
X-Gm-Gg: ASbGncv+IwSZT0tj0/+9/rxO26TgGp2L9GhVOWv2RznFQysDpM27clat4Hb15c1Msoh
	KKLFfXhi2hJLxyQjmtoIEkyuboHP3NCcBV3I0dWICoz7jAvDj35HjzTPe6LmHSjYZoaPouGpUtq
	Elf7FVjGCx6Q1vg1nRUNAS68VNVSZNzAt6Kvad6FzmeYsFoOVGQx6E77cjJleEqNo2nNqzg1ZQi
	xuo86Yp
X-Google-Smtp-Source: AGHT+IFlYjF0XoZ6YjDdGmioWJWXbujED3VQ6LNjCkPxQu7LgY+wIZ3Qa0bmUz0L1oKNKVSXApdy0xye0zOciDFd8qA=
X-Received: by 2002:a5d:5d89:0:b0:3a4:f8e9:cef2 with SMTP id
 ffacd0b85a97d-3b776667125mr1910403f8f.36.1753456857992; Fri, 25 Jul 2025
 08:20:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAAVFnNkdgXuUk6ziu5FkB=sAHzEOyiynQpQJFox_p_ZL9VGRfg@mail.gmail.com>
 <xmqqwm7xxn4a.fsf@gitster.g> <184ec60f-9431-43c1-bce3-405bb6b7f959@gmail.com>
 <CAAVFnN=q5nCD3K1jppVcq7qB9P5WX0M070jqR_rey2hzBt0ERA@mail.gmail.com> <xmqq5xfg5o5j.fsf@gitster.g>
In-Reply-To: <xmqq5xfg5o5j.fsf@gitster.g>
From: Cameron Steffen <cam.steffen94@gmail.com>
Date: Fri, 25 Jul 2025 10:20:45 -0500
X-Gm-Features: Ac12FXynXP-EhSFLTW6eA2O7bgbvIpoNLB8J77YHH046bUxcGWbWx0tYY0_w_o8
Message-ID: <CAAVFnN=S-bu1FNafyyH797AeBxUu+8vk5yJ5xaxCUBkBZin_6w@mail.gmail.com>
Subject: Re: Show skipped commit message after rebase conflict?
To: Junio C Hamano <gitster@pobox.com>
Cc: phillip.wood@dunelm.org.uk, git@vger.kernel.org, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>, Kristoffer Haugsbakk <code@khaugsbakk.name>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> But only if we can positively tell the reason why there is no change
relative to the parent commit _is_ because the commit we are
currently picking has already been applied, that is.

I thought we merely would need to see that there are no staged changes
to be committed, and there is a currently-picking commit that will now
be skipped? I don't need to know whether the commit was already
applied. I just want to know that the commit in the rebase plan is not
being committed.

On Fri, Jul 25, 2025 at 9:40=E2=80=AFAM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Cameron Steffen <cam.steffen94@gmail.com> writes:
>
> > There is already a message that prints in the case where a commit is
> > automatically skipped if the changes are already applied.
> >
> >> warning: skipped previously applied commit <hash>
> >
> > Potentially we could use the very same message.
>
> Yes, that sounds like going in the right direction.
>
> But only if we can positively tell the reason why there is no change
> relative to the parent commit _is_ because the commit we are
> currently picking has already been applied, that is.
>
> I am not sure how you determine that, especially after giving
> control back the end user upon conflict.
>
> Thanks.
