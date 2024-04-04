Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD7F56B66
	for <git@vger.kernel.org>; Thu,  4 Apr 2024 07:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712214606; cv=none; b=VYX8a59k1IjOlwP34tNuWwn6K31ju1WnrsL2ckyra0S1AOa3Va1+uRuS2cYcbKfUO3eWptSbHRAOcBjkgrDBL5jTpIZ0ezI7JYzFsrX3thSoWEbvo8Sk/7/ysJS24sGhqq2J9A+DGGVhHgzrfR3AiRtypGpWbfZQcb2HcQkwftM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712214606; c=relaxed/simple;
	bh=MtiUS/q106eUAn1Y2QBIeJ7lB3Fw+Qk4Jfufpl/jl3w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Scre7w57fYh3GmfK6+Ft1DvWbG8KsRhLs9buuotz43xrYtXOVANXGG2IG+dRv8w6KBH6HDeidcbcM7sa5PMKGNH1+NIRRSlt1u7JJ0wMaS5b3jN7l6s9mv8igpJwTKRq5T4M8Y0YuKDLZK45GJ/Lc+WefRol5qU75cOKfOLm1Nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kshvA5NF; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kshvA5NF"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2a2da57ab3aso142563a91.3
        for <git@vger.kernel.org>; Thu, 04 Apr 2024 00:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712214605; x=1712819405; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MtiUS/q106eUAn1Y2QBIeJ7lB3Fw+Qk4Jfufpl/jl3w=;
        b=kshvA5NFinFPx3XmztCQM6LnTjLATiHwvq+3Fq8KxfMhhHSUJzIV39wQFuIgxO9T+S
         +9uKno7TSyZC0t67mI9Bf3wTXuvLAOXG1jCVivbEYcWuP+S9CFVc/NLCsBuoUp31vcIg
         meJRXWJ/ouJ1CZMGbmcrq4/rbOjxFzWF7eG3zkIPu7k57DOYEuVnwYFTBxIb3AuCip2s
         bm1yF87beZukX6iiwUyqNFN5880GL3ejjzccNC0t956wMApGrEHhLtfBsLumm8ig8EAj
         g2PTSKZU/uEWH4LjgfmY4ZeVQ0ksjwg2mavD/CUAR2AZMciRkyrkhez41+URgdVYtdqg
         EJdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712214605; x=1712819405;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MtiUS/q106eUAn1Y2QBIeJ7lB3Fw+Qk4Jfufpl/jl3w=;
        b=EfqHyN0oSZBhy1GSpkAqdZaIf+kft+tXidrif1msLVQ4nRQvCgzjMzSk3H0mikq4Rt
         BZ48WCF00JZHjtyJJySmWaFpzQAs3pw84e+VoYuPJwHYltNWTErzdpd/6FrPnPP8wXu7
         7qG1Crp3BI6m/ftJJAlgqKkZJ11T9eFk4W1/Jkk07YxoPeTpF0qjglGzkpM9fSHGop+h
         pqhOTYsWYUUH00+UhTxXMPGYy5cJPzc/vjctSBVBY3ZWs61nWgBPubPLSRJ96NOxKH21
         499D8WqCWjEMFbfGWhok5hPhb42Ii3k/eoj+WwGhLk5vqYTmBS/X08UuSg84O32mAY2a
         nw3w==
X-Gm-Message-State: AOJu0YyVezM6v1Fq9Og2nzAyqbK1AykpZzbKw++xL+TXcw8atAUMru2F
	UhVskwOezrsrEhAI736p9DGWdoFfWkGjQ4rbxiMYAr0WCrbMXelnXEj8jP6YgFLTaEmrVVuMkq9
	B20PGa0tXyFgdgsQyDdmQzMvhzcokec56oe7IIg==
X-Google-Smtp-Source: AGHT+IFlESzgzDOCNPuYZY3TJdOQa9gAZQQJurKB+avrtX9d6wMo6C1k5But0sCAvKKnHZrsj8eKF25q6DucuJGJLSM=
X-Received: by 2002:a17:90a:d512:b0:2a2:5a8f:cacf with SMTP id
 t18-20020a17090ad51200b002a25a8fcacfmr1417389pju.22.1712214604812; Thu, 04
 Apr 2024 00:10:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1712078736.git.ps@pks.im> <cover.1712209149.git.ps@pks.im>
In-Reply-To: <cover.1712209149.git.ps@pks.im>
From: Han-Wen Nienhuys <hanwenn@gmail.com>
Date: Thu, 4 Apr 2024 09:09:53 +0200
Message-ID: <CAOw_e7ZFJVwV-vCP65kaT5jrvHeigWRyfsC0vfnk3B-S_dXz2A@mail.gmail.com>
Subject: Re: [PATCH v2 00/11] reftable: optimize write performance
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 4, 2024 at 7:48=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrote=
:
>
> Hi,
>
> this is the second version of my patch series that aims to optimize
> write performance in the reftable backend. I've made the following
> changes compared to v2:

Looks OK overall; I had a cursory glance.


--=20
Han-Wen Nienhuys - hanwenn@gmail.com - http://www.xs4all.nl/~hanwen
