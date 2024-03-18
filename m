Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E6E118E28
	for <git@vger.kernel.org>; Mon, 18 Mar 2024 06:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710744766; cv=none; b=Y0BQ3awUWbYv/X9BlJdJfytff6KXlFKMv8gpf+zVVTTWC7oj8Nn7bwXjENkSqw7k6q4hD1y9M7HsDD5+kJb9ykNrFUxM5Qdp9fDXPBLWkXW0fR/vRKiRE3tOwQKPhIXF4OXhiXyUnQOPH76IDYI/rZAVuauzPj7Ps71fuv7VH/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710744766; c=relaxed/simple;
	bh=azSE6+d4zdGuvtA2VWIAb8orWXhaGbJHrYSW6JPEVRY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=G/dZiUExqfrTYn6NwYBQlXip9N9fne2E3wOgsHJNinAuVZI9UO1BUIhuHyxwIJGPakB7zWKQQNMhIVNCCxZWVKyT+ktkkFalye6SBbTuTHpfKo+YnIudYzX5xuDiT0lY8KYJFssjy2G5emIXUjvUXoe9JIVIbmfMP88XsqgywpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kIkzEgbu; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kIkzEgbu"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-1e02d9c0af5so3631685ad.2
        for <git@vger.kernel.org>; Sun, 17 Mar 2024 23:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710744764; x=1711349564; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D86C6f9xymUWKFfmaQb3UENceIvhuAn1nDwW6Uqw85M=;
        b=kIkzEgbuUnsNx/HZRjpOYXp5PkRI1mXv4/Dwbns6Yf8t4ZJQRGpoaiDMWYaTrEdV4C
         qhv5w9at0qz5iJyBfH5hxLNTJVmL6zcDpR0umHwEJu7BdV+06hfAJNdx4MwQHM0wrSL2
         qkTqqlL3ksV3XfaGWrf9RHT3PX+6Hy2yDhkZrV08Crmc2HUPDiQyQLANFciNH/+9x/36
         gWTb9ve21UhgDyz6hTf0RlR0rNjEab+P1LtE9xtRJ8kTgu9LD2PuWesejO82MNYgQgmQ
         I7D0oA5Zz5SN6UZYimY9+Wm2hz64HAnU99DmW7Q6PYALO1o5KWj7tuaTxHM8CB50Z+RZ
         MP/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710744764; x=1711349564;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D86C6f9xymUWKFfmaQb3UENceIvhuAn1nDwW6Uqw85M=;
        b=TO1CN2XqTnLXmqUZOIUFHkdvwwxZXW52wrQLGykqNkfiDB0V6/PJXyDh5/iwScRDpW
         qOPr0ZceIC90lBXXYd0oUVHYp+HFfwZhpfHnk/pIQy6uuSy3Pz8DmoWPC/ZxW5TSRRYl
         GQOoB1snT9Hx0TLg4+CpNtCKtUW4Imrr9wSdOcSjwUIfl+bEbi1ZpspbhfTfMG2GmmC0
         aQ7uU/08zQhvFhNOraq7E8cPhiFn1kWlx1mrl9gwdROr/bA3TR2SEJ5NZ6OEyTTIVs+m
         SLNwONNs1gjGj7M+mcJDnugCWNPk8B7FBBNJR1G+EljR2gsL5ix6QwWeCbJ5r7MYUBTD
         U+7A==
X-Forwarded-Encrypted: i=1; AJvYcCWgmN9htnSe/P0RtRu0xtyMt+Z26RbQKnKwpwJUdsYYKBvrOdjSFDEgajKPrTfe1D6YePRtmwcvRHhV8Vcftzv5CYp0
X-Gm-Message-State: AOJu0Yzk7ZTu68Gts4ihdgDMhRA4XrOqEYXgMVEMabGD7sakOK8my3mn
	URlQrgiKwbE53hiimPPcRFgRn0aX1k9qfSZ4oCzIphr8dgQnBDsDqodC5MA/6sqIpgvTMwsjxeG
	dgQ==
X-Google-Smtp-Source: AGHT+IGkolO0g1syzrnd+/nWFhYG7qkZCW9dKiVaRCyiFabQJ02w5m87d7bfhQx0lz17U8pVXuu/QKSvzK4=
X-Received: from fine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2221])
 (user=linusa job=sendgmr) by 2002:a17:902:d4c1:b0:1e0:1a1f:5de with SMTP id
 o1-20020a170902d4c100b001e01a1f05demr257455plg.0.1710744764242; Sun, 17 Mar
 2024 23:52:44 -0700 (PDT)
Date: Sun, 17 Mar 2024 23:52:42 -0700
In-Reply-To: <3e217121-f49b-33bd-b76f-df24efca6d14@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <3e217121-f49b-33bd-b76f-df24efca6d14@gmail.com>
Message-ID: <owlyo7bc2fr9.fsf@fine.c.googlers.com>
Subject: Re: Failures in GitHub Actions linux-leaks and linux-asan-ubsan
From: Linus Arver <linusa@google.com>
To: Philippe Blain <levraiphilippeblain@gmail.com>, Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Philippe Blain <levraiphilippeblain@gmail.com> writes:

> Hi everyone,
>
> You might have noticed that the linux-leaks and linux-asan-ubsan
> jobs in GitHub Actions started failing last week. I investigated 
> this so I'm sharing my findinds in case it helps.

Huge thanks for looking into this, Philippe!

> The failures are due to the new ubuntu-22.04 GitHub Actions image
> (release 20240310.1.0, [1]) which uses a kernel where ASLR is configured
> in a way that is incompatible with ASan and LSan as used in 
> the GCC and Clang versions in that image. More info can be found
> in [2] and [3] and pages linked there.
>
> A workaround was already implemented in the image generation process 
> [4], so the next version of the image should work. I think the images
> are released weekly. We could maybe add the same sysctl command to reduce
> the entropy to our YAML file, or we could live with it for the next week
> or so while waiting for the next image to roll out.
>
> Cheers,
>
> Philippe.
>
> [1] https://github.com/actions/runner-images/commit/d67fa31aeeec3cf0d666d0eb2976b683471c6b90
> [2] https://github.com/actions/runner-images/issues/9491#issuecomment-1989718917
> [3] https://github.com/actions/runner-images/issues/9524#issuecomment-2002065399
> [4] https://github.com/actions/runner-images/pull/9513

I appreciate the links you've documented here for reference (and the
care you took to write up [3]). You've got good taste. :)
