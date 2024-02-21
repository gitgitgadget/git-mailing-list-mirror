Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB693A28E
	for <git@vger.kernel.org>; Wed, 21 Feb 2024 08:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708505008; cv=none; b=FUuEiUtuKMJ9zktyKPUAHpGzT1TYl1a7t2FLovvmr2k92cUpTSvcRVAojH1pmaXKCTYk042U9y4iCpgxyedNHYYYwffkLnPkHkcqbR6u1yuQmb15lZZgAwIwoLFqWAAFnGohxQ0t/SAwBm0GMj/Gcy0TyS5Vt0S43d4ybDvdjsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708505008; c=relaxed/simple;
	bh=eeu9r3wkeZ69eSpp+3heNxXyxiiSGwPCuGU5y92iyrI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fZKZVZroW3RIPkopSoW0wNaSNIPDgKd/7KBxyRMH6tw9HsQfzKu+mO2Wr3nIXWltZi8G4cd0F4xB4vXYjxOXnWi0kaFnnzcTW+X85RiPeJ7SuSSe6tJntwTOMy5e6Q+sECFco110ln+ohdnYJi/DIePe5q2hGY8ohsLObS8rTTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hb4JkRzg; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hb4JkRzg"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a3ee69976c9so289715466b.0
        for <git@vger.kernel.org>; Wed, 21 Feb 2024 00:43:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708505005; x=1709109805; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eeu9r3wkeZ69eSpp+3heNxXyxiiSGwPCuGU5y92iyrI=;
        b=hb4JkRzgC4UF2XGhabCF4JceETrcXdAJEb+21u1eDNQTlohYNhyXSx5rZ7g23gWSN2
         K39YNaegfWRnSvI+X1SK7t+IriZQKVyq36wSyBgQHaiaovUdlJhGBTmvJabfECIMkNEW
         D+vLz6VsMavP0fMM9YWgZPnQSXs59f6FqW5s8wzcfDImtj/2oYNZcjdGAwbgUW1TCJRR
         vRFuQ7ymtB0HEyE60FO+4/DVLeF1TvwVDU/bR3zwxKwcK/xLcAoiJYErKKdI+hwHTU1H
         TKkwayO2p3ylI1PMYgiN70gKMOZggbwJpMNoZGJ06CER7w1L81oQf89ul4Xwfd9IEbV2
         n8kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708505005; x=1709109805;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eeu9r3wkeZ69eSpp+3heNxXyxiiSGwPCuGU5y92iyrI=;
        b=H9gUpnHiiEPNGJ9v1DQd9WPo+S+rVFmqn1KymeeLnCeO82RBJza0bpkFvuPTw5/tv1
         T3RmkHEErtWWGRgN2isdoZT+QoOSKXjzsfxKiZ2Q7eT0NxfdKdRjUQGgoTP0CVZEZMrz
         /Q5rvbsMJUYwVhPVtzixbxthxV5yWdjkzehRjqrY4yFRCGG7zYC4CtgsCJOmmkG7mHXt
         rpHc/y1ikjzP1w94A3Z/LeAZTW1TnWdNVHCGv2esud3PSA6FgVhd/S4iUj484mvEQtBL
         jmFeU6BQbUNVTTy2Hl0KTnC4XRJIgFKa+x8R2deoaY2VN4k7eNtAWgHHMXUDbF/X0+za
         n5Bw==
X-Forwarded-Encrypted: i=1; AJvYcCUpAXSJPBW2Jx0AvXkGbnBDuR56D5JNv0yrTwb0VzTvzx5ST/BbLWx3vk79HKKEZ8rvEc0JBHnsfA1xGwvlw5HUjap/
X-Gm-Message-State: AOJu0Yx6uI27jhyzCfBpyBk2TNPIgBYY2FPyxNkEuozGqiPCKS7Xpg+y
	3syfgn7TBr47jeMpmuqJnpofJ0fDV03mygmpX7uiHuUrNBPRNsfLmKZqL18dpsiFnVda5xAG0RA
	msjsNRE0ZHhA3MxeoBC0vlU2ZH/4=
X-Google-Smtp-Source: AGHT+IEmUPkPzl2jrCWQsZYQDX62vxI4LE6svacVxd41mprk4LcYrOsOxLS2My0Is6oLraftVeRm/mCFOeNIsS4PAto=
X-Received: by 2002:a17:906:f1c6:b0:a3e:5ffa:d564 with SMTP id
 gx6-20020a170906f1c600b00a3e5ffad564mr6563889ejb.8.1708505004324; Wed, 21 Feb
 2024 00:43:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1de82b27-116a-450e-98c0-52eb65a8f608@gmail.com>
 <CAP8UFD1VAvnkM6afZvtpdXhA4csDBDwMnF9yUzSx_ut-Ypf+eA@mail.gmail.com>
 <Zbi8pfvGpYrlZXAu@tanuki> <ZbpGzAd6FGEeTdrh@tanuki> <c61322de-8cd9-42b8-a04b-a8ae47b25c5e@gmail.com>
 <Zbtmoo8qTmj-yt99@tanuki> <d4797f27-825b-4e2b-85a6-cc30f33934e3@gmail.com>
 <CAP8UFD3GBT7s1jGOc=fe6XdYGF1c--tMBDiy_sDg1Afsa=drDw@mail.gmail.com>
 <26cf6320-7ead-4ca0-b4b8-ca7008cae401@gmail.com> <CA+ARAtqicQkhKFcTxoT+GWMhCxnV-BNqd0oOcn2YwznfFnnRPw@mail.gmail.com>
In-Reply-To: <CA+ARAtqicQkhKFcTxoT+GWMhCxnV-BNqd0oOcn2YwznfFnnRPw@mail.gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Wed, 21 Feb 2024 09:43:12 +0100
Message-ID: <CAP8UFD3fmgcdN-zFVxmMu7mTBdrY=NPSdskj-18aHhpjNmpx_g@mail.gmail.com>
Subject: Re: Git in GSoC 2024
To: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>, git <git@vger.kernel.org>, 
	Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>, Victoria Dye <vdye@github.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Kaartic,

On Wed, Feb 21, 2024 at 6:02=E2=80=AFAM Kaartic Sivaraam
<kaartic.sivaraam@gmail.com> wrote:

> Christian, could you do the following so that I could add you as an Org
> Admin for the 2024 program?

Yeah, sure.

> "Visit https://g.co/gsoc site, click on the 2024 bar which will display
> the 2024 Program Rules and Org Member agreement, read and agree to the
> same."

Done. My status is now "Accepted", but yeah I think you need to add me
to the GSoC 2024 program now.

> For mentors, as Patrick and Karthik are new to the program, we need to
> invite them first and only after they've accepted the invitation can we
> add them to the program.

Thanks for inviting them!
