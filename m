Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 520F412AAD9
	for <git@vger.kernel.org>; Tue,  6 Feb 2024 08:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707207982; cv=none; b=aHizT8VPh/IPuAaiAOycFACw6gJ79ugH56AinW7s+uYMuW9k0O5gc+BVWe4c8p85M4/mg7CeaD0Gsa0w7FXl1nfvQUv/MC5rhW2WcsDMa5hU/ad0ZyPGbLoTL70MAQvSSAxYrF59J5jPL6bl+ccs/RQJGEXMw/qiVwVtbHr6IEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707207982; c=relaxed/simple;
	bh=dGItd5crTRX5L6ftYe0Gv0myT6BLqD2ia3EvtfzNRGM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nz24r/srD5b0onnN2tViAiJjTPXq5+qALSCkIikgqEycb+qNG0stuogGHUngxxT0nIIJ+BOQKj1pcjk6FWiIugPErc7MYMBTA6IQ9/2d1ZTExzdSb5jSOAypAKnB26bQexeRDybRKoortgnbG3WJVUx2Y+oFkT1289NrX/Q7Rq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=feKfGZKK; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="feKfGZKK"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5602500d1a6so3072735a12.3
        for <git@vger.kernel.org>; Tue, 06 Feb 2024 00:26:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707207978; x=1707812778; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dGItd5crTRX5L6ftYe0Gv0myT6BLqD2ia3EvtfzNRGM=;
        b=feKfGZKKb/EEhHmwMzCLQaXnLgR7ZGhfJojaf1qq/c0TGI/Qb4y9WQ0MbFGCo5zW/0
         wBSaoVRCBFsw2BpuT8kbbbf6hK4iT8IurXL2mrwKDcxCcGdPxD26dWPzcJRhXx4nbocW
         sO8NIJtAkF+xUyamhc5Oak5i0ogYoaPs/rJKbwRZZxcTb6S+qIZhwVbU5Z5eqJxEDlVe
         QQthpqf7DgNothMblgGKVmnyk/p7OXBfTrRwLmv41LRB/OVpqTurewy7ANlQuoHhGRRz
         9QoB/TGyEBDwnsc+zu4ymMP0hVcpTiECWbXP4xlkS+FU5c4SYZQkjaYpWztHGAvaxueN
         eWlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707207978; x=1707812778;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dGItd5crTRX5L6ftYe0Gv0myT6BLqD2ia3EvtfzNRGM=;
        b=RCkSfSDAxXdsXeALJIeHLOL+GhtmGh27DkLU+U147R5P0pIs+2BnwB3z3+ftZntHIv
         On/3Kcdp7/8L5s/jY2x0mna/Hkmdk2DiKRbyBEYQ9TDosBwTyp6tqMlAoEdCymXmofcJ
         lnu/JodCsYvTWy+6D9WNug5ZKvuEFEjp+q+V6nvp6We+QLzbX6j3c8ecJiFF5ZetR02V
         kwBzBumqSy4dezlkFsK5GkFEWevLyIb61/Fwky+ADIFpXf8Vx6sZohEsmVC7IdArtLTr
         PgHj2E5tOVo5d4IbhIwYPDjLPnxEzhPmrYZmVNAEo5N7TflrKi6Koes4Hh8y18dtDhY8
         X48Q==
X-Gm-Message-State: AOJu0YwZIDLGX2zQo1zBtWlaPpz/uCZJ6IGWiq+VMYHJ+nEnBMP6RGnQ
	44HI2S2k3CjPQmhjHUBSDKKt5/Zr9+EfpA96se5RMC+Gfzz48WhKpxnTguvvWOstWz3ReLWUDkt
	rpOILdMML73gXsIthEmWThKw6jXY=
X-Google-Smtp-Source: AGHT+IGzRuaEkA1BLWVvwf17E0L3t6IiO1XStJvgk/trViMQLr5Gci0hcxNxPAGbwPC/lPGwpjLWSvtN0M7qW7rmP1A=
X-Received: by 2002:a05:6402:7c5:b0:560:5c58:dfc4 with SMTP id
 u5-20020a05640207c500b005605c58dfc4mr1206838edy.1.1707207978400; Tue, 06 Feb
 2024 00:26:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <d4797f27-825b-4e2b-85a6-cc30f33934e3@gmail.com>
 <106b8e7be9ddc2d24670b01d54347dfcf9aef196.1707122040.git.ps@pks.im>
 <CAP8UFD3F95TzytdpKO=LLf6Y_ejxwh9QtgAxRNKgMXW-72hjgQ@mail.gmail.com> <ZcHH9UCiQgGvugyc@tanuki>
In-Reply-To: <ZcHH9UCiQgGvugyc@tanuki>
From: Christian Couder <christian.couder@gmail.com>
Date: Tue, 6 Feb 2024 09:26:05 +0100
Message-ID: <CAP8UFD2t-eD_WWz8Zv_iz-uPL6bqxO8o8_SXgvRc-p2v=FCY-Q@mail.gmail.com>
Subject: Re: [PATCH] Add ideas for GSoC 2024
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>, 
	Junio C Hamano <gitster@pobox.com>, Victoria Dye <vdye@github.com>, 
	Karthik Nayak <karthik.188@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 6, 2024 at 6:47=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrote=
:
> On Mon, Feb 05, 2024 at 05:43:17PM +0100, Christian Couder wrote:

> > "Difficulty: Low" might not be very accurate from the point of view of
> > contributors. I think it's always quite difficult to contribute
> > something significant to Git, and sometimes more than we expected.
>
> That's certainly true. I understood the difficulty levels here as being
> relative to the already-high bar that the Git project typically sets.

I am not sure potential contributors are aware of the high bar that
the Git project typically sets.

> Otherwise there wouldn't be much use to specify difficulty in the first
> place if all items had the same difficulty.
>
> Or is the intent of the difficulty level rather on a global GSoC level?

Yeah, I think it makes more sense to consider it like this.

> In that case I agree that we should bump the difficulty to "medium".

Yeah, I think we should bump it to "medium".

> > From reading the discussion it looks like everyone is Ok with doing
> > this. I really hope that we are not missing something that might make
> > us decide early not to do this though.
>
> I agree that this is a risky one, and that's what I tried to bring
> across with the "harder part will be to hash out how to handle backwards
> compatibility". Overall I think this project will be more about selling
> the patch and reasoning about how it can be done without breaking
> backwards compatibility.
>
> We could bump the difficulty to high to reflect that better. But if you
> deem the risk to be too high then I'm also happy to drop the topic
> completely.

I think we can keep this topic with a "Medium" difficulty. Perhaps it
will actually not be very difficult if all goes well.

Yeah, it may seem strange, but I think unless we start to have
projects not related much to our code base, like perhaps projects
related to our web sites or some infrastructure or the Git Rev News or
our docs, I think most projects should have a "Medium" difficulty. We
might want to use "High" sometimes if we want to discourage
contributors unless they have some special background related to the
specific topic (like multi-threading for example if we had related
projects).
