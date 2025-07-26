Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE3AC1C84C6
	for <git@vger.kernel.org>; Sat, 26 Jul 2025 15:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753542020; cv=none; b=PENV+pTKO1HO9G05RAhaPBtYbS+T4QwTz9vw3ZKh2OvcmAPMHVcDGRDd3qCHELaXNwy95m9KCyPu2DHxjnFzSdnNG8hE/Y9tuwPdUHCzQ2ZLzV20/XmJo5jH2mxrfIVtgJbjMft7HGK5rvICWssVOBnV45h1LrQlmDX24VgucXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753542020; c=relaxed/simple;
	bh=6IuP9102kBXZPvHwyZr5S2GC3jVDefZyde0NeDaQerQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B/LUZho8iTm2V3enIcHet58+gTyzxOWUW9hNj3BmmLubJUchEHf01OSsV7Fzob8cnI0bKEKeNK0t1kzrFo8CdBcxnFZchv4p52UYIWcLQm7TQamNj0AIB0L9Wb5mtz4b9qN8REMMiX3+agg8gt5mATjgY9GU8h8Fb8PayQGThqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KA46gUXu; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KA46gUXu"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3a510432236so2145988f8f.0
        for <git@vger.kernel.org>; Sat, 26 Jul 2025 08:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753542016; x=1754146816; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6IuP9102kBXZPvHwyZr5S2GC3jVDefZyde0NeDaQerQ=;
        b=KA46gUXuQ2hERFowGYfJtlHLNkJi8uasXv93sF8SGNhaO2R8O8YE0WiE/UIALEOoVE
         5zszQp9uDS1bCCK40tSua7gFw6ujBrVmqApNCcYO+NjyQQ/zV4DD94Bw+fQIe0KVDkkk
         Atz5KAFMv78fLraqJiDgPZzQHRzP4JIC+SKY+tTXBEXvx7nyLaWwNYCnYBEFbWVtBToN
         FqLSydgq2rtg8EcNc5q4iK2Lbq8ZmSFNjAME/5fH2kdpftr+d7dZ3iyWw5/OLMzlwpVQ
         kizDUGBd6ol1IdnsoytMMaMNqoWolQ8ZZh7t/M5t3gMsKleqGDLcTu5TZmY+/LEH1aB6
         BRlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753542016; x=1754146816;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6IuP9102kBXZPvHwyZr5S2GC3jVDefZyde0NeDaQerQ=;
        b=v9VdyMH7zqSdfUWgbkt64iXLXUEnptXCpPVjkP+CQtStDCp3/ox8lKqXpgQFaILsbm
         d4H6j4S4LCmLeIXarN1d6+Y+Zl1jKJXwuTLclWtHEVQqaE42d1ADwVppE7r1LDbwaNFR
         M6jbJ07wCFpSBqUY2htU5LfKrsdbeVkZXZLWA/o4n7iu24xJq8+bS7WnqsVhXM4fl3EN
         UpLL6XMw5SJ87EYVY5GfDQWtzK8hjBDvP9BlD6kLUzDzjQdd0BsBzbGK8ul7VCkPyYDb
         GTmksJtSfEKoJFf6wZyZNhffjRohoPlytrDBN0duPlazec4pNtIVoQn0B3YCD85fNbxX
         oANg==
X-Forwarded-Encrypted: i=1; AJvYcCXfj6j1k3Js6T/YVC4LFK74GZT3MNxzzmMiK7SiiJ4q2EpUU5b4AdHb/Fj1daazKf55l5w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2j3aQ/9gOxfOOjxoPVpgxBkaMuqldILfNUZvI2GsL37d2z+27
	9JgIWBVnEw9SEvGUOX+m/MaXb0vXlBtqkEyTxilBthRibyE3/moPNwleluZmQfbZjEMD9bO78y5
	EFeEMKjKRGWNaLmmZsps67KVkfGS/7HM=
X-Gm-Gg: ASbGncuxhG1JlwBjDPjAMq1HXG8Z5lMsOYopLYxBGsJINbtncS3S6M1BR8Rccmaar2v
	dBUIvKOKTYS0+2PBeTmnFQGWzDpT+vlxKGkPuTHKRfDphLcYvPYjqyMwVQ4cGMJI9EjBfhH4XP0
	dfAi1A3Mgcvig712HIaQkBLrievev/stLJs6urCnIr4QsSLBqrEsLbPw0ViIPSWNGXzEoZn1UBM
	NeziTQpanwdJUQooSo=
X-Google-Smtp-Source: AGHT+IHjuVnkDOKbl1+E+Ibpy2Z8iCgprKNMPevElvxdtrH8uLj8rSrJjNck7yH99+njm9pzbMmPMPzNxyrjVLNufrk=
X-Received: by 2002:a05:6000:2410:b0:3b7:75dd:f378 with SMTP id
 ffacd0b85a97d-3b7765ece16mr4724387f8f.10.1753542015849; Sat, 26 Jul 2025
 08:00:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAAVFnNkdgXuUk6ziu5FkB=sAHzEOyiynQpQJFox_p_ZL9VGRfg@mail.gmail.com>
 <xmqqwm7xxn4a.fsf@gitster.g> <184ec60f-9431-43c1-bce3-405bb6b7f959@gmail.com>
 <CAAVFnN=q5nCD3K1jppVcq7qB9P5WX0M070jqR_rey2hzBt0ERA@mail.gmail.com>
 <xmqq5xfg5o5j.fsf@gitster.g> <CAAVFnN=S-bu1FNafyyH797AeBxUu+8vk5yJ5xaxCUBkBZin_6w@mail.gmail.com>
 <553bd772-a92c-4782-a7aa-3092b3aa0494@kdbg.org>
In-Reply-To: <553bd772-a92c-4782-a7aa-3092b3aa0494@kdbg.org>
From: Cameron Steffen <cam.steffen94@gmail.com>
Date: Sat, 26 Jul 2025 10:00:04 -0500
X-Gm-Features: Ac12FXw9IYH9e-i7ETlCfLRnV_yjQBkOYJ3WPbjrGrda7L2IMOO-BvfcjtnGe6I
Message-ID: <CAAVFnNk5YO7J_M8JoOiTMUBRsHQyXLtRPrwT=xSeovQMgT=+ew@mail.gmail.com>
Subject: Re: Show skipped commit message after rebase conflict?
To: Johannes Sixt <j6t@kdbg.org>
Cc: phillip.wood@dunelm.org.uk, git@vger.kernel.org, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>, Kristoffer Haugsbakk <code@khaugsbakk.name>, 
	Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> I could have fixed the conflicts and committed manually.

I believe we can detect any case where you ran `git commit`. I just
know that when you run git commit in that case the commit message is
_not_ auto populated from the pending commit. So git seems to be aware
if you did any commit that "replaces" the pending commit. So I think
that addresses most of the cases you mentioned. As long as the first
`git commit` after pausing from conflicts is non-empty, we can say the
pending commit is not "skipped".

> I could have reset to a different commit.

I think it would be okay to emit the message if you hard reset and continue=
.

On Sat, Jul 26, 2025 at 2:00=E2=80=AFAM Johannes Sixt <j6t@kdbg.org> wrote:
>
> Am 25.07.25 um 17:20 schrieb Cameron Steffen:
> >> But only if we can positively tell the reason why there is no change
> >> relative to the parent commit _is_ because the commit we are
> >> currently picking has already been applied, that is.
> >
> > I thought we merely would need to see that there are no staged changes
> > to be committed, and there is a currently-picking commit that will now
> > be skipped? I don't need to know whether the commit was already
> > applied. I just want to know that the commit in the rebase plan is not
> > being committed.
>
> How would rebase know what I did while I had control? I could have fixed
> the conflicts and committed manually. I could have reset to a different
> commit. I could have split the change into two commits. I could have
> removed the changes. I could have made additional changes. Possibilities
> are unlimited. Saying something like "commit 123abc is now empty" or "is
> skipped" would be incorrect most of the time in my workflow.
>
> -- Hannes
>
