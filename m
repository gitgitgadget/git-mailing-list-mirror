Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DCB41591E1
	for <git@vger.kernel.org>; Tue,  9 Apr 2024 23:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712706169; cv=none; b=RB7aeEjyCH2OUXD5LG+7mfokYGUVfopQ8YrV4wfqePfQyHrZpr4mrJBT8ILo8LMAZYHIPoQwxrjNFB4AXJI1fjzQW0EhTfRX1MqQ2ZHJXoBJbAxzbfdk4OvzyaAkdynrJjDomk3cMNK/eGsmZ/TkTsZjCxM7O4J5A9wluqgZnFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712706169; c=relaxed/simple;
	bh=ttLj+EdO7hVF3Gnt29ocQw+Nsp2etBLP8QqQbrDBVpU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OD25nsr101wLnOJPLFkQCKuYxl+CsaI9VS772FTuLMn6W3IklDsCiamHSCCeb+r6ZRBL2WT3Zc0gWneAJSjWIb0xTTsuaL3Xx0/rp9I2da4KJAl4C4R3wZA5uDnucKc+yj0AbKn2/dOHszru4ml31M5NSxlx7v5sJBSUmKDDfPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SmBiQUOz; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SmBiQUOz"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6150dcdf83fso120348507b3.2
        for <git@vger.kernel.org>; Tue, 09 Apr 2024 16:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712706166; x=1713310966; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9jEQpsSmrN0Kik2RI9iPQS8U9dimP8Zw2f0URW6zYiw=;
        b=SmBiQUOzuwBOj1FfDyxXGqwCGpVq5RMDErwF7QNDr0SLdzY2uhvy3bEZGGK7hCYy56
         v7e0JONVkVKcH/mszZOJ0GvQrLsKbnf7A0z1ld2PTlfYyprbb1WBVXoKKbmyavPz1kop
         9fFJYXtTK/xWfGrwaqq72kRGXToEeHbsh4rPABy3+aXI+tQvlEMZFI8eJZSh9axYZbtF
         Cj7NTxnfkF4Ib1s9AAGherYdLqiLkAamZhI9egJ5PHrOy1bMg+ZGxBsKI0sBiPV9wZBT
         sHdxmxumeg1DAefVdHatoGHdt/XI5PJOAKtNfq4c3bk/H8/HXd4duXNBamzI0zM69HBa
         YH3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712706166; x=1713310966;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9jEQpsSmrN0Kik2RI9iPQS8U9dimP8Zw2f0URW6zYiw=;
        b=bNn9QXWtwxRGLoMzyOngJR+Q0GPgDWAFU4UwVE/Z6itSRBJZen0HZ2qXLFDZiZsmiy
         j2sYdIOZDr9edSAdBc6Mv5fAjnoAukTA6I2yB5gJTsFSGsfgJELim/iK4616GlxcgJRH
         5byHBDYesxH6DApezXqzpxk70gJdx6bUqLss1L5zMTh4CfatxNsieM2VVvrniRV+o00E
         tTW16oitam69kkpw1mJdGp72VAKOvGl5G+8GRopV7cYsvtrGGwgvUNqCzH4JU3uyET2u
         BgDkov+U7rAgTT2qPG+gJe+1s4Dz7NEqVOlgoML5HlDS1faKJVDl28vx14/U6yDamMWc
         AWmg==
X-Forwarded-Encrypted: i=1; AJvYcCVnfzb3iYWZ3fTaFTicRu9GaliNZnCW2vtdnw06KtRrNTwepw+GjQXgRwhB0Rk3McT+wtQSiScCXnbFtbtpzTGk3x2v
X-Gm-Message-State: AOJu0YxuNpg6gCNb7BvQ5moB3BjMxbbxaXfKRMcEYNVGAQfR0CcoLMn0
	0+ucBXHY7joRMTZYzRUKBIF/U6TQvGnwhPz8km8xaSvbTaRxM0Scisk9pxdip1kWUMASZB9ORmW
	cjA==
X-Google-Smtp-Source: AGHT+IG3/m7qTkxhS3C9yvA7dfsZaA+flsxhAMPKRX1bXXnWESEdJX0hVxVKq3ZC/jBSpUqlfJlAudyqmak=
X-Received: from fine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2221])
 (user=linusa job=sendgmr) by 2002:a0d:e2c6:0:b0:615:4805:4ab3 with SMTP id
 l189-20020a0de2c6000000b0061548054ab3mr289682ywe.8.1712706166571; Tue, 09 Apr
 2024 16:42:46 -0700 (PDT)
Date: Tue, 09 Apr 2024 16:42:45 -0700
In-Reply-To: <xmqq8r1m16n1.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <pull.1704.v2.git.1712366536.gitgitgadget@gmail.com>
 <pull.1704.v3.git.1712699815.gitgitgadget@gmail.com> <1f65dc5ba3ded5b90ed929aa3884574e8b26cd9b.1712699815.git.gitgitgadget@gmail.com>
 <owlyil0qrxev.fsf@fine.c.googlers.com> <xmqq8r1m16n1.fsf@gitster.g>
Message-ID: <owlyfrvurtl6.fsf@fine.c.googlers.com>
Subject: Re: [PATCH v3 1/8] MyFirstContribution: mention contrib/contacts/git-contacts
From: Linus Arver <linusa@google.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Linus Arver via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>, Jonathan Tan <jonathantanmy@google.com>, 
	Emily Shaffer <nasamuffin@google.com>, Patrick Steinhardt <ps@pks.im>, Matthieu Moy <git@matthieu-moy.fr>
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> Linus Arver <linusa@google.com> writes:
>
>>> +NOTE: If you're not sure who to CC, use `contrib/contacts/git-contacts` to get a
>>> +list of reviewers you should include in the CC list. In addition, you can do
>>
>> I just realized that I could also do s/should/could here, but I assume
>> you'd prefer to modify in-place instead of me rerolling for a v4 just
>> for this change. Thanks.
>
> We do not even know if there are other things people find issues
> with in this iteration, so it is a bit too early to say that.

True.

FTR I should have added "I don't want to reroll this right now so soon
to correct just this error, seems a bit premature" because that's what I
meant to convey.

> In a
> case like this, if you do not feel so strongly about it (which I am
> guessing from your "I could also") either way, staying mum would
> probably be the best.

Ack.

> If you feel more strongly than that, saying
> "I plan to update 'should' -> 'could' if I end up doing v4" right
> now would be fine.

In hindsight this is what I shoould have said.

> Then when there are other things you'd need to
> update after waiting for others' input, you could keep that promise.
> If there are no other things you'd want to update after waiting,
> that would be the good time to say "Here is a fixup! commit; squash
> into topic X. There is no other changes".

Makes sense, thanks. I need to set up `send-email` so that I can start
sending individual patches like in your hypothetical scenario (I don't
know how to do that with GGG, or if it is even possible).

> For now, I inserted this extra commit between [1/8] and [2/8].
> Thanks.
>
> diff --git a/Documentation/MyFirstContribution.txt b/Documentation/MyFirstContribution.txt
> index 00f4c63cb9..bb7e4174e8 100644
> --- a/Documentation/MyFirstContribution.txt
> +++ b/Documentation/MyFirstContribution.txt
> @@ -1116,8 +1116,8 @@ $ git send-email --to=target@example.com psuh/*.patch
>  NOTE: Check `git help send-email` for some other options which you may find
>  valuable, such as changing the Reply-to address or adding more CC and BCC lines.
>  
> -NOTE: If you're not sure who to CC, use `contrib/contacts/git-contacts` to get a
> -list of reviewers you should include in the CC list. In addition, you can do
> +NOTE: If you're not sure whom to CC, running `contrib/contacts/git-contacts`
> +can list potential reviewers to put on the CC list. In addition, you can do

Nice. I think you can also remove the trailing "to put on the CC list"
clause because it's somewehat redundant.
