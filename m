Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E930C2E7BB6
	for <git@vger.kernel.org>; Tue, 14 Oct 2025 23:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760484493; cv=none; b=omdBGr57CFu751r5drYlbDK1qIxYCwmpXmKm/1j6P58PrK/eDQ7qirk3Z79gXg2LiVKYT9cil92kRqTYk2TSnwp7MJ2oPe97Rnxneih54ll3tLBuSNaTIUPCgm98jbtmNwIi3VjZqnglSi97zsR8l6notn+/v4Q4uiHWW5cfUdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760484493; c=relaxed/simple;
	bh=xYs7F6vvnOrs8O3BBslgPHqzUm8ESy0nT0rni3yschE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=cXIxcIscUgHgdAX+ougGcGAwOv7zvqtybDEDuh15ooOqdlq4+MQNOyrV59KBHn/JlbwAI7z9qG4oCbRp+n/2milHArS/LfwizkvHl8ooPbddH1T33ivR/2AjKR87HsWgQxuWWIGnKad0C4jrXWHCpel5X7SoIYH3QuEsuDpEIC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LUuRotLV; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LUuRotLV"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-791fd6bffbaso91812196d6.3
        for <git@vger.kernel.org>; Tue, 14 Oct 2025 16:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760484490; x=1761089290; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3yAUtrr3boXch4x+WivWP9LPVoix2z9NgOLm0VFcHgg=;
        b=LUuRotLVroKhuUVVeEmN2r6p/lcIlRHKR8RqyOGpcBt4ge6+fuJ39oOBP/EvdhXOIu
         ybSTKnVZ+/WUbh1dblvuwNRUFu3OZT5T+m0iLJchd8uwSv6/Paij3oxHkUM2ovL7u0WC
         ZA0ijibZy7bfzF1NW0BE1mqyniIaoTPsfu7B3+0Y28Zm/SMGTh8QkPGqOcNn3K435618
         f4A98DYzp657lLi5PdRATkmaYqvpjzZZ/kiY9XdhUMX3fJEEopAPn61PEgRGNnssFIJL
         L4GIxY57vaIk1/zAj97MojGf6yoWtPnM3qlfhGKvmRc6vQdBqvzoHxOxGTWL58YKapP9
         ZOYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760484490; x=1761089290;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3yAUtrr3boXch4x+WivWP9LPVoix2z9NgOLm0VFcHgg=;
        b=H7VnJ+jSa+/hl4j7AoUPPX4Oeg3aNIg++GR0NmvHdNKmk3LXTdXutMupf/kmcFPF7i
         hFRquXv4mnawDJzz+XFYOT0Hk6sKUedi/NHSmjqMK2DEBpNmcnYTTETftHZfbOF2oum2
         TPVS/7cdiHUqWRa32bcANcdKNLsV24Btt/mNeJjf+VypeRA6kiyx6Bw0Di/VAZZuBPUB
         RcNOvr6MShFt+vShpDFlLrfrSne/tr6iSB0iTNT+E5MGfHBuX7o9VvxCPO/HyEXsNMEv
         ichG/+bO1cg4JY60Heofx1phCm8FFSdKBM0tih9nb2LtzelelsV6fiR5x9Dd+6iGRj9s
         uJpw==
X-Forwarded-Encrypted: i=1; AJvYcCUK0OhCezuhyWGLruYXC+AIUIHkQMAcL+czexSdOTPm02SmF6qvAljSBYjGUApBVCyZ7Bo=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywcz0BHl62n8Xt0tZsrmQpURS5mJp3cR2vBazyuQYCbsGKc/8db
	OgBcAMvR1hXES+WKt7VMqViNsBei2KpwGdr3d5iJ2zdW7MUbFh9OICNCBRHW53q5GEenagGmpCw
	fQ77+lTrcCpis9EUwWyPRZNVouaFESUc=
X-Gm-Gg: ASbGnct84XfarZVgR1ZbWO1x9s3nIs082vWYtmbTcDAezCXn/QeDgBnO56TbB10M2+m
	eUZP3zBo7mWnckPrDt0IpWZ0q03m0X1vkrF3G0hnImarcY2+uPOlXUC4GjDTWIQU9gXZSdbss34
	NvRps8aYsHntDs7iY68aZ4nEolqiOk/DKozLY1c7W9DYWAoVWFJnhjhZfc+zVuly8uG7JAVJ8Di
	bElDo+QTUdr2/ykyndevclurBu++++3s1nvKhVRKfoqdJFVS0TzPWaO4CQApyxn
X-Google-Smtp-Source: AGHT+IEjnusl769/9Gu0W1t3BxuLXqYQxloHkGMSa+jz5HzkTBFWoRYAKPaM9ZH/5UdU8J9t+8mac2rfuD4TEvCfyog=
X-Received: by 2002:a05:6214:2aad:b0:721:a9d7:297a with SMTP id
 6a1803df08f44-87b20fe4891mr372350636d6.7.1760484489730; Tue, 14 Oct 2025
 16:28:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251013174658.236940-1-okhuomonajayi54@gmail.com>
 <aO6-LBqhW87GWD-5@fruit.crustytoothpaste.net> <xmqqjz0xw20h.fsf@gitster.g> <aO7Tgj4OJVLhFASW@fruit.crustytoothpaste.net>
In-Reply-To: <aO7Tgj4OJVLhFASW@fruit.crustytoothpaste.net>
From: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
Date: Wed, 15 Oct 2025 00:27:58 +0100
X-Gm-Features: AS18NWCuYqwVI4gUxrhsxWMPQr68S__0roLkC85Jv54Gh6mG46nK4W-ri9rrlIg
Message-ID: <CAFpMFfCV0-MHDYDuVz81hdvBN8qoyse=Hie1rF5=qPOigPM67Q@mail.gmail.com>
Subject: Re: [PATCH] [PATCH] [Outreachy] builtin/patch-id.c: clarify SHA1
 usage for patch IDs
To: "brian m. carlson" <sandals@crustytoothpaste.net>, Junio C Hamano <gitster@pobox.com>, 
	Okhuomon Ajayi <okhuomonajayi54@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Junio, Brian,

Thanks a lot for the detailed explanations  this gave me a much better
understanding of the history behind patch-id and why the hash choice
isn=E2=80=99t straightforward.

I see now that just forcing SHA-1 isn=E2=80=99t ideal since patch-id alread=
y
uses the repo=E2=80=99s hash in SHA-256 repos. I=E2=80=99ll take another lo=
ok at how
the computation works in the other paths and think about how to handle
it better, maybe by adding an option or clarifying the behavior.

Really appreciate you both taking the time to explain  I=E2=80=99m learning=
 a
lot from this.

On Tue, Oct 14, 2025 at 11:49=E2=80=AFPM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
>
> On 2025-10-14 at 22:29:34, Junio C Hamano wrote:
> > I do not quite agree with that, as SHA-1 in patch-id is merely used
> > as "a hash function with good distribution that we happened to have
> > handy access to" without any security requirement.  Being able to
> > compare patch IDs computed long ago stored somewhere with patch ID
> > on a patch that claims to be freshly written and find them the same
> > to say "you know, somebody wrote exactly the same patch 7 years ago"
> > would be valuable, and we do not want to lose it even when you
> > happen to store your payload in a SHA-256 repository.
>
> I think that's too late, though.  We already use SHA-256 in a SHA-256
> repository, so people already expect that to work now and in the future.
> The time to make this decision would have been in 2020 with Git 2.29,
> but we now have people who will be using SHA-256 patch IDs and we need
> to support them.
>
> We have also specifically discussed in the past people eventually
> wanting to compile Git without SHA-1 support at some point in the future
> for regulatory or compliance reasons, so we should full well expect that
> to happen and we'll need to be agile about the algorithm.  SHA-1 will
> definitely disappear from at least some distributions of Git in the
> future.
>
> Given that context, I think allowing the specification of an algorithm
> would allow people to say, "Yes, I am in a SHA-256 repository, but I
> want SHA-1," or vice versa, which would work with your use case better.
> --
> brian m. carlson (they/them)
> Toronto, Ontario, CA
