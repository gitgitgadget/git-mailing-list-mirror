Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAEF3146A9F
	for <git@vger.kernel.org>; Mon, 13 May 2024 14:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715610607; cv=none; b=nTcApHwFQvO3Sed8T0CERrHF8XC4h+768vqrqHOLFWJlozzQYpZT2oMN7XqpXIrwBWkWOgWODGwQm5RrFfw0yFXji+HwLzIxTiIA5FHIMfabaxyC57PmjML3Plg2SwVAlcVjfLrMr6jYgDBIVeU7S1z1fvOnpwI2hFtXhT0gFqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715610607; c=relaxed/simple;
	bh=RbZ0a1N7pRdVHJnwYeJKgs3UYYfIbOpP5uxe99PbLTo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bmPwtJ6jhb6lULA4KwcLEP0aoYWBZiaWzwPCeQYTA/fdlVMMDtaobOWK6L8h5zg3vSEVAvSbSUxvQ0DFESfdGNZrhf+Y2C4sPVTz2dv6nPdkekyPdSN/aacaI8C2AYgYsItG30j2ckVA7MNYCNq6f0U5Q4dNXnwbRYmE8uDB85A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gree.net; spf=pass smtp.mailfrom=gree.net; dkim=pass (2048-bit key) header.d=gree-net.20230601.gappssmtp.com header.i=@gree-net.20230601.gappssmtp.com header.b=PnVLzxGw; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gree.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gree.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gree-net.20230601.gappssmtp.com header.i=@gree-net.20230601.gappssmtp.com header.b="PnVLzxGw"
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-ddda842c399so4411731276.3
        for <git@vger.kernel.org>; Mon, 13 May 2024 07:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gree-net.20230601.gappssmtp.com; s=20230601; t=1715610604; x=1716215404; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RbZ0a1N7pRdVHJnwYeJKgs3UYYfIbOpP5uxe99PbLTo=;
        b=PnVLzxGwzVhrjPh+odovRqbtKlDXdquQuZymmm/9LPj5hD/ekts0CH7Lb7cWz+baFr
         OS8twcLzmV+tbG/UZLW+7TMRxRQGSWhI9OEb56SP+dKnJ44vimrYda/vvYeAMcL0yPOR
         ffPeprDcZmJYON5wGn06d4oyC7RsZBvYxQwLbw2gXr61e6ruT2/XuoX5K9AXcR3aukey
         0Ml/qcWvzg0WTDJJLIktNJoVuV7OKXGtbTKfMzOTPBXybf6hhNwXkkWXu9VgOM0cjGOz
         wVTr63MiXJwl/SIc3jHuQ+OfS5Gsb8T3jMedDuG/psr08wOZ+ejh++ZfRBJY8upjYh9o
         jEqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715610604; x=1716215404;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RbZ0a1N7pRdVHJnwYeJKgs3UYYfIbOpP5uxe99PbLTo=;
        b=TUvRP4Ev7v/w8cGhhkKwKzoVxhb3am4361wZWOwP+fyauYZ4KhIcuuyBqRSNzJXbt0
         MUFrYmBVwEzikOPxzP5fyks7KsLuhcvtFy7BoodLezcfhVdz1Ln3mX6dka5/Y6zgjlr8
         9kofbc5v1n02Udw0dAidF13I3Y1gGXIiu1LLRxZelqdd+0Z1dNQQ1YzT7UIQPmD3glkz
         m3tneFz0Vo77vDv68Z6QkwFpWVlFI/LXEJh8H+4P6Xie070czUTX4eDEhM5a7RIgnRs2
         8PFmhopwj7ddMCKSr5TbH1WYQMdD3BWcKEEv7Ng0GnZw9kRLcKCU8wuyfsw6WikJJVLB
         yLfw==
X-Forwarded-Encrypted: i=1; AJvYcCX7JX0cwahc51WH1TNFxb6jvP5HlSES9c8OlrrCJ5U3WYGyQpscYuJ6bqLvk12O5WUW4aKJTDRRlZD88+d/NdAxr43a
X-Gm-Message-State: AOJu0YyNLJMTmyr+p4NgIsRRXLG3HwOPnr32SNGVe2imJ3luM/OmfQpi
	wGw5BVtjyLbASfLO/R0D5UwH+E+L4EMjtj1AbVb1DjYw32sdZy2QkoYlfBlJnO0mCQNXw1hKNn1
	Y6Adyd01tjaDvO8/N3X66yBl0yB91E331c2ZAXYY36ES/B0HURaXQvROR88HdnTrZW55EhU56n1
	tCLUCmrYEwHjDzeutF/TWSpCT+UZStREewALOHJJRH+r2/xd634l1g9by1Yj1PPUoED8eDObLqt
	mBLogNEPZ8DtUz0s7Iw1ox/H42Ml0Qpme1BvWpOxGsoi8juxGdH38oPJ4IJOut+Os/zClPAriwP
	D2F8GnK4IP4=
X-Google-Smtp-Source: AGHT+IHVl2erQKYpiSzCzlWJCBoTGz/5V4VXnP13JHBcGuMHkip5XNTdUb/t1R7DACWKcC9hRM9rTpt4nJyJdh9dShU=
X-Received: by 2002:a25:be82:0:b0:de6:669:e66a with SMTP id
 3f1490d57ef6-dee4f359e83mr10996716276.27.1715610603619; Mon, 13 May 2024
 07:30:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKkAvazeFvCfT7tZm3emwA=k-NnzPD7X0v4t2E9Ja4r-GpZfoQ@mail.gmail.com>
 <20240510221323.GA1971112@coredump.intra.peff.net> <CAKkAvaxFbcLZNdz5cdAF8ZFNtVT1qQYKWcmkniQ3Uzu8mdEt5w@mail.gmail.com>
In-Reply-To: <CAKkAvaxFbcLZNdz5cdAF8ZFNtVT1qQYKWcmkniQ3Uzu8mdEt5w@mail.gmail.com>
From: Koji Nakamaru <koji.nakamaru@gree.net>
Date: Mon, 13 May 2024 23:29:52 +0900
Message-ID: <CAOTNsDzLAW_2C2vk4y+=GRvsHKZ_C+rEtorFAuoZaDu+jhQhdg@mail.gmail.com>
Subject: Re: Error: failed to store: -25299
To: ryenus <ryenus@gmail.com>
Cc: Bo Anderson <mail@boanderson.me>, Jeff King <peff@peff.net>, 
	"brian m. carlson" <sandals@crustytoothpaste.net>, Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

The patch fixed error handling. This is the direct reason for the error.

cf. https://github.com/git/git/commit/9abe31f5f161be4d69118bdfae00103cd6efa510#diff-9dc7db77a1c795b4849ac77ac8d618a75c85ff3b2128501ffa647c43df200d60R308-R314


Koji Nakamaru
