Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D910223C9
	for <git@vger.kernel.org>; Mon, 28 Apr 2025 22:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745880920; cv=none; b=lU6DtHmaVZHGAN8udqlfbvMQ/+kFUrPGHCyM+giWIWSpFZJ2Zv0DR1kn9oGPY/LKiKHwvyD56xtilY/ITNTtkv2yAYvNkN9qll+zq3Cn1u1rT8f1LT87YbccP08LDCL6THEfBYuNCrBIXDphbw7sf8giDrMKxjRL0+pZLINSGH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745880920; c=relaxed/simple;
	bh=0PjrNXQhZAjTGccM2hKrPEM/K1MQ4oCf3/DRdfVyQJA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jQQtf5ZcfFMvzH9WVXpKXjC06X7ALFXuWeu1RgVk2vCaLX465ejEZf1+di2gctD7kgVc2kjYinAHvhUA6QUt8ShrLHD8lA/2xEt7QTg03QcMbWpweImlAZSrySfAlrgYnmeAS3hnYNmQTJWNhhhFNuurOyjnVL0SGNN0B2xdkP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=applied.co; spf=pass smtp.mailfrom=applied.co; dkim=pass (2048-bit key) header.d=applied.co header.i=@applied.co header.b=zQdiX/HS; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=applied.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=applied.co
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=applied.co header.i=@applied.co header.b="zQdiX/HS"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-af51596da56so4566359a12.0
        for <git@vger.kernel.org>; Mon, 28 Apr 2025 15:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=applied.co; s=google; t=1745880917; x=1746485717; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0PjrNXQhZAjTGccM2hKrPEM/K1MQ4oCf3/DRdfVyQJA=;
        b=zQdiX/HSAPun9yXL3F3+XVuOAoS1jbM8Ybs1LDLSux7QoNfX/aJ1dxD3J//O6vXgR3
         8LfNyFfO6Cukkqaj4F6rioG/wx8XfkyFSyY7PS0rAXyWlXJQidlRo8C8Iw7Z+ITuGi7Q
         wzTBSNNqwzcRwWh9Fk1/Q5QKyyQBz9ZPxh+X4iySxQPtqOe+zTVN/UmWDTRNQcb+tBgm
         OXxOf83iDKEDEI/EBZlFXpELRsNgyd/AeUSQLPKGeiT4k91qwjZmgHVbZNO7C4e1Vj8G
         3FqAfoOGND8kTTqR/sYRq3WhoJYHY4cx20RGQP0qvIkBFdPxeU7QNYvRrksjDY3IqARf
         9Vtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745880917; x=1746485717;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0PjrNXQhZAjTGccM2hKrPEM/K1MQ4oCf3/DRdfVyQJA=;
        b=uyati/L/wA2VwVLQwOshKBDzcsnNAjQDetrEgk9O+W1Y3rk6u/jv9keCr9/UzG7UtK
         oLzks5Ggz80hEYdPbDVtaFIaJN0Mt+mXIh+85PkYVwFV/SW1N/RT0618TGW6Fbc1N6TH
         Bjh9Hxm6RrENpUj9LBzN7kDbhOZqsf+Vk4FWlc6R+PChM7fJT5oTZgOvf3vthadDKbpN
         p7kLm6LPweRsYkhIjSdjLsTU6i2LwpuNt2QsTsyOIpXfXquIFLL1t7AdFpjUa/3iZcyF
         OVYoV20eFs7Ik5/2lUQZXZIIUGFdfLnVPodGLXtY/DDEaUk5Li0UVbE2Trv3wYWxYcYG
         4ijQ==
X-Forwarded-Encrypted: i=1; AJvYcCVI3sXR/KCRNI4pDEjZKa7ceZIb/EjLrohuT0QXrRi4GjtTGLXJRQU61JPV8y7sFLyXgf4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKn/Ejy6RZwDpzFyj3RBeDXP8956yKoOwiZwpKh8HKEtXm2SxK
	93C7OFTzTd+flOspxn8krnzC9Zry+oPDg+/hsIqdP4aQYMcyREWIe8gh+qOeZJuXwmYFZAAUMsf
	FnsKuNrNCRuqNxwZXtE08fnJUbA3BtuJ2EGPYhw==
X-Gm-Gg: ASbGncusM4WzLcxz+7D2Gc63fg3mNj3TQKeojfQEojcrpr3TuDMEujXPS8Mft4eJHGm
	U26AMLL6eZHZz42oJaBAZxTGtdrnaahCg3N1mv4I6FShUnClsaoAcr1kDMl8BII+V3zGylJctOw
	Oic66hc7KemkVX4pwaIw==
X-Google-Smtp-Source: AGHT+IFSQDzXywO7JaMiy9nxpnPIIBQHEk0iMftg2MO5m+wnKkf4aogml2qf8S58RPbCRsf4Nf+BdKqllIQnxiW0CxQ=
X-Received: by 2002:a17:90a:d644:b0:2ee:e317:69ab with SMTP id
 98e67ed59e1d1-30a214ba934mr2657135a91.0.1745880916735; Mon, 28 Apr 2025
 15:55:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABPp-BFiLURYmELQ1omyPJ+49cVxk1h4rPYj42zMwGUW-NUUGQ@mail.gmail.com>
 <20250428192320.3595509-1-jonathantanmy@google.com>
In-Reply-To: <20250428192320.3595509-1-jonathantanmy@google.com>
From: Nik Garza <nikolas@applied.co>
Date: Mon, 28 Apr 2025 15:55:05 -0700
X-Gm-Features: ATxdqUH2PBz135oXFfDalgacFPI-CCF-5zFNvOAOOVpWv_ZXXqxLoLRotYTDsvc
Message-ID: <CA+ODqj34b2DsvjxGgVb=jSaTUNYRh_nNtaCzCx8QiJ8QFsRecA@mail.gmail.com>
Subject: Re: bug report - BUG: builtin/pack-objects.c:4310: should_include_obj
 should only be called on existing objects
To: Jonathan Tan <jonathantanmy@google.com>
Cc: Elijah Newren <newren@gmail.com>, git@vger.kernel.org, Jamison Lahman <jl@applied.co>, 
	Jack Zhang <jack@applied.co>, Michael Diamond <diamond@applied.co>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Resending....

I haven't been able to define a repro case unfortunately. The error
surfaces randomly in our CI infrastructure. I'll take a look at some
of the failures we have seen and try to come up with a repro. Will add
a test if I can find something.

On Mon, Apr 28, 2025 at 12:23=E2=80=AFPM Jonathan Tan <jonathantanmy@google=
.com> wrote:
>
> Elijah Newren <newren@gmail.com> writes:
> > Cc'ing the author of that commit for his comments.
>
> I took a look. I'm not sure why I made the assumption that
> should_include_obj() would only ever be called on objects in the repo
> - in process_tree() in list-objects.c, the case of a missing object is
> handled only after should_include_obj() is called. Looking back at the
> earliest mention of this on the list [1] I don't see any clues either.
>
> In any case, the fix is probably to change it so that
> should_include_obj() returns 0 if the object is absent.
>
> Having said that, I couldn't come up with a test that exercises this
> failure mode. Nik, do you have a minimal repo that reproduces this
> error? If yes, if you could contribute a test in the form of the 'after
> fetching descendants of non-promisor commits, gc works' test in t5616,
> that would help prevent regressions in the future.
>
> [1] https://lore.kernel.org/git/fb2c202591b466eea33b4585e47b70e9086603bb.=
1729549127.git.jonathantanmy@google.com/



--=20

Nikolas Garza

Software Engineer

nikolas@applied.co

(209) 499-1193

Applied Intuition, Inc.
