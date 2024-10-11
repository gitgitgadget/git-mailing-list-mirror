Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C3EF215F55
	for <git@vger.kernel.org>; Fri, 11 Oct 2024 12:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728648782; cv=none; b=WqoLStqQVJgQngHazVd4pnSZdO/1ir8WdrMigFkJ/T9F5+m7IyKlGX236qzEo0TYKGR7FHDDD8vcu92r2RBQOx1ZUyC/L0BxnVgFyAULnIWOIcjvobNrES6UNRNUgiPwQs4p5MqJHtwy1fryy9znYncRSAkagF04VBFV4BDhaMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728648782; c=relaxed/simple;
	bh=1guwdQRN67LHeaQ9L0eNF4/IRrggUoDzgaiXWgU1TUU=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TaFCeJVnVz8xW01BIqfTlKgmBQDFVjk9F79cB1fKvXx9pNyc9GWfNotMbvUO8s5iEUPWvctp4aHI+tRbh7xgFeyohLYFXsmjk9NWqvWrdusuuzbDDu7x4wsQVy2dpz0lzFxilFAYZXt4SvW5kUQ4NAqg/90qV2krAtaMDWzndB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eceTY7fH; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eceTY7fH"
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-50d24099415so144155e0c.3
        for <git@vger.kernel.org>; Fri, 11 Oct 2024 05:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728648780; x=1729253580; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=4uWFACZWFTby5Yy47TFnIpljKQVmo7U55/o+V//E2Wo=;
        b=eceTY7fH587xxe/p7wSzX98pAYE3cT2x6B+u8ckXz4SWTp8QhDm7dnINXIgQ9RJgpf
         vhxykhY6ppvSufu5IRc7LKhCSzqrgFZI8yGBRtl61asiDwKUHducQVH4ifurhiHGZDj4
         kyu3FHgiZExoQgseFQuIJMaOUqsvfVH7jKpUUcb4RH2FSx6k7N390RcLgdteSW4E1arI
         gJfOYGnNlUGcIOpM99P4SEGYLSIUN5IbRc9i+TXSci+qrOcODhBZaEXiO1DHXxv3Zysb
         vVlcW7o2VKxUxN5nLfzqIEMzlfxaMcx3I57ZHetUevkgU1FJilTb8rjb0X7q8x7Mtcwb
         nlsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728648780; x=1729253580;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4uWFACZWFTby5Yy47TFnIpljKQVmo7U55/o+V//E2Wo=;
        b=OM3QgFX9YESbBf/03HR//JOS2ckv9ucETOqpqEzHXqm4Lzhu1XMb7F0CUK8r43A0xq
         tzKCqixlz6kK6xYU12IrPPaqqjpNPPyl5F/cZFaAj6hpCGC3zh/fItNFVqBR/I86VK56
         Oaz2WzK14mrrle5ngglIOjLVjzvllnQRC3FtmRABHioeE4mbCh0b7MlmJKgropD4x/I/
         Q41FjPd99xrUIOocACc9aZRg9e7GHfYRPTVgjSnB3BOqeG0cfyAEA3L3p92uFgDCNqdp
         rIJSfpsVw1x3xCRLevW6nGJdKJY9xPN+kYUZ8UZhLieYRyhnZNimexFU/U8D5cnmNoQG
         G3oQ==
X-Forwarded-Encrypted: i=1; AJvYcCUmrXIREH1X/3F8rPuoW+TFiiX0wi+y4BittkpbSqQ3bZBzoqb4OSciQC5U4DBChd0huCU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBuUBOq6dmV75G88kgzGEEV72VWgTJX8w3LB1+odBVnKhDztFY
	urDU09rmqDVwRqO3r/8vFd5nY0efMRe4iRTBTk06TiBgkGTOXDe3igQekBuUWcu0Bc+mEQwd1dt
	CIxH90xKuT3kWTBksbZ6u3fIS+EDAL1/o
X-Google-Smtp-Source: AGHT+IHmp4kFBqVF5Jz8NLJkJROErFHJN0N/9gtKQ6yPGnuo5x/eR74RnU7yLQ+XOOycD8PnKw/GYVxz50W2x9Nvkxw=
X-Received: by 2002:a05:6122:2024:b0:50c:4707:df0 with SMTP id
 71dfb90a1353d-50d1f3bdc59mr1099464e0c.5.1728648780163; Fri, 11 Oct 2024
 05:13:00 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 11 Oct 2024 07:12:59 -0500
From: karthik nayak <karthik.188@gmail.com>
In-Reply-To: <e2ac27dbca0956bc231ad2a866bd796170deacf4.1728629612.git.ps@pks.im>
References: <cover.1728629612.git.ps@pks.im> <e2ac27dbca0956bc231ad2a866bd796170deacf4.1728629612.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 11 Oct 2024 07:12:59 -0500
Message-ID: <CAOLa=ZTOVGNxqJq0mj9GuLFqa6mVHp7WOkhuQsgiW79OKhhyNg@mail.gmail.com>
Subject: Re: [PATCH 04/10] reftable: convert from `strbuf` to `reftable_buf`
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>
Content-Type: multipart/mixed; boundary="0000000000007bcccf062432688e"

--0000000000007bcccf062432688e
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> Convert the reftable library to use the `reftable_buf` interface instead
> of the `strbuf` interface. This is a mechanical change via sed(1) and
> does not yet handle allocation failures. These will be addressed in
> subsequent commits.
>

Nit: Would be nice to list the sed command used here, so reviewers can
review that instead.

[snip]

> diff --git a/reftable/basics.h b/reftable/basics.h
> index 4cf3f0e7593..ac3100417ec 100644
> --- a/reftable/basics.h
> +++ b/reftable/basics.h
> @@ -104,8 +104,7 @@ char *reftable_strdup(const char *str);
>  #endif
>
>  /* Find the longest shared prefix size of `a` and `b` */
> -struct strbuf;

I guess this is the only manual part of this commit, would be nice to
mention this in the message.

> -int common_prefix_size(struct strbuf *a, struct strbuf *b);
> +int common_prefix_size(struct reftable_buf *a, struct reftable_buf *b);
>
>  int hash_size(uint32_t id);
>
[snip]

--0000000000007bcccf062432688e
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 9526a30e046c3e57_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ0FBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1jSkZrWVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mLzg1Qy85UnlxUmdBRlhvS1NCMmdEY2pVNlpJaEZuQwpRWlRvUllIOVlN
dWt2YzR3a0wyOVhJWUVsTytKNEUreGVsVlBuTi9ZVy9nczh4S0ljVHNOdmNlaHlvaEE4TUllCkdq
aE9IajA4d1VGbHN4YTJselV2RGtFZTNzRjBxV2g0Qjh5cTB0QWdKbnhPKzBKNVIrNStnQnJoU255
U0RuUncKYVl1UHhpZ2hKRjU0dzJOalRPNnZuQm5CVzhlSVFpZ3R4T2VOZnJ2clY3aGNzQTJzdzNR
NXNMQ1FpZitQVTF6bQp4MXNLT3VSRXQ1cWlOOEdobU1pVDBMWlZjNTBBWlIzaHVkREJteUozVE1Z
ZFVWbFdac2F0emZaaUF4Q3VkaTJSCnpoSlhUVUNoZWtva0IrY0ZhN20wd0dMT2c2QlFVTFdoYTgz
WmNHZWhRbVBkNkFXZDYzMmJXNjRiTW9pNkI0Q2YKbGJVdnVtcVBaKzluTWZJUjBCQ0Q1VHJ3OURV
UFl1cjN1c3c5UlM4K0tCTnhVS2I3ajJjRi95OC9FOEd6VHhXcAptTGdJYWViekdiMlJ5N2pDVFZv
WnVXQ0NmTU9KdjlWcGM0ZHB2Ynp4UU1MVXhIdjhlMG5OcWZVaCtVZFh3TnF4CncyNzhLdEIyRVhP
R3pGM2VHRFlWZ1o2U0NQTDBSWlR2WXArNmgrYz0KPWhaczAKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000007bcccf062432688e--
