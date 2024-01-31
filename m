Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FBEE13D514
	for <git@vger.kernel.org>; Wed, 31 Jan 2024 23:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706743250; cv=none; b=MvYY1oVIXmacxxrL1VcFU0teV7xJA23sYsBcM6YQORfifO/rfbMR8YW+slOLx/jwLbUaThJK5gElFx9Z1PkTiIMW/MqCZfeRFCbessUyu0pXMywVWWqs2mIcO/ufM4+E1JtvIbU8rPIlUWB2bESZHncUfkx22w71QH7ngrTRigM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706743250; c=relaxed/simple;
	bh=IdJHbwXzaJQi44zz6tZNOiN18sbL2NgOIQ4pMBnCK8Q=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ulzrCB0rtW++Mw8Cs8fsaMr/MneLx2LBWQ2L3EZo6YpFX8ePZOBm3DNAsXUj3EjtI2Oz+gbUF9Gp0sHo/fGBHWw+qKcW09AsKZ5h2LzjKlwjFNR6WHdJu93OGstMbpEgxMXsf2XJv3vEE7IELFNdGtstB2EmV+c7X21u5fL6CyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZYbRACSK; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZYbRACSK"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc64e0fc7c8so393590276.2
        for <git@vger.kernel.org>; Wed, 31 Jan 2024 15:20:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706743247; x=1707348047; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=GL3xG+kw5wq6lcS7WlqE/i5eCrGUsM6lqT2OVPTUKto=;
        b=ZYbRACSKynNlIwFqbQu4opWBuLKQp2nPuB2RWsdQ7KZeyPaQ+n1ZRlIx+0ul9uKqce
         hgkjpasWbt1QhiL5XUY0E4tMr1q8TSBLLReCAEy8RBpxPA+cSm5hZ/2vYHbS8KVJO7bN
         OsF02dcDctPt9++GommwWYk3STJ7V4kjkn3OebwV0zNyFgZjowSEhK0G2g1n01MgeQiX
         gcoZtHtbJCadri+q90TQ0EaXp+ShmbWkMFq/Ak3ieMhNrE10SotaVa3YM8KK2scqzQHa
         ITyYeGPp0Wqhqp3QaufctuWWbOPRuGHk8gswjsK/05Z3KfbcMEZHdaH8H8AythyBPI5Q
         7gzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706743247; x=1707348047;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GL3xG+kw5wq6lcS7WlqE/i5eCrGUsM6lqT2OVPTUKto=;
        b=t0DhYjfHnsJomQYu2kYUnWO9BuhfTRa4bsePwiNHJtwq2OcVne8tc9i4+654bs799m
         wPCGXkSYZFwSwMIYzkgHdjiaooNuhwnjN0VHyT7ZM9BJ63rZyiqEGoIYlylE4xTaPWN8
         aGIpspleUmaGBY1nOXgsTBe1EnWB00s+bPpOU8PvEqJuGjXvFYO1760fdAGFwacrCgRQ
         Qe2J4cnPGjVTyHGFhW1VgzHKNJ5YhiCkfAtfeXB3XDcN7sMuHANE/M123gdvAMtrQ5iw
         EawT6PRnva0ow5Jt+raDGCYj+of1JAvhXl6wGJuSvDrkIWuZ+qZ+d7sGcCZ809pVMyAO
         BmdA==
X-Gm-Message-State: AOJu0Yy/NqLFtRj6DlHH2jwoTHpZiZWT+8SI8YJs7UB8NIpUQ/1P4LCj
	fyUhpYZnTANPngzJiwPjX5Liaej2SitKcFCKtbVKwwsvg1AU7Z0jJBDU/nZ6XFCk6Kz6dot6KYc
	eVw==
X-Google-Smtp-Source: AGHT+IG7jaX/nUGmMNZm1qM8IyiEJwrXT6qlmhXOWNMmTh2BvKyD6aX2Gj5BBV/LptOLd/fD7wFpWBLcCEA=
X-Received: from fine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2221])
 (user=linusa job=sendgmr) by 2002:a05:6902:2009:b0:dc2:6605:f6ba with SMTP id
 dh9-20020a056902200900b00dc26605f6bamr122460ybb.2.1706743247404; Wed, 31 Jan
 2024 15:20:47 -0800 (PST)
Date: Wed, 31 Jan 2024 15:20:46 -0800
In-Reply-To: <xmqqy1c55o6a.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <pull.1632.v2.git.1706308737.gitgitgadget@gmail.com>
 <pull.1632.v3.git.1706664144.gitgitgadget@gmail.com> <cafa39d10489f90897227a244e012457989a7710.1706664145.git.gitgitgadget@gmail.com>
 <xmqqy1c55o6a.fsf@gitster.g>
Message-ID: <owly4jet2ipd.fsf@fine.c.googlers.com>
Subject: Re: [PATCH v3 02/10] trailer: move interpret_trailers() to interpret-trailers.c
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
>> The interpret-trailers.c builtin is the only place we need to call
>> interpret_trailers(), so move its definition there.
>
> A few helper functions that are only called by interpret_trailers()
> are also moved, naturally.  I would have less surprised to see
> the addtion near the beginning of builtin/interpret-trailers.c if
> this part said:
>
>     ..., so move its definition there, together with a few helper
>     functions called only by it, and remove its external declaration
>     from <trailer.h>.

Will add in next reroll.

>> Delete the corresponding declaration from trailer.h, which then forces
>> us to expose the working innards of that function.
>
> This was a bit confusing, at least to me.  The reason why several
> other helper functions that are called by interpret_trailers() need
> to be declared in trailer.h is not because the declaration of
> interpret_trailers() is deleted from trailer.h but that is how I
> read the above.
>
>     Several helper functions that are called by interpret_trailers()
>     remain in trailer.c because other callers in the same file still
>     call them, so add declaration for them to <trailer.h>.

I've adopted most of this language in the next reroll to make the
reasoning a bit easier to follow. Thanks.
