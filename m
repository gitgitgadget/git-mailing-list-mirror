Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61E266AA1
	for <git@vger.kernel.org>; Sat, 16 Mar 2024 09:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710580803; cv=none; b=G2667xFcN+pU/knU98IEGftZMjknIJIFVFP1GdqcW08lCzRrEZvr+5GPxDitxHspbAEjYE5Kd4BLer9aoynield9QmWihu21odue7pQuEwu3oSPzCCevAYiMY/LMQIHHAQB/TxLvb1jaCMF4Ff/CV91D5n7rOCrOOLXgETLMSJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710580803; c=relaxed/simple;
	bh=xsWKWaORYCM6pMo2ZUPYpyPMNzI2qiej7sDR8Wz3BW0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ksPUPXcK2WU8Evwr3JpFeGSrr+8UY++74E4xuMfPxixIzocC2W9WaWVMzabTp1ZhbmjzMJb82JDBSZPQ9xRJykjxGm3JGjBb8tK+p4Ucj4SvXSJ2UVGn48UdnxDEXIFt9TcZm/kVir2SheyEhvVw/hxooobPrTD4/WLwAKZYaAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=iAOjTW/W; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="iAOjTW/W"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a469ee62fd1so80214466b.0
        for <git@vger.kernel.org>; Sat, 16 Mar 2024 02:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1710580800; x=1711185600; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xsWKWaORYCM6pMo2ZUPYpyPMNzI2qiej7sDR8Wz3BW0=;
        b=iAOjTW/WR47Ms01G5Oqdl1giOpyeiCrsc8Do2hLRQVUaXQTM3UhV1L6BZgUL1LFO+g
         QBsssroQec7gkjS/gyauq7jyQPGeqBhDJHipKjNNcIAnd5sv7P2ZLSbm53x5iUQx44cY
         Yq/PXKMzHYOQGcZ9d/ayHyjSJ2J3YJxhIZXf9EyFM3bEMeM+UoZw0yaynfZVpPh6+UoR
         9Kba54nIY4Zu0+kSToJjEXVK43c4ok7UXhg3d5idKMoDDd77S5JR4R3NDZOWOZsZl7G2
         D0utHpMQ0JRr1n28suVcxHWGQOsvO5WsEHj3zmnRSiQd6m4+kVuNJEoDZ7ASN4pAxDIs
         W8+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710580800; x=1711185600;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xsWKWaORYCM6pMo2ZUPYpyPMNzI2qiej7sDR8Wz3BW0=;
        b=hcT07KItohTnom+GoD4G9nZ3QAaTonUWOzfFgcedj6vO1zMKHGnQh6M1BJTU6coYbQ
         isG9sE7KoZq1wQ+ceMSyb23EIHkT1B6OHyXDEsVkxrXPr9HSsy6jsDcYFwajhGSzExSD
         7/Z+/Ndc6Oo0g/qnvhwUakCfd5GJIHY2H6v+xknokONHUE2Zzr1MGELE95HnAPa02mDv
         hcqvg3379NXa6L++gdANY6NSCiLHbNHaeJJ9pGcqOntfUpoRwnX6FLDk3FHMWGlF9bO8
         AwtACjvt1fQXDdepB56gQy65j1nMPKDMGKq80hrVO7bc9LAFt89ll+BX/jlRGTUy7yFu
         E3Xw==
X-Forwarded-Encrypted: i=1; AJvYcCW/utEBHdI+zpevbkWwmQi99ZnTeYEhXxUr0B+zxXQA1eq5eMh9inRx8lFkIG1nbD+W7hnuDmxekuHqXPBMZlp27LTk
X-Gm-Message-State: AOJu0YwTTkap3eYrmG5+CxIQYG9jsVmZSGEKSZleY3gpEuXGDQLwY5zE
	EkUAzNedQm/fspkaK0lTh9aKV9K4C7S0muppJwZ5dfSgUHpnvc3e0mtAI64b4kFzB4k/r2CCQao
	qNki6nH6V4IXFyyHlyH4hRLFi5W6o7a8voNM=
X-Google-Smtp-Source: AGHT+IEuJDtSwjQwdYRrfrsMVjJz3dCYRYAPcOqAAVjP6dTwoCOqqPUMGSKfLEvndjr92sg8Miqttib+bBsycrDR+Ro=
X-Received: by 2002:a17:906:13cf:b0:a45:b492:325f with SMTP id
 g15-20020a17090613cf00b00a45b492325fmr4196513ejc.13.1710580799407; Sat, 16
 Mar 2024 02:19:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+XMOBuK1_BNqgQRfCne8dVXKGPt+iQ9wt4iZqz0PgEqZ5UCtg@mail.gmail.com>
 <606fe3fa-a5a0-4d35-a4a0-59521043dde4@kdbg.org> <CA+XMOBskofgsmCbcchmPYo9rF9+Cdtdj_m8VzQrLbGhZPm+mrw@mail.gmail.com>
 <ebd073ef-4ba4-44df-919a-2adefb40e3e7@kdbg.org> <xmqqzfuznn7g.fsf@gitster.g>
In-Reply-To: <xmqqzfuznn7g.fsf@gitster.g>
From: Kai <k.vongrambusch@googlemail.com>
Date: Sat, 16 Mar 2024 11:19:48 +0200
Message-ID: <CA+XMOBuYVWwEE-p=3GHBUcnnM_jn0pneW1rbcQU124DjnJYycA@mail.gmail.com>
Subject: Re: Git is not recognizing some merge conflicts and just accepting
 incoming master version
To: Junio C Hamano <gitster@pobox.com>
Cc: Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Thanks a lot for the explanations Brian and Hannes. That clarifies it
a lot. I had not come across such a semantic issue in my limited
experience with git before, so I was a bit thrown off.

Given this behavior, I still think it would be a great feature for the
person doing the merge to at least optionally be able to see
highlighted parts of the code that had any changes between the base
and the other two branches. Since these parts of the code could
potentially cause problems much more than lines of code that have not
been touched by any branch. But I guess that would be more a GUI
feature than related to git directly, correct? Maybe there is already
a GUI offering that?


On Sat, 16 Mar 2024 at 00:29, Junio C Hamano <gitster@pobox.com> wrote:
>
> Johannes Sixt <j6t@kdbg.org> writes:
>
> > That's the responsibility of the person doing the merge, who at best
> > understands both branches being merged.[*] It is of utmost importance
> > that a merge result produced by Git is not taken without thinking. It is
> > never a no-brainer.
> >
> > [*] That is where good commit messages shine.
>
> I am glad that some folks appreciate what I do every day ;-)
