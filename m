Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F4EC174EF9
	for <git@vger.kernel.org>; Thu, 18 Apr 2024 18:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713464030; cv=none; b=hiInURYur5ie1gYbePBwscx2YKdwIhWXjvUCGL0UAIKMwunGSa9bVWDD9QTTcEs93bNrfua8ap/Pqs4RMMtvjpl8/zvG8P9j55M7mSzvUyRUdJzYC7weNMxiAcxyuaSHmJtlQasJs67KWlKJFLNh8lK5tNt/R6HF91LYi1+6+y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713464030; c=relaxed/simple;
	bh=gQU5cNvQYcCrfd5ixvdYOd6Z8nQG/Y9SgFCngTUvOVQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=IrT1A+QJOGQok4G9sduRZdR4uosyypBfNOYm42C1mt0ze7mDX/BTaeYebgn6Y9CdkXtWFBineOXZ4rp9rwjNZjdtyzWaBQIdauMuKgBuJVK9lkOfeJ+yrEIBkSICnsbT9sq4xN7fjlGOELP4TuePe3ZhlWILogstjvxW9ePUGJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Hhn5lds1; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Hhn5lds1"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dcc0bcf9256so2163986276.3
        for <git@vger.kernel.org>; Thu, 18 Apr 2024 11:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713464027; x=1714068827; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=fXFTBkwf2eSSYXD+DUOuOG2X53nI6aPQXilt2umlBck=;
        b=Hhn5lds1puqamYZfU8KzrGqamcl9OYy4kznOqc2t1MHyvDGFZh73Jl1aaAZLjDRyfI
         ceDPuJBrwIe35uhQa6jyhboFC/2k6NasoEACCw4F670MDMK2zW2ixBzr/X8NdYmR/6gh
         R7eTWMBLXlX1LCC6SEULWKBnFufjarhpvKczVjeY6AC1638jsmqb8AHb5W08njakIeLA
         m1HwNhoxscb/hBpJOqXWELP+EdPCT7XLxidwFmQBJzflGlvw4z9KulBLktxQrECmTyLQ
         MtAV7FUQD3WplkGthtIA+4WjBh/lkQuG4y3TFpFnDVovSQc9ASAh00Cxf9fADw3MiTyX
         xbRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713464027; x=1714068827;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fXFTBkwf2eSSYXD+DUOuOG2X53nI6aPQXilt2umlBck=;
        b=q2Riu3nPOBZMfLSo7dIL4bZVM+U+Y5+x+QvikrHHUj5ikKKAnihFg2Z1BNFFPoB+0B
         3b8rafy49Jr4ppJIryb7PkkPuH1SlHgtkfwpntwLlErZybESWKs6z6Y9gr/ubX4kjRb4
         Fs7Fk4hD7fqwY+s4W3Mo/9uTl6URpH1Dahtfl436wa98Hpc24c9oejRFMfkg3dzd0USp
         YqPV+QuPhejgcC2j07XdwX9Hj+yXrfWBCaE3Vsf0Ie1vWp2lSrNfNsBH1LeyJ37HLg21
         SAY3Btu7DuKhA/jZ900RdHcjd41KL37be7RarCBJprkXO76PZJtRrdeqd8dUnbxtcVGo
         r7CQ==
X-Forwarded-Encrypted: i=1; AJvYcCX0+sukFyi3BRVbU1eaXCUmbQeLO62xPwIKlkDbsAxwntifmqobmnJnjy4cQuFKmCix3Ow5nDh8Ld1h2/PtA9Rng6SD
X-Gm-Message-State: AOJu0YwmtmSpUMc4iW+QX0EiZbGxnGQY/twaMzCD3E6Qvo1WztKxiw2T
	/vtXwQ91npswny9VUdBOjHPgqANUrjc9MhL84PK3lF1OY1HVLPLdpW7jatZ6ykWhZJQ+4HSPfM2
	16g==
X-Google-Smtp-Source: AGHT+IHXTSPpMUjMsFEFIXCxa4aQxiyWxItANA8AISK3CYiJ2PtjNlU647z8cfPZSGwFBRFtlZUSbBSpPA8=
X-Received: from fine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2221])
 (user=linusa job=sendgmr) by 2002:a05:6902:2b88:b0:de4:5eaa:4b67 with SMTP id
 fj8-20020a0569022b8800b00de45eaa4b67mr293268ybb.11.1713464026995; Thu, 18 Apr
 2024 11:13:46 -0700 (PDT)
Date: Thu, 18 Apr 2024 11:13:45 -0700
In-Reply-To: <owlywmov4mg1.fsf@fine.c.googlers.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <pull.1704.v3.git.1712699815.gitgitgadget@gmail.com>
 <pull.1704.v4.git.1712878339.gitgitgadget@gmail.com> <c43de19d867cb5e63fe6689b2b7d645dc4741950.1712878339.git.gitgitgadget@gmail.com>
 <xmqqsezqmrtd.fsf@gitster.g> <owly34rl53mr.fsf@fine.c.googlers.com>
 <xmqqjzkwdigv.fsf@gitster.g> <owlyzfts52ln.fsf@fine.c.googlers.com>
 <xmqqfrvkd843.fsf@gitster.g> <xmqq8r1cczw8.fsf@gitster.g> <owlywmov4mg1.fsf@fine.c.googlers.com>
Message-ID: <owlyle5a4jza.fsf@fine.c.googlers.com>
Subject: Re: [PATCH v4 2/8] SubmittingPatches: clarify 'git-contacts' location
From: Linus Arver <linusa@google.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Linus Arver via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>, Jonathan Tan <jonathantanmy@google.com>, 
	Emily Shaffer <nasamuffin@google.com>, Patrick Steinhardt <ps@pks.im>, Matthieu Moy <git@matthieu-moy.fr>, 
	Eric Sunshine <sunshine@sunshineco.com>, Kipras Melnikovas <kipras@kipras.org>
Content-Type: text/plain; charset="UTF-8"

Linus Arver <linusa@google.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>>> We are not installing this thing (yet), so how about giving an
>>> instruction to run "perl contrib/contacts/git-contacts", only
>>> assuming that the user is intelligent enough to be able to react to
>>> "perl: not found" by installing it on their path?
>>
>> That is, something like this, perhaps.
>>
>> As the string given to --cc-cmd is stored in $cc_cmd, and is used in
>> this call:
>>
>> 	push @cc, recipients_cmd("cc-cmd", "cc", $cc_cmd, $t, $quiet)
>>
>> where recipients_cmd takes ($prefix, $what, $cmd, $file, $quiet) and
>> runs execute_cmd($prefix, $cmd, $file).  execute_cmd in turn takes
>> ($prefix, $cmd, $file) and does this:
>>
>> 	open my $fh, "-|", "$cmd \Q$file\E"
>> 		or die sprintf(__("(%s) Could not execute '%s'"), $prefix, $cmd);
>>
>> IOW, $cmd is just an early part of a shell command line that takes a
>> filename as its last argument, so I think it would be fine for $cmd
>> to be "perl contrib/contacts/git-contacts".  I did not test it, and
>> it would be appreciated if people can test it.
>
> I should be able to test this later this week.

Looks like --cc-cmd="perl contrib/contacts/git-contacts" works as
expected! I tested by setting up a working git-send-mail config and
running with --dry-run to check the CC list.

Will reroll later today. Cheers.
