Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48F8B1DF975
	for <git@vger.kernel.org>; Thu,  3 Apr 2025 11:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743678464; cv=none; b=IJs0ETILZOPHBoQtUqvSPa1QCRz1hKjeLG0MCwb8bzWkY7TZSwp/gvUEnRsP5ys5b0+sNrY8NtQc74Qd+QCBOHMv0S6ICdGQMPPUhfuOq7ZyNJRVTs8xv56SRPJLDEUBDqA6SsHkQLpwjnJkSZr8EPrD2MsR9J30zAxlkx495uY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743678464; c=relaxed/simple;
	bh=XCCTJiHt+oYVPwfW4sTtlYv2R4TgwPBmoh5dtuBt5x4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PTOAQEvCTqp8k2e3v7vLnDcOQ9vgZ1I9Wn1XaUsXorQ3W7d85+CLsgHWyTtnmNF39EYshz4Iv8v9i/yU6FI7j//Lb5pCADBUBSoS1jsQ6yizrHgXJWB35RcH4LxXbG0Bxn7e7odKIfELE/4oCuFXKXxYIVtpOK7m+mMpTaJOzp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a04iBB8j; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a04iBB8j"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5eb92df4fcbso1470488a12.0
        for <git@vger.kernel.org>; Thu, 03 Apr 2025 04:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743678459; x=1744283259; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XCCTJiHt+oYVPwfW4sTtlYv2R4TgwPBmoh5dtuBt5x4=;
        b=a04iBB8jBloIOuE2RP16dPbWQLXqdwbDlTmKu3EL+O7rRbYgv1pydPJj20VMP/62ff
         RELUJ6McEFPlBZ+6Wo1lPLW9NZbYuUUeUKiRPB4NMolbcx8spKB3OQ4SCiHvKzXg2Ba3
         sKQ4QpoWrMWyGdY2H5ZuBpyzMxB8Us3buMTMxYFDYUlzPJJiYRlCVsN3zqVOovJ7EQCj
         JgpFYOw7Ob4Wd3cOkCDY6enQ2Alfg8JmtnSCl5HGaOrwK8VgHcMFnNOqW/hnDcOEHNUS
         xCBCMmmcPJTGO+g8eDoVoGzSYRe18Xb8o7As52hIupKVH96n5jdfjuCrKsO8Ryto4mS/
         qckg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743678459; x=1744283259;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XCCTJiHt+oYVPwfW4sTtlYv2R4TgwPBmoh5dtuBt5x4=;
        b=ORvIFXBNr2ExH30thxEkXeHhXfqiOXAVUj+KSDoMBwyuj1Ui2YAt9AyCyiZMl6h0GI
         WQ+dr3U+3kiMxN8uXe4bUgzOnjM6hV3iozP1AJYeWA0nnENuMi6bmNoiG8COvtAzXFLc
         TOb2TUGU9q7r+JUFmbie+rXoXyp+rfIAmWVbtBrHBO4iGGRZdS02PFP8bvbD3wGS45t5
         qSzZroBRBL794jOVse1bI0pI1PVtz3xpHI679nPPZ32ZEdUlCIF+UjgdrOeL3VqQGhFk
         vIQ2x7OB+onmb1ljQR6wree8UK1o0q4G5NiQ8NJklKb/0luAzqKHwrVc+lwfGkvKy063
         RuyA==
X-Gm-Message-State: AOJu0YwLjirCQ/dU35OfvDGA1TcxdXIUJh56XX9k0da6eFL9cyKS+gru
	GT1UTigHGJ4wHLKjGxT8iOwkrdUa4MHn14HSScgS4en0yxc+VtchE65m5rISsCZ8peE1rDmGnFy
	A/t3aPH0ex/K3HbEmMvGWrWyfpU4=
X-Gm-Gg: ASbGnctotO1iv73Ka4qwyt7sNaGpQd2LUee/5KI/Y7UbB+RPd2vkhSq2PNkdQoPui2O
	8hkoyy2LjxleOU1AWe52RRGdAe7HYepIljsILGJXChRtJp7P2qDaX07hjR7y7nqwxzN/ABBcuHZ
	mudR+aRG1KcPdgmHw62zqdS92wKa3j
X-Google-Smtp-Source: AGHT+IEGbtWQIBJc2FbBNphenBxVNmYHQAyuEc01yNqS1qkx3PjUkSbZLgDBEmmLYxFUHf8F2+q1+FywYfDXFU2yldo=
X-Received: by 2002:a05:6402:13cb:b0:5dc:63d:b0c1 with SMTP id
 4fb4d7f45d1cf-5f08726eb02mr1457539a12.29.1743678459131; Thu, 03 Apr 2025
 04:07:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+i-1C1DM0CHoFJ0A5CchQg=qDVLi_SSiZqcd0dxsay-Y94WTQ@mail.gmail.com>
In-Reply-To: <CA+i-1C1DM0CHoFJ0A5CchQg=qDVLi_SSiZqcd0dxsay-Y94WTQ@mail.gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Thu, 3 Apr 2025 13:07:27 +0200
X-Gm-Features: ATxdqUHKwDBqa_WdDBQ8KJ-ByO9lWyVUYMRtt-8zZWNrV2ra_doUg9GnjhW1OhM
Message-ID: <CAP8UFD0SxKOYFegN=DnmyY5RW7dMqyohGzeCfoVLNOtwjY2APA@mail.gmail.com>
Subject: Re: git-interpret-trailers and period characters in the key
To: Brendan Jackman <jackmanb@google.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Apr 1, 2025 at 3:27=E2=80=AFPM Brendan Jackman <jackmanb@google.com=
> wrote:

> Basically, as soon as any trailer key contains a period (which in my
> case, it does because the trailer keys refer to versions of of
> software, i.e. "this commit was backported from the following Linux
> kernel commit which appeared in version 6.1"), it stops parsing the
> trailer block.
>
> My guess is that this is just that it doesn't allow periods in the
> trailer key, and once there's one line in the block that isn't a
> trailer, it no longer meets the requirements described in the man
> page.

Yeah, it's also my guess that the trailer block is not considered a
trailer block anymore as your trailer key is not considered a valid
trailer key.

> I can't find anything in the man page about why the period character
> should break this. Am I missing anything there?

We tried to be quite strict when implementing trailers to avoid
regular text to be too easily considered trailers.

Having a config option or something to be a bit more lenient and
accept more characters in trailer keys could help some people, and it
might not be very difficult to implement. On the other hand if people
start to have a lot of weird trailers around, and abuse the config
option to make it too lenient, then it could be a bad thing in general
as more and more regular text might be interpreted as trailers.

I also agree that our doc about this could be improved. Patches welcome.

Best,
Christian.
