Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00887DF58
	for <git@vger.kernel.org>; Thu, 19 Dec 2024 01:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734571872; cv=none; b=fCtPltCkIWmpdC/c9SihocVefVw6pr89uXp71KQmGJEgebjZEDuQw2AG0vXNrL7eOjaEjgJyvUfr6U89nPw+SX4hufgCIyiP7m3Gamwe5X0J6jsvrH3i9vpJ4T5YoBzdeOmSkNNxcrd9V6Whr64ywGGdA1BJ+QFkfnhrIi9HeRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734571872; c=relaxed/simple;
	bh=PI1zHj6ftnOqYhgZNkJ1Xc5bLZzhIzT7kxoGwpYz94E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OhnSnHN6vN3t9bg79fNJx77vrL9IKalGL5PhfQfczTvo2mKJTM5XTGTucCjNNkBWzNHzIwpvsMEqJBJgfkyDXPq+bb9Lu3bmsIuWvBPgBVZU1rV1ekolWU13Tdt1MBm8i91sH8GQyDnT5D0K9Fd7mggtxqUhhJliu+XSrLtymJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=uQXdWeWS; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="uQXdWeWS"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-6f145e5cd83so2577057b3.1
        for <git@vger.kernel.org>; Wed, 18 Dec 2024 17:31:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1734571869; x=1735176669; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HlNGvkxBFYoU/+v+zVnQFhQXcTfl77hoj907a4oy+Cg=;
        b=uQXdWeWSKYYWyqD6yROB/QghaKRqxhq77fVOuxC1H1fQjA9xURCwFwRHsospoKVrms
         WCRgMJe0dawEgJ8sZ8DqncvrkNqdu724aV+LB57j7Yew4w7rZoGHUUH/fO82ApHf4tz6
         S6YkZt2ahmJf0ECyHaeVO9y9iI8XaLRfM/vYB5MDg59Kg/DkEetipAyjAaDFp0luds7d
         t5CKJsDODuQyxMfZi+nT7EiJudljOrprO7fC11EumdEwaZIpzwLy0xuzdi7C4HMCQEUS
         WvOLkAHTNLO9Jmc0QmnslYwGP//PVZIMc1wldcrdcd7wAXPRMWcDGVdAZH0T0MxzfGPg
         04ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734571869; x=1735176669;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HlNGvkxBFYoU/+v+zVnQFhQXcTfl77hoj907a4oy+Cg=;
        b=eS8nCuAZPwVlCVXcwBtQF9XHTBW/ckEaH3DJClfijYqtwNxKSTOJDP6E2WZavZO5cT
         /19TDLm6jDsXSHdPsGAg1+nQGVC3/cHWjFlIxUnksLDx5gFL+AmrTa43bgemvn7SsFVL
         ceWVsfNLH1eCsIeypCnvPxI6Wvf8LPUHF902uQukzU62xuUchgIGRbXtM4QiFzPtM9ef
         DCs8quxjQ2Gd5bpF/ETz99Bdp2MXuJ8V0s3agTFSraQ0MxQ8yKkgt09LWeMjPTAKCzwR
         9Ypd7qQjtMngW+icG9MzCHXyIN8mjwYiyxh+bqyTvtqYhxEg6wKi0ngBkUyxUt09cel0
         8yIA==
X-Gm-Message-State: AOJu0YwpCW0nhQdScOBgyp115ehhtRBrX43vBmiuZvXeBdVl/OsnisHh
	papts47kNW///+Cbc1hKRX7kj2tzE0hJR9QxfaSLrHP5+LGcu1ZVtcMDfRTdSPOAL4GxUQNYjzY
	7NgI=
X-Gm-Gg: ASbGnctroy2o9RXgsgER+FU2Yaz382G59WKifhRfJ2E9Pjf7ONyWzGd+0msnIiIA4S4
	2qtavd6pcq48VofbwyI5X8Ec95bchs3WlLGhlwpruDdhteiyD9E6gUD+4JzDlWqMJ+J+Wr9JW2r
	6cWuAfZqQvSYHmoi+aq/aaK5Mbw2+YmOC7SFs28FMbLrjMXY2/AY73uLMWVtFdIXx9RZrEb2iQ0
	FEb3+lF65udoj3K8RQfjuOYVRbxBuQae3eLoEfl38w9rrIKWtgshxx/AccIw/NheuBtruF3nYWF
	+1NzjhOLK/6gE+6M1U+ed/Pi7hWm
X-Google-Smtp-Source: AGHT+IHRU9MGN3qY6SoHWVEvtQs5tnkx1A+15hurVF6WOK+XZquUfu1utWH7906fj/Id2Ws2CFmlOw==
X-Received: by 2002:a05:690c:680d:b0:6ef:6ba2:e84d with SMTP id 00721157ae682-6f3d0f3294dmr46013207b3.17.1734571868915;
        Wed, 18 Dec 2024 17:31:08 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e537cf74d97sm40677276.53.2024.12.18.17.31.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2024 17:31:08 -0800 (PST)
Date: Wed, 18 Dec 2024 20:31:06 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH] pack-bitmap.c: ensure pack validity for all reuse packs
Message-ID: <Z2N3WkMj34ACPEoy@nand.local>
References: <7fdbfadc04926efc094633b238a55168c92e3d58.1734117577.git.me@ttaylorr.com>
 <xmqqa5cspym9.fsf@gitster.g>
 <Z2NfhDOJOOUdK2Xk@nand.local>
 <xmqqplloo4jw.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqplloo4jw.fsf@gitster.g>

On Wed, Dec 18, 2024 at 05:16:35PM -0800, Junio C Hamano wrote:
> >> I wonder what we can do better to make sure the work a contributor has
> >> already done (in this case, resolve interaction between two topics) is
> >> not wasted and recreated (possibly incorrectly) by the maintainer.
> >
> > I am not sure. During the interim maintainer period, Patrick sent a
> > couple of rounds of ps/build with a final patch to the effect of
> > "unbreak everything in seen", which could be dropped.
> >
> > But I think an easier thing to do would have been for myself to indicate
> > that you'd run into a non-trivial conflict here and provide the
> > resolution proactively.
>
> A trick used by recent series from Patrick say things like "this is
> based on X, with Y and Z merged".  This patch could have done the
> same way.  It of course makes two topics entangled and one takes the
> other hostage, so we need to carefully judge if such a dependency is
> worth it.  So far, I found Patrick's judgement on the choice of
> dependencies quite solid (essentially, Y and Z must be cooked enough
> at least for 'next', and can reasonably be expected to graduate while
> we iterate on the new topic that is being built).

I typically try and do the same, but I didn't want to base this topic on
top of tb/incremental-midx-part-2, since that topic isn't mature enough
and I didn't want to hold this one hostage as a result.

I forgot that the other topic was still being held in 'seen'; I should
have remembered and mentioned the conflict in the patch earlier. Sorry
again for the trouble :-<.

Thanks,
Taylor
