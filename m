Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D374328DB3
	for <git@vger.kernel.org>; Mon, 20 Oct 2025 18:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760984730; cv=none; b=ky07hzUjt/FG7C16ik0aTTQUraF53wjvmoBfZj/Xno2/vV+WjiKyhk4sJYu3Yzeo7IDtkE+Oj+Y0ZVhOaX1ARwJi7Vqs52aW1kXDtG+KBLyxLBVoM3Wt9OuzH29nZCqq1Cb2nF0Ip4TQyZQ6yCqIjRrN27Jd0F/RW3ri/bFdA9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760984730; c=relaxed/simple;
	bh=0IbOoOUF0VFfKaWXs3Ck/boaf/9T/XMObdAhMdqNt70=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TFkcfbXfnQ/6LtJu3HrZEGTarVwYWndgzi8RcFD5/vWOcXjiZPCuQBc4MJT4DyGYg1ebDUr5rMJ8r8uc23ieiLGfC2JhusEHUmNrkgpW0PqtDPh6AZuAKfKV/HED3fq3FVuvbgQEZDeRoK1df+WwymelaZPtQ0jcpXiVYMw7lrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B6kRbBuX; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B6kRbBuX"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-29292eca5dbso17207405ad.0
        for <git@vger.kernel.org>; Mon, 20 Oct 2025 11:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760984728; x=1761589528; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pPIHtiCn1VGgl1emHwzIAXkb06USKOl6Zw1aUtOJXN4=;
        b=B6kRbBuXJgmpg8FCNMArbvP8ZkrZ+oee+od1s6w7blVrntGhDuKX3mWRH0DBDJyl3/
         NJt3hHj2eyUEg3MxIcFmj1eK0L6U+jLTNJ1m6ZhgEc/OouUG5mWVNAhusUhXwBjt/HIz
         LA+JzzoQQIfbG7x773l6kgVWQivDj7+EEIyziG9AoRKekCjz81jOA19PsDo//ZgtgG6m
         bIQ8Bxlugok3xacnCseLeVNwCkcGj5SeQsPKLG5fljW+/6bw4lrq+603BERyze5LlfF3
         UFjgS+vNKERMGIY6q2kiOpeikvQqe9gUX/h+whs1KKC/S62GQyB/AqcfsRuauf+YZkW0
         eDRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760984728; x=1761589528;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pPIHtiCn1VGgl1emHwzIAXkb06USKOl6Zw1aUtOJXN4=;
        b=WTRhcw4712VA/IWGeyn2E/83v86UYjLxyYlgfS0kcFZxzmrfUZdHvVC35pTlJRmHnO
         t6xdsXLp+oFT34sbiJdqBn+F9Z0Gci39fBchSBhmyjWqGIAM5VJMS5GJMMTRyzA+K6e9
         EIbExB/tfrjPskDxc9UaaFl2UQiWyO6TmtiM9SDCwaNOiR6ZDdTigHTCX5nTBefhxwNl
         wwdxiCR7GsjSOezGZ6ezZP0369J1kYK6jqjxl7+PJ6SjbzIIbXuSfYIe9Jx+RSPtjVKI
         jnbo/rMZjgE69dOk0Ydv/sOzyZip6sQC8IJusA2llXJ+h3gx6cxhcpjn+NjN3ywLF65h
         bDLQ==
X-Gm-Message-State: AOJu0YwtDx5/OJNtxu7EqazThCITHAw3snb+8qUW2fJuTn9+AdvNBNFl
	a9haoe4UJFbQoeo1Jj09DHR/nDj7lhZ3YKk03juEQ4L05skHhYVRZiVDoIFI26JktnLIdLmbLOO
	ApHg+mao+InWYOTfhI+mvvtCIUmV1og0=
X-Gm-Gg: ASbGncsgweATNQMwTZOmJXQqTQGSVChO9e9aNhOyEOmFXE4VE0Bheo4giem4fBK43rT
	50PFn/sOIDoH61m9o8k0G1l0p7GIDQJMSGH1Qj4zqkkyewNVT7o8COcMFhW/jnUcxpN95Sa5gpc
	ZEuuyiliLZ3nLphAw8YOdf76ZrJc3aZWqB2ofteNDvo93j005EfCi6OkhMZ86ZIxRSp9lh2g+AE
	WwlONeHFjZuyl1zZv/OurhPnyVGNFRjCOc7WRitS0LZtkJkvGpN1NfqBZX/l+yGsgDmFybv
X-Google-Smtp-Source: AGHT+IHcTCy0qhBP4JIOJOlqGQpV27C3oKayE69qGCDPtQ7NoXA64mTVrWvm65QmixYqA0fmwWko7l4A9QIqMTLkD9c=
X-Received: by 2002:a17:902:f681:b0:290:d0fb:55c0 with SMTP id
 d9443c01a7336-290d0fb5971mr166542565ad.43.1760984728157; Mon, 20 Oct 2025
 11:25:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1760869186.git.belkid98@gmail.com> <7da4fded535984faea52d5f88793d3c8e47c0091.1760869186.git.belkid98@gmail.com>
 <4bd36d2e-7629-41bf-9731-493cf3bd151a@app.fastmail.com>
In-Reply-To: <4bd36d2e-7629-41bf-9731-493cf3bd151a@app.fastmail.com>
From: Bello Olamide <belkid98@gmail.com>
Date: Mon, 20 Oct 2025 19:25:28 +0100
X-Gm-Features: AS18NWC8Y8pOcmvwWL_Xh5VQPfJ1xaoxqkVPGAflsJNNH8cIYptxactFEAMpHx0
Message-ID: <CAD=f0L_4O9oLxUToLn3QwDopFCnYAKQwBPOXwb+xuPkqXh=p1A@mail.gmail.com>
Subject: Re: [Outreachy PATCH v3 1/2] gpg-interface: replace strbuf_split*()
 with string_list_split*()
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, 
	Usman Akinyemi <usmanakinyemi202@gmail.com>, Christian Couder <christian.couder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 20 Oct 2025 at 17:46, Kristoffer Haugsbakk
<kristofferhaugsbakk@fastmail.com> wrote:
>
> On Sun, Oct 19, 2025, at 14:07, Olamide Caleb Bello wrote:
> >[snip]
> >
> > Signed-off-by: Olamide Caleb Bello <belkid98@gmail.com>
>

Hello Kristoffer,
Thank you for your review.

> Signoff should go at the end of the commit message.  You=E2=80=99re sayin=
g that
> you are signing off on the changes as well as what was written in the
> commit message before that line.  If I later add mine:
>
>     Signed-off-by: Olamide Caleb Bello <belkid98@gmail.com>
>     Signed-off-by: ME
>
> I would be saying that I am signing off on the changes as well as the
> previous lines in the commit message, including that line that you
> wrote.

Please just to make sure I get you correctly, you are saying the Signoff
should be the last thing in the commit message.

Like I should put it below the other tags so that if you also want to add y=
ours,
It can easily go below mine and it would mean you are signing off on the
changes including my own Signoff?

>
> > Reported-by: Junio Hamano <gitster@pobox.com>
> > Helped-by: Christian Couder <christian.couder@gmail.com>
> > Helped-by: Junio Hamano <gitster@pobox.com>
       It should go below here instead?

Thank you.

Bello
