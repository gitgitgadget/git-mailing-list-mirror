Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 729901BCA0E
	for <git@vger.kernel.org>; Tue, 21 Jan 2025 13:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737467048; cv=none; b=UNx/KevBu15b77hboV4kqps4Ke3fHsm9AQ/HpJ7IUv3G23kDwCUR4US5ajSwYpp1+UNFSzrboTzCXj1GQe04wa99ddSZGanfTLtX3ji/cu0gHXYCdCf93KV6kUNMhcOafpEfv/fojf/pX4e+bcUAFg9tX6eNpHygMm6WOyckReQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737467048; c=relaxed/simple;
	bh=0l0AedE6aJMNzqSgeYbtjUIAqC5EuD7SJqLRjroSmvQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y5abl40ybiRMxITwKeiRQEe+MTxmusxA4h36FdP/T+Gc+O3G1SNpAgbDm6d0UJR8u+mi61jRROw/FBU7EpJ7NHu4r6yDiXZ5/vQoZemjd8kDnVTAFJpjReNyQULW+EeywE8nqKknYvqjKGRas6HBaL7y6/kLnJgxhveOlaBqCe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y1EfKnLU; arc=none smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y1EfKnLU"
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-51889930cb1so1603946e0c.0
        for <git@vger.kernel.org>; Tue, 21 Jan 2025 05:44:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737467046; x=1738071846; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aCLjelJvuVcAAEPvXFUxgpecsjZ2nbvxxvC9nFN1ozM=;
        b=Y1EfKnLUTO5wYhOyKFEzMtfKLukhz19kkXcG6wEu750nlPDFw52JzKVcr06vIvNhq0
         2OK5X7zi8JLqv5Fd4tGWOJD2+m00SYj/SnqdgKoNkGxxPrtlueeMIC4409vUV59005+x
         7p5MipP3RX1mIvg1HOVl33A85L+Y6oT4oFWgwocdmuQ3afVKyeImi+YGlvkyHCKTP4Dw
         CeL68gAtvorKYf2E4aECLzC/2ijrjpRxrHlfVDVjguvCfq2jcz0IBPq6kJfPe3q9s59y
         /iE/lmTIJIVw4dFC5yAmahrQ8MVz3jMez7NwxIbTnVeOjzAHlFm1sIA1kynCHfYaoDYV
         hA4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737467046; x=1738071846;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aCLjelJvuVcAAEPvXFUxgpecsjZ2nbvxxvC9nFN1ozM=;
        b=NuG/KCJ1cbAgiMaC2vhCKTh7WV+aAvWssXWa2tIvmFzmMNvd7WIOfQGlePdHCATGEF
         VgoH2uw7hyYX2dmIjECT46cH0HCMdtjQwyA++qh3MIsxqrwy0KfaBTmEHSrU7sKm9dnj
         31k0w8A9X0WIaOLSVoWSyRxT680b/NV9mwNQCiWp7EO7oDSrq1e6u9IVcAlERd98naxZ
         CFuvGk4ZYfD+dlpB8eP8m300vuN7+PU6Pm5V9FShoOMBkVQEKZtxnGnQZEzDd+vYz5pp
         sPqgXDyJBaLLjd/Zf8f6THMtEOGuS+sUZpxSSfE5Ug8QUfFmlq7V6JSMJsVvrSyTxYRe
         Wg0w==
X-Gm-Message-State: AOJu0Ywj5EOJ1s7AHyNpQHJx66/REjCW3tZdLwGQEOf/riVY4OVDjPKF
	aKwqaUlgEZKdKSpPY/udq32KMA5sBLgKvaVwvfy6ysjw8D9sFZdlcjFD3XxJs8YX322MGzV41fP
	WX0a5Ddl2dC1MPflFAxovpbFp5UI=
X-Gm-Gg: ASbGncs0R8U78ukMilZBYGoB1lveFMFQH/Ei9gZwlcUgqF0UDjcjFMnNJk5vTcoSEO2
	KciYordzuTjFXDj2f02VxcxwiVQ1xU6FqrB7ts/mClDihGg2+JuM=
X-Google-Smtp-Source: AGHT+IGSVwp+Ct2iTFc5LBbEpUrOHDqDSBjS3nL82zBlUg4lYZMu5d6zLnPD6wZgP/DC7Mx/qN/RW5TCzAjGTFaYeQg=
X-Received: by 2002:a05:6122:d1b:b0:515:ed1b:e6dd with SMTP id
 71dfb90a1353d-51d4c656390mr11920290e0c.0.1737467046065; Tue, 21 Jan 2025
 05:44:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250106103713.1452035-1-usmanakinyemi202@gmail.com>
 <20250117104639.65608-1-usmanakinyemi202@gmail.com> <20250117104639.65608-5-usmanakinyemi202@gmail.com>
 <xmqq4j1xkzir.fsf@gitster.g> <CAPSxiM9qRQ2HuTJDmhq_xeCRmn+yUvjXokwEwJE0S4av9Y-TKg@mail.gmail.com>
 <xmqqy0z52rg4.fsf@gitster.g>
In-Reply-To: <xmqqy0z52rg4.fsf@gitster.g>
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
Date: Tue, 21 Jan 2025 19:13:54 +0530
X-Gm-Features: AbW1kvakVQo3VQv3poTmrZPBmVpHK2HXtSz9Qc5xAOsUjCcZdM5Mlo7uD4Q4ako
Message-ID: <CAPSxiM90EGU+eYN9KTpOXX4nK3Rhu605CCQd+-TzYK51svHStg@mail.gmail.com>
Subject: Re: [PATCH v2 4/6] t5701: add setup test to remove side-effect dependency
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com, ps@pks.im, 
	johncai86@gmail.com, Johannes.Schindelin@gmx.de, me@ttaylorr.com, 
	phillip.wood@dunelm.org.uk, sunshine@sunshineco.com, rsbecker@nexbridge.com, 
	Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 21, 2025 at 1:22=E2=80=AFAM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Usman Akinyemi <usmanakinyemi202@gmail.com> writes:
>
> > Yeah, that is true, I could not notice this as the next commit of the
> > patch series
> > was able to fix it. I will change it to "echo", with this, it will be b=
etter.
>
> If we want to prepare ourselves against any arbitrary garbage the
> builder may throw at us, using printf with _fixed_ format and feed
> the potentially arbitrary garbage as its parameter to be
> interpolated is the safest approach, so writing it as
>
>     printf "agent=3Dgit/%s\n" "$(git version | cut ...)"
>
> would signal the readers that whoever wrote it knew what they were
> doing and was being extra careful.
>
> THanks.
Yeah, I will add this in the next iteration.
Thanks.
