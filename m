Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F07B6801
	for <git@vger.kernel.org>; Wed, 11 Jun 2025 07:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749625231; cv=none; b=kMtCf9TPQl3h89XfjEPRH5oQW9eHesDsgIsq+4TCcLkKBezPkyUuzA130ltF/6bHxHNBqvaDeJ9nmN5ieNyvf2SxJvVJV9GnnuDOsUwiwQEd2Zd9LyLj7kGlQmTpgZWY6xsvnccFgygFDQjhOx/PdelmdYQ7uN62osSCn37lDp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749625231; c=relaxed/simple;
	bh=m5TijgG5+rt5BYkEjwHKBml/6Xvth+0Gdoi+DWRbj0c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LnKPc0ZqgAta+htcHsWTi/S+ypdQ6gJMm5VTsFD2/1c0bXwp93Htbcz6jqEdi05HOpMikPLLWsKfJgDc09N/JHAr70Emg7/rn40CKuaXghiD+PHqURUVnJzRkjTPwHl9O0cOSwrn5wxg2nb+dDJprzx2tcPVH6QhexO34sImQYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RgGen0uI; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RgGen0uI"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6070a8f99ffso17656a12.3
        for <git@vger.kernel.org>; Wed, 11 Jun 2025 00:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749625228; x=1750230028; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Db+oHokv2jRi9m2r3VA+1jOhJxV76nBnnTpgBw5q0P4=;
        b=RgGen0uI/+W/ADEA7J0+P62jlpqDCQJLJJOEMDJn9fxOtDOIOID+DC8qkkOneRdnbp
         D1aHbZnY/7HhdliwgJb+HoZw7wEV+JhWOWiXVbxj+O6MghBCQCGyNYOQ2ftzNP88aA75
         gfExhg5EepUSc2xq6JauSfBnW+U9L7+HPyaCVKVRyahFdlu6//ehAQtBYXRziApc5SAD
         fce1jSLr0kg9uxE5z8MoyVy3HhHwLx2VvfHh8dGJ81QOiqkxxFFAKRHL0qOSUQof5HbP
         50cQ2ojbOEtMrErk7RxPcmuPM+U8CEpo4cIDtxX26LHfLEc4gIA/BmGzirlSWcJQgvEM
         Mg7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749625228; x=1750230028;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Db+oHokv2jRi9m2r3VA+1jOhJxV76nBnnTpgBw5q0P4=;
        b=RGQetjkaENt5AKFKLl/O/cV1RHWRQiDFTiPlzEz00w2JU2ebi/NdzGyJuRjWilXmDP
         KakHXpRrwMF2SksqNb/r7kVvz/+1VMCoNBtBtPJXVDOldY1k6cE0JH8so8D052CojCnQ
         fKwHdvcsFEurGXUwkACsJTPHvA+yZH3F56BZs1ckg9xOt/b58dRf1yCZbEHczi9+ETA3
         2UkO3nRKxbV8C+m/hqZoozHmR/loN8EWaibX3koEB4oGvt+sE84ayCblF1quT2NuJeEq
         JX5N3kjJ4cjzsE0ghtR+ADJFUU67HTepVes+4EJF5JAjW/oLX0NY02PtRp/Oe9oWxBW2
         utmA==
X-Forwarded-Encrypted: i=1; AJvYcCWb802meKVKvwBmpBKPR9THKRfkAcxqJCsFOC3rNOAOT48gDdwCeVhO8FSmdnvlWocNSbU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyQkBbWYwaQbhu1gfo3hC78mVxqJqxQ619ELUxUc+ucBYk+BFl
	2XJUyfbW5EhzGPh+jT1oPsnDald3rTgG9roWEPh85KVLRxzgZI88bDNutYzyB8CxFY1sJ1lvtsn
	qNH1Y6TstLjAx7gdAkxwtNZ6i4Vihic4=
X-Gm-Gg: ASbGnct27tL7l1ZGxA8cDJBlStEPUVbGeXGX3NK6MMPb1vLrQ0qr0HaHD4KkC2BTT5Q
	hTofsnCwKAtJMXS5M/0yvS/Q3OnqJR2xqesDguQ8K+sGfxdRXc6Bzpp00DXC9whPKsbbqsBoWXk
	/d8mq6undrDmnuKJyf/RoyMKFgNF52cLciYhIBO22byowXHP6En0esT4fqw4Agqzxgrr6OX7AZ
X-Google-Smtp-Source: AGHT+IFa+s86U8/TtUw0XIQBsjE8SzVlSbv32oZWomoBtpNNegndMM/Bq/07F//nzrhUfoh08UcyS7e9gtaiWwuEsDs=
X-Received: by 2002:a17:907:3f1c:b0:ad8:aa3a:772b with SMTP id
 a640c23a62f3a-ade898d101emr76444666b.15.1749625227904; Wed, 11 Jun 2025
 00:00:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGJzqs=kJtPcMrWC8Dayd+VW7BvC1rmzS0zT+EwQXfLOpZ3Tfg@mail.gmail.com>
 <CAGJzqskDumbMSbC3rdYT8fZ8gNJ5MOjR_o8RAo9QS-nuvbBinQ@mail.gmail.com>
 <xmqqtt4u86x2.fsf@gitster.g> <CAGJzqsksmQmY4o-_7DoPFK8VP-h59ANUjroVv2+++ZG3gDBdUA@mail.gmail.com>
 <xmqqtt4puhwq.fsf@gitster.g>
In-Reply-To: <xmqqtt4puhwq.fsf@gitster.g>
From: M Hickford <mirth.hickford@gmail.com>
Date: Wed, 11 Jun 2025 08:00:00 +0100
X-Gm-Features: AX0GCFtxVG6P7l74AUwN_lAhlAHBVIsoqoFCwUaVlFm8I-lYujWIapzj4jbqCpE
Message-ID: <CAGJzqs=Xur+=0=KUSR6TQA-A3zt-Bpyd5-T52_ntuV+mCUrAQA@mail.gmail.com>
Subject: Re: Fetch remote only if remote hasn't been fetched recently
To: Junio C Hamano <gitster@pobox.com>
Cc: M Hickford <mirth.hickford@gmail.com>, Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 9 Jun 2025 at 15:08, Junio C Hamano <gitster@pobox.com> wrote:
>
> M Hickford <mirth.hickford@gmail.com> writes:
>
> > Interesting, thank you.
> >
> > Suppose my network connection is intermittent. While the machine is
> > online, `git fetch --prefetch` runs successfully. Later I am offline.
> > How can I complete the fetch?
>
> I _think_ that it uses "git fetch --prefetch" to store what is
> usually stored at refs/$R to refs/prefetch/$R (so your
> remote-tracking branch refs/remotes/origin/frotz is stored at
> refs/prefetch/remotes/origin/frotz instead), so I would presume that
> it should be the matter of doing something silly like this:
>
>     $ git fetch . 'refs/prefetch/remotes/origin/*:refs/remotes/origin/*'
>

Thanks, that worked.

To support Git users with sporadic connectivity, might it be useful to
add an option to git fetch? Perhaps  `git fetch --offline` or `git
fetch --complete-prefetch`?

https://git-scm.com/docs/git-fetch
