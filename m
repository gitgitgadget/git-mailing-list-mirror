Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9608194083
	for <git@vger.kernel.org>; Tue,  1 Oct 2024 18:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727808141; cv=none; b=d2znkKmliZTJqrjZUbzK4OmZuQ33yc8dbzMUQfdQGyRdzjzLksNgb63UNXKL+oa2AX54kO4hVf7GvSiljOu/BYUYf9ReZK38pICAYTBd5D4xrTpjnqYewFI/7P9v99fOGe9IpyuqU00vH8BIQ1DR4paluhqMa+Q8JFerf8abFsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727808141; c=relaxed/simple;
	bh=HZqMDqDnCzMPz+UdrO+EwYDXbZto/ijccCJztEkGd6s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JCgR4Y64gDpg9CKfDPRbAMzdWpBEWDs+9ZkI+XvyMklmp+PQd8S3Dd++RIsOqo7fDj4gNph9Ft7aJkgwTQcIDotvmITogLv8SHOis/eBPV7NNqVUzUPtYWj5jn/vi/dEbIJBjbfuEK7oBHxQnloieEFqHgZ4nhHGgyN6ndn4FAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gree.net; spf=pass smtp.mailfrom=gree.net; dkim=pass (2048-bit key) header.d=gree-net.20230601.gappssmtp.com header.i=@gree-net.20230601.gappssmtp.com header.b=EcwO0BBQ; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gree.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gree.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gree-net.20230601.gappssmtp.com header.i=@gree-net.20230601.gappssmtp.com header.b="EcwO0BBQ"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-6d9f65f9e3eso50741207b3.3
        for <git@vger.kernel.org>; Tue, 01 Oct 2024 11:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gree-net.20230601.gappssmtp.com; s=20230601; t=1727808138; x=1728412938; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PgfkYdAGesAMGPP3oQhapolYUGYu7w6TBEYFzsyozxc=;
        b=EcwO0BBQLAkIEM0O9P8EsxoX07PJIdIUV/SI2f9H5iaSUrQHO2XlhsbywkaTJ1DJfT
         AevsN0PZ68oft+U1Mzz+xjmq1rvUTTdXTXS0EiQS0c5YrFQapB5sGitng5R0M3C6T2cM
         w+fi4DuxEwWKi6yUNlAhPZ6X+Ps8ZPPHS9qRMsWRHzf+Boc7OJ4LHYvcKqxMr3dXyriS
         FO+eeh8dUTOiTB2mPA0WIfgXK7BXO7zByllf7lnCN4CBohY8+bZr5qdzqqPRWRhvIyUA
         XnUG9mL631btKeBd90vsZxddPLvqoACk8ES4gTcJkxrgM00NdI0xo8XsfEcutwMhWddf
         iAVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727808138; x=1728412938;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PgfkYdAGesAMGPP3oQhapolYUGYu7w6TBEYFzsyozxc=;
        b=P2Fh41blCHdDa5oCui+aL5LjQrDaGkgk0YkPNwEaSkqmp9+RWSkYfN9n1pcZU4Gz5v
         7qTaUkMeh9RIPwFb5/YGiOIMIXkWzJA1Rj6HaX0qfQG6chnCq96yfZ9Rb1fqzo2xLmrs
         CrGMQJCebW0iY06yGwyYoa9GgHzjTCRCkaC1Kjgj67IutsqkG9CgYHxctcVLDIVOW2ua
         vW0yLTJz3F9IgV9Arfv2AMsCL8+nKdMmuTljd8y7Aiae7/9kcL6XPLNypaXz9kyk8XHy
         vkzatXVCDp5TKS3V6mR8RkOyOjz4hSk7jCBHGykY47OFV8Nfpbny3cM917X/dtiUwqge
         pvWA==
X-Forwarded-Encrypted: i=1; AJvYcCXyfSBBQ7NlMu4U7nRsvmXlhQkX5vYa3eRtjROLb6StGOE6YaGQ7HJGAzWs2/+ywQaFrWY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy05Zd89PBREsRM5q+owx7GWhkgqArNk7kZ5HLJgk9ASe4yEgbb
	7TR23ytQIZEKn3rJUK4Kp2IqnSVEmYEZfvhMMUYC+1bCEtUQgGWqVtMsNONlfJ4ZlNqB0RHvaNF
	PYSMb1E4BRZ8fbpkeBK182H7X0DmiR7Ohy8ECnapX4/wUGj8RhPgVN1p/BASNl4hlh/FNYEHL7X
	awYwo85W8vnpRNCpZcOpPI+mky/emLqo/eyP6KfPXSBDGsBRrpFvO3izNKml2L8/KG9wvpDxH2Q
	j1Oud7EQza2aTdLAHTeKOmmjIlEKt9ZKaVMk+34Gvk5+VtUf/VZ+rxRGG8aCutA3701OBwYY30M
	jWzau8fHoKSlHo2JxZIPiMkW
X-Google-Smtp-Source: AGHT+IHbMptnNtRtbxtBEiPhzBUZRn9fYNw8QC5BkV7X/3ta9PEr+Jsij4CvAxlNd/30u3PGIqynQ+pYyLuvbMOnS1E=
X-Received: by 2002:a05:690c:660f:b0:6d3:d842:5733 with SMTP id
 00721157ae682-6e2a306e268mr7355737b3.35.1727808138315; Tue, 01 Oct 2024
 11:42:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1802.git.1727577690390.gitgitgadget@gmail.com>
 <pull.1802.v2.git.1727759371110.gitgitgadget@gmail.com> <xmqqwmis11f7.fsf@gitster.g>
 <CAOTNsDyg2SB-wd+a7vrctXck46jyfqV4uME6nf4YQZEafWbxMw@mail.gmail.com> <xmqqmsjnya1c.fsf@gitster.g>
In-Reply-To: <xmqqmsjnya1c.fsf@gitster.g>
From: Koji Nakamaru <koji.nakamaru@gree.net>
Date: Wed, 2 Oct 2024 03:42:07 +0900
Message-ID: <CAOTNsDz=gV1TQ=N+8V+CdhWkPSogNM-42B+vzhDNWdM-Wz9CfQ@mail.gmail.com>
Subject: Re: [PATCH v2] fsmonitor OSX: fix hangs for submodules
To: Junio C Hamano <gitster@pobox.com>
Cc: Koji Nakamaru via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 2, 2024 at 3:04=E2=80=AFAM Junio C Hamano <gitster@pobox.com> w=
rote:
>>> > +test_expect_success "submodule implicitly starts daemon by pull" '
>>> > + test_atexit "stop_watchdog" &&
>>> > + test_when_finished "stop_git && rm -rf cloned super sub" &&
>>>
>>> If stop_git ever returns with non-zero status, "rm -rf" will be
>>> skipped, which I am not sure is a good idea.
>>>
>>> The whole test_when_finished would fail in such a case, so you would
>>> notice the problem right away, which is a plus, though.
>>
>> t/README discusses that test_when_finished and test_atexit differ about
>> the "--immediate" option. As git and its subprocesses are the test
>> target, I moved stop_git to the current place. This might be however
>> confusing when someone later reads this test. Should we simply put
>> stop_git and stop_watchdong in test_atexit?
>
> That is not what I meant.
>
> I was merely questioning the &&-chaining that stops "rm -fr" from
> running if stop_git ever fails (and your earlier iteration you had
> multiple "rm -fr" ;-chained, not &&-chained---not using && is often
> more appropriate in a when_finished handler).

I see. I'll fix this part.

>>> > + set -m &&
>>>
>>> I have to wonder how portable (and necessary) this is.
>>>
>>> POSIX says it shall be supported if the implementation supports the
>>> User Portability Utilities option.  It also says that it was added
>>> to apply only to the UPE because it applies primarily to interactive
>>> use, not shell script applications.  And our test scripts are of
>>> course not interactive.
>>
>> How about the following modification? It still utilizes $git_pgid to
>> filter processes, but avoids "set -m".
>
> Nah, your original reads much better, and the code is grabbing and
> using the process group information anyway (and my question about
> "-m" was more about "should we be relying on process group features
> in this test to kill them all?").
>
> I am OK with the idea that we can assume, at least among the
> platforms that support fsmonitor, that sending a signal to a process
> group would cause the signal delivered to the member processes just
> as we expect.

Thank you for the clarification and the support.

Koji Nakamaru
