Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 536B02BE621
	for <git@vger.kernel.org>; Fri,  2 Jan 2026 17:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767375477; cv=none; b=Rj7iWNTc7U5NuNqAw42yyKD1+FxfZGO/WDD3VlSlAuN+oCgZMYJF3Drlv6Qv7uG8ANo/4ixz59AONztiQV3jvHtEwN5jmCflaYCLcLW0+JyB7zC+zOfe1aEZGh2Ou5lTZ0KRsEh1vVxXfAcUWWtN1wzuyjufQHFM9fdSUQJodzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767375477; c=relaxed/simple;
	bh=a3bh3pb2Mxifo5Xy8ONQrE3rymXdeMgTZyeAj6tcDe0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dH+pOiWi+EO6mNeO7EYbtXfsAUk7BNvv2NOhtwho+kH1xWM3e8Qmye3lGsQE5wI2BoDheFdo93Kdhn21y8Hf5KT0lSjpCWATrlzSvKX6EMidj2c4mZJm+hSvC9lrkW3J7xIFnzk16OW2+P2k4LCw4mNo+1xcZ4rAVnP/p0pzFKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Eu8m9rbG; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Eu8m9rbG"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-890228ed342so49342556d6.2
        for <git@vger.kernel.org>; Fri, 02 Jan 2026 09:37:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767375475; x=1767980275; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IzBBs/HXphRb8Tn40GD+OxdHQuh+GRo46Zil7UC4/Zk=;
        b=Eu8m9rbGQmym2wujM0R6RRTXRNZPoNffAP3DEQaLekKa4rBWGlc0NdEaGwO8aNLDrL
         G6ih2HE74UxA2cBJck4Te/yxg7jTp0/DqD6zCkk4cRHbSh35X3ib6wTsw+Zvx3xbsS2I
         AZAipFsmxPaAqT8oQey8HbD/7rV8Oy9n7zRc9MvKSIpfv6n8Im+5BEWVeHuMI/JZyYbh
         PYDxrh2/dhU7b20lNqKJYeL8VtZwfdLAdpzzJMS9qMSTVERESsF/reujuPYAM1Bne3Ai
         Z2ti85cIOL7NFjP6YiRiHPv6psA8io8lFageUg5b50ganFYRpv6C/o2qNlGy04h6ykCk
         CeIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767375475; x=1767980275;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IzBBs/HXphRb8Tn40GD+OxdHQuh+GRo46Zil7UC4/Zk=;
        b=MW3dBBvlEx1hIvEdkxhLpZQ/DGKEREB1NEE4NqE89x6NkIUQEXomSVuHHMITlVVGC5
         DZgc3T1OjfWUKmg3flMSQdeSiETD5BE2O+dBxKPgVp8zwVZSsTWbyLR9ZuRqojUpckKd
         01s4D5XCFcnictKxtrgw3IAZQQfKG8tGEp1tIuQ1bdVYwwWBvuwULVa0zl0bJC/QX1tT
         ATDl5PQa8W0gWRsM+hgIMqGNnHwrBCrYOOhyhM/GONQ9wLTN2BDykt+Ijp09dPuL9s9r
         fk3lyiSyThLTGj7R0+fQSGeRusdqIVpLt6ubs4CTmzg9iePj2ACRl72t2OQ6zf3J3L4P
         d9SA==
X-Gm-Message-State: AOJu0Yw7oKvHBRXp7j7uZrPPQZSiZnNZlsW8gCFRhmyOhoROkjo373SJ
	ZqOqBBq9ARIigjPEAtlZi+1OaCuzk+Rnc8lsWr71jVHs/GrAEXcz4sywgIBPLrLKd7mAe2w7zml
	aeNiJZ84+9SE1B31zwd9lnu0jN2gdw/Q=
X-Gm-Gg: AY/fxX6BDU97kjpJZCF1Lqq0QAtGCND1sADudbFUUP29JpaC+etY7tc7poWKsCSVy3L
	Yxcw9h9iH0ulpRgwKekFf7OeqzE1dDErq1gwU5uqww6s9BbJViU6Qq1stY8Y6Inawxah2odXEJ6
	3ByIpRFjMTca054VsILrysLTPmhz8oCvemrpevvj1Jw8AFxZTwVC9tt1kqY4N+JEQlpnUq1AGOK
	x0mdJod2NPP15HV6OGEdOM3wmL6I7CEx0W0fkQqpm8qcU0iIfsbKnuJdv0ChrFfMJSi+1nzNahx
	CtYk7N8IR+2rUKImd5NJCjjxiQ==
X-Google-Smtp-Source: AGHT+IG7clk4C/9IB+wVtvxxIv0U7117Uw3dPkMRABi8FcrqPB3ZPX5tTIQVMjgA1fXuu2nluQYf/ZI65F1V0BlWWvU=
X-Received: by 2002:a05:6214:154f:b0:87c:208b:9556 with SMTP id
 6a1803df08f44-88d82526733mr459713136d6.30.1767375475258; Fri, 02 Jan 2026
 09:37:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260102002735.31390-1-rostiprodev@gmail.com> <20260102002735.31390-2-rostiprodev@gmail.com>
 <20260102061626.GA2581074@coredump.intra.peff.net>
In-Reply-To: <20260102061626.GA2581074@coredump.intra.peff.net>
From: Rostislav Krasny <rostiprodev@gmail.com>
Date: Fri, 2 Jan 2026 19:37:44 +0200
X-Gm-Features: AQt7F2ruuItzOeXWh3q--wRm2AzXZIt0jCmZHyGk-DIzxSo7xjV1Jfq0_k6cSAU
Message-ID: <CAKU3Xk5=dmdQhTgHB8WrPbbOOo3cyJtCgFgo7juW06F9YaceRQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] compat: modernize and simplify byte swapping functions
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, 
	Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
Content-Type: text/plain; charset="UTF-8"

On Fri, 2 Jan 2026 at 08:16, Jeff King <peff@peff.net> wrote:
>
> On Fri, Jan 02, 2026 at 02:27:35AM +0200, Rostislav Krasny wrote:
>
> > Replace manual bit operations with memcpy + network functions for better
> > maintainability. Add missing 16-bit network byte order conversion.
>
> This is burying the lede a bit, as they say. I don't know that the
> maintainability is much changed, especially as these are not functions
> that anybody looks at or touches very often.

I just meant that the code has become simpler and more understandable.
English is not my native language, but if you would like me to
rephrase the commit message, I'll be happy to do so. Just suggest a
better wording and I will send v2.

> But this part might be compelling:
>
> > - Performance improvements (GCC 15.2.1, Clang 21.1.7):
> >   * on x86-64 with -O0 4.2x faster (GCC), 3.7x faster (Clang)
> >   * on x86-64 with -O1 4x faster (GCC), identical (Clang)
> >   * on x86-64 with -O2 identical (GCC), 1.8x faster (Clang)
>
> The -O0 numbers are IMHO not very interesting (and are entirely
> expected; you are comparing optimized library memcpy versus unoptimized
> assignments). But clang making -O2 faster is quite interesting.
>
> If we are going to do this, I think it would be for the improved
> performance. And it would be nice for the commit message to go into
> details about what was measured and how. I'll respond elsewhere in the
> thread with some more thoughts.

The main motivation of this pull request is improved simplicity,
readability and consistency of the new code. It looked strange to me
that for converting a value the optimized ntoh* and hton* macros from
the same bswap.h could be used, while for pointers a more complicated
code in the get_be* and put_be* functions is used. This PR also brings
a few more small improvements like fix of typos in names and
additional functions for API completeness.

My performance tests (that you discuss in your second email) show that
at least there is no regression in performance. They also show that
with n < 2 in -On it is much easier for the compiler to optimize the
new code. I can agree that -O0 and -O1 are less relevant in release
builds of Git, but the fact that the new code makes the compiler's
work easier with any -On only strengthens the assertion that the new
code has no performance loss.

And yes, the code that I used to measure the performance of get_be64()
is probably not ideal but at least it proves that there is no
regression in performance.

> -Peff
