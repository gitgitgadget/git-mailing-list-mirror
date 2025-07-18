Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2587207A0C
	for <git@vger.kernel.org>; Fri, 18 Jul 2025 23:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752881502; cv=none; b=ICE/vqh/eUuRpfcneAPMSWdvJlGh8+T7tEvMXg2uTiRiTD4pICvhGwBjWlpB0W/nTVeQFMUqKU4wmA73ndsqPmsPq2RvO4lT22dkNogNo2NxQMTTeYHY6WpKwEfEhldYAIqH8PJnBzEXssfjBIHTG/ueB6IRwZ2YVpfGH3+0EDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752881502; c=relaxed/simple;
	bh=sfbag0bDZQ+x/YdC2lvrOL7SooQARHdzrajPOrf/MnQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UqHdFZwPGmPd6P4yPyjSiMM5ijqjI4+jb7uFDCqVqK/BiUIZDpxvIzVmI2oJ+JovImWcgd/e+cF6IxyWg54ufiWL2uR0r6F2SyhxaqJKQAFONrArt12pOyIhxiLToxPMlS2P6Zb1E4jR16OXNrH1DGQKm2TUXJ+plq0ZF2HXYpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kCd30Cj9; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kCd30Cj9"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-23636167b30so24495355ad.1
        for <git@vger.kernel.org>; Fri, 18 Jul 2025 16:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752881500; x=1753486300; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sfbag0bDZQ+x/YdC2lvrOL7SooQARHdzrajPOrf/MnQ=;
        b=kCd30Cj9uBJQSFWeGfCCbww/HiYGMDQUr7kOIxeZwo/JKLKfjj7hnThalZiHynMfwQ
         onm+29nnagBbpEy2gMebSMVemAG+WnufkBmB89hUl8DIKxbySuhmTlYLXz95UEISbH1r
         3I996HF/APV4wmRh6o1VpI6e35M1wYDgYbhHDDvsaXEd2Q0PSPd2Dm1fQX03TS50YWJZ
         BEc7EwB+v3R+2Ci9kmqRXLgYfPdn/nGY/gf7ISWlGSkKDQG8dvLsI5U+HOB7PgUXdZZY
         nd6PmY7DF2XH5t1PkIFd+r512vOarzkGLoFG3P3pE81nVVbxD3z0ui8itEkCqy5USYZs
         F8Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752881500; x=1753486300;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sfbag0bDZQ+x/YdC2lvrOL7SooQARHdzrajPOrf/MnQ=;
        b=j6F6h1i6A62HQujS3plxfmL0sYEsWKMIefiYG1oU9Kf66as0Sgu7a+NaV8eh0a2CjN
         WroerMKAREHgwF5dLHM9k89e4tyU7VUH9YEePHZpfGN29dqNTkd2BlFzbaWptgW3cRyO
         lep7/FCUCWb1cWhEgPleo4Iro8MbAK58NnvyhLjxjRfnQS5WGlIoXDPfJ7cpNOIE9YGF
         zWtZnr/AkZut4O+sDdxEvfwvNVWVeqO/zRaQCNtP3NUhwZtRdwUa6m1AEUwrKzuH0/tb
         jdRvWBkIsewdSBG/6fu+IjZF9clP8UiDGggn1fkv6jwY6AfKMeg8JzYprVBH5SLcZ61s
         LgnQ==
X-Gm-Message-State: AOJu0YzhvuYZ1toqlPfUiq6oqV77PkE2pZR/VuGubGmXiRKU8nah4BAj
	SqdpT3m0kAXHXVFQBbzsE9LFwTwnX/cSL9kziTYT2NrUNvsIwsZCP/t2s8mvbW0OMa+SrDVDZPS
	dm/JAtT+SBHaITIbMOFAHlmfR7s1nk6o=
X-Gm-Gg: ASbGnctoBM+QRRmnrIUkpp/d1am/34Wpl4gCaP6Msx7ZVQ61EBeTqvyB86cVEyeV+b6
	RjYyV9RdbrL5y/OX8zaac/ZpRAoo/339WH/0GgeX9davTYomH91hKXYjF0x7eaH6DdKpgBIzMme
	FgB9jCGju7tlOYFLEh4gJdjFUFDddD5eAzoSiRhOcCR72rB1ZFoPzOW6grJP3gVGhu0DHSKUh+V
	Q+9lyf5rSIWGvVn9Oo=
X-Google-Smtp-Source: AGHT+IFg6kYNyTfw1WYChZ01aO82cLXO398qEKRvqTjJCYbyeIY4bTdQkVQ06+dEtk4kOFAv2M9cx8DeQWtqQXHcHtQ=
X-Received: by 2002:a17:903:8c5:b0:235:e1d6:f98b with SMTP id
 d9443c01a7336-23e256c98e3mr182846585ad.22.1752881499822; Fri, 18 Jul 2025
 16:31:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <87y0slp23s.fsf@arch.mail-host-address-is-not-set>
In-Reply-To: <87y0slp23s.fsf@arch.mail-host-address-is-not-set>
From: Ayush Chandekar <ayu.chandekar@gmail.com>
Date: Sat, 19 Jul 2025 05:01:28 +0530
X-Gm-Features: Ac12FXx-vpVwe1TTMepaOPaHFtp85JHea8jEnKKPSiihhxmSWG6ih94UYzcc75Y
Message-ID: <CAE7as+Zf=ASEpz0YgAsMys3akbztFr+Z31jY6S2QXux3mxNBjg@mail.gmail.com>
Subject: Re: A Question from a Hopeful Future Contributor
To: Eric Frederickson <ericfrederickson68@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Eric,

On Sat, Jul 19, 2025 at 3:58=E2=80=AFAM Eric Frederickson
<ericfrederickson68@gmail.com> wrote:
>
> Hello everyone,
>
> I hope that this message finds you well! I'm a software developer and pas=
sionate
> git user, and I'd like to try my hand at contributing to the project. I'm
> sending this message in order to ask Junio and the team if there's anythi=
ng that
> would be particularly useful / appropriate for me to start looking into o=
n that
> front. (Reading through the last few "What's cooking" messages, I didn't =
see
> anything that jumped out at me as needing a new contributor, which is why=
 I'm
> asking in a separate message instead of replying to one of those.)
>

Welcome!

It's nice to see you excited about contributing to Git. To clear
things up, there isn't any team defined as such for Git, however ,
there are people working on it as volunteers or are employed by a
company (eg: GitHub, GitLab, etc) to work on Git.

If you want to know more about Git development and contribution
process, you can check it out here: [1]

> (Some notes on my skills: working on docs or tests is always a favorite f=
or me,
> so things in those areas would be a great time. Also comfortable with low=
-level
> code, and any kind of scripting. Note too that academic background center=
s
> around programming language design and parsing related stuff, so I've got=
 some
> fluency in those areas that I could hopefully apply well to the project i=
f ever
> needed.)
>

Git has something called as a 'microproject'[2], which is a small and
a relatively simple patch meant to help new contributors get familiar
with the project. While microprojects are often done by students
applying for mentorship programs, they're a great way to get your
hands on Git development. They help you understand the codebase, and
the development and contribution workflow.

And as you mentioned that you like working on documentation or tests,
you'll find that most of the microproject ideas are based on these.

That said, you're more than encouraged to scratch your own itch as Junio sa=
id.

Thanks,
Ayush:)

[1]: https://git.github.io/Hacking-Git/
[2]: https://git.github.io/General-Microproject-Information/
