Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A0D34A33
	for <git@vger.kernel.org>; Thu,  4 Apr 2024 00:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712191655; cv=none; b=DVzwi3qGfQ5ib9hV6dPazMtfIwHN6HCwGppFVLOMMHA9fD/LSzBVkspBraPqCjo5ZyfUtAnZDloO6zh12bRPvrC06I6+NI8ZZpB2PJ3rabRs49dlIEWz8hB7IHLMGlWJJ0IHxdUqAa+9vKvZWOQJr4dz016B5vvSsgvRzSk5xog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712191655; c=relaxed/simple;
	bh=dG5vl36BxEiMBh70KP7pCSeuNV+b/ha78HcDQQd6Ktw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sOmVrGsCkBKtdf3WWp5aqMImqazOjRUbWbfqyMy92CQUkLpQ6P11DbHd0Vop4HwGzz2Wsy9oeqSdRTX2clpXXsKD40Dltmmn9Vsy63nKIPo1i/7jNGW4+OSjlDo8YpLwandB7frhCGoM8+wDdEDw7HVaigWzzQYzr85ZkO52YS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Tf8KRUoE; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Tf8KRUoE"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-6e6c5b1377fso1072379b3a.1
        for <git@vger.kernel.org>; Wed, 03 Apr 2024 17:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712191653; x=1712796453; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=DICQyhtXxquTnih6ma4T5X4w24nlEsAiKOOxwQt806k=;
        b=Tf8KRUoEGMKZqO5gzxNmlg9ltHXXaVJOO+nXf05VwzerAD903JMsNPWw3cbrfcfH3D
         WC5iLnyMisxENJPVca1RDPvqXSISZfR5pSrGABe5wsYBbRbcw9qoOMBld9tWJpnWJyZA
         7Iqkd3xgCDIPY+FV00pU4ZDpSrvDqWLmMOgKiOVjVoIgl9WqLirKBsVr1TA/w6xByx4A
         JNcEP+8LgXfe1TqGYepPpF5fV3amIbtr9NymQJAJ8wJQfFBodOXpAYKgfySAuCG1fniI
         rOemdXD//C5gUriX9Q5LwmI1gCOsx3zGRXtoSZ3vMZdssW8ezg4GwteWOgxMvMErVVQ+
         ExZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712191653; x=1712796453;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DICQyhtXxquTnih6ma4T5X4w24nlEsAiKOOxwQt806k=;
        b=nHnAv2ebR1Vi53DMk8JqBh2b8o3tZehSbagfouZLa5nyocgjASc+r2Nu43fbYSobb9
         spUDmhQwNV92H3ZyK4VpKxnF+s7jwAt/5CUvtNLpEcxLgsabM6LjfWCsrNK4AnDwok4C
         YWR+cRGb6XUQ4I7fsxWyXKs6RXQmZvlfnY2WlIckahIe4x5Jw9aHJ5lgOV5lTMN5FA8j
         JqYNwMuqeIPUxdbyxCaxMum8XrXvbTfzY/ktvDg2J2XQE1f2nIDAg6Hpd8bGbVPJTE3C
         zZMy+fXXSB/xuw0IksBaxuM4eIJbg3pdKO86EnLZL4i+VfzfIf/uHmXl3OWQNeDN+V/Q
         00TQ==
X-Forwarded-Encrypted: i=1; AJvYcCVn6QCG+Gg6+4jut2quoLfLkWvw/nl4IrK8Byic4FaidbQ9s0HfFPwF/Br22DnQdeBUpavhThZgaO04RRmoJ8uJGl8r
X-Gm-Message-State: AOJu0Yw6y4oRQZGtYQotvhCPPxxh/Q26SZCQz1+wmVs7hir3Jd8D4iXy
	qrqdG9WrKUf7Y7BiEDuIotaOpExA6Ecb3YzHAj9cBKf7YeDCZrTiUaZU23MJM5xboLkZn55Cs18
	QAg==
X-Google-Smtp-Source: AGHT+IEwzW2POoH3PITFJCKhujLWcDvxGSZlNcMeUG8d7TlvfI3XAOtu/JrmnHFfl7V6mXUoQuCnN2WqVPY=
X-Received: from fine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2221])
 (user=linusa job=sendgmr) by 2002:a05:6a00:7312:b0:6ec:e89e:ad7d with SMTP id
 lq18-20020a056a00731200b006ece89ead7dmr3138pfb.1.1712191653252; Wed, 03 Apr
 2024 17:47:33 -0700 (PDT)
Date: Wed, 03 Apr 2024 17:47:31 -0700
In-Reply-To: <ZgukEQVqOgqAIIVR@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <pull.1694.git.git.1711164460562.gitgitgadget@gmail.com>
 <xmqqsf0gvjrg.fsf@gitster.g> <owly7cho1eh4.fsf@fine.c.googlers.com>
 <xmqq4jcr6bx2.fsf@gitster.g> <owlyttkn61nq.fsf@fine.c.googlers.com> <ZgukEQVqOgqAIIVR@tanuki>
Message-ID: <owlyzfuarm1o.fsf@fine.c.googlers.com>
Subject: Re: [PATCH] RFC: add MAINTAINERS file
From: Linus Arver <linusa@google.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Junio C Hamano <gitster@pobox.com>, 
	Linus Arver via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> On Sat, Mar 30, 2024 at 10:59:53AM -0700, Linus Arver wrote:
>> Junio C Hamano <gitster@pobox.com> writes:
>> 
>> > Linus Arver <linusa@google.com> writes:
>> >
>> >> I realize that such an idea is beyond the scope of a simple MAINTAINERS
>> >> (or similar) file that's checked into the Git code repo, but I think
>> >> it's worth stating as a thought experiment.
>> >
>> > As we already have agreed that neither of us care the exact format
>> > of the file (yet), regardless of how a contributor, who is about to
>> > send a patch, will find an area "maintainer" to help the patch along
>> > the process, it is far more important to discuss and decide what
>> > responsibilities and authorities are expected of these maintainers.
>> 
>> I'm starting to think that the new responsibility should be as small as
>> possible, and build from there. So the smallest bit of (initial?)
>> responsibility expected of the new roster of maintainers could be
>> "maintainer must respond to CC pings on the list within 7 days".
>> 
>> For those who have more time to spend on the project, the next rung of
>> responsibility could be "maintainer is available to review patches
>> outside of their domain of expertise if no one else has reviewed the
>> series in 7 days".
>> 
>> I haven't thought too much about the "authority" part yet.
>
> One thing that makes me feel a bit uneasy about the authority part is
> that contributors to Git are quite often direct competitors on the
> company level, as well. This never has been a problem in the past, quite
> on the contrary: I really value the cross-competitor collaboration we
> have in this project.
>
> But I have to wonder what it can potentially lead to if we did assign
> more authority to some contributors. Theoretically speaking, that would
> allow for sabotaging interests of a direct competitor.
>
> Mind you, I don't think this would happen in the current state of the
> project. I'm merely trying to think about worst-case scenarios, which
> may or may not be helpful in this context.

No problem (I also like to think worst-case scenarios, so thanks for the
thought experiment).

Initially I agreed with the concerns you raised, but on further thinking
I don't have the same concerns any more, for two reasons.

  (1) It's impossible to tell if someone is actually intentionally
      sabotaging the interests of a competitor --- simply because no one
      will admit to doing so openly on this list.

  (2) Even if we do have authority figures on this project, if they
      block a patch series from being merged, the reasons they give must
      remain purely technical. Otherwise, I think such authority figures
      will compromise (lose) their reputation pretty quickly.

For (2) it could be that they could block something for both $DAYJOB and
technical reasons, but I think this is still fine. The fact that they
have $DAYJOB reasons wouldn't take away any merit from the technical
reasons.
