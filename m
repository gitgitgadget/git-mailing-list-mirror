Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE3F9182C1
	for <git@vger.kernel.org>; Wed, 31 Jan 2024 19:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706728424; cv=none; b=jslQPfZj/fHIlTKnu7EMP+IBwW3xBBP15gmkashwtrFYuKEmZzASmdzCJgwzLymR/bmUnLIVUYvRPFAGfstBD6YpGe42d/FPJBPujF5cjfU6wWBdPjvWETORR4WIITQIoG7Qu0P7jdW1ZlUjOGCgBHnfYp+GEvMcpMebgOZOJCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706728424; c=relaxed/simple;
	bh=Kfkecy6TaLptZ49IJ7QeTorybxrvLmisdSsuVfqPtcc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RMsIF6Yv4xXv4ctv668adTTWY/aKLaGCTG3wkj5OC7DmyDSh71umf3ypDPx9bdbHQnwFPV02rfkgKu1SeXW6JlA1gynfTueSAJDDD31mOMhEAw9Vk6Q+4qfZoWa/SvBlqbMeXf9yJUTOxiyXCTYumhsEyOk/AizodgXXPHGVOdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dinwoodie.org; spf=pass smtp.mailfrom=dinwoodie.org; dkim=pass (2048-bit key) header.d=dinwoodie.org header.i=@dinwoodie.org header.b=Fs8odoyJ; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dinwoodie.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dinwoodie.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dinwoodie.org header.i=@dinwoodie.org header.b="Fs8odoyJ"
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3be2ba0ffd8so22900b6e.0
        for <git@vger.kernel.org>; Wed, 31 Jan 2024 11:13:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dinwoodie.org; s=google; t=1706728420; x=1707333220; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qX+4+laxpw0oZyrzMzZ1sIK1QP7Rh69BJV8RI/Ec/mo=;
        b=Fs8odoyJHHpJtmfuyH93L0UsswZNro/imaIEVnsZvcIy5TctcaygL2RY7SZ3TWiSUS
         Zm7Xxvbg+gjiGx/cbgUb1Qj9XlSql3gQmIIcoE6uw6sUez4vTPGxLOrhLekAeIeEE+8y
         RELs/FwW/fXjIUcyL9weWHyrF+TxweVd+KZWOKGxLI8yqEoJYkEJn5nDgWX6ekWim3Gz
         c6sY9zG8zFsEdS5xBoWfhHBdRX/JovaNmLXZizpr0doNYZVn+eXus129VLEB+MbFPYtz
         V+m7b8tKjQbpT7eKG0uiRc+sJsJ9oeRGS1/oZQlAMS0WatqwFnsxctuyK63jaCM5dXqK
         2nsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706728420; x=1707333220;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qX+4+laxpw0oZyrzMzZ1sIK1QP7Rh69BJV8RI/Ec/mo=;
        b=ZQ1MALls273aUs7uUoVdBil1892xCZtMFSYiMGQT81TaV5kin559yxI3pLmnpyeeuj
         sLGzlvkdpeJalT04j6xOgkZ3s+3SS6xg1dCtKth205S61nTiAkSPsISa7V19XMHoGKdB
         Dd1ZfHO5AvbhL6C6sbkbIk/piTNcQQMGi54S0ga1FUsMNfjUyRzFP6Gnbr1W88v3NWgQ
         ElJ/1J9eapf2+Y5jXhXJJl5EymgJes8fOPGm5NJyZRbwaRydl4322UFkloJEvaEw3P+8
         /QS8EUjFKb1MPEGExV38oThrtJjbJo3fJQX2+7u/D/p60ifGdqsDEvT8E5o7ZwJq/d8O
         zzIg==
X-Gm-Message-State: AOJu0YyAAtYarxWlUtJBvWO8yqOMLhzU5Z2HaA1S3kx8f9M7nGioUqbh
	7hns0fWbxv9tlfte9K7Dc326swqArhThfTWHSqS4TXDwnNWt1dqav+fodZ8FAcxP6F0aBaoY3tD
	8Yth71bUw2YtC8I8QgknaNurIjEYIT51S40zr
X-Google-Smtp-Source: AGHT+IG0l1KGavxFBJJI4uY9G0dCPg6RH/HpBFUiNtYpAriOvBuUyRtB3KDzSYqorJKQzj3MKZQZTp2btyuFelYf4S8=
X-Received: by 2002:a05:6870:659e:b0:218:d535:4aca with SMTP id
 fp30-20020a056870659e00b00218d5354acamr95404oab.5.1706728420524; Wed, 31 Jan
 2024 11:13:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240129031540.GA2433764@coredump.intra.peff.net>
 <20240129031933.GB2433899@coredump.intra.peff.net> <ZbeLcrjIYd4d7PaB@tanuki>
 <20240129174918.GA3765717@coredump.intra.peff.net> <CA+kUOanDydgCEax9RFu_xVXkx_LeiSPOoWiUpwAg=EVQxSDJRw@mail.gmail.com>
 <xmqqeddzfywg.fsf@gitster.g>
In-Reply-To: <xmqqeddzfywg.fsf@gitster.g>
From: Adam Dinwoodie <adam@dinwoodie.org>
Date: Wed, 31 Jan 2024 19:13:05 +0000
Message-ID: <CA+kUOakoMi4wb0=pAbWiRLmSumiQCXewW3S67cM5WJ4tttYFhg@mail.gmail.com>
Subject: Re: [PATCH 2/2] t/Makefile: get UNIT_TESTS list from C sources
To: Junio C Hamano <gitster@pobox.com>
Cc: Jeff King <peff@peff.net>, Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org, 
	Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Type: text/plain; charset="UTF-8"

On Tue, 30 Jan 2024 at 00:28, Junio C Hamano <gitster@pobox.com> wrote:
>
> Adam Dinwoodie <adam@dinwoodie.org> writes:
>
> >> Hmm, good point. It seems like the answer should obviously be "yes", but
> >> Windows CI seemed to pass all the same (and I checked that it indeed ran
> >> the unit tests). Do we only get the $X suffix for MSVC builds or
> >> something? Looks like maybe cygwin, as well.
> >
> > Cygwin will automatically append ".exe" when doing directory listings;
> > a check if the file "a" exists will return true on Cygwin if "a" or
> > "a.exe" exists; a glob for "a*" in a directory containing files "a1"
> > and "a2.exe" will return "a1" and "a2". This causes problems in some
> > edge cases, but it means *nix scripts and applications are much more
> > likely to work without any Cygwin-specific handling. I *think* this
> > logic is carried downstream to MSYS2 and thence to Git for Windows.
>
> Interesting, especially that "a*" is globbed to "a2" and not
> "a2.exe".

My error, sorry! I've just double-checked and Cygwin's globbing will
report the file with the .exe extension. I clearly misremembered how
this works.

Having looked up a bit more of the implementation is simply that, if
Cygwin tries to open a file named "x" and doesn't find it, it will
attempt to open "x.exe" before it returns the failure. This means that
scripts that call (say) `/usr/bin/env bash` or `cat` or `[ "$x" = "$y"
]`  or whatever will broadly Just Work(TM) rather than needing to be
rewritten with the extension added. But the behaviour only applies
when Cygwin is looking for a specific filename.
