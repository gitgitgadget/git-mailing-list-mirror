Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E83F2F32
	for <git@vger.kernel.org>; Fri,  5 Jul 2024 16:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720197595; cv=none; b=cYaklu69NiDa4AvfK0uYFhFUZwqAOI0irGYL57utSH5t4k5FUsKLcTSe07M/bFkYnFupkGPXK7EpPpYIZhQWaa5YQZS/KHcidCZ7k003WB58NRry4PixAMipKsgXq59JZi4kazOvtIVIZcZ4aghYORUBa/pxv3wOuhxIbWzdF58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720197595; c=relaxed/simple;
	bh=tjmCFihq0BLQcq0E8jVb6RNZbRiL7CJb/NCTTVYLWBc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Gn9yQcnPsDFxD+B7Jf5gF84iSMCy1c42iAqgRnuo3uuxD4SA62yJL/WMsABG2/0V+FlZxWM+f+tnxrAfHAslRKPzknT/4DECtXlQykFkMHc1mXF7pMJ3w4tYcz/Asyad0LnuvNzq4AGpLBV7tEKAhYNq+h37X1DeutfM6cHlk6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LbyoMFYK; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LbyoMFYK"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-70b07f27788so946183b3a.2
        for <git@vger.kernel.org>; Fri, 05 Jul 2024 09:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720197594; x=1720802394; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UhYhfSmbnBfJwB7B/TAhavGbpclIKagu03Fvyf1XGYw=;
        b=LbyoMFYK5ejLgxaw2NoJK9A/axkXW+GOkHmi6Zk3o6O2m5LulF3iT+m1Bj9Mqw8SLj
         9CgJ9XO8v/bv251w6a/uKyCIqYV4F3OAvwYGiV8TGBUACtyn6Com9PnF5ECHWGE/NbHM
         P13ri+qOvVcJipj4gi/66+NPJDw+68l61c9l4+H7Lhzyg7oMqErZzR1/5wH/AYU14LAD
         vOwBW7pvajqRYsOPE6f3URM+22UOVybCYnE+cBXugaNpEvtkMEK+M0WN5SZHkGluR9KA
         MGES+k/aLkjLpi5GqoVDNqP8dv2eqXr53Nw0Xcw4ModjNAHd4qllhyw2ZDC1F0rMevj8
         WV/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720197594; x=1720802394;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UhYhfSmbnBfJwB7B/TAhavGbpclIKagu03Fvyf1XGYw=;
        b=MwFSq85h99to/4sqcj+H+yZhPGJuA1RnjaK4m+8CfW1u5sKQE/1Ve7OSn+S/29NxRV
         rs8xGG8QNxAH5ArwhDRD1TqlRZYMDRY8+84Pq4qqCQEzdrMA0/tUNI1cR1fM1G4YHF13
         9WrF0ROY4DaZnBctAbWfZfg8bNcnAfDKuWSF3DwijX/A5DSRuJRWBfK+QKUe3lJzKR5H
         Z20B4zhDZAvK2dOdBWTBNe41SgGOjWDNqVgHDo/yWWtyZ/ejCbxRF5UjSmUjLUXLjdtw
         yLnYuGTSAssetLumRyhwcWB/5zwrCjl9Dj0blEg+0ALTwklGWlLrgTUvq7s1fwaTneIT
         qinw==
X-Forwarded-Encrypted: i=1; AJvYcCW5pp8IrAlr8U8YHYhftB+RtZr2/R1GwiuuoBLBy+pxCZ+tB+LUQrxG6AbKrzlq7wKdG0PTOqljpxJkbi2vMTjXsMVj
X-Gm-Message-State: AOJu0Yzq4e0nVbOBmxAu2XAsm1PtuhDXuv6qOPYKUnraXYtIu6eEHAox
	V6MhfxEW+Ayw6eFu89RTDr20gg+H3LybBpgHrJ0hLeuw3jEgEANi
X-Google-Smtp-Source: AGHT+IH47ngANasGGMjPxyinZEWa1P0is6KRIUrA1Oq7DK55uyUwXF38QniKMMjNbxIP8nhcstRy1g==
X-Received: by 2002:a05:6a20:da95:b0:1bd:1a06:7ef3 with SMTP id adf61e73a8af0-1c0cc737360mr5806250637.3.1720197593573;
        Fri, 05 Jul 2024 09:39:53 -0700 (PDT)
Received: from localhost (236.219.125.34.bc.googleusercontent.com. [34.125.219.236])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-72c6c7f76fbsm11430898a12.73.2024.07.05.09.39.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 09:39:53 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Ilya Tumaykin <itumaykin@gmail.com>,  git@vger.kernel.org,  Jeff King
 <peff@peff.net>,  Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: git crashes in `git commit --patch` with
 diff.suppressBlankEmpty = true
In-Reply-To: <ab974e62-098c-4200-bee3-7de8d9115516@gmail.com> (Phillip Wood's
	message of "Thu, 4 Jul 2024 14:14:56 +0100")
References: <9b31e86f-c408-4625-8d13-f48a209b541b@gmail.com>
	<ab974e62-098c-4200-bee3-7de8d9115516@gmail.com>
Date: Fri, 05 Jul 2024 09:39:52 -0700
Message-ID: <xmqq4j937pyf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> ... but I wonder if we
> should change 'diff-index' and 'diff-files' to ignore
> diff.suppressBlankEmpty instead. The plumbing diff commands already
> ignore most of the options that change diff output so I'm not quite
> sure why they respect this particular config setting.

Very true.  Even though POSIX adopted the text:

    It is implementation-defined whether an empty unaffected line is
    written as an empty line or a line containing a single <space>
    character.

it merely allows the implementation to show an empty unaffected line
as an empty line (where traditionally such an output was not allowed),
and we probably want to give priority to consistent and stable output.
If the addition of diff.suppressBlankEmpty were done in the usually
recommended way to first add command line option to prove that the
feature is useful and then add configuration variable to pretend as
if it were passed, then it would have been perfect.  We then could
have made the plumbing to completely ignore the configuration to
make the output more stable, while allowing script writers a choice
to invoke plumbing commands with explicit comand line options.

But that was not what happened, unfortunately.

If we really wanted to force the world line to where we did what we
should have done back then, I would say we need to do a two-step
transition.

 - Add the --[no-]suppress-blank-empty option from the command line
   to all commands in the diff family.  Plumbing diff trio will
   still pay attention to diff.suppressBlankEmpty but when they see
   it is set to any non-default value (i.e. true) without being set
   by the new command line option, we loudly warn that we will fix
   this historical mistake in Git 3.0 and encourage script writers
   to update their invocation of plumbing diff trio to use the
   command line to custimze.

 - At Git 3.0, plumbing diff trio stops paying attention to the
   diff.suppressBlankEmpty configuration.  By this time, the warning
   we gave in earlier versions would have helped existing scripts to
   migrate away from relying on it and if they want they would
   instead explicitly pass the command line option, so we stop
   warning.

As to the "commit -p" issue, I think the patch parser is in the
wrong and needs to be corrected, period.  As long as the patches
given as input are well-formed, we should be prepared to grok
them (we even allow manual editing of patches, right?).

Thanks.

https://pubs.opengroup.org/onlinepubs/9699919799/utilities/diff.html
