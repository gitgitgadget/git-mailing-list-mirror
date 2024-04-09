Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2023F14D2AB
	for <git@vger.kernel.org>; Tue,  9 Apr 2024 16:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712680604; cv=none; b=itAqXI9YcAdOXt2hJtv3SeHJLIZmQyRLlHDVNXZaernaV4xN9JA8U0Fi/Svecb3UkRFlvyjpfrnfhoLxoKJEA9YtmGGZi8s5diBZsG8k3z+a40CsIQMtMQXP3uEUwlLIJskIsNv/xu8AbQhjNOQkKxfXMiSUl1WlC4RC7YyXGmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712680604; c=relaxed/simple;
	bh=MoV4O4VgkYPH5dC3hcLQ9I+jMMYTKmQhelKeoe9mKGE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FJ2Ttqec+uKME9RoBpnTBmh6BPHHdGoXiv1M05ynpkoNJdPIU/1JH8+6pSTlGXGzyVOaNFhYAD9zk20ZO6uNIRN1FgsownKmthHL1sdxxdPvOlzKkkJnRpAauIAFWdtmghH3XFiYqu6OKVdcuDjNdU2g+OGRvIsf1t4WroB9M2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DA/t0EjZ; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DA/t0EjZ"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-42ee0c326e8so3291cf.0
        for <git@vger.kernel.org>; Tue, 09 Apr 2024 09:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712680602; x=1713285402; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rk3zykQLxyIHXM9zn2YV7oQkGPWzj6DfNwm5osFFjcs=;
        b=DA/t0EjZK4EeFkLXF77t+VGASZs/JIMUCimuFxnJ1bknoUtDQo9D90xb6oV0ThqUeV
         iXI9ja56qV98llKgEgCnfY3PiR9P4srzMeEQHNicO6ez4R/+HJvfqo0/fzPi1tdDH4VR
         Yu1pGin3ySBDN8o9egveVrxxsOB0ctcgPyVvLtOR6Z0Nfpp+fhf3cWLg9ACvwB/yO/v7
         3jYjL1gqTP7d9fqO2LQ5TP+q0UHmAZ4yps0Ytvg4KtbVXVhVy1OL/6qdyJieI/sRZeU7
         SSgDvENMjnQj7h3hxW2jQh0WL+tHRDPkfG1Ci5EAmNAZ6CkPsxy1f3uRuAf7e6b7sN6z
         BH0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712680602; x=1713285402;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rk3zykQLxyIHXM9zn2YV7oQkGPWzj6DfNwm5osFFjcs=;
        b=r/dcL47GJugTIB9GQwsDi4HzfGwv3stBL02a9ES7hx2Y38UPaV2WeXL/8dNAdTKVU9
         XtjKyFItCQ8Js39H5hxOdTzOBY255OpcVNzYgwJGvZzglqdwThsRkldd8K15a5OFtxRP
         0/LvJc7uOZ4UxZhZBO2sqy8hXl62gFlyfcifouitAx2DY8xDa85XNTS2x33eV6D3DoWs
         jhfrdl+C1G+0uX5ccqhRyYoCC5oyvyy45xM/aSsLwtjg4YWLQ16uwtCEBgt2WfyM+2Gv
         qlXmCNmNnzJrdG8ciKNDgUkA/j7CQLK9Lv9GOHCDlR1UvNV0TP2MX2PoojWomoKNu82p
         fwOg==
X-Forwarded-Encrypted: i=1; AJvYcCWa6pOoLk764qCUJUhtbs3ZBPWF4QcLet9G4lGvVxqONRIEq9xZUkOiahDdQrvnpe+pPU7stEaATP3VA7NKDpX7AiSt
X-Gm-Message-State: AOJu0YyRkL1lImn+3BHYCoo8qA+mF0bnmfjuyx47MMpCq3svul2sjdxp
	1Zw+BrZZpl2ybYzmQ1OVAhLFdDMjOrj4i8SijUESaTQt+We9SJ/psGd0B1lWQUmB5t1r6QpzYOR
	girl1XsY5SGs031RcoHcVpDWhNPbdJ94hmOH+
X-Google-Smtp-Source: AGHT+IGQD0xgqu7WRqFCr6MVWGSRwW+D26k0PLj2pmm3y9iMJAS/QK1Fzr+rVkBELvrZmxrSh3Nd30K7DsNkLGmQH1E=
X-Received: by 2002:a05:622a:400a:b0:434:6677:7311 with SMTP id
 cf10-20020a05622a400a00b0043466777311mr250234qtb.17.1712680601782; Tue, 09
 Apr 2024 09:36:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240407212109.35131-1-benji@FisherFam.org> <xmqqr0ffbvjq.fsf@gitster.g>
 <CANc=FSNXzsFqzbgGs3CVAPxtxske_DEorNrk66gvYe2+1d_PAQ@mail.gmail.com> <xmqqwmp61poj.fsf@gitster.g>
In-Reply-To: <xmqqwmp61poj.fsf@gitster.g>
From: Emily Shaffer <nasamuffin@google.com>
Date: Tue, 9 Apr 2024 09:36:27 -0700
Message-ID: <CAJoAoZmBvkVzP2i=BEgZ9fEcQFHtPkh4pPHm4hj_U5AUqKQFFw@mail.gmail.com>
Subject: Re: [PATCH] MyFirstContribution: use switch for changing branches
To: Junio C Hamano <gitster@pobox.com>
Cc: Benji Fisher <benji@fisherfam.org>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 9, 2024 at 9:11=E2=80=AFAM Junio C Hamano <gitster@pobox.com> w=
rote:
>
> Benji Fisher <benji@fisherfam.org> writes:
>
> > I was under the impression that the new "git switch" and "git restore"
> > commands were recommended in most cases instead of "git checkout".
>
> These two were added so that eventually we have something we can
> recommend to new users, but as a pair of experimental commands, we
> reserve the rights to update their UI in backward incompatible ways
> (meaning: those who use them may need to retrain their fingers and
> update their scripts if they used them---not that using these
> Porcelain commands in scripts is a good idea to begin with).
>
> So your justification could be
>
>     We want to evantually be able to recommend restore/switch to new
>     users, and want to take advantage of every opportunity to polish
>     them.
>
>     Because this document is not exactly for totally new users, and
>     the readers are expected to be knowledgeable enough and highly
>     motivated in improving git, let's have them use these
>     experimental commands and report newbie-issues they found using
>     them, so that we can gain more experience and chances to polish
>     the command and eventually make them recommendable to new users.
>
> Note that the "WHY?" in my response was not "I see no reason to do
> this", but "You need to say why you think this is a good idea here
> in the proposed commit log message".  Without your version of
> reasoning, my conclusion was "I do not see a point", but with a
> justification like this (there could be others---it is contributor's
> job to explain why a proposed change is a good idea, not mine), I
> can understand the reasoning why this change may be a good one.

For what it's worth, when I wrote this doc I was new enough to hacking
Git that I did not know about the new experimental commands ;) or else
I would have used them. I am not opposed to pointing them out in this
doc as part of general evangelism towards a nice UX improvement (and
that could be good justification for the commit message, if you agree,
Benji).

 - Emily
