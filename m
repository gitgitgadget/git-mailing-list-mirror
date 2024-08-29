Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50CE6335C0
	for <git@vger.kernel.org>; Thu, 29 Aug 2024 20:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724963276; cv=none; b=ezO/yH8lwoV5G7+pa9ydr2MVrR8OQk+pkzZXOrw03cjCe8/vzip3xQYeFLPklJTghDwWk6xwfi9V0YgCU5COgGbZG1xTXc5RXlmbzdC8RfLRc4a4MiDnPKsnDeTW/2rurko9q3ZbjHFa9X68Mb6I/OOK3UqO5ZELtfE0TpqFQdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724963276; c=relaxed/simple;
	bh=kpVIetFfo4jUW5bVFfuZ2Mg9bQBlE8Xb3Z+Q0DizcfI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sDNDUhBLewKZlPAFleHx6/nYRXBg981o1Eohit4UYOK5cIRrAnfcggDZbMrrUB9MGt3jCV9mf5I0clrkrJXg5CGzVuz8KhDgyvneJf39Q9Ko7NHMXHVJ1d62R15uAVNGLdgknJ7vGV/06ClPwEqvHk1I6oYFppml1WyKkDKe9Lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4568104962fso1397151cf.1
        for <git@vger.kernel.org>; Thu, 29 Aug 2024 13:27:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724963273; x=1725568073;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kpVIetFfo4jUW5bVFfuZ2Mg9bQBlE8Xb3Z+Q0DizcfI=;
        b=wEpaw6YnKvy+V55+F9+/uLUDOqU8X5FIHt1yFueXtos1R02YUwawHMk5A8I91z0/va
         eVeT+MBD7V3r08yfcuHYua/AjiyHXUrzrS0QYgxFX8B6SxePt3uqplC3MVJEwPi6Ieb2
         vHMwv5Rp48dScI3nvRbxse3kT6fI264H7MU6uWi/m7pOAY+QfAQMhAINqUoQRi1zS47N
         nz1mr7UVVmPDFQgw+ReHCfV84PlRfVpiTaQ8X04CYmR6vohvUmnP1PNoHRR0equNGrPv
         anM59tM6PkZHx7kyJt6c907IpFbn07CjGR6WcP88kzo26qZFUoS76DT5tuaL7khrayQN
         RnhQ==
X-Gm-Message-State: AOJu0YxxAYeOn6/ipqpPZeTHVyS6mBaV9Y64KoSP+K+AVFR3ZEVpQkNi
	P81nr/soUmb66y+vQC9kS5ZGEZfYsmPnl7yYR7rC2DuxHzGIpUTeMjDdU7Q/g3v3jRA5wgMWX4E
	095o4sDoA+Rc2njcjhXpZYRm+NdM=
X-Google-Smtp-Source: AGHT+IEXw/++Sj+8fVSX2Xq67p4sKj0HIQUDY95jNT6T6Iw3q/O68d6tuIxGnhqjz23Amx9VCCKXeBrFZ2anOILB73o=
X-Received: by 2002:a05:6214:4103:b0:6b4:fda5:88b6 with SMTP id
 6a1803df08f44-6c3495f9315mr384696d6.1.1724963272798; Thu, 29 Aug 2024
 13:27:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240829200807.GA430283@coredump.intra.peff.net> <20240829200953.GB432235@coredump.intra.peff.net>
In-Reply-To: <20240829200953.GB432235@coredump.intra.peff.net>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Thu, 29 Aug 2024 16:27:41 -0400
Message-ID: <CAPig+cS0fT6+j3nQx7rh7bTDoMCsEUUWK3_YnpuiJVo+bVZWBQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] grep: prefer UNUSED to MAYBE_UNUSED for pcre allocators
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 29, 2024 at 4:10=E2=80=AFPM Jeff King <peff@peff.net> wrote:
> We prove custom malloc/free callbacks for the pcre library to use. Those

s/prove/provide/

> take an extra "data" parameter, but we don't use it. Back when these
> were added in 513f2b0bbd (grep: make PCRE2 aware of custom allocator,
> 2019-10-16), we only had MAYBE_UNUSED. But these days we have UNUSED,
> which we should prefer, as it will let the compiler inform us if the
> code changes to actually use the parameters.
>
> I also moved the annotations to come after the variable name, which is
> how we typically spell it.
>
> Signed-off-by: Jeff King <peff@peff.net>
