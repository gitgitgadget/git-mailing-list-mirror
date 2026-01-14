Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BE6D39283A
	for <git@vger.kernel.org>; Wed, 14 Jan 2026 21:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768427345; cv=none; b=nE9Jmw1mHt4NWlKDMxH35mpY0MxAOsPmeIOMFlkH01npj1y/IkxW/cnWBVVyvAI73EWVB8taqSF8ANGm1lzXKcm5b3GL7XnNWypjigkub2PsWZEV+bIQyDXiHo76oZTpbeFT8QfsNR0X9eqkjUcaAmhisYhixN8pO22IiMNdUZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768427345; c=relaxed/simple;
	bh=NXHiMkSSOepw2oHQY7ejWrJS3v3a9SnIWr8Xw8aUQjQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KHHXJWyrtHTNDv+RcCp+zv6ImvJc2eD49PVnr9mQmfEyNqMZ0FoB7qegBX1cNkberac40ngqdddCl3K7gG0SC92WWZhH59sMiA+Wt9iQwcMs9bHQnMtsSgvUqySzXNZzqBCbrP4d1fMO0DrBKmzO+BGls7Gs0GaouAaHKTVJUg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LqwBTVeS; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LqwBTVeS"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-42fbbc3df8fso141554f8f.2
        for <git@vger.kernel.org>; Wed, 14 Jan 2026 13:48:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768427315; x=1769032115; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NXHiMkSSOepw2oHQY7ejWrJS3v3a9SnIWr8Xw8aUQjQ=;
        b=LqwBTVeS7tN0PmthFjWv19Ws5ssxDHXP7WZ5B4A3RQWs5VZq8Yz4oKxkxBhpvr0cGO
         1oqWMn5LZArOzOzTKSxZbFbEQEBuGQNO8SJEnntlyuyARenIGLKaSjFhwA3wpEDI1f/O
         0Qv5eWD3//Odnr0XAT3sJM9qPMvzOHf2l6Df+b3LW4YIw8EFjSEuD/kAuH8SQIGbFH2U
         v0M+OFB8Kue68rmkGeFEnd25t1Kwz50WWjkueJxYbsfDAzMZYH+oz4Cyu5t3ikPtgWlj
         vrl9AXGcxQSdQNoXwDdmUx4utkCc83iICBBin6ftGj94zV7+4kFff7SJcBVw8yOtYG3i
         AJnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768427315; x=1769032115;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NXHiMkSSOepw2oHQY7ejWrJS3v3a9SnIWr8Xw8aUQjQ=;
        b=h5CswTZKJzvMmGYyByLZlHePE+LsnIXAqhR+qkcTQxtRoAIKN+hZPr4snJa6IlCJM+
         UJ07z3J5BDKAgmq3viYTM4X4irkX8OMY7kLPQ1bzRKbmKkpTg8U6uDhxSRlxYul/m/6m
         B9XFZ84azS4C4JRxqlf5lyF7VXzH1zJR40YHx0hIr24AwNfj+RD8gmtSqmA7cOlo6x08
         A0VaAOiq+Dh1WtVBm1HdwrQnWiCG5nnCpldi+nUCQhNS0MAvNfZr1wQ0jHYyiRGyH2IR
         3c6h2w1OlVNs5otsBjRKp8zzXvPr0Qzl1zGl0BfkXy+NcNxsYp8ePFBE9vhKlyNQ0nG3
         ztIw==
X-Forwarded-Encrypted: i=1; AJvYcCUMPYZvVGq4MjfBDXO+HHp4IeDx7MLOskiUXy68XyM76PVh8FBG5QVdFkpFHFVZk+bBQGM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIWTEPJC8588ZkzoThzxC/cQmNQzG5ctnWGMbufzBUlh0pyQcJ
	i9gI1e7T9I1Ns38W3o+yjFGtEJG98qkcMb7D5CSCGHFKAU/qgDaye60PxS9b9+uWeWQA+v+nofL
	tsgTwZeQAD2d4lwrVwo2pvSS15DnBQYU=
X-Gm-Gg: AY/fxX5Z3dLql1U1cfSO2ZHDh122/F70WgIxrExIl/OL0fTJBU8sMqI8w7Xw7abtpC/
	0Q7fXckl+RgSTjYvM1HL8i5mhUFZEU+MnKk/N3+05HOCQSFfToSSdhE2hcge2GgWtOCTyCHMR3p
	gdmp485drm1x1LciyfyWyAjjdTMy0ncIpGYE5qnZkCJEpZxzWiG/Fzjkd7HkwcDd5/HpO2i+Iyr
	uGmOoKnMk75fA0sdPvsvPOkOHga8d5ZvvqnOMO21YB51Qum8PzNyzZ0BRDPK53hd0/ilwl1LS20
	vTQlfBA=
X-Received: by 2002:a05:6000:22c7:b0:42f:b9c6:c894 with SMTP id
 ffacd0b85a97d-4342c54874bmr4803390f8f.52.1768427314594; Wed, 14 Jan 2026
 13:48:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGe2LO0nxXuNNRYS0fk0JuPBDa3UCT8EDJ6G1u4GNW1d9rzRgA@mail.gmail.com>
 <CAOLa=ZT4fQdHqG+1AeviYuLUR5VG33voJk_DU1y0MzhUKBQvvw@mail.gmail.com>
 <xmqqh5sof61i.fsf@gitster.g> <CAGe2LO3t3B1g1ARH-LQ9V0UoGmToO-Z9XYpeMOTKkaSQvCpaRA@mail.gmail.com>
 <20260114211115.GC1008851@coredump.intra.peff.net>
In-Reply-To: <20260114211115.GC1008851@coredump.intra.peff.net>
From: Rajiv Sharma <rajiv.tilakraj.sharma@gmail.com>
Date: Wed, 14 Jan 2026 21:48:22 +0000
X-Gm-Features: AZwV_Qj6626CdosPMZJ5PAQNeZwNpQ-gRVg1IlqwMKmTLhBAWyG5wGRgDoanYDA
Message-ID: <CAGe2LO188CuDetOKRQZs8MNw3Fq9LxpAwM8HMEP2AMHAB_g0_A@mail.gmail.com>
Subject: Re: [BUG] Git push sends too much data unnecessarily
To: Jeff King <peff@peff.net>
Cc: Junio C Hamano <gitster@pobox.com>, Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Ah you are right, "push.negotiate" is exactly what is needed here. I
tried this out and it works like a charm. Thanks for sorting this out.

- Rajiv Sharma

On Wed, Jan 14, 2026 at 9:11=E2=80=AFPM Jeff King <peff@peff.net> wrote:
>
> On Wed, Jan 14, 2026 at 05:39:43PM +0000, Rajiv Sharma wrote:
>
> > > This boils down to how Git negotiates between the client <> server
> >
> > I think that's the crux of the problem here. I don't think git
> > negotiates in the push path the way it does in the read path, i.e.
> > there is no process of client-server communication that involves
> > gradually arriving at the common base (in this case it would be C3).
> > The read path does this quite well (using something akin to a skiplist
> > IIRC?) and the common base is found in a couple iterations in most
> > cases. I am unaware of the historical context behind this difference
> > but I assume the server sending unnecessary extra data during the read
> > path would be much more expensive than the client doing it hence the
> > push protocol is kept simpler.
> >
> > This kind of negotiation _could_ be added to the push path but it
> > would be a breaking change. I read somewhere that there were plans for
> > Push Protocol V2 (in the same vein as Read Protocol V2) so it would be
> > great to see this improvement making its way there!
>
> I think you may have misunderstood Junio's response. We do have
> push.negotiate already. It's just not the default.
>
> Did you try your example with "git -c push.negotiate=3Dtrue push ..."?
>
> -Peff
