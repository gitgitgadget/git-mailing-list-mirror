Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1021B5FDD7
	for <git@vger.kernel.org>; Tue, 13 Feb 2024 20:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707856629; cv=none; b=mmTKTjNX/s3EszBKzUDYbK2yROoM/uzuLJaQjzq5krnnERFuaZyQUWRzubKwnbGRYICrdU7SDz7U5nkeuaDbwyt2plWat9N76bYcwlsX9howPszagFNVcmeco0TDBEZ0Hp7B2WAx7TJdEt15C3hIwLDCv55t9x36lehE3ctuy2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707856629; c=relaxed/simple;
	bh=FGYjEIKUxCE74SB78VWFSYii3zRaq4KSKjzvxQNQDaA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=H9nnM5SB+0YR5zM8Z62cHBM8mlqg89DyS05V+MdXegG1nQNfQlZGpOcJjqtEhTtylup0AltTsjs28K+DH7iyDlDGQOoU0mdPr3erF8e8XwdebqkM99MLJs7/NS+9hKmVLFoWI+ILzw06rAPyd6qNmRBIahC/4CcO1O1VeJdPB2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0BuE1otu; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0BuE1otu"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc64e0fc7c8so6796263276.2
        for <git@vger.kernel.org>; Tue, 13 Feb 2024 12:37:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707856627; x=1708461427; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+0wER0y8FcruUBL5Ule9aLntURhP9WxfuTZUpeUg7W8=;
        b=0BuE1otuM33PqlnQITSuy/OXQydUcxtnb/In42le+VlZWBYRHMw1smuImpUVBEt6DR
         hzjLAtR1dErn0l+sP6YyIri9edvK1ldv+fQkhrwy7OMuDBOYEoK0HEoYxsptDYfTTPZy
         zsCTIF1pnKQqG4AeWsSCx+YHaURbRFPlUFalh7RYex7Xv6l3/5Vy+z1TaN9kd2wis3tu
         G8ljn6511B08OWLbqXlslKka3FWHp3XlJW74pmEBBQVqdizvdaXc2nkP6ZwCF5nDforE
         9MbRx0QQnz6V0o8S0ajs5tWHHNT3gx1+808XhpzVDH5kQX4/ST3ARDu8bsHNmdhwu+L5
         LbMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707856627; x=1708461427;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+0wER0y8FcruUBL5Ule9aLntURhP9WxfuTZUpeUg7W8=;
        b=Tpbm7Nzo5nDYoTnfl8nF0d8fF63Fwm17B85RLi9WVkWVxB28jx76xW9qQAE+IDnmC6
         C3+uHVwsw+84HLffJYUbAiFDv5UDBum4+NtHK8Eaqe601vcXlvuRFUgI55DBpNgnKm78
         A+hUj62NQRkfenkCTXJIpJagbZ+Ecp3DSyoMG50Vt3jxtInoOxE9XmKuFefKhNLR1p1t
         217M3s+o3xUjhSoaqnaa/IdpEF7EYxHPMWUVCUNGnRHKWR7q2497dCoXxzwWdlS5btW6
         g/VLU2RcczapRpam5aP89Pf4Q+lqB5JOEZd87Vg0O91WyQeASoNURvHMfU87CmrB30tl
         2sFw==
X-Forwarded-Encrypted: i=1; AJvYcCXVBrwHJ1rp/6Yrb/+H6OUUsAnN4iKdIxAu8fH0LgNE74N6VlZ3fUCFsXuQu9iRA6EUcGpxdZp2ggXMwiSlkNtgBcY4
X-Gm-Message-State: AOJu0YwnvY3XT91logr37YtSkKWLFDp51ykh21bE9Js7hAQ9cg0Hxxhi
	zOFalVrx9s/59Dwb4psWFXI0NReycR/TU2wRaxK6Kl8+YFDZJS59cvfb6TqXN1heWbd6QoJSEcD
	WqQ==
X-Google-Smtp-Source: AGHT+IFfo7Y/+lcJcVqeesstXhkk4L65rOrFTs2y873Rpvb0sEzBm1ANnX6/SqxSB6aA46lXhTSDgpWJ/qs=
X-Received: from fine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2221])
 (user=linusa job=sendgmr) by 2002:a05:6902:1029:b0:dcc:79ab:e522 with SMTP id
 x9-20020a056902102900b00dcc79abe522mr19332ybt.11.1707856627010; Tue, 13 Feb
 2024 12:37:07 -0800 (PST)
Date: Tue, 13 Feb 2024 12:37:05 -0800
In-Reply-To: <owlyr0hg9kr3.fsf@fine.c.googlers.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <xmqq1q9mmtpw.fsf@gitster.g> <owlyr0hg9kr3.fsf@fine.c.googlers.com>
Message-ID: <owlyo7ck9k3y.fsf@fine.c.googlers.com>
Subject: Re: [PATCH] git: --no-lazy-fetch option
From: Linus Arver <linusa@google.com>
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Cc: Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"

Linus Arver <linusa@google.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Sometimes, especially during tests of low level machinery, it is
>> handy to have a way to disable lazy fetching of objects.  This
>> allows us to say, for example, "git cat-file -e <object-name>", to
>> see if the object is locally available.
>
> Nit: perhaps s/locally/already locally/ is better?

I forgot to mention that the new flag is missing a documentation entry
in Documentation/git.txt. Perhaps something like

    --no-lazy-fetch::
        Do not fetch missing objects. Useful together with `git cat-file -e
        <object-name>`, for example, to see if the object is already
        locally available.

?
