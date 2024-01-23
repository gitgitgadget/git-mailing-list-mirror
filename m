Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0BDF4EB44
	for <git@vger.kernel.org>; Tue, 23 Jan 2024 06:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705990151; cv=none; b=Kcc0YLUD1lv/AP+YglbJt28Gb0T3plRjegdp71FlUH23NN1YPskt6MjVRRpUF7z80Tx5blKYgN+fkQJzStUSv0EF0kChVNnU2uhwFD517auR1gYUHMXnZtNmKrcBRSVjmWDenIGQKYqcWBEydyKxiJSC4vXM5SWQRPx6o/b1lbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705990151; c=relaxed/simple;
	bh=fz4BDqMgk0Suf/tDgHOWOeAb3cUOczmWXmLuqN1rHEY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SeZ2v8nWj3MibWTIG+YRI6wvUfXKQ5ctSYc6MNpe+kE39a+gWzq6fOyQCYpRsApHeXcHrgs/dh51rdwLXWoOGOFSCmIp9r42+FAYMGmoRFrR/uFjrIY2SAnj8BbsCOV/9fS2Y560oB6tAFZJwarDvEX8a9jXU4B56CJqjRGNuTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MBKzUTPZ; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MBKzUTPZ"
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-da7ea62e76cso3082589276.3
        for <git@vger.kernel.org>; Mon, 22 Jan 2024 22:09:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705990148; x=1706594948; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IUKYTTHnGoB9Qzlg6Q323MH0FomcmMHF0dO6F3jluQE=;
        b=MBKzUTPZXYfkDiQ6kT4C3nu2BmXa/Fy2rxtRpS1tT+EezVNXWpTsASuPBI0wORQhv4
         e9wLUaTyMfuPfqfdaEuBlXATjSXIlaM5yFBMC9x60NW98AZCmfqc4cbDS4SGUa5Q9LQb
         c2+uvdZTzNG7nJiLOly22b4vKFzM+2EK00amyffyThwEQxIf62WKufRjVd8VokrM4Dwr
         aoiNaODthURr5mDey3DIf80l6sCPbAcI5945S+yFiUGapZT7NIG7o0x+qkmduRIT2V2j
         mbqzaOygCNduJOGYc9+n1Z4b79q8nPN2gAdrbKGfFVA/vGG/zZ2uLY3CybxdTARURxVl
         bG0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705990148; x=1706594948;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IUKYTTHnGoB9Qzlg6Q323MH0FomcmMHF0dO6F3jluQE=;
        b=pasaNwZA2+wBkdevyT4cjLjFidRhxelMW7XDWL7EH6AvCs0nE1nWjwdQVBLd4/Ido/
         G+HnMuimL1JKToUTS4VZAufa5iQPXil6D+6RJcBULzVfsKzOaRUN2FBMpSr3TNzCqnNl
         OPLBUmixNIS1sHrg8FH1R4sfjdLC3e+bBd1sGsso6Ysnm0Auptu8E4APjOpkVQ2iBF1G
         07l0rC4FS17XAn8pnsLGlLXPgsZ34THFE1Deb9fR3mqxg6E1v2qxSJRvIOL+vKvDMRA2
         tT9SP4GebM9ya+CMX+WXOkik85f1qet55PyKGMZulsGmxHfWtZ5Bqnt3Rp5m/TBMv/ut
         FBsg==
X-Gm-Message-State: AOJu0YxiGQGbvoRcHOHhkjUfH6EziIeykw9qlEoP5G3KC0AoGq1axWUl
	/YVDNJOSBmRWv64IsLLF8QT47hQbp1VcRFOd5xtmEz309USFup77STrsSehHSzUYouDkqGLtB0X
	iITOw7w1i/qrfJ4TWiNab3Cp+83o=
X-Google-Smtp-Source: AGHT+IHatJhx9X7+o8vo66TRtQuNR9OdPjZSn4mwV0DxUhjQJ5HI+MxqkkMJ+m53aNgMRsnTsPM8b7NtCtk3YumTsLs=
X-Received: by 2002:a25:3505:0:b0:dbd:b69f:33aa with SMTP id
 c5-20020a253505000000b00dbdb69f33aamr2805957yba.2.1705990148607; Mon, 22 Jan
 2024 22:09:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGF1KhWNaO_TUuCPo2L_HzNnR+FnB1Q4H6_xQ2owoH+SnynzEg@mail.gmail.com>
 <CAGF1KhWiYX=3R01Odj2yCNgvx=f5+HRCjRJogWf5eBikuATCcg@mail.gmail.com>
 <xmqqfryprsyp.fsf@gitster.g> <CAGF1KhU=o2rb-tCjZAG278kgoW50NYymsJakUwiMxWTQ33gQYA@mail.gmail.com>
 <xmqq5xzlrqoi.fsf@gitster.g>
In-Reply-To: <xmqq5xzlrqoi.fsf@gitster.g>
From: =?UTF-8?B?UmHDumwgTsO6w7FleiBkZSBBcmVuYXMgQ29yb25hZG8=?= <raulnac@gmail.com>
Date: Tue, 23 Jan 2024 07:08:32 +0100
Message-ID: <CAGF1KhWEnbOy1DQhv4xbov5Fg+hQdihWcwcT9A0f1b4Fc1gR-w@mail.gmail.com>
Subject: Re: Fwd: Unexpected behavior of ls-files command when using --others
 --exclude-from, and a .gitignore file which resides in a subdirectory
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>, 
	Phillip Wood <phillip.wood@dunelm.org.uk>, Sebastian Thiel <sebastian.thiel@icloud.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Junio!

El lun, 22 ene 2024 a las 22:42, Junio C Hamano (<gitster@pobox.com>) escri=
bi=C3=B3:
> We have been discussing to extend the mechanism so that we can have
> "precious" files, which also will be left out of the project (e.g.,
> "git add ." will not add to the index, just like an ignored file)
> but are not considered "expendable".  If file F is "precious":
>
>  - "git add ." will not add F to the index
>
>  - "git status" will not say F is left untracked and can be added
>
>  - "git clean -f" will not remove it.
>
>  - checking out a branch with a tracked file F/G will *fail*, to
>    prevent the loss of file.

And that is exactly the concept I'm handling here: files that should
not be tracked BUT that are not expendable. You explained it concisely
and perfectly :)))

I'll wait until that is implemented, and in the meantime I have a
couple solutions I want to try, like using .gitprecious files and 'git
ls-files --other --ignored --exclude-from=3D.gitprecious'. I have more
ideas.

Thanks a lot for the help and the explanation!

--=20
Ra=C3=BAl N=C3=BA=C3=B1ez de Arenas Coronado
.
