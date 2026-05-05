Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B4C430C615
	for <git@vger.kernel.org>; Tue,  5 May 2026 23:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778022468; cv=pass; b=thWp95LKLuDBBy2+AVYbhaWqZTutjpZ7Ajv0QyPmUzQmIjrzCGcpmiuhZCdCU+bPxHAL+o3zteo/mIVmys6uVVZyXSOdSUKpbLV4KhkVxSeHia1LCSrqCr8k60S30Y7Bn0MQxYMRrICaHp321WSQduf2FhYSrbFx3KKJzxBeeu0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778022468; c=relaxed/simple;
	bh=pUI4sLqTVkbnyrxm9HybIzMTq6oofqE5v81lEAMnwtg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GxN0hOTMEuSPS+AwsX68+7jsr3G9915BxElTyarKtQm7cOVwCfJ5cw9xioTHpnhqfVTLKcImimTSpLf8ARhW+h09YbVqQWqL3NnJFMLHAI5wM8MlGze8b6MkddJOYw7svXJWuWlFAsjUEynmp+VBuvsvNDMn0m5qR13BgDtYtHc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=gmail.com; arc=pass smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-39393ec4ed0so34277991fa.0
        for <git@vger.kernel.org>; Tue, 05 May 2026 16:07:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778022465; cv=none;
        d=google.com; s=arc-20240605;
        b=DwswFre7aZdvoTtdtJuOvW/1KwTzTfTmyTmg7LKEk/Xrtrrg3Ohb0X5VSFMWvtyZWd
         mvja5s/R2/PTTGoH6MSlKfvso7n1Idh3DOP7mIKdORRnAluzNfNJVgek+IHHMUt2oAvM
         REys951SM7E3MOh38njxi08ig1tN5avdmPMVF1l9ot0RzWDlKqUp90Xy/NpgreMdzy9l
         Qkltdmlzc3Z8vIzW1RgT5BQYtkQRNw9K6RLSXRkN5gpoj4tTA5POQfhUS1RE9E1fAtys
         jrXhznyWC/vvVjWutXx8fgWYUcuGgfChVHE/4TE+l2Je4zu45EVjgSbIaevTa1VcHS9y
         xGqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=axYYvYuKqcQl1+j1i6sSsBEYA66HHHOXBBPc26b+mBQ=;
        fh=wbYxXeni1XPTnre7Gq1y+nFRJClBzAah/qPqAZ6gb0k=;
        b=FGyZeKrM4C0ZvmjMH96jjqL1UcYpmpc6rrjT/1h2pDNYoSTwdb1IF/gg4Vxho3ranl
         fOBYuz/RRb7Vr/pfAQZ9kL62mE9L80GeLhOY87K66M4UBs3FwKfyuPNqh4bJ02Wvnn0g
         rjPqwkUwpcIsrIF6NIbJZa+v9U8t/60+fCQ45iH1jODjsAKmFWurFcF+rv2C+Ubaff2i
         UlpMKpkJPgqg9Bo9ONtvQorzkxWOxdl+hIQO2JBf/HL7Hfj5vCZpr1xvZ/EEowzti2Oc
         1bCObBeJ24Slu9ZxthCioVYqmYg1SKLEQPXqV7BvFE6sXmz3FDa3Au5S+IKhLSy+KPct
         1+kw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778022465; x=1778627265;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=axYYvYuKqcQl1+j1i6sSsBEYA66HHHOXBBPc26b+mBQ=;
        b=eBuQruI92l6hqzLQ6n8+jHAsfnC5SLO3TomTXwJuZumr1IhtZ6olQHr4J/pt+S5+z3
         CcDUouv418upnuVP7YYL9nihMKouBvFTJxmAC34gpy508X1avZNjT+hlMnRnRJlTQQVU
         mPBsZ/cnOoUW1sVlNP/nzq6gc6oChdwMksO3PtuIz5CJOrqm0asf6d1vIKLKfU8D6y3+
         jzAfKxCO8YBwMuJmOCy4d/i9NGQrnduX6uMZsNUrXkeCsiX8dP6W96oV3GG6QQpdhI40
         LtwQW02uN0wyG76gjT3RhdRnPvMRs0Ld4xY+yQRJtRdFSy6Vk9pW83L8mt+04f0huGYq
         ytKw==
X-Forwarded-Encrypted: i=1; AFNElJ8nFNNQZ4a31Rw0hiD7KnGPtWPeYd258obzaXYryZQ4scCbiXUF2suoCGqWnsGC1LL1kHM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfT75T2FuI1Kkj/FH1CHd3vMTsYih046KGdi0S64IW1D6soGb4
	Y/g9kbgsg/aFJj3lvGPcG28DygCAK9EbDGAaAhfagHHyJrkC/XbY2pfgStqXU8dxy8sPe6Jq1MQ
	WA+liVBTk/wMTMgkB93UkfXT/DjItae4=
X-Gm-Gg: AeBDiet/bOrYjhJg5TbYsgMNLxlU5qutdjhGHJWU/vqUoYzNIquY6zjF0B3ZXerz3Bm
	GY7w60MfLcLhTgwQwwBnFdG6c8RKBtd0sh47srAf0coEt4TFHtWcJhOgeTxo1clZvFXv+jWBo6Z
	mwnTX/5IcQZfETiKxjHtgd30Yc/LUy2YiqQ7zEveF3L/FNi9n9zcQLh91zT2hBIql99rCMogJ5c
	dwyywLOqSp5LENBtZRfFgy07tRrrV57+WRiJG/f1GjT6b8yMg12fOYB4MNo7nO3h1Oz7dnN565V
	l8zE/aiQ/7JiI8+a9oM=
X-Received: by 2002:a05:6512:33c2:b0:5a8:5289:7bc0 with SMTP id
 2adb3069b0e04-5a887cdf0d6mr184565e87.21.1778022465090; Tue, 05 May 2026
 16:07:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2102.git.1777393580.gitgitgadget@gmail.com>
 <pull.2102.v2.git.1777914508.gitgitgadget@gmail.com> <1eaaa7fad7a1432dd97ffdd7c45e8162f61bc302.1777914508.git.gitgitgadget@gmail.com>
 <42f96e54-7b94-4075-91b1-1c2447b93322@gmail.com> <xmqq5x52nhg6.fsf@gitster.g>
In-Reply-To: <xmqq5x52nhg6.fsf@gitster.g>
From: Junio C Hamano <gitster@pobox.com>
Date: Wed, 6 May 2026 08:07:27 +0900
X-Gm-Features: AVHnY4KMmdOD9DQJ7wY7ETAVS0ikpu9QIxm-vXV6bTl9mUfPt4dnX57wy3kvjuM
Message-ID: <CAPc5daUzr+mn6ojzsqpW6mCXzc2yVqpevVk8njefx4j09G_OgA@mail.gmail.com>
Subject: Re: [PATCH v2 11/11] ci: run expensive tests on push builds to
 integration branches
To: Derrick Stolee <stolee@gmail.com>
Cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	=?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>, 
	Jeff King <peff@peff.net>, Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

(in GMail web interface, excuse typos)

https://github.com/git/git/actions/runs/25366120610/job/74377320625

We seem to be hitting the same _Generic error in various (but not all) jobs

  /usr/include/x86_64-linux-gnu/sys/cdefs.h:838:3: note: expanded from
macro '__glibc_const_generic'
    838 |   _Generic (0 ? (PTR) : (void *) 1,                     \
        |   ^
  Error: list-objects-filter-options.c:222:10: '_Generic' is a C11
extension [-Werror,-Wc11-extensions]

I thought we updated the codebase to avoid stripping away constness
with strchr() and friends, but the error seems to be more like one
hand in the system passing -Wc11-extensions to stick to older version
of C and the other hand in the system that uses _Generic to implement
the const/non-const variants of strchr() in the system header not
knowing that the other tells C11 const-preserving strchr() should not
be used?


2026=E5=B9=B45=E6=9C=885=E6=97=A5(=E7=81=AB) 21:56 Junio C Hamano <gitster@=
pobox.com>:
>
> Derrick Stolee <stolee@gmail.com> writes:
>
> > On 5/4/2026 1:08 PM, Johannes Schindelin via GitGitGadget wrote:
> >> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >>
> >> Derrick Stolee suggested [1] that expensive tests should be run at a
> >> regular cadence rather than on every PR iteration. Gate GIT_TEST_LONG
> >> on push builds to the integration branches (next, master, main, maint)
> >> so that the EXPENSIVE prereq is satisfied there but not during PR
> >> validation, where the extra minutes of wall-clock time do not justify
> >> themselves.
> > I like that this will be run as part of regular updates to the
> > important branches. The important bit after that is whether or
> > not a human pays attention to the signal of these builds.
> >
> > Junio: Do you pay attention to CI breaks when you push to
> > 'master'?
>
> Well, it is way too late to notice breakage when the faulty update
> hits 'master'.  CI failures should be noticed before breakage hits
> 'next'.
>
> I often notice and complain when I see failures on 'seen', and
> sometimes I help original submitter by bisecting, but I do not
> necessarily have enough time and bandwidth to help everybody.
>
> Quite honestly, the best place to give widest test coverage is much
> closer to the source of the problems than in my tree and mixed with
> other topics, i.e., at individual contributor's CI.  That way, I
> presume that GitGitGadget can also help submitters avoid sending a
> faulty series, reducing the load on the list and the maintainer.
>
> Ideally the CI tests by the integrator should only be catching any
> mismerges and unexpected inter-topic interactions, as they cannot be
> caught by contributor's standalone tests, so I do not mind widening
> coverage of CI tests when I push the integration results out.  But
> so far, the majority of what I have seen and reported back to the
> list have been something that the authors should be equipped to spot
> in their topic without getting mixed with other topics into any
> integration branches.
>
> > One way to help this procedure could be to have GitHub CI
> > failures trigger new issues, which could then be more easily
> > viewed and noticed by the community watching the repo. This
> > is of course out-of-scope for this patch series, but could be
> > considered in the future.
>
> I think a better way to help would be to arrange the workflow so
> that we do not even have to trigger an issue, and stop before the
> patches leave the original authors' hand.  They can of course ask
> for help saying "here is my topic in my fork of the repository and
> failing in this way for macOS that I do not have access to.  Could
> anybody help me figuring out what macOS peculiarity my changes are
> tickling?", or something like that.
>
> It would be best to find problems early, and make it easier for
> individual contributors to help each other by having a concrete CI
> failure reports in their forks that they can point at when they ask
> for help.  And CI run when I push 'seen' or 'master' out would not
> help as much as CI run when they publish their forked branches would.
>
> By the way, please expect slow responses as I am (officially) still
> mostly offline for the rest of the week.
>
> Thanks.
>
