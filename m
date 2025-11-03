Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BE3F279331
	for <git@vger.kernel.org>; Mon,  3 Nov 2025 01:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762134091; cv=none; b=JNXZjpCBhs4POSq1v4FXCTTcFj3gBE09CorZmoErBVmoBSlL8yCbuQa8GSUWbLbqmZUkyKaXO7/uiRentVMzxSPmx6oYt20UMGChKQn752e9PhXtZXRPCMosVXppFih1S4eZ35qYJh4Rtt5978tur6bLWfyr9Ju4m25J95Kj8lM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762134091; c=relaxed/simple;
	bh=40ZUf98AgZN4RFR54DFpoJ7MmrPEK443gP3n0MG4L6Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PQtYUzDr2+eOr3EzPsGL+NDm0oUKZtVmbEIPiMIR08VCZBw7kJcveCS7QRp+RGfFAtwHA2lfy6HGnQlRG1myw5sA8JVTWbu8uAWYbfEIHqjRx7gDH+g8wMvZPjA77rJDJB69QA8nTa0lbFGpevQKo6QmFtBOe/5xsjmv25nEqbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EyYNbLlm; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EyYNbLlm"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-7867497ad2fso7061287b3.0
        for <git@vger.kernel.org>; Sun, 02 Nov 2025 17:41:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762134088; x=1762738888; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0AMfv0ezzgglEUhnhkCgRJRk/EuRBOAlZGhaaFp91r0=;
        b=EyYNbLlmgnYzAaHA4hj4n5k/3uT0Rg09wjv/AsvBcJDrb7wB90tcwAceHp+5NVGgMj
         6ijyEykoa5/uAgpgLXdBnbdrQLQuIuup8smYwYn/ZMIAK6qwOvHYCdWqrKDtl+TIEHhE
         LesHq3rMCVC0KnVCtjxGpllpIvpEPAbX7gGseC353XxhmBGD2vEqipUWvWVPxsBIy0JQ
         ChkiyX5NH6bS4Zi+bEcIr1i5Uxbs6ODnoqnCCd24HJuLbTIm2pCe3hqwpGbv6kH8OQ0I
         JWfdHvqpKLN0PkaS8IKQM/fPw9UGW3qzFeCGPApi5b/TGEzfX5jgRkU/uCzSQFTGMiFc
         2YdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762134088; x=1762738888;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0AMfv0ezzgglEUhnhkCgRJRk/EuRBOAlZGhaaFp91r0=;
        b=pKd3cSdSkljAwH4t2IvzWN6di9ucuBKxYwjSmQ1q8Kv6WDpF4uQ79oeRA7e7nicKok
         D322Ren9SPdiQ3HGsaFu8DR8LFKzIWCViFxceRBt4FaPeXua4KCRTrYIKMTQ6oICZJO+
         263VypWCNkVZDj69L09eXjPWoibnmy+RXo7ZqrZ0OJEkXZPwKFR/xyxY5CDQbmhHi/Vf
         /Zt4xuPn+zY9ecqRJtx9TuLnQlFwOXI8Ro6Sj6J5l/uoVzWr6lSUPMXeDqQV6NUE/jlH
         R9WhPAfw4lENgqG+uWb1YRSz1s8TjGkLjO5qAnMNaW8HMznjEMAz5F/GIn0/KvwJrQ8y
         qN7w==
X-Gm-Message-State: AOJu0Ywx7WMEbe6r13Mj+Sg+UqRSOhXzgLDjDReEEqfCo7b1BQR3tAFg
	OKz37VogSWMg+UQ/vjA0vXiN2+MOqFUL5QIaQ2xPHKvts5uJSEGJvweWjqAs5fxO4A/BU9AEcSC
	zVlOkcCTb1j+x+4btiS9mpb/uamEQECs=
X-Gm-Gg: ASbGncvB4eRsqnysPPVUwIc+G+eu3dbwQH9D817o2OBZexiw+9yfXglafischD6Co7j
	CY6xJwDyqnEnnsAeLSEOC3mjKhWB1AxdG02Rb5qrgy83EXytaEGMpmgx+WdfZlk15AXPbgthaTP
	FuZh7hBHRPRB3aRnLr0uDFRhn4Lg234ilR5LkAEFuAJk5hjL3PLyMnuKDq+x1gpfrLaK4k8wQUY
	dl7UN26dVVu1n+8Mq/Bf0COTWw3urHXPUF1atWbdahciYF1egiVArfdcsQGBqIAGI9GlPZXZ/oj
	bnhMKhp6NCPK4jTtHH7CQzRW
X-Google-Smtp-Source: AGHT+IEancbz+zwB/EsCQwAgJyJLXYDmKsiZFo0FIgJSKataMYBjEFfO8UobPGJzm4ldW+/2PmLNSwGHvB7TPAzCQNw=
X-Received: by 2002:a05:690c:3684:b0:786:7842:b3e1 with SMTP id
 00721157ae682-7867842d724mr27856097b3.12.1762134088398; Sun, 02 Nov 2025
 17:41:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAB9xhmPcHnB2+i6WeA3doAinv7RAeGs04+n0fHLGToJq=UKUNw@mail.gmail.com>
 <xmqqcy8418me.fsf@gitster.g> <CAB9xhmPw6P1J2a3P+btUT1chhNQrhcx3pSkq+vqZbhFhCqcX9w@mail.gmail.com>
In-Reply-To: <CAB9xhmPw6P1J2a3P+btUT1chhNQrhcx3pSkq+vqZbhFhCqcX9w@mail.gmail.com>
From: David Bohman <debohman@gmail.com>
Date: Sun, 2 Nov 2025 17:41:16 -0800
X-Gm-Features: AWmQ_bnB66ZOl-U9uLaHIaQAiYf6p5ahfIzUr-x2hRMVgSpBWRS6agYnJqLoja8
Message-ID: <CAB9xhmPAe1z8wqWnbpPuPE=y=nuKMsGG3_bk+DkGmXDfshaaiA@mail.gmail.com>
Subject: Re: git-2.51.0: Fetching tags does not work
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I am able to reproduce this locally using a bare main repository, a
local bare clone of it, and a non bare clone of the main to insert
revisions and tags into the main. If you move an existing tag in the
main using push -f and then try to fetch --tags into the bare clone,
it fails to insert a new tag into the bare clone:

% ( cd test2.git; git fetch --tags )
From /private/tmp/test
 * branch            HEAD       -> FETCH_HEAD
 ! [rejected]        stable     -> stable  (would clobber existing tag)
 * [new tag]         v5         -> v5
% ( cd test2.git; git fetch --tags )
From /private/tmp/test
 * branch            HEAD       -> FETCH_HEAD
 ! [rejected]        stable     -> stable  (would clobber existing tag)
 * [new tag]         v5         -> v5
% print $?
1
% ( cd test2.git; git fetch --tags )
From /private/tmp/test
 * branch            HEAD       -> FETCH_HEAD
 ! [rejected]        stable     -> stable  (would clobber existing tag)
 * [new tag]         v5         -> v5
% ( cd test2.git; git tag ) | grep v5
%

On Sun, Nov 2, 2025 at 4:47=E2=80=AFPM David Bohman <debohman@gmail.com> wr=
ote:
>
> I am sorry to have to bring this up again, but I am still occasionally
> seeing this problem with git 2.51.2.
>
> What is happening is that I am cloning a repository as bare, and then
> later I try to fetch the new content including the tags:
>
> % ( cd bind9.git; git fetch --tags )
> From https://gitlab.isc.org/isc-projects/bind9
>  * branch                  HEAD       -> FETCH_HEAD
>  ! [rejected]              stable     -> stable  (would clobber existing =
tag)
>  * [new tag]               v9.18.41   -> v9.18.41
>  * [new tag]               v9.20.15   -> v9.20.15
>  * [new tag]               v9.21.14   -> v9.21.14
> % ( cd bind9.git; git fetch --tags )
> From https://gitlab.isc.org/isc-projects/bind9
>  * branch                  HEAD       -> FETCH_HEAD
>  ! [rejected]              stable     -> stable  (would clobber existing =
tag)
>  * [new tag]               v9.18.41   -> v9.18.41
>  * [new tag]               v9.20.15   -> v9.20.15
>  * [new tag]               v9.21.14   -> v9.21.14
> % print $?
> 1
> % ( cd bind9.git; git tag ) | grep v9.20.15
> %
>
> As you can see, it is getting an error for one of the tags, but it is
> also failing to record the other new tags into the repository.
