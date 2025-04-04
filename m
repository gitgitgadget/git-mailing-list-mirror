Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BB0233FD
	for <git@vger.kernel.org>; Fri,  4 Apr 2025 05:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743745896; cv=none; b=NnWghUheo5nfLcOr93yZbo9JPkSVQNHyQnTysmGscaoC/vJ6/yZIL5AxFMyMisLl27Fo/BdgGjS0KZZHBaQnJUMMRNHjP3IvP6Osz4BPVKEZi+n9a3mogQLXTBL1gEH3JaBCi9bb62B7FvS+Zg3yJJQM3ljWMndvF12pb3Quxfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743745896; c=relaxed/simple;
	bh=aXlNcjx8LjY+6AKSiK/pHVD7tgOlACvrnadqt6SJz7I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=bPvbJQsT7C0sLIPJY8XutP29/gW8aS8dVWhFBRq4G5ck6OhQGo8JMaPsmJrZ5ZELRRsAeMJBtnxl4RBguY7Jx2LIFrDvJkwDyseQHBrtGkj/AGFX5V40NuRnNw+KI55EBy98cTlP7bBV/os4+rns9ZRja1/8pRk7x55Z8xrGyeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IZGZqwoA; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IZGZqwoA"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-39c13fa05ebso986941f8f.0
        for <git@vger.kernel.org>; Thu, 03 Apr 2025 22:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743745892; x=1744350692; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aXlNcjx8LjY+6AKSiK/pHVD7tgOlACvrnadqt6SJz7I=;
        b=IZGZqwoAeL6GiXfjU4yz9nPUbKEw6DLOnc1ufPfTTmjgl/RgL4fPeP90xBIAciL2C1
         QtZlRJhfNAffW2GwhBGmPbb5oM0oTGDFg5XIU66i0luCifxifJDbCEQAcRMPgHbZ4ct1
         X8svxKwDSewy8poZuOpWqMmWesTwx0EWXcxy7oOugyvagjs+UX9M6fDJr4v5d8H46Z+D
         FVv/RmEob/3EMdzD536RlkSnOZdEx9MCV85ryRTSEZw6vxVYKGTJXhJ2xbeXOt6FKdIq
         ZejDBscdUNASoQmFDVoGOhm0np8lqELSNIviLu7tI+dzoCJZnEvfX1suFHOeAR4ccsnF
         WlRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743745892; x=1744350692;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aXlNcjx8LjY+6AKSiK/pHVD7tgOlACvrnadqt6SJz7I=;
        b=EpHvL2HaDTeGMRvBAPX8bd7RUpbFEyKwdetgCyggNic+LVj+z672cHg8RN8HCHjVs+
         NNTKcv6rq5v4sxg19GYKJdCcMv+7Q7vM9cLMsbdZ7buREXZ1u8DBQ6WhPDsxp/jD+x+n
         CMZN7jUSrMGK3RGlRWtnGWkI1sGJQ2sU0X64CzSfUFpwtv46w4G5dUvrsSGx+cb2MRNz
         AXy5aICX0NKr7+TKhz45VdDyuqYrHqS9sPwmQt7L+N4CXhTEBzcFDYRSKUzlmI/i2MkW
         dDevkPKrF575/NY5DRGVTJ/40agmpqKpstK6x+T5lpb5O8YdOYGCdJnm5cfj0t3IPcV+
         C7Ag==
X-Forwarded-Encrypted: i=1; AJvYcCVAA2rtF9OhjF3QnbDrUlIuuDgmeI3SvQztt8OTE1yOPqAhGGY42xO7wIBn1SkUzbIoxxk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfADvoi0lHOygCnnXI5wnrJ0+n/ONrC+Eofq1s3jFkmnZiIrIB
	QWNFvPSFxUmPVjloGUhUZcwKX6Na3FyB3PvAA/sEylMKIuYwV8FMRs4vFyAb1gpMa4qHcS+gFjn
	KXgbtUU+PDmCK4UB0o+SvlBcvLao=
X-Gm-Gg: ASbGncu/8GjUV+fim0My9eSHLui8He9WbGFGDhEaUNbBwofGKtjRQc/zJpRc05aF4ea
	DHle/lUa08yERohf4kuqjH+47wPDshXQkUNQh8SDoyGTUTNsZp8SLR5Can8oab4/5imlv+m+YYy
	argYqZESXZRLEgXKw2ahXmzMfpTQ==
X-Google-Smtp-Source: AGHT+IGbfNsc0FNOt1z4KBmsFcYRZ55rhBvOCOEflLv4CQ8K1LA388eh4ygwGp9BDFQRRN6f8YAJfpgG8u4phBEugJ0=
X-Received: by 2002:a05:6000:1a8d:b0:397:8f09:5f6 with SMTP id
 ffacd0b85a97d-39cba93cd39mr1594789f8f.47.1743745892285; Thu, 03 Apr 2025
 22:51:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAArAzAoU9qDj+yLi3pA6wFYdTAk0UvQk4omSWM1RL4D9w5fw_w@mail.gmail.com>
 <Z-29LsgDvcS0qY5a@tapette.crustytoothpaste.net> <Z-8K9ZIt4j_UMNZm@tapette.crustytoothpaste.net>
In-Reply-To: <Z-8K9ZIt4j_UMNZm@tapette.crustytoothpaste.net>
From: Andrej Zhilenkov <azhilenkov@gmail.com>
Date: Fri, 4 Apr 2025 10:51:21 +0500
X-Gm-Features: ATxdqUGY5kNjkWfgX3s_nQdMXDEsiT5l6FWlC-i723Jf3m6vXodDjiiBFM7H6y4
Message-ID: <CAArAzAr+YPwVXJo8mjkyQG8uWv=wt89tYyp6TL-rNzvwVYm9YA@mail.gmail.com>
Subject: Re: Update symlinks after changing core.symlinks
To: "brian m. carlson" <sandals@crustytoothpaste.net>, Andrej Zhilenkov <azhilenkov@gmail.com>, 
	git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> On 2025-04-02 at 22:41:50, brian m. carlson wrote:
> > What is your particular use case that requires changing this value?

Hi, thank you for your reply.

Just recently started working with symlinks in git and I've found that
in Git for Windows they are disabled by default
(https://gitforwindows.org/symbolic-links.html).
It's possible to just change the setting in system config or override
it in global config, but it's probably safe to assume that the average
Windows user will have them disabled.
And if your repo needs them, it's probably more reasonable to ask the
user to enable symlinks in a local config, not global.
So, you can enable them during clone `git clone -c core.symlinks=true`
but I guess as a user (and symlinks not being used very often) you
typically learn about repo having symlinks and you needing them after
repo was cloned.
So this is the use case I've found for `git checkout` or some other
command refreshing files based on current `core.symlinks` value.
Without this feature you would need to have a script where you list
all symlinks, remove them with `rm` / `del` and only then you can
check them out.

Maybe there are similar cases but on Unix when users would want
`core.symlinks` disabled globally and be enabled on a per-repo basis
but I can't imagine why.
