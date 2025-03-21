Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EDA11E0E15
	for <git@vger.kernel.org>; Fri, 21 Mar 2025 06:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742540228; cv=none; b=CuiYfYEhdBUJFRQyYb3gvetlFX+J/2Ww/Yi2w1A39Fu4fXihoEDrnRXaLRukRfenmYBmgFMcgceey+TkBND12JJQaX2gzYrE+azYFnsyXdDogA3GJnvQrhUm17kT/Y0ix3A+OYF2TAwaqUdXt+maBOOjdL00dGPI4bPz9rA8wUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742540228; c=relaxed/simple;
	bh=DR7eMML9AZL/Xkm5dFfKOP6idIM59KicHOn5xNVrxiU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BlcyxS+6Po46WbtCuc0ZS/xX5aT4GQ9G09k8hgYAppmzJ1iOKlC2BKkxJbb0yshIe5sYwiDdHxRksi6A7zmfGqHe0BWsbXApslkvwchBboa3165N/CPVlXfe+UGl+nPZWKzyMsJBLg5W3NBOnqWkiRI9KxPglDucGRe+ErpWQB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XTdLgShI; arc=none smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XTdLgShI"
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-86f9c719d63so458193241.1
        for <git@vger.kernel.org>; Thu, 20 Mar 2025 23:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742540226; x=1743145026; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GW5F0Y5hrozsasIClZB6fBiUOK9BPDK0UButMM2VswY=;
        b=XTdLgShI2gxZYHh/So41x9a3Znidskxke1N6xYK7M3+E0pmDfFcAk3/JL1ez5n78pi
         h4BWNb7ToYpyveobyv2fN6QzcM3EOzX32y7Kgjzy1U9cQNoyrON9w66r73OLDYVZWcCF
         Mv0m41sVQ21k1x9hHEy6bZZo2PCjQJwXBxbHTtfzuwmmHoLPQCDi7+vitm4kqD60wRCH
         lXB7W+rWjSQPEAXFcfeSODFjBVROVbO7vaGlPbwvJasdh8Fh0jwzmeocNfy3c67/rQQK
         cni7Giuuk6Yu0GFrcMDB7JU0c8pBnw7vkuQJC9qMOA2AlFWHHTEN/PEX0xattF5pAj/H
         jnCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742540226; x=1743145026;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GW5F0Y5hrozsasIClZB6fBiUOK9BPDK0UButMM2VswY=;
        b=WR2dFV4CEAoTfvLB/I4JcosghHU3HXrGLG3XhZHiqRWriZidjEGifKPtI18QTM4LcP
         vQvXUb52Km28gWLF63HSC3DvB61itPYHhUA4KXGi0uG7EuYsPqMz/QlZ4O7ciCdGgCla
         ONYHX303k8mf56EhuJGbQ2BM6vUJeuJFB9r6gLwG7kNNULDkvpJDZJQHz82bWlx1vHjM
         3lWI+gOQVwHPFZXEvUTL8EbnjiroRjBV0liwj7BxoqABgERXTdPtHwdBCcc0twp02Sb9
         H5NTMK7jh7BRW6UDplGaaQnxu6SGDxNs1gkbliM5SU39hOgM8C6hqLsqyYTNayzApcp8
         /awg==
X-Gm-Message-State: AOJu0Yy1fZlG4+ZZr7Sen+AwzkhubZHJTDhaggzjlWxKJlU6pHzVP386
	Fm++4nK6u0G/23yzFT45sxfVXmkVJfGJNbzl6kbQ9v6y1TS9Fc8WmT0C1pW1USZWXDCE3LZJWdw
	lCmgi8em0lpPobMLHoFMBsWp6RKw=
X-Gm-Gg: ASbGncvNtb5A0Ki1PwXG31U5jmuw0DC0pd/oZrG9PUIATgAnkrjK65q03FARfIDlfMN
	eDCtmGUSJ1cXAX7VI8GEVtpwIQJfulg/iCeFmqoow5uVPvxG1QpseTUtyrqK+ZW20RbmpXRBWZm
	uN3NTdM9rZwqFghRhK/pySo8JpFg==
X-Google-Smtp-Source: AGHT+IFqJgRKy9Yt3pIhfAIRKFDwtamTbLblcn1awK414b9nFdGmNjMTelKUPfy6MZMRWxqC/q+QpCpFNM4SBgJ4BrY=
X-Received: by 2002:a05:6102:2ac3:b0:4bb:d062:420 with SMTP id
 ada2fe7eead31-4c50d491d1bmr1477932137.1.1742540225759; Thu, 20 Mar 2025
 23:57:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250318115912.2978992-1-usmanakinyemi202@gmail.com>
 <20250318115912.2978992-2-usmanakinyemi202@gmail.com> <Z9vB-Mm9YpIcv6UK@pks.im>
In-Reply-To: <Z9vB-Mm9YpIcv6UK@pks.im>
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
Date: Fri, 21 Mar 2025 12:26:54 +0530
X-Gm-Features: AQ5f1Jq_nv-_TkSk5BKnc5ksQD5Q-MuRo_s_8xs7l3sbCRi1PofMMCTMhugBLPY
Message-ID: <CAPSxiM9RDiBqqGsQmAFD5RvCh6ABXegUvpyzOC81Te3-NKX7Yg@mail.gmail.com>
Subject: Re: [PATCH 1/9] config: teach repo_config to allow `repo` to be NULL
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, christian.couder@gmail.com, gitster@pobox.com, 
	johncai86@gmail.com, me@ttaylorr.com, phillip.wood123@gmail.com, 
	shejialuo@gmail.com, Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 20, 2025 at 12:51=E2=80=AFPM Patrick Steinhardt <ps@pks.im> wro=
te:
>
> On Tue, Mar 18, 2025 at 05:28:53PM +0530, Usman Akinyemi wrote:
> > diff --git a/config.c b/config.c
> > index 658569af08..e127afaa8f 100644
> > --- a/config.c
> > +++ b/config.c
> > @@ -2521,6 +2521,10 @@ void repo_config_clear(struct repository *repo)
> >
> >  void repo_config(struct repository *repo, config_fn_t fn, void *data)
> >  {
> > +     if (!repo) {
> > +             read_very_early_config(fn, data);
> > +             return;
> > +     }
>
> I remember discussion that `read_very_early_config()` may not be a good
> fit here. Most importantly, it ignores any configuration passed on the
> command line, which I would think is very surprising behaviour. So
> should we adapt this to instead manually call `config_with_options()`
> with the expected bits set?
Hi Patrick,

Sorry for the confusion.

There was a discussion about this here.
https://public-inbox.org/git/xmqqbjum2ayc.fsf@gitster.g/
https://public-inbox.org/git/xmqqcyeuhwqb.fsf@gitster.g/

Mainliy ignoring the configuration passed from cmdline for this purpose.

I was sending this patch again mainly for the 9/9 patch.

Thanks.
>
> Patrick
