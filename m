Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29364DF58
	for <git@vger.kernel.org>; Fri, 16 Feb 2024 02:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708050330; cv=none; b=YL9sOWiBhHhgcsHwrMOVX0V4ps96wCSR0D3pTA7+w8gL/AxqrjWRkSgnbe/4YBAgutBTNhwjGANI1/nETka9oY1w+bAdZQjUAfNgH62D/jgiP/hFtqVigTwcVqcZqPkkOk6GlzJmB0L33yJDoaPfUjJi7Ye6R5B2EQpJmRAEL5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708050330; c=relaxed/simple;
	bh=rGbudE/nTo+8Zyv4kR7aC7q5v01EuyHXdv3tJj5mi6E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=s20aty7hsQEzPyfe1rwemnkYXoAJaPlM5fDjxB6x/49dDbf9uWdqOzMDMCjaBvb4UNrbvQARRREdSmKmafsVmjpViCcHoaazltYMGb3qLt11I2bBoSqLxVML0dLFw4sJ3Cu2IMKrJVpAchu37x0Oc/pRIKdD8RCj3dnnccMQW+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=i8dIeDd4; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i8dIeDd4"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc64e0fc7c8so2126450276.2
        for <git@vger.kernel.org>; Thu, 15 Feb 2024 18:25:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708050328; x=1708655128; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AcSJW1BPmPZgNfQbsWB31R59daQJBMSveegokU+U+68=;
        b=i8dIeDd4jAzRhbHRpnMdUHLAvmja3C0vetEnu4aMwZCTrWnpGUWTPOoQHcg/JaWOrH
         Jn5Ow42MQ/ySodORQQBRxunprl46z0EHUggRFY9d9ZaQNiUu3/EJEXG9bIVVQLlOWgmz
         +kfEtpzQSwCkhcejBVDzh2glC+4VCK6/6j0p3tf29pAbePxiTUmZrw2BSOvzpfLDoXoj
         dHaAWnBhGTS4vrQw5kYW1h7cu44wIiZxs0OlKPhXyOS29KXWIINyGojkolJdvRi9ffzA
         ztA17+OZ/57C6hho8pNCglkQ8Oh1LVYpx4vSpzgolm/ZwIh8djEifQ/P5pFPV22FSYeb
         IT+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708050328; x=1708655128;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=AcSJW1BPmPZgNfQbsWB31R59daQJBMSveegokU+U+68=;
        b=PFspjdCRYqj3BFvm1kDHJKNtotad9jY12d0yrTNjvPmjbyZYxK6cqKm2x4FB0yoJqs
         oN7vfmihVDjCStp3bNAnPgekC5lWxZ1iH6OpUA+VMOqot6cpayS+J4YSZcHBMKKqEOAB
         nPVkAPs6h/YezYiG07usIVXCDTfu6Yu9xRpgQDLcVk84aL3StlaimMQXi4BfQgEDBnTB
         sbXhbB4RrPoSPjZkYXxqUjpcj1R3YbPFU6VjXklqmwquYbpjv9FeepDySMKK0jHvO3d1
         CaYXpfgKiFmawhqo5kXTbfd2akJc2Oyo2V/Tx/2hxdkGmffd+EmjiONScMS5+jzEelv+
         8K/A==
X-Forwarded-Encrypted: i=1; AJvYcCWGGUfrgMi9aBu3OvRsFgF8CILoO6ZwBGiMy5LGAVxybGN1pZOufsZaFHt5PJMLhKU5aiufHwc6HCY6CGSmNkOhumse
X-Gm-Message-State: AOJu0YxcDp3kSX8qt93B13CajcY6tDbAL9BSU+Jevw7Mrata/t6Qfqek
	w9ngUIcrcMOmWszHcMuHbMPKGFdBBknIHXPtOLJnVLPr4Zf60Rq9IFIbXHmP8bc7UY5sPYWLhJG
	9WQ==
X-Google-Smtp-Source: AGHT+IE2TZC+FH57iHvkfcx67NAxrnmUDcLT6gZnyiME8HQPZ205dP2w8gYUC3hPYSPWOCvBFAckuAmQafo=
X-Received: from fine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2221])
 (user=linusa job=sendgmr) by 2002:a05:6902:1001:b0:dcc:79ab:e522 with SMTP id
 w1-20020a056902100100b00dcc79abe522mr142151ybt.11.1708050328120; Thu, 15 Feb
 2024 18:25:28 -0800 (PST)
Date: Thu, 15 Feb 2024 18:25:26 -0800
In-Reply-To: <CAP8UFD08F0V13X0+CJ1uhMPzPWVMs2okGVMJch0DkQg5M3BWLA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <pull.1632.v3.git.1706664144.gitgitgadget@gmail.com>
 <pull.1632.v4.git.1707196348.gitgitgadget@gmail.com> <CAP8UFD3qLGua5PTA+i29N+yJH8iKVBPwUn=S606B2E+s959JFQ@mail.gmail.com>
 <xmqqjzn94404.fsf@gitster.g> <CAP8UFD0C37qdTUvCpRFe6_zAeAcssoySY6tobw+AO8hpA8iAfg@mail.gmail.com>
 <xmqqa5o46zla.fsf@gitster.g> <CAP8UFD08F0V13X0+CJ1uhMPzPWVMs2okGVMJch0DkQg5M3BWLA@mail.gmail.com>
Message-ID: <owlyplwx87s9.fsf@fine.c.googlers.com>
Subject: Re: [PATCH v4 00/28] Enrich Trailer API
From: Linus Arver <linusa@google.com>
To: Christian Couder <christian.couder@gmail.com>, Junio C Hamano <gitster@pobox.com>
Cc: Linus Arver via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Christian Couder <chriscool@tuxfamily.org>, Emily Shaffer <nasamuffin@google.com>, 
	Josh Steadmon <steadmon@google.com>, "Randall S. Becker" <rsbecker@nexbridge.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Christian Couder <christian.couder@gmail.com> writes:

> (Sorry for sending this previously to Junio only)
>
> On Tue, Feb 13, 2024 at 6:30=E2=80=AFPM Junio C Hamano <gitster@pobox.com=
> wrote:
>>
>> Christian Couder <christian.couder@gmail.com> writes:
>
>> >> I presume that [01-09/28] would be the first part, nothing
>> >> controversial and consisting of obvious clean-ups?  I do not mind
>> >> merging that part down to remove the future review load if everybody
>> >> agrees.
>> >
>> > Yeah, patches [01-09/28] look good to me.
>>
>> I was hoping that you'll give us more details of what the other 3 or
>> more you would envision the series to be, actually.
>
> I think the next one could be [10-16/28], so until "trailer: finish
> formatting unification".
>
> Then I am not sure about the next one, perhaps [17-20/28] or [17-21/28].
>
> The rest would depend on the splitting of the big patches towards the
> end of the series.

Ack, I'll try to group them like this. Thanks.
