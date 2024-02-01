Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA42B8526B
	for <git@vger.kernel.org>; Thu,  1 Feb 2024 19:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706814884; cv=none; b=cwid5OvQ8phphlsn3p4V3dX0A+E+atjxAJCJMKXMKUQ1OuGqtVWT388a3DvyTbTaJVLe2nGeUoclT8qKTGcCYFIf36+v1i2ksIwtD5mNy3pFGux9JEWBIuVYQkWvXsx2nJbx2JaEg+HFF9QX3wj0RA5OLSFQEHm8b3lYEjuPdTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706814884; c=relaxed/simple;
	bh=p7m25jc8kD9MAALUc30gii6C3WFmQa0PoKXdm1ixy/o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=X490B3aUv7Y9MAaJxyqLBriPY/tvkIE/UVdxSYJLeSYfOaMxR/7lWohSR7BIoMq/8UGPAxlUA+JdlEI7WR/+FsfHQSwSvR+cWH+kqTBZzeUsRMqOcOOLQvjH8qmThhGQJKS0/KytI9+HUePnfmxfPLEu3AbezwyyRW0HQBsQo2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DkHXhiwf; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DkHXhiwf"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2963802f73cso47768a91.2
        for <git@vger.kernel.org>; Thu, 01 Feb 2024 11:14:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706814879; x=1707419679; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=esT4QlrcPeVN9x30aQGcS1Ugeh+NuQcz2OlaTf+VTJc=;
        b=DkHXhiwfwh0VmBWbpJh9yCMydvLVZ4dDHElqz8MbKt5x+xD38Xezx2DyvcgZ+lOOhN
         nIJZE+B3KuYqzMF+fxheAUVaFdeOPc1cpgMtLy4KFRm5nA3hgyYww8HvOX5EhGLm/8d1
         QDfZpFj8v8x6DQ7TRDTR0SyzMv1OUK+St8Qv2nTqScdTblOENFS7FW9IAk/Ryxi7Ua7F
         yWsKvA3u1WRPM94UnX8UcZrYoTg3+nFfq46obF5W/mU+Hl1YhgQFfGZoZTNMkUohS5Yg
         wOjkSkxzfa1kBEDSe2mRjaGzRYE0vJhJGRRWsNZCp/nZrqmKOMdAC0qvXtt009jpBiHE
         5UqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706814879; x=1707419679;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=esT4QlrcPeVN9x30aQGcS1Ugeh+NuQcz2OlaTf+VTJc=;
        b=nvHHGG0PYDNE/QLR0bltHWPupOi8t9N5Ga6VPjslDmawGXQkz6qQNFhevOZJM79XTY
         yyLRggS7yfTMEbY3Zqtk6UbITYaxXV0T2S9o4eGs8Wom2ITz+ToJwk17BSPBnghg8edK
         uJeH8Ahmn4yNs9t+K4pLLHf/QU3krgl5v7VBI5PbHfV5SUEIXn6LE9t02ODsOll8w2AV
         ywZ/1URXGauqI71nnVGeLD4mmMxldfgXOO4yNO617T2h0H8gUJIda2UrbGC4Uj9NKzC2
         pHFimMgE+l0yhTd2QWZ3Pqj40fRExHwCDBh+JNaPc1Di5pz532t1Ouit6GiDj87dl6Vs
         uDFg==
X-Gm-Message-State: AOJu0YwLIQEudKP9auSzdTJS3Ly8l5u9ngCf6+aBSmA86X74lBJrtbrL
	3AhzZzRgEWBo/lyk68o2tXbNKI4VnaJHuwUtBpVkluwF3PMqcWeRXZbfFtkA8uwjS5n7yOBNW0r
	6gQ==
X-Google-Smtp-Source: AGHT+IE7Qeow1JVSGYngp4du5lwEwpp/m49jdPwRHAxcKGWVDbi+ugmYBYq+68YLk0ZJbc246xcIMBdpgWc=
X-Received: from fine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2221])
 (user=linusa job=sendgmr) by 2002:a17:90b:104c:b0:295:b7e1:f6db with SMTP id
 gq12-20020a17090b104c00b00295b7e1f6dbmr18268pjb.4.1706814878848; Thu, 01 Feb
 2024 11:14:38 -0800 (PST)
Date: Thu, 01 Feb 2024 11:14:35 -0800
In-Reply-To: <xmqqa5ok12lt.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <pull.1632.v2.git.1706308737.gitgitgadget@gmail.com>
 <pull.1632.v3.git.1706664144.gitgitgadget@gmail.com> <bf2b8e1a3c4bc77022fab1ebaa0fc89a7813b4c4.1706664145.git.gitgitgadget@gmail.com>
 <xmqqa5ok12lt.fsf@gitster.g>
Message-ID: <owlyle840zfo.fsf@fine.c.googlers.com>
Subject: Re: [PATCH v3 04/10] sequencer: use the trailer iterator
From: Linus Arver <linusa@google.com>
To: Junio C Hamano <gitster@pobox.com>, 
	Linus Arver via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>, 
	Emily Shaffer <nasamuffin@google.com>, Josh Steadmon <steadmon@google.com>, 
	"Randall S. Becker" <rsbecker@nexbridge.com>
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>> From: Linus Arver <linusa@google.com>
>>
>> This patch allows for the removal of "trailer_info_get()" from the
>> trailer.h API, which will be in the next patch.
>
> Hmph, do you mean "shortlog" and the sequencer were the only two
> external callers and with this we can make it file-scope static to
> trailer.c?

This was what I meant (originally ...

> Or do you mean the next step will be more than a removal
> of a declaration from trailer.h plus adding "static" in front of its
> definition in trailer.c, because there need other adjustments before
> that happens?

... but now I realize that the operation adds a few small tweaks, such
as tweaking the parameters it expects and also what it returns). In the
spirit of breaking up patch 3, I will also break this up into
preparatory patches as well.

>> Also, teach the iterator about non-trailer lines, by adding a new field
>> called "raw" to hold both trailer and non-trailer lines. This is
>> necessary because a "trailer block" is a list of trailer lines of at
>> least 25% trailers (see 146245063e (trailer: allow non-trailers in
>> trailer block, 2016-10-21)), such that it may hold non-trailer lines.
>
> That sounds like a task larger than something we would want in a
> patch that focuses on another task (e.g. update sequencer not to
> call trailer_info_get()) while at it.  It seems from a casual glance
> that the change to shortlog.c is to accomodate this change in the
> semantics of what the iterator could return?  It smells that this
> patch does two more or less unrelated things at the same time?

I think you're correct. Hopefully breaking this up will make things
easier to review.

I am learning very quickly from your review comments in patch 3 and in
here that, in the absence of area experts, the existing tests/CI tests
cannot be trusted alone (after all some tests could be missing), which
makes it more important to do so-called "micro-commits".

But overall, breaking things up is a good thing anyway as a general
practice, so, I think this is a good lesson. TBH I have a (bad) habit of
saying "is the diff ~100 lines?" and if so I don't spend any time
thinking of breaking these up. X-<

Thanks.
