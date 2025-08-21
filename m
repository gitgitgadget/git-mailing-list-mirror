Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87D092E7649
	for <git@vger.kernel.org>; Thu, 21 Aug 2025 17:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755796930; cv=none; b=PTImgC9ap+64TbqJ6pEUkRpWitZWwjr6a7tnrzJl5VfOb/tCBo8TEQlmr8Y72BJbEieoh4hQDg9N7U7qN4pFaP+FG42qsYdVDeofeLp5DTkdYPo1OE2YWZiCXH4P+2IZi9dAu368nROUl2pmRAH0Vmz4F9OCekmADoJj8q5+ZQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755796930; c=relaxed/simple;
	bh=HlKAh8zXnpwgMjRxqdVT1JLVtPrJQSxm7Hm8SZlZRwE=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=rGiHP0T2S2oM6QVcImAQnMG33a7cPMv9+pNmpvL+W/yKdoOEFPaIk0VuLmdhpGD+/S0X9JIpIsknPgCZYyzbc99WWXSwgZdaDEcxTLvlXo7fkcgPpUNEz0nfWv893b1hZM0oFKfh4wTqm9n/jUVz4mD3CXeHyc+q0Ph6TJLEgpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A/hb3EWp; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A/hb3EWp"
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e951bbc14c5so175115276.1
        for <git@vger.kernel.org>; Thu, 21 Aug 2025 10:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755796927; x=1756401727; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zdTKM9DXNNwmrF39VxxEvkptZnVEqym+G0f4UIEClCY=;
        b=A/hb3EWpTykkRrnFutbFxfPJ+KOtIykWqdkd0nmr79WpH6iDzNopXcqr+cX+JjHCP/
         0xtdlNycFhKqZO/S4ckz6xDfSJnn7didayDgeFVW8fC4+lkmXpIUzeO1xMwICeIy2xLH
         Vl3DCSzWbE3YZG6VTWSTVPs+i0ccilSYbT7bc12X6cZDX2Vl3q8VDOozybMq+KhB+ELk
         /CJSEfPHTlZP+fw5eVJMpMU9KetslwGbCqJDAIF9yQ8tIvHhTVDoEFQWQKS8SMcghWlN
         AItnr6eXv2QDkH+E2wHxmmpyNOQbl9DA7Hv0bX0W24qsbc0Y3JgCVhKvRBU9FLDbvoTK
         Pwgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755796927; x=1756401727;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zdTKM9DXNNwmrF39VxxEvkptZnVEqym+G0f4UIEClCY=;
        b=xR3eVyu7mKEeau/hhW3Q4H1qOuVppO3f4houGgsFFhyH2y7g5hzJpBpWIT3XLriCNz
         5tGVghCMlyNfief0O6bJ3o3zTD/sU3jBkalS3tdvZ3JhaAGp9399z4CYS2VBFYpqweM0
         wnXFMDuLOOhU2RxXgXSdHF/xZUDtkk1vYEnsTSG429YH/FxuIhuWz4aMrKDLc1X3M829
         uzy6z1eMvXcDXwDC12bIlImcPrVxQmzL/EGZuGzTRw3KEvgxRjl3wQc2yfYiPuMgKNqQ
         +TL7lNBWl9xiP2au98GtF8eMofogCZJY1dkwoPUHPmBRUYGvBRrN1kcMDtLoM/ctdVTX
         GgOg==
X-Forwarded-Encrypted: i=1; AJvYcCW5hW6zcQRRqFuxfoVTXUcjL2OXhn4TNjCpJyEhFpuXRmTk36UARDzjpwBeSLIx1fRalc4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0hZqx6Ku9HN1Bd70qPzOhtdxaUdZguJrWJKcw9xD+WI1zd57k
	nJek9enfUG4BnNvTzjamaqeYnLI7TYfRdnj9TC6ka1/AgTaTC012C/Av
X-Gm-Gg: ASbGncvV/lagUdXrtLBnaHrHIbybAzaY7UqBa4vISYUvLG8swhTNK5peLrJZge4faPM
	RTFitB9D0E+AjKo9w96c3Ib8fwOwQaFof/memJQpJPA/nr9vgWl1dbCUMdW8IF0FEBuZfpnL3wH
	XY1eBclwCcwFC06i9OM4PYlJ4WkfhmUN1G8B3ONoP6UQlAj+S5tFGTvniJwIowtNnyJLDQRhpue
	1h1EEGc9765WZa6tgvlcX6dtHaBl8odjrPJWc53sBpUpFuwK8To/9lUTqtdPjoBXfz5lx7fF+fE
	hJ0XBY0v716EnhSLBuhqAljEu1Lu2B3HT6U2Q6VKzeB88WA6PQc3xgNIXLU110j+P7u4UYTGeoX
	E0AkDiOK/Mb2QxCxDwn1R0rslFDczcP69PdqTWrCg/qMckO42z+U=
X-Google-Smtp-Source: AGHT+IHfux6r9zTCCT/dQNKX8iRD7UPCGSi2ISFawlN03AYTf3uPZ8hFY6asiYxXi4bwd8ereUO0nA==
X-Received: by 2002:a05:6902:4111:b0:e93:38c1:1fa4 with SMTP id 3f1490d57ef6-e951c2ca5b7mr326184276.1.1755796927311;
        Thu, 21 Aug 2025 10:22:07 -0700 (PDT)
Received: from smtpclient.apple ([2605:a601:90a8:8b00:98b8:ef87:b2ce:efc8])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e94f695b1bcsm1906773276.15.2025.08.21.10.22.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Aug 2025 10:22:06 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Ben Knoble <ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH RFC 00/11] Introduce git-history(1) command for easy history editing
Date: Thu, 21 Aug 2025 13:21:56 -0400
Message-Id: <6EC11FA7-D80D-4DA9-A615-C3523967CF93@gmail.com>
References: <87a53sr67i.fsf@osv.gnss.ru>
Cc: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
 git@vger.kernel.org
In-Reply-To: <87a53sr67i.fsf@osv.gnss.ru>
To: Sergey Organov <sorganov@gmail.com>
X-Mailer: iPhone Mail (21F90)


> Le 21 ao=C3=BBt 2025 =C3=A0 12:51, Sergey Organov <sorganov@gmail.com> a =C3=
=A9crit :
>=20
> =EF=BB=BFJunio C Hamano <gitster@pobox.com> writes:
>=20
>> Patrick Steinhardt <ps@pks.im> writes:
>>=20
>>> In the end, I'd like us to learn from what people like about Jujutsu and=

>>> apply those learnings to Git. We won't be able to apply all learnings
>>> from Jujutsu, as the workflow is quite different there due to the lack
>>> of the index. But other things we certainly can apply to Git directly.
>>>=20
>>> Note: This patch series currently builds on the cherry-pick infra.
>>> As such, when one hits a merge conflict one needs to `git cherry-pick
>>> --continue`, which is quite suboptimal. I didn't want to overpolish this=

>>> series before getting some feedback, but it is something I'll fix in
>>> subsequent versions. Furthermore, the command for now bails out in the
>>> case where there's any merge commits in the history that is being
>>> rewritten. This is another restriction that can be lifted in the future.=

>>=20
>> Two comments.
>>=20
>> - You would want to honor notes.rewriteref yourself, as cherry-pick
>>   does not and that is deliberate [*].
>>=20
>> - It is a sensible design decision to limit it to linear single
>>   strand of pearls history.  "history reword <commit>" when
>>   <commit> can be reached from many branches along linear history
>>   that rewrites all these commits on these branches would be handy.
>>   There may need some way to say "these branches are protected, if
>>   'history reword <commit>' needs to touch commits on any of these,
>>   abort" and things like that.
>>=20
>>=20
>> [Footnote]
>>=20
>> * "history edit" (aka "rebase") is an operation that "edits" the
>>   history, once the edit finishes, the result is *the* history you
>>   want, and the previous one is to be discarded (except for in
>>   reflog).  "cherry-pick" on the other hand is "I have this good
>>   thing on this development track, I want an equivalent _copy_ of
>>   it on _another_ track"---it merely is an easier and quicker way
>>   than typing the same thing yourself on top of the other track,
>>   and does not duplicate notes.
>=20
> Unless I'm ignorant, "git rebase" (aka "history edit") lacks essential
> feature though: in addition to saying: get "this" history and rebase it
> "there", one should be able to say: get "that" history, and rebase it
> "here" (aka cherry-pick on steroids), that also would eliminate the need
> for 'git cherry-pick <range>' that (poorly) duplicates rebase
> functionality.

But isn=E2=80=99t that

    git rebase --onto=3D<here> <that-upstream> <that>

? And why is that cherry-picking a range is a poor substitute [it is rather r=
ebase that duplicates cherry-pick ;)]?=
