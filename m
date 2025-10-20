Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05252238C07
	for <git@vger.kernel.org>; Mon, 20 Oct 2025 18:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760984117; cv=none; b=eciVAiScIuHi1nKah5oMbedFyElivFn1Zf2RMubWtqblg/yogTc6ZIuufcLq2Rxi8S0BtTQNsI7b3y2lsRO8lDd5uUumA0r/z5Ufo3EQOo12OxHARFkJGCrRLPpFA/3m3FlhrDy/gMQcNotQz9MyMZWbZjZqWrFQCHVSGRXwMq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760984117; c=relaxed/simple;
	bh=CnzzZjJktP/zERPbAwC5JscVLyinNe+bvseHbBQ+asU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qTIQsrmG1VrKUaSdgu+wLVrUm5/SZCG2+IHJ5vMK/26KPEtIL98mx4S8A2EO0/1mdr+vLdQUdnR11WUBr8cWz7h7eI39n5CJgYJ6TBg+mCaZHZM6BXmvGtajfKDWClR5lgxSas9eSVtbpvGhFt4r8vqyFU9nzrqHAoxS3yiDoDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xf2SeO9J; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xf2SeO9J"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-27eceb38eb1so48555285ad.3
        for <git@vger.kernel.org>; Mon, 20 Oct 2025 11:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760984115; x=1761588915; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mmqiN3sjudYaOaoUTKb3fQYXIRmddnLFAjJY+b0aJxg=;
        b=Xf2SeO9Jyn9YNAJcwOs+C0n3aMJJcL4jLzmyOTaI0J1jNkCujQngU0TOK2JLSGnfkK
         KpvzetmOaLeFccBcCOCFWA8wyjIb+fvjgHCeqZX3NFra1DmM0o8XQhVAwsj8RrmdQvKR
         LrF6ymBKN/SNvCnE9oLaM0YBbpdsyKgMYHcG+zsO5V7gjvdW7mx1/wU9r83FXH2yJrXN
         RQSkk8XYCTKOSHWlnbEeaTTRn8JL3lwtr5PcbUIT0MaeySFlQt+ecF9OjBqElxZh3fbn
         WyTwbOqJVTTXuOddVwqYbkuVEVf8tHGm97SiMTkjreznLjAQTHp7LPTW2pMg2T6UCWT8
         Gjbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760984115; x=1761588915;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mmqiN3sjudYaOaoUTKb3fQYXIRmddnLFAjJY+b0aJxg=;
        b=Gt98ZS9pwCsStT4PkjmsAh1Dix8Bm2JWxbb6DExz5+TetEdyIj3V6jCvEo+Pc6IUtF
         x/aO1493hJfQEaMJ8rXN56vCI21cfILPo/2XD0dI5d3GI9dd/m8avFovPnDraJAxE5ll
         xVXMilvLc1NeRMcC/ornLUUNn5QCuEZ6GeRtF+q7vkqgq5+FI3e1Sw+zdsTzTw2unLKa
         LDOZQT7HQ7ZOuUQdMqZ4WOsei0xk4cY4JR8CfqwYymJG/7NgmJiReUyqgEy+uGDzj0q2
         AeSFgdQnk2pmDack1pw51vUAEBt156eDpBXCYiZt2t1b2ExmREt6kXUwzFq20JTQB6bL
         uWvg==
X-Gm-Message-State: AOJu0YzQl4SchssX+Sf0lS+0eh0i+V2/wydpJCe3kYQ04F/pEzdlDcc5
	9mBuZtlG1r8V3g/H+EdyCOQx8qmfQsmZGTlL3ImLUeD4xH2RScTPdXCsE/hoREZYR+9cDXltdDt
	hKpsb3ehVK/qBAkVCVY9OJhMLuws1g1Y=
X-Gm-Gg: ASbGncsUUU+X+ud2tNszMiGAZ7P8CyqzHjyTSCHw17Fo9yRuZ69ThYUiyYExkwsQObO
	qOlnw8KEH4rKPuM3gkneCNI7GWDyvDcuO1G8pDjIp9JmZfdkRhce24tWvhflqFTwul6aiLgkLlF
	rI5MOWWi5/gBWDaA4C7DqGXY3djksFldIxiVn5wj7FeGbz/Pkvdr8TNuEcwBuQ1UydgNd3BeoEr
	s3a3OOsP/sQI0uNaxeDGUPnML3WfMz5pLS5pwPr2RnIuf2SNkBejdmuSOuP6fCRl6m1j/RD
X-Google-Smtp-Source: AGHT+IFaJSoePAnaU6MRDn2Q/HPXuEt9bTRsBRH5s/IcDvAUFrbPFsMzlMtdQxMyQ7Kq5272uLi1mvzhNzWddvZuakg=
X-Received: by 2002:a17:902:e841:b0:290:c902:759 with SMTP id
 d9443c01a7336-290ccab6c0amr138852275ad.51.1760984115100; Mon, 20 Oct 2025
 11:15:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1760869186.git.belkid98@gmail.com> <7da4fded535984faea52d5f88793d3c8e47c0091.1760869186.git.belkid98@gmail.com>
 <xmqqqzuy3n3k.fsf@gitster.g> <CAD=f0L8Zc=rRwCo0QHWnf8OCXidubJrQYpeQg=gLXV=npO-T1g@mail.gmail.com>
 <xmqq5xc9390j.fsf@gitster.g> <xmqq347d1qn5.fsf@gitster.g>
In-Reply-To: <xmqq347d1qn5.fsf@gitster.g>
From: Bello Olamide <belkid98@gmail.com>
Date: Mon, 20 Oct 2025 19:15:16 +0100
X-Gm-Features: AS18NWDe3e4jBvYeGGed5XEtQlkY9vGzfSYiQESb5gWCZiO0bxGc21dkOXcxdUA
Message-ID: <CAD=f0L9jn5WSkq7UCYw8UQbHAp-wj7Nrh1+qQJ=6RqcuWjjjPw@mail.gmail.com>
Subject: Re: [Outreachy PATCH v3 1/2] gpg-interface: replace strbuf_split*()
 with string_list_split*()
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, usmanakinyemi202@gmail.com, 
	christian.couder@gmail.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 20 Oct 2025 at 17:31, Junio C Hamano <gitster@pobox.com> wrote:
>
> Junio C Hamano <gitster@pobox.com> writes:
>
> > What I was missing was that we use fingerprint[1], not
> > fingerprint[0].  So we need to do the strchr() twice, i.e.
> >
> >      char *begin = fingerprint_stdout.buf;
> >      char *delim = strchr(begin, ' ');
> >      if (!delim)
> >          die_errno("Barf!");
> >      begin = delim + 1
> >      delim = strchr(begin, ' ');
> >      if (!delim)
> >          die_errno("Barf!");
> >      fingerprint_ret = xmemdupz(begin, end - begin);
>
> Ouch, of course "end" is not declared anywhere and it is an obvious
> typo of delim.  Sorry for not proofreading enough.

Okay thank you.

I will prepare the patch and resend it.
Thanks

Bello
