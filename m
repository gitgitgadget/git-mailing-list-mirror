Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A83A31F931
	for <git@vger.kernel.org>; Wed, 20 Nov 2024 18:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732126556; cv=none; b=Sos7bdEkiVhYvC8xV2OH8mJ/hqYBX5+QOX5DqcHY4XAKs3vdRhSJF8PCcciCGb6ePOtP4uAdEGMu7yde9SKwb6/2rH2E1V56r6IGt+lCU6RgivHdvK9nhYTykkRsn3rcEUfTrdytrz63FdTzIJEU5Hk9vy81pkPIAtHTbTZ3TIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732126556; c=relaxed/simple;
	bh=LTAvmPKH9rYmQMWILUtZMdruO7i1h6BmiG/Rns8kWEA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iX6ioR39lCFX59cXPJesanjN8vAjed1Iskgeg4v9HmaolxcfucpTOMKyUYvQQYDWvJCY+lEAeVeHkS8s8gvbAkGQCZHbcNA1eNKaDJJQdgSRtgsKb77UEt0M4rhnOTpZK3GgntqsQNV4cNVE3iSY1JqA7H7sfnNsFKRziKv7QCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SBsDYz8x; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SBsDYz8x"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a9f1d76dab1so11924966b.0
        for <git@vger.kernel.org>; Wed, 20 Nov 2024 10:15:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732126553; x=1732731353; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LTAvmPKH9rYmQMWILUtZMdruO7i1h6BmiG/Rns8kWEA=;
        b=SBsDYz8x3Qme0OdKo1karBNvQTyX7APctFRinCDBwW9vPWXJ5OoJoXGSuO9JsFfA0q
         jpT+uKB/Raeii6Xg/q4UIcW2BlH6iNEafmzVKtRTyS2dZCPNlubszPtzI/Gzj2McXrRN
         qCwuVD92uQZTfbLVM+a3dS9krvmQtWCdBWVHC2WhU3iEDPOb+MLybItgnZxPusXntHo2
         m1e8BhJ190DVIMMjRccPfHnbKzttjwFbmsbUcIh2FA9J1XCEklVuTl2pfbOLoi0FWff8
         Cd5O6z/J88LX6B1AoyuDqiM2ExnWb4uLzxgnkGpSmUf1bHinVmOMsr/xhsENI5VJi450
         iZKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732126553; x=1732731353;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LTAvmPKH9rYmQMWILUtZMdruO7i1h6BmiG/Rns8kWEA=;
        b=i1g+p//jHJnHWR0x5JExBOho6WMIT922W7wAEkc2PIMNy8Z0ujRq70DSk2l8kQfcjI
         8IoczXL1SDAiNBAgSHaVIpSCyygDYQhL/ScmFK0GQ+uuNM4OajrmBtYNpV+7o8k4/e/z
         3jBeIhs5iqpAqOfGg8tgcTgxpvjqO/My0X/OTgFpnhyLptauMwz4qdOZlhRdnQzIwzu8
         zXV9VKRqrmHFAvNnCaEcoyosjRQ0xGsYCgSv5H77um1e1yPt/3QtytxrL2AQPlr+U8CQ
         yzuSd+o2YzKQJG5zYTD/+4c1qQPqEtHYtWTGrzqybZfNaf0vxEIbE/i8LL+JNIfKbkRv
         4H3w==
X-Gm-Message-State: AOJu0Yy6lwSq08z0h6/pmYTOY9pJhFnao3ZmDDf5+bzYL2KCtglRKCpu
	Us2GqzzP4j0EOHQ9QveLTeoewekyXv0cA1KO4OMV1xuAmwPXKrza8PasNtzRQev2XbTb1nKgF4+
	hoCTafPvgKVA30lzHFFQ7FQqAa7DAJg==
X-Google-Smtp-Source: AGHT+IHHLSrlnZ6P14o8wd/qLM4D7O0da5Og6wWc6s9Lcnl6GIb3T/bkjau4CmxX2rU9CN25mKGKGbYlo8U2TOA6Bo8=
X-Received: by 2002:a17:907:9415:b0:a9a:1792:f05 with SMTP id
 a640c23a62f3a-aa4dd59f63emr392227166b.31.1732126552750; Wed, 20 Nov 2024
 10:15:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241119-374-refactor-midx-c-and-midx-write-c-to-not-depend-on-global-state-v2-0-e2f607174efc@gmail.com>
 <20241119-374-refactor-midx-c-and-midx-write-c-to-not-depend-on-global-state-v2-9-e2f607174efc@gmail.com>
In-Reply-To: <20241119-374-refactor-midx-c-and-midx-write-c-to-not-depend-on-global-state-v2-9-e2f607174efc@gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Wed, 20 Nov 2024 19:15:40 +0100
Message-ID: <CAP8UFD02a+ZfHo1L5qhbzD2r4bmhXadSj4sy0acPncnj4pcRpg@mail.gmail.com>
Subject: Re: [PATCH v2 09/10] midx: pass down `hash_algo` to `get_split_midx_filename_ext`
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, ps@pks.im, shejialuo@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 19, 2024 at 4:47=E2=80=AFPM Karthik Nayak <karthik.188@gmail.co=
m> wrote:
>
> Similar to the previous commit, pass down `hash_algo` to
> `get_split_midx_filename_ext` and use `hash_to_hex_algop`.

I think we prefer explanations in commit messages to be a bit more
self-contained, and not to rely much only on other commit messages, or
links to a mailing list thread on a mailing list archive, or other
external content. It's better to err on the side of copying more.
