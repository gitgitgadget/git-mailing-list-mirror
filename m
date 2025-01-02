Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABECB184E
	for <git@vger.kernel.org>; Thu,  2 Jan 2025 02:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735785677; cv=none; b=KRwQqnsnxOlExeW8iabzMX4+SyOvlWzO1yEyZkQFul1akhAJPvtTVpDw72xKQ1r7qvZcL/fUOy4cSlCFTCIoiMzCwUXtGgxi8iO5KVc2la/7C+8gZPZ5S4ck+ljPo+yCXKp8RalEmpiJm0Q6AWkwk7Rt+rRrVKt18CwqEfRKS/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735785677; c=relaxed/simple;
	bh=OvdFD7Ybl5O/AXeYXsuFVG7NY+20CxGddID9ypqVEFw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dYeWMtevJBSmVPTYsJqfQ20aNBkjqiuZmooSBQPCA/HekMXbbAuXgplb3lKn+F0BmarfcPoyyr6fwYKrfpR4rFWqw+jA0Xr1U+AvarmDlCGMBSfzR/tsW5BMdTfKVVhcbeL6iLga4oRWsOXj5BkDlsXSjJSEXvf/Y9UOjEAnHtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jM0wm2uE; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jM0wm2uE"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-53ff1f7caaeso12281670e87.0
        for <git@vger.kernel.org>; Wed, 01 Jan 2025 18:41:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735785673; x=1736390473; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OvdFD7Ybl5O/AXeYXsuFVG7NY+20CxGddID9ypqVEFw=;
        b=jM0wm2uEvxouUMq9RN4mRmBxEYdzRzNpAVzRJibK6jKFGQAdwos7TCHRFd0WzEdi6e
         Hoqz0+efJh6RFB0V+1Cppfo5P5mPEAhpBa+okOnCpGrJ4ItNKH1BhAR8OYb8dmtwqNZo
         W3VC/xNU2oNdjbE+oxrQfWcjyQKN4p7cWqCCqP1Na5TxdH6fiYkD8gEoEhXuKp587e0J
         xcNSc932RslWHw7xkr9BBlaB+qKCcgb6JBwnU5eL3OYZZkmEPZULfEo/NnrI4Sy51UjG
         fFC5D9OLiu1r5qy++K3XXeYbPQcFM1nR05Kbyl2dYULUOeYVekl94T0wpEITL1sG82ck
         WJDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735785673; x=1736390473;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OvdFD7Ybl5O/AXeYXsuFVG7NY+20CxGddID9ypqVEFw=;
        b=Y5d8ZvtPCiZJbiD3D/bfD5NImvSkY58MBswmZ7Y38K5998ZSOOZSFtzwNCRPDhYKl/
         qpmUYtjyn63FhoL8TvSOrl/yDKtHDAxeONGMxvVIs15/xsvpg3SiuMqid2ddRZh9Qth/
         +jgkVF2C87riHbGbIFJLufAIkBWLAqwq8kyuoWfAPUdi+4udM5TTXfv0AqD7ijJ2nAbw
         d6Gog9BM4AKbJ+zxBdlJp1GU0NcWBPtRZfn8kWKtdB7zDlhhR52c+zhlAnbZnv/o6Y+6
         VruAcmhGUxaDOWZz77M5gmGoPc50YmP3hRxxtDcXYM6GuGNtSrTMP4BRE9+B5W+zp9gf
         QzWg==
X-Forwarded-Encrypted: i=1; AJvYcCXJl30dfrYuXEX5XjQQGlKc+Xq3C4XwuzqL7kTaaM9Gohd3tzfNhVaZuGnfFR9+zThaEYY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIFfuxLHAnzU2rmTKSoedTm1IsNrOxPKzB6DCUMobvTeB6tQfw
	pcH8BcHKMgNYb13unrvPLlNdC0BbV2tz6np2kNtg/wbZDrxDQnztqo48S1n+v4ABgBIphYFN9DU
	mc8GpPVZ+7d/Py2/OliHksoA/meA=
X-Gm-Gg: ASbGncsqohmiIZkPvdtBMwCwQKwxdyxcWPu7OY+sBsZLkaPZ0X9JwWyDFVeVZQA69bM
	nAwAiqnaR49JBItLdrKyyxJVpH3NrbWA0RH3Hino=
X-Google-Smtp-Source: AGHT+IFiN7o/EYxnzS4rVtnXHZt9AxX6RZjlJwdXiIN5yNtxR7qg1ftueMcKj9+OVFUWA5O5nx6aUwO4dL/qEyQk/rU=
X-Received: by 2002:a05:6512:6cc:b0:540:1d37:e79 with SMTP id
 2adb3069b0e04-5422953adcdmr11950079e87.27.1735785673287; Wed, 01 Jan 2025
 18:41:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <xmqqpll9xehr.fsf@gitster.g> <20250101191422.GC1391912@coredump.intra.peff.net>
 <xmqqa5cavz8h.fsf@gitster.g> <20250102023224.GA3853144@coredump.intra.peff.net>
In-Reply-To: <20250102023224.GA3853144@coredump.intra.peff.net>
From: Chris Torek <chris.torek@gmail.com>
Date: Wed, 1 Jan 2025 18:41:01 -0800
Message-ID: <CAPx1GveQPRop_qJgAQxq+6-2ZsXX6x89sTyTtYFvbMfET09z+g@mail.gmail.com>
Subject: Re: a less-invasive racy-leak fix, was Re: What's cooking in git.git
 (Dec 2024, #11; Mon, 30)
To: Jeff King <peff@peff.net>
Cc: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 1, 2025 at 6:32=E2=80=AFPM Jeff King <peff@peff.net> wrote:
> I wonder if revert should have a "squash" mode that reverts all of the
> commits (perhaps in reverse order of application in case they depend on
> each other textually), and then gives you a commit message template
> similar to git-fmt-merge-msg, where we list all of the commits, one per
> line (though probably with their commit ids in this case).

I have kind of wanted this in the past, but never enough to build it, I jus=
t
did a few separate reverts.

Chris
