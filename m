Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A52BC14AD17
	for <git@vger.kernel.org>; Mon,  7 Oct 2024 13:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728307545; cv=none; b=Nws6l6Q4JKaFQ0758fJ8zRlVmbs9bgpdDjwk8uzOOpI4zYDEZBEMFv0iZIDzmR2TfOXSr8eLPYSAnKWsKurpMRR0+qxOGC4eYh6PIX6USDkEw0BaAp0fJHz8sxPsajcGKb+y0ItbPoVJR1WApKMPBo94Wlpm1eunn51/5aXCFH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728307545; c=relaxed/simple;
	bh=/rF6q006DNYusDtqRd0HNnYJSigZkHdKVrCYchuqn8Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jZm/DYrhfTuH8CnG3j5WgvZNo4vNkThMNhk6pAy4yxfTo2SbrxPBJx1ie/8AWFCxjB9pTdpSV4Ajc5wdZAaIKx5rRU8xNOHnNhnDtmOlaFkRwGFMBsc9nB7A16GDrYO10Ju0Szao2AM3TE03TixUE2mAE2R5ks2x1Mgxy3g/UlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VPf5UPa6; arc=none smtp.client-ip=209.85.222.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VPf5UPa6"
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-84e87902e35so198481241.2
        for <git@vger.kernel.org>; Mon, 07 Oct 2024 06:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728307542; x=1728912342; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/rF6q006DNYusDtqRd0HNnYJSigZkHdKVrCYchuqn8Y=;
        b=VPf5UPa6pZ9BHhdkLAfEjMO6q4cwwhcKVgn2aFgpYoIUN4iSbXdHfSjPW2lEeA6lw1
         Z3ztWOY+mcvwsSrlhJw2DC0Fx507ckWxd2Ns+tz2gzlgza8dO1Wy/7663iw/SGUs1L/o
         n7w1vS5s5sZMgWtNp61tnsSs4d2ovqc2o5YbTD3JAKyNtHUmf35P20CvbLlVfJMsO3/4
         /s53Ao9bhL8VoxWtEI4ZHXEA7/fCgPGlqvm+G32TSbQ9mPbNxzk0oL8TjbhLXmE82nEk
         SD4gi4x9PnXyxwPFbcD3AuEp+w4GW6MqHCaiMrqaH9IlU/1qAH4OQujlxgSd6GJa91gz
         yzlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728307542; x=1728912342;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/rF6q006DNYusDtqRd0HNnYJSigZkHdKVrCYchuqn8Y=;
        b=Wme4mdgw/bq/dd2/f/HJPqRlD2IJJpn5ycmIu5Ui0EP3yJNAuvTwQ/8Ez3lymKFKeb
         xWaQKExPDjx3lL2r42mmWlMmv4moWtFsG0+IVrKndLU3p/7AUSYPJsUlWBgwAx9LOn2q
         dxBBAg/WbBZSt1injcGHJqBM+aRZXNA45g26Kb6HJ5y/vRYFuygYdBiqyo3ZS4LoPytt
         UIgCuu7X6kTLgmpDIepVOk6LxyIpYQ5orSmpiVhBq7XwI6pFk/c0uOtl/zGzmDO1aLeV
         zoN1K4F81zUM2sEyRdgF1zu8B0V5VlsOWetfcs/vQWjd8B4L1z4lgfdSv2PuW2Pi6uMm
         Vs5A==
X-Forwarded-Encrypted: i=1; AJvYcCUuAhPSYsLPZLRYmuygmVSdLHv0MsUla6grQqFauV58T1OnysOM0MA2DNnh/drpX+alFOI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyA4PsV6jVcCoqHOoWvdsgNVkiVUburtsDtSLlMS9G1kz6WBGjL
	H5oaL2yRdkDk5GlnqKTQ9VYsOXId7eu/VaF6PnKdkb3weEoOjnEBJW/3/P2kVtNWaHA+qz+x957
	XYkzbDuKWaCYAy9iVyIi4rQbzycDvBhOgQlt8UKFP
X-Google-Smtp-Source: AGHT+IHlgl3+nKuoJk7ma0/VT0zjI9Lexj2/sfHKDfDjMVHljVDsxxm2GhdhSl/rgIpermJF6qEZ9vvtVZUc2XrcpJ4=
X-Received: by 2002:a05:6122:45a8:b0:502:c196:194d with SMTP id
 71dfb90a1353d-50c855bd5b8mr2331267e0c.3.1728307542516; Mon, 07 Oct 2024
 06:25:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAO1n884e13_9FZDBtcFrwU8oCyv+0_WUT-c16qN0W9c+D6k2PQ@mail.gmail.com>
 <834250ef-46ec-4667-8e41-e427472fd623@gmail.com> <CAO1n887uu5qUcqLcdKfh8FBKJAQUCGqVOnAzX7WWiFEnuuMF3A@mail.gmail.com>
 <CAO1n887hN81j5h12t-6xpNQAQ5uOx1wxLz48c+O4hZE-pWdY8A@mail.gmail.com>
 <ZwNx-sKJJNDQ4sIC@pks.im> <CAO1n886ANrTzz2S=P4MT15WEeSSDFv+7+uBTsJ5MtXV5rgTu9w@mail.gmail.com>
In-Reply-To: <CAO1n886ANrTzz2S=P4MT15WEeSSDFv+7+uBTsJ5MtXV5rgTu9w@mail.gmail.com>
From: Abraham Samuel <sammymore50@gmail.com>
Date: Mon, 7 Oct 2024 14:25:33 +0100
Message-ID: <CAO1n885B-gcWFb1foA27OjWX8_mHQ=sKebZVbhvewwis7vRR0g@mail.gmail.com>
Subject: Re: [Outreachy]
To: Patrick Steinhardt <ps@pks.im>
Cc: phillip.wood@dunelm.org.uk, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 7, 2024 at 2:24=E2=80=AFPM Abraham Samuel <sammymore50@gmail.co=
m> wrote:
>
>
>
>
> On Mon, 7 Oct 2024, 06:30 Patrick Steinhardt, <ps@pks.im> wrote:
>>
>> Hi Abraham,
>>
>> On Sun, Oct 06, 2024 at 10:57:26AM +0100, Abraham Samuel wrote:
>> > Hi Philip,
>>
>> one note up front: we tend to not top-post on this mailing list. The
>> reply to an email should either go below the quoted parts, or if you
>> want to reply to multiple parts of the mail you can provide your answers
>> inline like I do here.
>
>
> Okay thank you very much Patrick, I apologise for the mistake. I will tak=
e that into account
>>
>>
>> [snip]
>> > Please kindly let me know the possibility of doing these microprojects=
.
>> > Thanks
>>
>> All of the examples you picked seem valid. You do not require something
>> like approval to work on those projects, but it would be nice to check
>> that there are no concurrent threads on the Git mailing list that handle
>> the same microprojects. I'm not aware of any though, so please feel free
>> to pick any one of your proposals and work on it.
>>
>> Thanks!
>>
>> Patrick.
