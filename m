Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F77717C68
	for <git@vger.kernel.org>; Wed, 24 Jul 2024 07:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721805495; cv=none; b=OKZrq1Wu+F0JazmTr3zbUQirr6uEjdMxqJNBn3wGdWN8ZvRR+ZpAQ1djlP6m/k/hTC+4mSNC0izbNYkgPqy1zfRh2u61dnjYxsxiEP2VZ4EKYmD45P/xPXxU1xFLi9uzkT/UFU0jbfHfW3hSgcV2Vv33cpBCbgBoEgAfUCWmMxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721805495; c=relaxed/simple;
	bh=bcfFXLLtBhhxRkb82/cedsGbgcPnO8ojxiQa2pZbLnI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WvGhl4LsbK/lWTrhqUBM5IK2pEe7pQCg8lsGM9my9A36YCsfN4c3vwSXPGiCIhOmuqmJo8ienrtAxNqrTNLkKiTgcp4RqnhUTTNq4/V4WuueNyJBf7kZT3IzjNAMdorewq+Oq0cjf1zfTHhHI/UiYxjoV+iV6daAMqOjGgNxRmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GDTqNvfr; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GDTqNvfr"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-52ed741fe46so7425397e87.0
        for <git@vger.kernel.org>; Wed, 24 Jul 2024 00:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721805492; x=1722410292; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aapdJt2xSrDMYXofuFYShZXa587evAM6IY4ZBUxqM/4=;
        b=GDTqNvfriTJW+TA/HHzkHktQ5pA3gZSwP1ssozNWOHzANob06DdtBGqc1D05cJUSWS
         S2EQrvTeK5VE+flW/8oVyRqSr8ojKtXZrQ9+uHWEpPmQ08hUjGQoD5Rk4rRH5AJiPcUg
         zRDO+Jqhy+1plE6GQMEgPG6fw+HZvQYDBi0TcezSzwF+eDgq2kxZLs153wdIkiougb4F
         05JwXQMxsd9Od4fqEQs15gihG2TUiDQ03HtUVY/uhQ1PqquQuEXjmAhRJQ8VpgvFBONb
         NZKoCPqIuNWnkUj/cqz9wtV9rr8fiU+F/wNnQF3ZB8ars7wxBhPkTkTkdGtGyaPpJehE
         CqJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721805492; x=1722410292;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aapdJt2xSrDMYXofuFYShZXa587evAM6IY4ZBUxqM/4=;
        b=ptXaIS0pNkFhvINaFQAGUgQZzcDefy86oUhW63+MlL6Fu2dFgFqhOiYAxyPl8t0kjj
         AYtV7qV6YnPIQU2Nz8o6Shi6Y0GXraV1Rq6VZw4DR/258Up5K8VwkBubrmoD5IkiNJyh
         KAZzNFzJfy/7Gy730ye59w0nfrL4skgAk0iHM6jx0o1WfwwjDjiiTX5czaspBOYq1jB7
         bl4e/Ju7IeeylaNhJ0zaftvRnzw03it8YmzGCb/Ktcjq1bShiRFXihu6vFjG/Wc9sIJC
         lX2XA8iNVMVwPxi4t9N+fvdLT+Ux3nRwQwLH372VCoJhAAVie8+u30MtpkY+dh8YTCJU
         9HXA==
X-Forwarded-Encrypted: i=1; AJvYcCXoU1CUGP/HS1l3VHzCzeUX7zisuIb4DQQJpHj1/uA0FJnp8t+GnbExT+VEmScDEHFAdDJp4qMgr1OKdc29vr21CGoL
X-Gm-Message-State: AOJu0YwncBfgcaKGevM12zrx+AAXts5ozubpADJY9BxDKXByPGmta9y9
	tSzy3RkxSNpRXkivrPknGqCSY6KXf5/lXo7aUiet/0fMbwOoOtN5kvAo0iRzdM4OXd4WhDQjZTl
	vj8gs/KXzIVtyXkKBZepsWL6RblE=
X-Google-Smtp-Source: AGHT+IEWIw/OMgZqDZ8y2f+zZxlzkBPgeshszF7YlFUfpOQa77FRLOFwDvW+LHLHCRZC4Xhj8+bdYjFhHAGbp31hIwM=
X-Received: by 2002:a05:6512:12d4:b0:52c:8fd7:2252 with SMTP id
 2adb3069b0e04-52efb76dadfmr8385753e87.11.1721805487636; Wed, 24 Jul 2024
 00:18:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240614095136.12052-1-chandrapratap3519@gmail.com>
 <20240723143032.4261-1-chandrapratap3519@gmail.com> <xmqq5xsw2fyd.fsf@gitster.g>
 <CA+J6zkRKzQGvwhiQdgRqcctDP76y5_v582rRTzEXJyx7=+WRqw@mail.gmail.com>
In-Reply-To: <CA+J6zkRKzQGvwhiQdgRqcctDP76y5_v582rRTzEXJyx7=+WRqw@mail.gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Wed, 24 Jul 2024 09:17:55 +0200
Message-ID: <CAP8UFD12Cqorr7oPS+JfOTYY6LaNUgPEJaEscf-jwLUOur+xqA@mail.gmail.com>
Subject: Re: [GSoC][PATCH v5 0/7] t: port reftable/pq_test.c to the unit
 testing framework
To: Chandra Pratap <chandrapratap3519@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>, 
	Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 24, 2024 at 7:12=E2=80=AFAM Chandra Pratap
<chandrapratap3519@gmail.com> wrote:
>
> On Tue, 23 Jul 2024 at 22:39, Junio C Hamano <gitster@pobox.com> wrote:

> > > - Rename tests according to unit-tests' conventions
> > > - remove 'pq_test_main()' from reftable/reftable-test.h
> > >
> > > CI/PR for v5: https://github.com/gitgitgadget/git/pull/1745
> >
> > By the way, I still haven't got any answer to a question I asked
> > long ago on this series, wrt possibly unifying this pq and another
> > pq we already use elsewhere in our codebase.  If we are butchering
> > what we borrowed from elsewhere and store in reftable/. directory
> > and taking responsibility of maintaining it ourselves, we probably
> > should consider larger refactoring and cleaning up, and part of it
> > we may end up discarding this pq implementation, making the unit
> > testing on it a wasted effort.

I agree it might have been better to start by replacing the pq
implementation in reftable/ with our own first, as there would be no
need for this patch series, but Chandra's GSoC is about replacing the
unit test framework in reftable/ with our own which is still valuable.
And I think that at this point it is just simpler to not get
distracted by replacing the pq implementation now. It's also not like
changing the unit test framework would make replacing the pq
implementation harder.

> I did talk about this with Patrick and Christian on a private slack chann=
el
> a few weeks ago and here is how that conversation went:
>
> Me: Hey, I wanted to talk about the message from Junio the other day.
> It is true that through this project, we are modifying the reftable direc=
tory
> to a point that it is no longer easily usable by someone from outside. If
> that is the direction we want to take, wouldn't it make more sense to get
> rid of reftable/pq.{c, h} altogether and use Git's prio-queue instead?
>
> Christian: Yeah, I think the direction the Git project wants to take is t=
o
> integrate the reftable code more and more with the Git code. On the other
> hand, there are libification projects which are trying to split parts of =
the
> Git code into libraries usable by other projects. But I don't think each =
of
> these libraries should have their own test framework, their own prio-queu=
e
> implementation, their own string implementation, etc. So, even if I am no=
t
> sure about the end result, I think it would be ok to modify the reftable =
code
> so that it uses the Git's prio queue and maybe other Git data structures.
> But I'd like Patrick to confirm, and the list to agree to this. So I'd
> rather wait
> until Patrick is back from his vacation before doing things like replacin=
g
> reftable/pq.{c, h} with Git's prio-queue.

Yeah, if it had been discussed and agreed on earlier, I think
replacing the pq implementation would have made sense. Now I think
it's a bit late at this stage in Chandra's GSoC to go in this
direction though. I think it's better if he can focus on finishing to
replace the unit test framework.
