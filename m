Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D83D154BFE
	for <git@vger.kernel.org>; Sun, 16 Mar 2025 09:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742117824; cv=none; b=uSPn4ER0FKfU7n3nlCSfHw7h6v/SzB+odt+vgvACFFPEyY5xWy8IqT2EkMgEpBiIdfZP8es3ao978KPMDYVPCnMeOdAkZAY8oGDjE2sT4Z508/JTnAO5Y5quk5eNWbsHrB6FzZ+WzyeNqkNBO6YXbeGo6H/K55jlgugFdBI9EQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742117824; c=relaxed/simple;
	bh=WoDk6b4VBYy9zO5KQYO1htZT9wICesWkvuUGvG+oOZQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QB5Zc9Ahgbj/lwkiFwYlWU4q0oD5Zljsgm8yPHKnGEdBhjGedt7BPH11FGJ1+e1l9ZGl+PekkSjpIuJU75PHqKy24D/4wbJGgEcmKwdqKYhdVZDJr6NDEMPDUEFw93WU90qdt0yRuvN7+pR0na/2qWSqj7qdTR5o0D33frV0KmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EMs0sBN2; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EMs0sBN2"
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e549be93d5eso3153306276.1
        for <git@vger.kernel.org>; Sun, 16 Mar 2025 02:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742117821; x=1742722621; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M2P693OBJrdDMRFMEKX6z2rd8ffDfkVZ6eVTFQc7+84=;
        b=EMs0sBN29Fih5NF2JzGzoTa9wiBbGrZNqz70O1ZO2wh6WqNI8rzrah/hXBvjMbrC4q
         6x/vzvDlx+I/rDjYA3B1jXtCxtyAbGZ/E8jrXTY/4P1gXp5xS1T8ge+RbPOqLzCQyyjn
         jS3+cAYe/ZcPpqKTUF8XFBFars3kx6hEwQwy8dOtZcJpLTeHNwVUYKEqATnZzbS0WnWw
         nOaZ45tD9qCc+Bgt6VIyV+5zFZrBZsBrB5wPNBwfbIcRi41iXlgkYlHVxAxQjrFsfhPM
         yJZ7Lfn6D8b5t6hQ4BgQDDzRaLqtCt0qexK+VEMJ4DJ6jDkxdyeYAkE+fb3c20GHl2dL
         P0vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742117821; x=1742722621;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M2P693OBJrdDMRFMEKX6z2rd8ffDfkVZ6eVTFQc7+84=;
        b=ahC0COMlDPGD5GmEYbrobGdCvwrS4jqTvGROj6/T5C9rfaS8mnb9fjVlvscvGJoHdx
         x0f7Hp1f6jb4ICP1fiX0D3cABDzGfkRtNTYjU5ODtx8M3/EnxSi7kxqtYHXyffllEiy9
         gZgipOF18iCkc5/0xZ/6fEaWdBDJPjBRefUKOg9TTCLHelaiJWc4gtpZ4k7AUvlkeHLJ
         F5c0j/Wqyx0kbK8hq+0PbVhj8wgebr3y+4KegE/5L5rhK6LnyT4/utp83+A4QfPhu7MI
         3mRwnRY/bzq8VKEh3YpjIS28SPh52No0GZJAyYgAHkTEOrYoD8Y2nJtfMWaHFU0vrYVN
         dsYw==
X-Forwarded-Encrypted: i=1; AJvYcCXBz7v6B8nGUpxmTLaXLFuSfTuINPAmnVVe6RgNLiwEhU3UcykOMrAgJ3Uj2jW5FjaAJS8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxfg5IOJJlUK9zhDmpxV6tPrwEwIFpMSuQAw2LUJhapfGzAqmRA
	A8z4x5NZt78ICnyPRL5/UFy8KbQB7HCyh64WDfyZhzj/RHuvJY4SWKdOqSW2UEHAd+b/rE9qYq7
	eqm+AVYXVjMIzWhCC5dN9uhZ/G5VokUzvkK31YQ==
X-Gm-Gg: ASbGnctLVeGJ20jc4GVqO+h7bVRSi2R4yX3nGcB9Ni7X/nXtStK8xW2JBVTHbgqzfg1
	e7BxHXGdEb5TbVU4bobKdzlNSpHllTduz28QXkAtaPir6Nj88CGDiTzxNtkK3ieKdaB34GTjDEt
	i2OrP3OV+VzQJMjT81ZgeLlY4I9mY8FRqagw/x7TIx2OwSOGHE+egtx6y0hIj9
X-Google-Smtp-Source: AGHT+IE0FPGsbCqLnGBW4KdhUPV7CY2DvEGvO7XFP87ES38g/7BbhAMPLGAj6n3jxOR6tXFp/QdOeX/JVRVa8FFMjog=
X-Received: by 2002:a05:6902:2d41:b0:e64:60c:54ce with SMTP id
 3f1490d57ef6-e64060c55fcmr5403040276.2.1742117821488; Sun, 16 Mar 2025
 02:37:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1883.git.1742089659610.gitgitgadget@gmail.com> <CABPp-BGbyKPmx=jNFE9TpvhSO0DcvqA8AETAYRt35_dG20rABQ@mail.gmail.com>
In-Reply-To: <CABPp-BGbyKPmx=jNFE9TpvhSO0DcvqA8AETAYRt35_dG20rABQ@mail.gmail.com>
From: Han Jiang <jhcarl0814@gmail.com>
Date: Sun, 16 Mar 2025 22:36:51 +1300
X-Gm-Features: AQ5f1Jr2HYdkedpJmxxikiy-u4LHVe0mIOWI8slclDUw5CgrPynOkvzVqTa-H7Y
Message-ID: <CANrWfmQ6LRfqcwtE_HEoY0JzE9KCE04YGe3tMzAsBgOWm53vXw@mail.gmail.com>
Subject: Re: [PATCH] doc: add missing commit C to the graph for
 --ancestry-path=H D..M
To: Elijah Newren <newren@gmail.com>
Cc: Han Jiang via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 16, 2025 at 7:53=E2=80=AFPM Elijah Newren <newren@gmail.com> wr=
ote:
>
> In the future, you'll probably want to use separate cc lines for each
> person you are cc'ing; I think gitgitgadget expects that to work.  You
> also might want to add a space after the "cc:", though I don't know if
> that's required.

Thank you for your suggestion! I will follow it next time.
