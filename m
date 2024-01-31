Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BD8F3B2A8
	for <git@vger.kernel.org>; Wed, 31 Jan 2024 23:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706743292; cv=none; b=S1ponbTIYrsFj0V6XF0plVtozJZNNvX9vGo2DeFb+WNlI+vCPxJ+29rf4toXtRPuVusjKqX17jIW5T9poLcrgoRfKzEb300eWwJKINX37k3TFFWjWaIjylV525b+9RBz2pohEj+8OQ4obf6bThx3OMyk8ZGKNmxPWnM+kD/HwCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706743292; c=relaxed/simple;
	bh=izS3HRHdflGHYUSlT/orT2AvdyPoWwWz7DMGw/ujAQE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=u6UibA3lA7zPov/zzrD3yWMja/2x5j9177NjoZ8+QHqz9gnWAUPcwpUf1diBPXxantwr5lwKKkkYbk7lO6iXX2fKyJs7IwyiIpl8+7+jj4xJza/f/rYquI90gaiBuYgJFCSU+zPJz4+yxkZbEPcE1Qkc8I6JWuH0ZYg9V0Yunf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YawhpR9+; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YawhpR9+"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc6b26eef6cso463044276.3
        for <git@vger.kernel.org>; Wed, 31 Jan 2024 15:21:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706743290; x=1707348090; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=izS3HRHdflGHYUSlT/orT2AvdyPoWwWz7DMGw/ujAQE=;
        b=YawhpR9+nC1fqrUJjasIwf+PZo1KmPCHOAUPVDlX+aUGgBUyQNfpAubW1+kCIfVeGJ
         hAWelcfL9PTcyYaGNHqJ7Fya7ytC3mDg8/g/yc362PnMXvtL8FIkIqGmxHqaTB5KP6Py
         +lHeUyizpcG+wBoA2mBXdynyhFV93SFO1brPTYF5PowGS3lppTLFOPLvKYgDkNBK10sa
         Dv8bkb+0pNfylSkgmPwbTiS7qtTh6dmQV75qalsqOPc5V3TaQ92LkIbK1jXbt0TCXRfZ
         2IbplMYGZuZGQS8OVXkOQxa3f2lbRXptN5hiIrb/ieotza8nSpvDG1YD0ceL3KxF4ngM
         AtcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706743290; x=1707348090;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=izS3HRHdflGHYUSlT/orT2AvdyPoWwWz7DMGw/ujAQE=;
        b=C1hEu88xWk4HA/fc7QY5lcXKtg/tR2/kLvmzBNRrpBtRBvNnl+maEY6rfJSJWX1+Xp
         LTGSALaD4aoAlS4wELE/c1ksBozbWdOhPc6VZTBufbfYx7NrkIe68kXxyf8s8qTm+8Ge
         BunefxGTqGqzCp1DTc9oLuFxDYgVfwP6uhoH+TniKTdj/V/B91Cbsh7x4zO4vGHojX5B
         R1eXp2n2GFOywViKjcvGrRibfgo3hNa/8Vr0O44IOH+U9/VVcFfOBADdi9mr6S+rGKIc
         XvC2Yac7VGwHkbhbJmIPAFAppv+5WDjmO8s9VYlLnybijFKyRjSX6YW6A6qkuliFPwbt
         onug==
X-Gm-Message-State: AOJu0YzpjGo+enM5/TucJae5vPdI+GhnMaglja+M3jkN0nmcTPzHoGY3
	B8ef5+hfjV8NeYXMnBQUI/+DRkTM6l36FTI2LOt1JD1ifOpWOEDnOU0dka4zR+tUtpqtknN5rjg
	bDA==
X-Google-Smtp-Source: AGHT+IE5ie5bZhiRG5EBvoWW7Zym2beFr52TlVuZ76UL4CvOnTYE7hBFAVWhfhDdjAHjwBvFDg3llSgMvYU=
X-Received: from fine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2221])
 (user=linusa job=sendgmr) by 2002:a05:6902:cc9:b0:dc2:57c9:b44d with SMTP id
 cq9-20020a0569020cc900b00dc257c9b44dmr25516ybb.8.1706743290543; Wed, 31 Jan
 2024 15:21:30 -0800 (PST)
Date: Wed, 31 Jan 2024 15:21:29 -0800
In-Reply-To: <ZbqnSNPjIQW3Durz@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <pull.1632.v2.git.1706308737.gitgitgadget@gmail.com>
 <pull.1632.v3.git.1706664144.gitgitgadget@gmail.com> <5c7a2354df0f4a29841f9ab8294ead0e1c3b9cf5.1706664145.git.gitgitgadget@gmail.com>
 <ZbqnSNPjIQW3Durz@google.com>
Message-ID: <owly1q9x2io6.fsf@fine.c.googlers.com>
Subject: Re: [PATCH v3 03/10] trailer: unify trailer formatting machinery
From: Linus Arver <linusa@google.com>
To: Josh Steadmon <steadmon@google.com>, 
	Linus Arver via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>, 
	Junio C Hamano <gitster@pobox.com>, Emily Shaffer <nasamuffin@google.com>, 
	"Randall S. Becker" <rsbecker@nexbridge.com>
Content-Type: text/plain; charset="UTF-8"

Josh Steadmon <steadmon@google.com> writes:

> On 2024.01.31 01:22, Linus Arver via GitGitGadget wrote:
>> This unification will allow us to delete the format_trailer_info() and
>> print_tok_val() functions in the next patch. They are not deleted here
>> in order to keep the diff small.
>
> Needs to be removed after squashing v2 patch 4 :)

Oops. Will update in next reroll, thanks.
