Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB36618A6AA
	for <git@vger.kernel.org>; Tue, 30 Jul 2024 21:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722375010; cv=none; b=A1ZF1e4l67womTfv1upjSEcb9wLu5oDT/aWYEm5TuWWNaDqs2+0Ckg/jH8PnYNahc7OvLGbuVcvNweZdmAXJM9GiL7A4BeXrm5Qngzu077yEWw4WR8TItWAwebAp/bnCCkH5jOtIXGjYiElRxwUKP9nPLFcreEI3MpuInnoA4+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722375010; c=relaxed/simple;
	bh=INa8yQE+sjSG6gwN+2oNMtpZcS32209x48eyvH1rdvI=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=n84+7bMDfn8aigzGxEBg0Ffa8PIBSLjLjURzyiyXuTAl2KTn0Z2nABADe7G/BCKfp5AgLFYbnGZRtiNayXvaOoYJ5VYinQtNpNGhqbkWsTHdmAl14YH9O8jMGSzVGA9U3K2P3Fuw7Eyvm5dibNgy5xMrxb2mDT+sHgiskhE8bLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U6KyuIpi; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U6KyuIpi"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a7ad02501c3so628455566b.2
        for <git@vger.kernel.org>; Tue, 30 Jul 2024 14:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722375007; x=1722979807; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rp/WsCcZJRoLcDetlaXjgcr3LT+L2rdQiyRkYo9BaX4=;
        b=U6KyuIpin3rKwX25BoBeKML+wxCqS4FzNJqq/cuPOB5bvnzmfg9VEEX+elcgJVzsPl
         4ZQ28I7dALXUFku8a4V8O1JYTEFhSgBVf3CZyRkoeekQocrsEVWL/twiSh2RZ6iQzU6w
         ROVAZDc1SUq61elatDQWwnCQk2Q7+DeGE+iPCzmwZJPeZQFILM2oQr2JAPc+vrpCqENL
         cUrDbKeY7E6KYbeW67QJ0FXBi4KouNAYBDu2Mv7chKeTpdLHPXRN+96UEJ4ttIVJh5/f
         CBrp6TyqqqD6r7THcwrNRife2TQfGoY0k1kqxBZJdh1CzkIsQWUmpOkhyEEi1GdJMgqL
         VaQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722375007; x=1722979807;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rp/WsCcZJRoLcDetlaXjgcr3LT+L2rdQiyRkYo9BaX4=;
        b=Nq6Vczqaofyi3Jo1zhILwr8ZA9VMrhBjaxbBHUkemEUyfrbAhWEu1QbUw2R1dqiyg5
         RuRDmWX5mc15oVqd0pZ6kOxaGu4oA2DlSTOm9Ec6dP/LWE0Uwf1iP9iXSVOpwLdPmkpi
         XEOgojPmeTQm+r0eECp3WACjo1m74v+ZE3CBa5wmY9RF7uu19RGOQE/wBimDtrpst/jL
         ZYhzswhUSJDdWO22yPMzM2TE+29TS4MDqXy3lugqf059bdVk9uPaYXtq5ptxrFPGZS4C
         F1Iq6CbYEvgyk8gIj6OlCZV2cMVqzlJ65mOn/8SFpSzMR85tr419hM7l+2YdAEjqoqyo
         WYsw==
X-Gm-Message-State: AOJu0YyJMRbIUJRiXychb1os89LgutPPyps1YcyZAAt63KliysbCT9eN
	XcLbdK0bo0Xz2PVbc1VZuPz9zJWTf5QBGaOQWau+6mx60elM4i2W3nEaEvPXaaPdLCKPachPtoC
	Rh7HtNa+zncHVVKwLWBWNUP0rutXorqgs
X-Google-Smtp-Source: AGHT+IE3VfHBIlHPj7TUr4riYXVhSuE3v+U9umqX2h/TkXx2kQBS6upv6LEivUvkWQl+UXf1MVoIc6zEMjrDCFkyqs8=
X-Received: by 2002:a17:907:728e:b0:a7a:bece:621d with SMTP id
 a640c23a62f3a-a7d3fdb8136mr1055922666b.3.1722375006323; Tue, 30 Jul 2024
 14:30:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Christian Couder <christian.couder@gmail.com>
Date: Tue, 30 Jul 2024 23:29:53 +0200
Message-ID: <CAP8UFD1r8mSNsHbUsxkc3pdAOhM3AddFYoUMaNCMFSgq2y0u7A@mail.gmail.com>
Subject: Draft of Git Rev News edition 113
To: git <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jakub Narebski <jnareb@gmail.com>, 
	Markus Jansen <mja@jansen-preisler.de>, Kaartic Sivaraam <kaartic.sivaraam@gmail.com>, 
	=?UTF-8?B?xaB0xJtww6FuIE7Em21lYw==?= <stepnem@gmail.com>, 
	Taylor Blau <me@ttaylorr.com>, Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>, 
	Patrick Steinhardt <ps@pks.im>, Yuri <yuri@rawbw.com>, Jeff King <peff@peff.net>, 
	"Randall S. Becker" <rsbecker@nexbridge.com>, Chris Torek <chris.torek@gmail.com>, 
	Gabor Gombas <gombasg@digikabel.hu>, =?UTF-8?B?UnViw6luIEp1c3Rv?= <rjusto@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Hi everyone,

A draft of a new Git Rev News edition is available here:

  https://github.com/git/git.github.io/blob/master/rev_news/drafts/edition-113.md

Everyone is welcome to contribute in any section either by editing the
above page on GitHub and sending a pull request, or by commenting on
this GitHub issue:

  https://github.com/git/git.github.io/issues/721

You can also reply to this email.

In general all kinds of contributions, for example proofreading,
suggestions for articles or links, help on the issues in GitHub,
volunteering for being interviewed and so on, are very much
appreciated.

I tried to Cc everyone who appears in this edition, but maybe I missed
some people, sorry about that.

Jakub, Markus, Kaartic and I plan to publish this edition on
Thursday August 1st, 2024.

Thanks,
Christian.
