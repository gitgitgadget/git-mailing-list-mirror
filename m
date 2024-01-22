Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF0C481D1
	for <git@vger.kernel.org>; Mon, 22 Jan 2024 21:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705957662; cv=none; b=QQyPEtwDl6BCUXnLee+xCGstiNlxgkYgunYHLk0EXINKCu8l3uyJMhvARp7V+x4QKJ4l1FHLqvkrJFLKtNB5wqTQu78eJnFl8idA6TRpKe5YNruDFcCXcFTrtitPaIJpc6O9t/8uSTN6yGzw7Kv9bQGRrrApzIiwX3osYlqB9M0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705957662; c=relaxed/simple;
	bh=RBy2vt/Sh25HZyjyc3VS6ZUkmUB0PbT5T90B92QxMfI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NB7kMKwtXKwd9zyA4mK6W8Orb/hkFAXcFUnVMbXWi/SEN4L8vNGzhyVSmT6azyZadBQIFrWyph/F2FPtflA2biC4p7keaGAtPzMcrtCUCoTKu52nIeWyzsqZ0bLFbYatYQmObAFPEZnnMWKJf+BAhnBJPq7U0coT0B5/alVCe2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h4V/beHB; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h4V/beHB"
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-dc22597dbfeso3939216276.3
        for <git@vger.kernel.org>; Mon, 22 Jan 2024 13:07:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705957660; x=1706562460; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D8MjZXR+43HvihO8tYYGfrgFhD8eq9T+k9T7HeeUhP4=;
        b=h4V/beHBPUeuN6hjCiJ49RVEqOe5FYjElhAaIeejySoQLgXTfMPTkCNtP/ihivDI9d
         D7IO8YXJ/tzU3OzyP3t9dAPY+fiVr7FizKGnqgWcLdyvQqS+DtnJfRbodc9bGqanMect
         +ee9NT2JdUXJiQDG+dpbzCKbYqRCvCDrSj1xapdK4IL8SiPp3Nd9xp8eI82XMNWUeAtK
         u+hHCzjeJlvMX+E9EHv4kj4l/lnFo6JUG2H3NZD5HBrlA+mmWWgmw6jNr51/f9W4R44G
         MiLl0g0h9JLP8+qAjEkAcuoV3EzzX0IyLHVZrE3Yu+4IiKQEFaIBqKBSvVNqLHNbZ8j6
         HkZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705957660; x=1706562460;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D8MjZXR+43HvihO8tYYGfrgFhD8eq9T+k9T7HeeUhP4=;
        b=a7I7+KVsc5R09/9kHCS92jgnK0dUJ6EOrZID6FzGDrnIbSJTiBk3OK/LwFjhPmSUxE
         yoiyW/yH1K7VgN5ejELEGAy1NAOEA4d6rmRbQwm5TsTtDj0r6MmNJkgfHF5ruwHKcg2l
         V8VJNXI35QsQyX+iB3FjTdR+ZwITv5ZhjA+9jB10lvgo2uvcFM3zjNEdyhzJiJ9/otbt
         bSO4q2+bGjznnV2wqeVq4uJAc+Rm+BG6PI1RLtcEFY5vt87Phvq6PypwAHN2NHLaHsve
         LmuKbJBtRW2D6oWy0O0LS8JqUZHMG0wxSBwuCgaIYsAA0sfEMM5mu8W1XUtLknPC9+Ab
         q6ew==
X-Gm-Message-State: AOJu0YyDDDsyTMJIqsh97RpD5tiU9vLEkwnqwTy7PRztqfXAGOFJKXPX
	Vs3X4uS1jUJCIQ5JWbsfnAnve4Jz8UDXYNgxSGipUkNC3kA6JGvoTpIFDiR+04YU1JUo21wxV+S
	8o2igX3mkkO90eGwH99nCMLjgjfkgiZ6/
X-Google-Smtp-Source: AGHT+IEr7uMyMS8tYH8awgT06EEOsLH49VGDGurvtJBQC+wj67Ur6haxc9M13N+g70Wi66RanG4UnepOB1O7c0cBXjk=
X-Received: by 2002:a5b:64d:0:b0:dc2:1b80:3166 with SMTP id
 o13-20020a5b064d000000b00dc21b803166mr3072967ybq.129.1705957660407; Mon, 22
 Jan 2024 13:07:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGF1KhWNaO_TUuCPo2L_HzNnR+FnB1Q4H6_xQ2owoH+SnynzEg@mail.gmail.com>
 <CAGF1KhWiYX=3R01Odj2yCNgvx=f5+HRCjRJogWf5eBikuATCcg@mail.gmail.com> <xmqqfryprsyp.fsf@gitster.g>
In-Reply-To: <xmqqfryprsyp.fsf@gitster.g>
From: =?UTF-8?B?UmHDumwgTsO6w7FleiBkZSBBcmVuYXMgQ29yb25hZG8=?= <raulnac@gmail.com>
Date: Mon, 22 Jan 2024 22:07:03 +0100
Message-ID: <CAGF1KhU=o2rb-tCjZAG278kgoW50NYymsJakUwiMxWTQ33gQYA@mail.gmail.com>
Subject: Re: Fwd: Unexpected behavior of ls-files command when using --others
 --exclude-from, and a .gitignore file which resides in a subdirectory
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Junio, and thanks a lot for your reply :)

El lun, 22 ene 2024 a las 21:52, Junio C Hamano (<gitster@pobox.com>) escri=
bi=C3=B3:
> Ra=C3=BAl N=C3=BA=C3=B1ez de Arenas Coronado <raulnac@gmail.com> writes:
>
> > In short: using 'git ls-files --others
> > --exclude-from=3Dsubdir/.gitignore' results in an empty listing if
> > subdir/.gitignore contains '*". IMHO that pattern should be applied to
> > the subdir contents ...
>
> I do not think so.
>
> Imagine what would happen then if you did
>
>     $ cp subdir/.gitignore /var/tmp/1
>     $ git ls-files --others --exclude-from=3D/var/tmp/1

I understand this use case, yes. I was thinking about what git itself
does when ignoring files, especially when dealing with .gitgnore files
in subdirectories, but clearly this needs a different policy, yes.

What I needed from this command is a way of backing up some ignored
files. These files should not go into the repository, but I'm using
them temporarily for development so it is a good idea to back them up.
I'll just backup the entire repository instead, is not a big deal :))

Again, thanks for your reply and your explanation! It's a huge honor
to be replied to by no less than the Git team leather!

--=20
Ra=C3=BAl N=C3=BA=C3=B1ez de Arenas Coronado
.
