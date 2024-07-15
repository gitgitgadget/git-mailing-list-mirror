Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF1171F61C
	for <git@vger.kernel.org>; Mon, 15 Jul 2024 05:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721020750; cv=none; b=YSPDW3FAMXMRN1n6zTzhZ+iLfBbs04lIkCtHeiBf8MqnYLwuUVwzxsf1ZDWMl1OeVX+Uu4paGhYdOMzMqx+Z1+a9vbZJR5mvQVkSIOeiiVbn15yUimsjAti217V/F7YRNpJ/QMYxKo+TjGRvVsBskuUFZ3cO6E9yVpOaLn8q01E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721020750; c=relaxed/simple;
	bh=dKPA/9gBmEf0s9nbaNcBrmNfrBPZWBPzAzEiMYB2GYk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ip1S7xRWaYKLYrHfNkRB8gbiW4uLUN7bb3uLcmSLLJ/h8gLCLHhY5by/EcWf+TKI9cn6pNzs63frCVQX6ZjC3CLNubsiRt9sn+jM3OzMZPA8uhO8ge0Ei5BOEkpsKlwbVbCFhz+xa/pEOwNIPJ9BbevEiKJL/KNASkT8gQ5ST7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JG1lyVUR; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JG1lyVUR"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-52ea929ea56so7137250e87.0
        for <git@vger.kernel.org>; Sun, 14 Jul 2024 22:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721020747; x=1721625547; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dKPA/9gBmEf0s9nbaNcBrmNfrBPZWBPzAzEiMYB2GYk=;
        b=JG1lyVURnkku01qGEAYaedOP89JVyIzXI5LZ+s5POooFJQ2aWjAMSdhVgZC66GWT+R
         Qizhc1BkQUmCW7zWHfyL1ioabNHLN4II1vPKH8csRXJwfB6DySUWEaXkxi8fEiR1bmWj
         y8RclF7u3HajNIpCmkT44IRIk+qFhHspqruJVesa9QZnOQdvpIFEh/FU/JKkjNCQaU4j
         a8bQmgEJK1p8EW2ka3bhHwdhPVeSJbRhdCaepMBi0MZZ0iHorYjGNoWAHbuNs8arSgqn
         CKRQ7uIFDmX2xjfzJjRM7ieGbD1EIf2KHrfMeR1M7jWik0z+SQdbfTr3GD5G8+6+jEgf
         Z2QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721020747; x=1721625547;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dKPA/9gBmEf0s9nbaNcBrmNfrBPZWBPzAzEiMYB2GYk=;
        b=cEXT4e4dAX+8ZDhWBIHSj6FMGbLuD+e/s+WUxOAMQ6iZw7jAXReTrmSDwm/OMOa51D
         IC109cIJw6SwnohH0P/OQqKiEl6PBxB8YVNaD6D5HSpcmF0tFxzB0p8/FXR//K49j6Fu
         JsigZfKk/qpgjmUgZThHdJOJInFbWMClfy0SGWkShNECkNiE+VsTTXZoc0Uc1VoXTZHk
         85R7JDishJQldGtFvRbG9UZpgqK1HjvIY4UTiHq1VZlaOuXCcF2r+J4pvhhdzr3eKCSj
         zYR/m3MH5csSkJvPMBBEzCHgsiDCm18G7OEbWi240X0fKFjzHArEBBmznE9WhAEF3QBm
         S4VA==
X-Gm-Message-State: AOJu0YyA+co78KXUBCGswWZs/7YZvRLu4qlrtAVdTj+aF8BxW0r26y9r
	0V/V9FqQ73oNwuP3QG5PXzqbRY8LXILKKlA/u96Is3IuRO8HhsgI1OWeuYnc06dhxcHpzPi0b8P
	PoaoyVnMZKpJTYVh4OmhPMgOyVlo1uynJGoesvg==
X-Google-Smtp-Source: AGHT+IFIBzuE4JrqAs4yHKacwZM+zAvkeTmrP0UiDLusZe+j8K9McfVkKv9OU5yQgQLjrrs+LLf4y8uhp1rlycrtd+o=
X-Received: by 2002:a05:6512:3f05:b0:52c:db76:2a7a with SMTP id
 2adb3069b0e04-52eb99a3560mr15790151e87.34.1721020746314; Sun, 14 Jul 2024
 22:19:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+J6zkRxnvnybM3vnPXX2YwpW1k-as03+A8kxiJoA8GrA4FSMg@mail.gmail.com>
 <CA+J6zkQaV9o7eUaD2bshH7zEmF115BbYv_uCFctySQNMgGQc+g@mail.gmail.com>
 <CA+J6zkRzM33MbMr4-U56M1SFLykx029+SzEeo8vBicBd9Xs8RQ@mail.gmail.com>
 <CA+J6zkSFCUYLRTRE0Gwug4-fF9f9-YbfRz_atArmMLLCtQDr1g@mail.gmail.com>
 <CA+J6zkSxcogPXdAdr7VL0B3MnQxQNYwOT5Kw2iK_YfPLW7CMcg@mail.gmail.com> <CA+J6zkTyVDJcOoZC-thRAOYNudVWB1wgye0Ezj3o1AO_5HOS6A@mail.gmail.com>
In-Reply-To: <CA+J6zkTyVDJcOoZC-thRAOYNudVWB1wgye0Ezj3o1AO_5HOS6A@mail.gmail.com>
From: Chandra Pratap <chandrapratap3519@gmail.com>
Date: Mon, 15 Jul 2024 10:48:55 +0530
Message-ID: <CA+J6zkQ7W=3+aqAHwzXzVM4-mZ9XpCkAfmP-GZ7T4i+i2Gi9aQ@mail.gmail.com>
Subject: Re: [GSoC] Blog: move and improve reftable tests in the unit testing framework
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"

Hello everyone, here is my blog post for the seventh week of GSoC's
official Coding period:
https://chand-ra.github.io/2024/07/14/Coding-Period-Week-7.html
Please let me know if you have any sort of feedback.
Posts for the rest of the weeks can be found here: https://chand-ra.github.io/
