Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BC8A344D8C
	for <git@vger.kernel.org>; Wed, 12 Aug 2026 07:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786520175; cv=pass; b=ZAnXsaS6jqEXSr/zArXJK4VgNIdihv1Zb4p/Iw0+vUbXn2p8boGrH8mrlsriftRLhqCLNhTjpKsH6JYxY9+CaHIvipQ+HYbWOs7Huyf+Ea5PdCDP1CeoiYBDY94Ao8KqR7dPP8AGGJ591vEiN8NXvsVPl0gkwYUBvsujsC8gVVI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786520175; c=relaxed/simple;
	bh=BRzUDxcOJyVFJC1AHhBGQfu5XV5u0TOJVmJsZiEZWDw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oiNKkcJCmtf5DHfheiw1QtdQbr/oUzpjMwmwjYQoabFrkCBlhDd4BH7FuPHByMzYNAk4GCiQvxZOSEccSpryEvUHkZEnxZ0zmyHIDK2rTk3t7xpwfkpjxm5gDGOhcIhmL8+RlYNPTJOT46WVZ/zl3bkLOiZcxXOH35fH0ZgRfmo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C5uc0vuc; arc=pass smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C5uc0vuc"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-ca00f126b7eso455491a12.2
        for <git@vger.kernel.org>; Wed, 12 Aug 2026 00:36:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786520172; cv=none;
        d=google.com; s=arc-20260327;
        b=IQxsTrxXa3auEI80RXBroDQ5OufCBCyeKMKr3UKRIM2ejdZvw1Lraa9kXr3VOjJycd
         etAYKQ0zkig1UdR06M9Vkwru9bQcQkSR0nIkrtZ8Xb46ZNBeIs0hWEEyrdX5WCs67XNz
         7wHQW+1z96dMFM4voJHkvQXc7sutwy9XLshgC8RTjFL+BYvScvCTlSdLSUxW5WUlyRjG
         svnYWXI1B1yAHlfV0GcudDkZ8Y1uXldGnCfU/BousSKXRUq5Hqfv3gWNJa0scM0C17uI
         DAzZwuznBVSJvi2cPwxB+UTou6H3YKN99DXRseaRGTB4NbC5Hgl+SHo1+79nqlA1y3iS
         wH7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=cMg9j73w2wMVPdTF19tVPa2pALCxiC08YXhv5TPaFb8=;
        fh=Bvu1LE3sV+nGF044MNVdm6apTttahoQkXWGXZ389HwA=;
        b=bjcywlLeKilvuvCJK7GJjwIIVs5qkf0FE/AZcBU4B+lsdb9E6yjiRHkuwih6jyS9xL
         9iIxaOJYXihcKYXaLy9pX0/Iu7o+jzTrzdk4ai7GXpksqq0NCHE45+nSf5LDsqF8jf2i
         S1oh4gdVbHh5bD2jTPylNlREzJdK87mX4qXI00dEN7RW8vDFKCpf+go5g/iM2e8Kx0EJ
         DK13p0V0LpA4TVozIxIRv/NHDMLrPDPcwTkKn10qsM8gEkRf4P6bBoAVVYG+9RgcuF8x
         P0PQoG2YCN3+nY0dkPOg7PrvVCePENN1i7hSsGfhd9yc+NlMRyLzh9IKOToYumsmWb1o
         mglg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786520172; x=1787124972; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cMg9j73w2wMVPdTF19tVPa2pALCxiC08YXhv5TPaFb8=;
        b=C5uc0vucKw9G5fiwmWz5JUNWwFGFg4Jddp0wAwmONfpdOGzxjiTNGYiJPorQpUewnK
         5VN6HzGnOdLe5I30U/vYOBLt8TGXagFLbywA4mHgcTVQK/Z43nO8aszIFYzQBjVv/cbq
         roL9ebE9up9lBEKT1neX/hl+Rki0jWOh1Rd9q8jRJUQWq8eAYBAoZfl6xLGcJkZ0Xitq
         p61ai0kcfCHTQF334J+ukQ04RGQs7vPXKTi6THhqP2cPd0tzLh+e9knHYd9yBGprD/QZ
         LQadteGmNaBu6JfPgzsaet9UiYj3psVL97JKRKBY5b5qKi7JQ9WYgSUh7/Zm+Egazh4y
         SVfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786520172; x=1787124972;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=cMg9j73w2wMVPdTF19tVPa2pALCxiC08YXhv5TPaFb8=;
        b=M/VPsoDeI7k2PgBaMOsSWhyt03RPtDzTw353CVj444X4xMwLokYQF8hEAOpAUp/xlU
         IAgQlw0BzqDmFJcPFQYXJkXqD2ycg/cRJfpt6LownnCLCBcxSDHB5h4TmspZLZkHKxHB
         UMZ8viJsjdxBGu8O+trQfJxdBtwFaB3eWttZajL9cvdy/XnvWRIpxTZ+JrebulV7mfEV
         NtwRsLKosc450QfbyEoJg7ixoFkEPsPRztOr3n4kiXPSxDZriZOBMIY8SqF10y6S82Vd
         Rw6Y1RaO0+gykuYHlDxvhReYvcWXaAEBH6yFJK/7EZ4jcA/7KM+pPE2n7YUQe/l7sIk3
         p8FA==
X-Gm-Message-State: AOJu0YxYxhRk/XrM+4yEDdxdes4jXpQ1SmgPtcTJJYsLpmGw8XDcAoZk
	06YEog3w8FT7sTXumFWCLxhta59DhAoiXialVQU6PGxXZhK6EbOfGaENlxWmBjV8z2WLPLhj6J4
	hwVZ2Rfk22hiKa9avgioBX1Z8/hTHJXZFxbWAogI=
X-Gm-Gg: AR+sD10tPZhPhMI0kCFnZF/fAulW97Qz1+7ZcXJ/FadcgQk08LHKkx1y+cMj7GZG8rQ
	j471nhKoWLuUT1NfHeYWm6GapzmKc/KFUIqsWAJBxEMzRm6VwBHjPW3GUfdZVaPq09JeC2ru5Xs
	x/1jjQ1Divj04Niy/P9MXT5X1e4C8KU+WTGZsA9N9G9DIOYgqhqpZBQ4qFNJ+UZDX3+r/UgTrI/
	mwxIsmkSFPUQSRgEXY6c8FGQWYPjCHPIgm5njawNOiJAlcD0HiCf3DFN/j0Hj01GtbC8WPaBW+k
	cm+IMNTd5AVw4BIrB5g8eie/eTDVjEpObcmJ2Sg405538eQbyPn178iiYZ801QTkJ57zFIyCkHe
	Rs/mrzhr0jkUQVGjE7JnVjrketWtlOU8l
X-Received: by 2002:a05:6a00:950f:b0:842:2419:6c0b with SMTP id
 d2e1a72fcca58-84fb541540amr3328108b3a.10.1786520172327; Wed, 12 Aug 2026
 00:36:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260806112202.75067-1-r.siddharth.shrimali@gmail.com>
 <20260810174047.6524-1-r.siddharth.shrimali@gmail.com> <xmqq7blw35su.fsf@gitster.g>
In-Reply-To: <xmqq7blw35su.fsf@gitster.g>
From: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>
Date: Wed, 12 Aug 2026 13:05:34 +0530
X-Gm-Features: AUfX_mwM49JRp4SJR2BgXI5DczLgBaaTfsdgXGdc_WrYZTthk0gipfBF_Gzl8aU
Message-ID: <CAGWgyh84QuzUxtCX1Z73uZT9RfamthfyuHYgvd8gX3MYGOm7Fg@mail.gmail.com>
Subject: Re: [GSoC PATCH v4 0/7] repack: add --drop-filtered to reclaim space
 in partial clones
To: Junio C Hamano <gitster@pobox.com>, christian.couder@gmail.com, 
	siddharthasthana31@gmail.com
Cc: git@vger.kernel.org, ttaylorr@openai.com, ps@pks.im, 
	johannes.schindelin@gmx.de, l.s.r@web.de
Content-Type: text/plain; charset="UTF-8"

Hi Junio, thanks for the review!
On Tue, 11 Aug 2026 at 23:20, Junio C Hamano <gitster@pobox.com> wrote:
> Are these "planned for longer term, material for separate sets of
> patches to come on top, after this series graduates"?  Or do you
> mean "v5 and later rounds need to do these three things before the
> series can be called complete"?

All of these are follow-up work meant to come on top, after this series
graduates, not prerequisites for it:

1. remote verification depends on the "remote-object-info" cat-file
   protocol command, which has landed recently, so a follow-up series
   can build the remote-side verification on top of it with the other
   future additions. This series deliberately uses the local promisor
   check

2. recency is an additional selection criterion. The feature is
   complete and useful with size alone, and recency can be layered on
   later without changing the design

3. the drop log was intentionally dropped from this series and will
   return together with the error-path change that actually reads it

so I consider the core --drop-filtered functionality complete as scoped
here, with the above three as separate future series.

Thanks,
Siddharth Shrimali
