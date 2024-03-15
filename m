Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 127DDDF51
	for <git@vger.kernel.org>; Fri, 15 Mar 2024 05:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710480723; cv=none; b=k2oXPMpMnjMCF8lyKYkpzIdbi4ROKDmkacqZGzNt/2nmAtk+8c083PHys0Xx6bJlTur3R9M3ErfbBHKJWjeq8bJRUWrzjp40vgqRpjW4A9f0uQ3KttU5ET9cMneHONGHrNHEmj7ElC919OE50wNv2HCVMmlk9NDG06HZWnV/5Nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710480723; c=relaxed/simple;
	bh=8VKn7Dyc8op5cWt+IxVy2+xLe1Nq67YaI76XjlhVhUQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Nb105E7YAVaqGphlQC3uT8DUNsTb/PBL5cyCLwaLncNTpL5Sfq9oJaTjHLhQa3ZWI01lR6Hsj5cmUbsir3FJIAdYxeIvAHVO2q/IiHCNzRbIRNWoVkF80/JAZd0VVk+pGLnYUnUs0tcs/N5W7jvPc2Nhcjo5ePkKreyHeFDWuUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=W064DtIt; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="W064DtIt"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-60cd62fa1f9so14164917b3.0
        for <git@vger.kernel.org>; Thu, 14 Mar 2024 22:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710480721; x=1711085521; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a8t0GGmTDDPakglaouofbjVGlCDdd/jsERFK7mLdE/0=;
        b=W064DtItNzzZ5TvWDGKAAvFHySJFIvK91TLnHk2X7GBomM5l0sBRwctNIzBr+GZDPt
         +LR6RunauacSfvoTg2oq/T1V+tFEuGEYHZlLRYnuufkFzRy962fzwwHWblcdxJa5eAil
         KwuHbbmTeWdqZWxJo3R6W+GZpcqBhI6VcIcqXCs2sl6s0RKAWCkV0PmizaJbEaG86adx
         9IcSqbwm9gQHcC6oz0sqyMuqFuyLJN10h8vgKRBifdoKD6N4CGRuzABRiHx3+eGN32rh
         f056XDFqKgvhUGAo31OkFB3GgzjUHl+al3/+ytLtU83n8avrbdDNzlKHoqZ+QUIpYb4N
         rsPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710480721; x=1711085521;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=a8t0GGmTDDPakglaouofbjVGlCDdd/jsERFK7mLdE/0=;
        b=N9hD128tZZmsEfH4HGOesbVtPXUCzPATFjKv4TbkXUtkqVzsAeXfEx5ga4EyNetKrz
         Q8L/aFPF1AEZUtJFjBr9kXVtSV+1pAMYbJzw8dJzBKpyhtAsr7W0oHF8uuz+O8GArvux
         e+gCvZIsFh2qUg0zfTJTOyXK2+bkT+1+2nxho1bXgp5jV5jM0lW3Ds404oG8CpBPybg9
         RDH6zA8v6nZzrlTw0N5VUCgCeLg3d3nRpgaySbJrnhBJcRXoLML1QLY9RxbzoB3fPRDc
         wGyIeYvwct+NNetlchWgb8ZHsbF0+wUEKxN3OnpuLf9PGCDooRm2XdxvbLervhBlGqV7
         uZeQ==
X-Forwarded-Encrypted: i=1; AJvYcCWw/hgvD/HNI/vO8fdiB3/Ic92vE6mNAPJYYeTJSsZtx8R7sgG7ynJ10GASeJ8ZE1bB8llg+D7pk0r31IKDCe5ThLYH
X-Gm-Message-State: AOJu0YwilFA2BGVTC55bqBSHsBkKY1h1JWZXruzqfyVHrLXwZxiG6W6q
	r5zLsWi7Qese17xvBXFFQhKshfRvPh4DHU89DpFu7yXCW7+UwszKYWVu/W56pyo+UdKX4RDhDxS
	j6Q==
X-Google-Smtp-Source: AGHT+IGR9fGGVe6RoMPcFIF2jqC20YBUvbnewbKienPYvG3oEbodSUS9vfA80aynJMoRWzRkPC3V1DRnp7Q=
X-Received: from fine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2221])
 (user=linusa job=sendgmr) by 2002:a05:6902:2207:b0:dcb:c2c0:b319 with SMTP id
 dm7-20020a056902220700b00dcbc2c0b319mr169901ybb.9.1710480720955; Thu, 14 Mar
 2024 22:32:00 -0700 (PDT)
Date: Thu, 14 Mar 2024 22:31:59 -0700
In-Reply-To: <owlyttmc9m5h.fsf@fine.c.googlers.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <pull.1632.v3.git.1706664144.gitgitgadget@gmail.com>
 <pull.1632.v4.git.1707196348.gitgitgadget@gmail.com> <ba1f387747b08a7270f7387beddd75dc4a8eddfe.1707196348.git.gitgitgadget@gmail.com>
 <CAP8UFD3u+QDx2LqpO2ZpeHQszwjMAsQ90qqbE7Om=t1vPRQ==w@mail.gmail.com>
 <owlyr0hgb7qg.fsf@fine.c.googlers.com> <CAP8UFD0nmK4ZigW9LcWOr_POEX5LX7m+T=Jq9rK34YL5C6xatw@mail.gmail.com>
 <owlyttmc9m5h.fsf@fine.c.googlers.com>
Message-ID: <owly7ci43vsg.fsf@fine.c.googlers.com>
Subject: Re: [PATCH v4 15/28] format_trailer_info(): avoid double-printing the separator
From: Linus Arver <linusa@google.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: Linus Arver via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Christian Couder <chriscool@tuxfamily.org>, Junio C Hamano <gitster@pobox.com>, 
	Emily Shaffer <nasamuffin@google.com>, Josh Steadmon <steadmon@google.com>, 
	"Randall S. Becker" <rsbecker@nexbridge.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Linus Arver <linusa@google.com> writes:

> Christian Couder <christian.couder@gmail.com> writes:
>
>> On Tue, Feb 13, 2024 at 6:21=E2=80=AFPM Linus Arver <linusa@google.com> =
wrote:
>>>
>>> Christian Couder <christian.couder@gmail.com> writes:
>>>
>>> > On Tue, Feb 6, 2024 at 6:12=E2=80=AFAM Linus Arver via GitGitGadget
>>> > <gitgitgadget@gmail.com> wrote:
>>
>>> > Also I wonder why it was not possible to modify format_trailer_info()
>>> > like it is done in this patch before using it to replace
>>> > format_trailers().
>>>
>>> The artificial organization apparent in this patch was deliberate, in
>>> order to make it painfully obvious exactly what was being replaced and
>>> how. See https://lore.kernel.org/git/xmqqjzno13ev.fsf@gitster.g/
>>
>> As for the previous patch, I would have thought that it would be
>> better not to break the tests.
>
> I could just squash these patches together to avoid breaking tests (and
> also avoid doing the flipping of expect_success to expect_fail and back
> again). I don't mind at all which way we go, but now that we have these
> patches broken out I wonder if it's better to just keep them that way.
>
> Junio, do you mind if I squash the relevant changes together into just
> one patch?  I'd like your input because you requested the current style
> (modulo test breakages which was my error). Thanks.

When I asked this question, I forgot that the number of test cases that
break are around ~50. This is a very large number. So I think it
would be cleaner to squash this and the previous patch down to avoid having
to flip test_expect_{success,failure} for 50+ individual test cases.

For the earlier patch

    [PATCH v4 10/28] format_trailer_info(): use trailer_item objects

there are only 8 failures so I think doing the *_{success,failure} flip
is reasonable.
