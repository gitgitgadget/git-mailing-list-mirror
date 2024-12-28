Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE8F136672
	for <git@vger.kernel.org>; Sat, 28 Dec 2024 09:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735379958; cv=none; b=SENwucsJq31iMekrKZl5r0N6lZeFHJ+EbkLsBe2Ownv5Gqix83A6xygANCqyuy9kGCot3Vp4XSVSnfy4ZtzxHfT6wl4PVkFilYFbDbEeoLCLgnejdh9hMXwskurjLK3HZ5Ha629qoQkKu8dSmy/8vFYqvvRbKIYQL0Vlk0lVq6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735379958; c=relaxed/simple;
	bh=k5XE+7i/oVRZbxgV7NfHDpMGnY6ss1tqcsR12pHgRTk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F7nVfO9CdKR5ml9lQjlP9MomhaLA4a2uKbaCGtcKH858C8A9J+79QdBSuuX2LLdRnxMgpEBtLJ2QiG+3QF1mUtss7conGR6RDfWaWHu/al0lIZK61j3oCLE/xzKmcjQNQGzOhPlhMdLcZEHHu3bd4iK/o6+kqk9jUuMAELtGUg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bO3Ps9Dn; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bO3Ps9Dn"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2ee8aa26415so9915254a91.1
        for <git@vger.kernel.org>; Sat, 28 Dec 2024 01:59:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735379955; x=1735984755; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RDU7OswPkvAJhgV62/logDjYG8nBBMUTsEUply5g1dc=;
        b=bO3Ps9Dne/78cfLO0rqJkzZkPwqjzn/fYb6oKIGbb5SCHuLkvSGf+0CeDBRMAhAMYP
         QOMjBkIiaeu43g7oUbi0xZdezku6bI6iOo2WltD3Oss2FM/Zh6NA79cFRd6Y+TESxNR3
         X4ghvQNlP5wx8iZR3979Ia8A03LnEniYinf9dV1aa9r1Qef0d9KCYLflLoamADuPjG5m
         wIeYoeOU+Q4Is5RZf/f92Ewpon3Y3CQxcZ8K/8gY9S53SVFWmouqwp/OH363zNbJGZQY
         gFg1kbCh6mP5MpvSP4wVXAslu5qq0S4pX9ic1D+iQwjdAoXXTbStEF55/zsZF1JKr/d4
         J5yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735379955; x=1735984755;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RDU7OswPkvAJhgV62/logDjYG8nBBMUTsEUply5g1dc=;
        b=X873TcwL3OyDPyAc3mj6P03jfffpnDFp9CMOYSQ6Ue1uApRx5Of+JG7crnKv9Kdcyd
         dl0k8+16vVos+cmoyXi4JIhoyssJasBu3jyicwVQFvrr1NL0Sky5twyMDladzTDv0hdQ
         8BrnXZ4QJJ47koAlVGdx3Ob561CSJPE00w8fJ0HkB/aIZkyFBT3FD7lndQMoD2votmQ0
         zcKNt2l5caotAi6+v719qJDtL2pghq4tgz2ZrwB6gQG8Wy39QzIpwdVnjY8/oIzgOyoR
         BahW+gCseTPhdhGE6KEf5sYnkvJX7BjbTsUB4OFWayZ8EkaDrujA2CxQ6KaB91ME++vR
         UGhQ==
X-Forwarded-Encrypted: i=1; AJvYcCXNkprorDxGMHLxalO3HhTlFBjCruAY6HKAOQPKdGYpDiZ32PTR2gd/D70sYZuNcfiqXL0=@vger.kernel.org
X-Gm-Message-State: AOJu0YznuN44tRmEx+VshfcmZfR6F8KHsYcZuMQ+vM3O3F1GrUkqCPXI
	f8HCu4c1d5V+89Tjg1pd2FRVcROnfyMaJqJUe5QQAitelplFZtJWWTsm1CXj50BL/bEvIRtysy5
	wa2FnAEDp65zCRDk786DFKwuhk0N1cg==
X-Gm-Gg: ASbGncvbA9UbtGp1a72t3rg0JRR7B2u2RCJkrx1kBKH6t75gO8a1iGCRMUrrUCtO3sL
	DzEV1QAWZXTWpqlib00DCog6jdyR+yPskde1UFurKNPZybxuy6fD7NCzeakERmdnSwp7HGJQ=
X-Google-Smtp-Source: AGHT+IERDRKQHqxs5pW6wFxrsy+uVtda5yE1T7kBc15itjS+GqlNnMKoPfHtvoLL8IsPzfaEcX2hLgeo6A2QSb6R9+A=
X-Received: by 2002:a17:90a:c2c7:b0:2ee:d193:f3d5 with SMTP id
 98e67ed59e1d1-2f452debe41mr46476955a91.7.1735379955543; Sat, 28 Dec 2024
 01:59:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1838.git.1734946566885.gitgitgadget@gmail.com> <xmqqed1tv6hu.fsf@gitster.g>
In-Reply-To: <xmqqed1tv6hu.fsf@gitster.g>
From: Shubham Kanodia <shubham.kanodia10@gmail.com>
Date: Sat, 28 Dec 2024 15:28:39 +0530
Message-ID: <CAG=Um+0a+ugf+gWUDS3htj3u2tewzOrH+xGbF+2A+w4ofjQfKg@mail.gmail.com>
Subject: Re: [PATCH] maintenance: add prune-remote-refs task
To: Junio C Hamano <gitster@pobox.com>
Cc: Shubham Kanodia via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, ps@pks.im
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 27, 2024 at 2:37=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Thanks for a patch.
>
>
> "Shubham Kanodia via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> You'd want to check your procedure to tell GGG about addresses; I am
> seeing these
>
>     From: "Shubham Kanodia via GitGitGadget" <gitgitgadget@gmail.com>
>     To: git@vger.kernel.org
>     Cc: "mailto:gitster@pobox.com" <[gitster@pobox.com]>,
>             "mailto:ps@pks.im" <[ps@pks.im]>,
>             Shubham Kanodia <shubham.kanodia10@gmail.com>,
>             Shubham Kanodia <shubham.kanodia10@gmail.com>
>
> and Cc addresses in it would probably not work as-is (I've fixed
> them up manually).

I think the GGG comment had a few formatting errors. Thanks for fixing the =
cc.

> Hmph, is there a reason why you need two loops, instead of
> for-each-remote calling a function that does the run_command()
> thing?

It can be collapsed into one.

> This loop does not stop at the first error, but returns a non-zero
> error after noticing even a single remote fail to run prune, which
> sounds like a seneible design.  Would an error percolate up the same
> way when two different tasks run and one of them fails in the
> control folow in "git maintenance"?  Just want to see if we are
> being consistent with the surrounding code.

Fair point. I'll make the process flow identical to the prefetch refs
task that works similarly across remotes.
It returns as soon as the first remote fails (without necessarily
affecting other tasks).
