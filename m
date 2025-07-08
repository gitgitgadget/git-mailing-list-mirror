Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B24CF1C6FEC
	for <git@vger.kernel.org>; Tue,  8 Jul 2025 10:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751969871; cv=none; b=Yeyd4MwCW8kC710daj1JCoFUbyBq/ddr9fbjlKKFDWD1biKxNLyCpZBVpZtGkfXIndBigy6CVIFk7cTC5MzBjClRL3XL++mLTTijiMpWK4RgF7C8XqtHfwhaO5txQl4rtfybzlmfX4UnqNdhM44fXw4jYqLn6XlGplxwGzpxdhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751969871; c=relaxed/simple;
	bh=j3jVhf+M7/IA78QyA2DH2W3H4EIXFoYkeVvbD4JNN18=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kUmx9ltH+1W5u4X3hoS3TeSWgpy+Y+BeDRhSLwFgb9LdNk4kiyqPPIdYYtfH5tPWgpZIyg25z1hQ8POd0J4Nu79r/RKVO+eolLm75pKBf/SP9BNFvbRblosT0cL2mEPc/lBz5NnZzD2+usT8/Gn8l6LRlH5n5OR+PEDsqITSRSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aMSFKsot; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aMSFKsot"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-60c3aafae23so11423561a12.1
        for <git@vger.kernel.org>; Tue, 08 Jul 2025 03:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751969868; x=1752574668; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3iokrQTZ55QL6rKfcAeorPIUAe+PjsmrnWv3gTZq/M4=;
        b=aMSFKsot2boiJdSidhAkagyrYb06642owIuCibSDm6Vgdnh2ijXU3lOSWL+xkOzLcH
         cAFYVTeI+j5yiT0jccPjyersUzO0OYS7UWJX6vxT0/FQ2wP9kbLOrrQIWwfRFXrRVY/W
         hiORzSRqk6dKE0IGj65jSSXq8z9GQXcGQzqeSfVXAhJEKyZoc8hK9cIrY/Hpb6hs8y+s
         libfZbIHU4AwMYyDDqahOIUeWlIflBvTvRlelIOo1Xm9jQe3na0JHIHyG8YJQPdPCMWp
         y7S59PPnNjVjWxRKT0NvnUa3K81FWGC18nOf/wgoHJ1+9i4mylsnJV6py32BHwQiaP1B
         vwsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751969868; x=1752574668;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3iokrQTZ55QL6rKfcAeorPIUAe+PjsmrnWv3gTZq/M4=;
        b=tGnw3AsDPPlOMvAylj11kztksIzloo6BFDKoV9+Sd/ET+x1WIPtPPrcRm9Dj99ADdz
         N8khY0JUCwAJQb0VD2IR+scr9dvSGhUvyyL0unHwW+R5I1lpxDv0WDZ7Rap0eeFssZ3U
         CALGQ1LVpIpdCcCihyszfi3rD7aLL7uCgqBhh0hRg7ZXnu5urkqM30vTBqLsv3+qswSH
         epJLutjcj2YwkU4Ba6yqXPSSR4kQsaThbDfQA4n9i/Q4/+PUfTSLYv/kJMlx2FOVrsGX
         0+XwYAGU3dqwN1UzrLBkzMfx/1Vp2BUIm/8OKyk8VaHSMJIfkV08SCv9Xw78/+D37r4y
         jyeg==
X-Gm-Message-State: AOJu0Yyipl3CcqSXvTFlFDsLiRfnNxL4osTb6TOW3tUZSk922h5E4PFx
	pMohrQFPlGk4bUX+l310o+dOo3CQlIyI+zI9GuH/Lreq6K9Vnr/ilhLuTKpsyoRCrgOnOL1rDu2
	NNh1KLXOZLSd0skUFVirK68xuYRxzdQo=
X-Gm-Gg: ASbGncu3LCaAIq1PqACdoOmxxqOwK2VHMf2Va+Wi5zJRlMyQ8CXM01wc6KJxwliRb6C
	KnylNUgGZ+vGBQbNvv1PFQrtt2VQh7Uu7SRzyDDQpaVEspLV0IQPEghzwmSaegsBGQ35ZaizV/R
	ntNypDD4iGKzrdrXXPrUXTWHv6gNxk2P+6AShCsWtCAYzml+BMieNMIn64QUSqMbsGw5KGyVGue
	VO3
X-Google-Smtp-Source: AGHT+IEftW8UiokhXTvQrVa8hvmHu+vKHnjsjWryOrykOF1HpFuuBiUQUB8krX/RZL3nMvbjOL8D+QJHJbfUyEW40fw=
X-Received: by 2002:a17:907:3fa7:b0:add:f68c:5200 with SMTP id
 a640c23a62f3a-ae6b2a45b79mr236388566b.6.1751969867899; Tue, 08 Jul 2025
 03:17:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250618151821.528627-1-christian.couder@gmail.com>
 <20250619133630.727274-1-christian.couder@gmail.com> <xmqqbjpv1ucb.fsf@gitster.g>
 <CAP8UFD223ja7jKU+wb6TiGkc9frh5dt1rCJkOkk+O+J2MPokrw@mail.gmail.com> <xmqqwm8jxoj3.fsf@gitster.g>
In-Reply-To: <xmqqwm8jxoj3.fsf@gitster.g>
From: Christian Couder <christian.couder@gmail.com>
Date: Tue, 8 Jul 2025 12:17:35 +0200
X-Gm-Features: Ac12FXwjOg62C5GQ9a5sPfglUmRtF-4sUIX1f8K6AfMEbjeuB4rUYeBZVUKfWsw
Message-ID: <CAP8UFD3ZitsRz3ccAjmB_k+DhdYw+AJgf-2vPCGUaRAgWd9SEA@mail.gmail.com>
Subject: Re: [PATCH v4] fast-(import|export): improve on commit signature
 output format
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>, Elijah Newren <newren@gmail.com>, 
	Jeff King <peff@peff.net>, "brian m . carlson" <sandals@crustytoothpaste.net>, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>, Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 8, 2025 at 7:03=E2=80=AFAM Junio C Hamano <gitster@pobox.com> w=
rote:
>
> Christian Couder <christian.couder@gmail.com> writes:
>
> > On Tue, Jul 8, 2025 at 12:58=E2=80=AFAM Junio C Hamano <gitster@pobox.c=
om> wrote:

> >> We haven't heard much after a few comments were posted on this
> >> latest round, since Elijah's
> >> <20250619133630.727274-1-christian.couder@gmail.com>; I understand
> >> that it would be the author's turn to respond (the response does not
> >> necessarily have to be with an updated iteration).  If so, let me
> >> mark the topic as Stalled in the draft of the latest issue of the
> >> "What's cooking" report.
> >
> > I will hopefully send a v5 later today.

I just sent it and replied to the pending reviews about v4.

> Thanks.
>
> By the way, I noticed that you often do not respond to reviews until
> the last minute, at the same time as when you send your next
> iteration, or even soon after doing so.

Yeah, right.

> That is quite different from how other contributors operate, i.e.
> respond and engage in discussions triggered by the reviews, and
> after people involved in discussion got an (even rough) idea of what
> the right next step would be, if not a total consensus, send the
> next iteration.
>
> I do not know which style is more efficient form of cooperation, but
> it somewhat makes my job harder, if I do not hear much _heartbeats_
> after I see review comments on the list.  I do not mind waiting for
> seeing the next round for quite a while---after all, any substantial
> (re)work takes time.  And responding to reviews may need thinking
> things through carefully, which may take some time, so I would not
> demand an immediate response, either.  But it would be nearly
> impossible to feel the current status of such a topic---a few review
> comments are seen, the author goes silent for a while, we cannot
> tell if the author is working on a new iteration or where the author
> and reviewers agree and disagree.

Sorry if it makes your job harder.

When I work on a number of different things, I alternate between
topics. Just after I send a new version of some series to the mailing
list, I usually start working on a different topic. These days for
example I alternate between this topic and the promisor-remote
capability topic. So it seems to me that if I were to respond to
reviews right away, I could be switching topics all the time if there
are discussions happening on several topics I work on.

I know I still have to switch often anyway between topics because I
might be pinged internally at GitLab about some issues or because
someone I mentor asks me a question privately, etc. And maybe for you
or others switching topics often is not an issue, but when topics are
quite complex I feel it makes it much harder for me to focus on what I
am doing. I don't think I am the only one in this case by the way.

> Also a review response that comes at the same time or immediately
> after a new iteration is already sent out makes it look like the
> author is refusing to continue discussion and reviewers are not
> welcome to make follow-up suggestions during such a discussion.

Sorry if it looks like this. I am not refusing any discussion or
follow up suggestions. As you say above, responding to reviews may
need thinking and often working to try things out, and often it seems
to me that I cannot really reply properly if I haven't worked enough
to try some ideas.

Let me take for example the v5 I just sent. It's only by researching
and trying different ideas without knowing if they would work that I
found (after a long time) a way to write a proper test with both a
SHA-1 and a SHA-256 signature on the same commit. It was the same for
using "$GIT_DEFAULT_HASH" instead of "sha(1|256)" in the tests.

So yeah, I could have replied early with "I will do it in v5." or "I
will try to do it in v5." or "Ok" or "I will think about it." to most
suggestions I got, but what would have really been the value of a
response with mostly those kinds of sentences in it?

> Instead, the next iteration comes as a fait accompli,

Even if I had replied with mostly "I will do it in v5." or "I will try
to do it in v5.", etc, to many suggestions, I could still have found
or decided for some reasons to actually implement something else and
use those reasons to justify it. Would it have been less of a fait
accompli?

> and makes it
> less useful to continue the review discussion on the previous round
> by responding to such a late response.

In my opinion the discussion can continue with more useful and higher
quality information, as I have worked significantly to think through
and try to implement the suggestions that were made or to research and
then often implement other solutions. Yeah, it doesn't continue on the
previous round, but hopefully the new round is better, so ...
