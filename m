Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDD401E535
	for <git@vger.kernel.org>; Fri,  3 Jan 2025 18:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735927656; cv=none; b=ufJGurbT1BgLH+YGPuoRcAIH6jZOROT9M6X9LD639vmSMUsCI+xvjwEk8hrFcSh2TE6h/+IALqWTZsVFEzzFR6g3v2Tde6vQO4pE56534dz/2Z7gkHqpbnCA5ANB1kPbQa2pgjO6JKsrySyBjqzTS9FFJqzPPP4qfGQnJ4Z/3eM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735927656; c=relaxed/simple;
	bh=lH7UbvIBjhqn93+bGtbnbt67+B6RLeveHyhDg+lfxv0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RwYUbKe06Hs1SX+ROlH7SfQMiqGXFIr6yUEwrKR5cCmtUkhul4lk9/iPNqz+L3rB1d8SztvmAqfAtXhYXNEyhhvnlQkTHoqEnz2rSl0RfarGIjc/0N76NqlIxhd9AdNEVTDWufBtXts+Yd03ACBUbwEnpCfqg8ViosXOmWT0uyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mPCoNApn; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mPCoNApn"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5d3bbb0f09dso21589269a12.2
        for <git@vger.kernel.org>; Fri, 03 Jan 2025 10:07:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735927653; x=1736532453; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KPN5JhZMMIzuzAzpF8rfIfQsmU96r7RZynbQkI/56Yk=;
        b=mPCoNApnsiBzYaNOzY2n16dWlRzRPRWtiW/GSnAhQPuzCb2iDS7PdmdF9lWUAmzOND
         ONGwJWznXUpFKSk+kPWkKNrNBKa7C4qTLERd9WZj3Jk+SDCEWs13RIpHXzQx4u7rZGQR
         dhlR/gR67YTHaaYwpfbn1EZDgNEgeVf2YNiwDU8zpK1ckGDg71b7cVP3NInWsSMlb5IE
         io2VFaNsDlcszP9G7G/EdE+kaGjfert+XcAu/CrfeyBDTQPjQvCkNemAtVsVH2N4PhLc
         QDWub0oAlsN0liCYiHadk3V9Edrrc98EALVuVZ6MKsp2sPaUgQp3UwSOixPpurK5/2t/
         cL1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735927653; x=1736532453;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KPN5JhZMMIzuzAzpF8rfIfQsmU96r7RZynbQkI/56Yk=;
        b=E4uIepOWW3Dpne51MoYbtG50QMONTW8q2QrzzqHQOEI6v4pyDXmCLZ5OXPhLjqYUrn
         r120Fl/HJWP1b5MF2+H0flWeasi5opqI8Sf0OLEoBp/XPCDE9gTNQ25OtspewYMH5nS/
         RrEGCNDKr3PlrecYa80ZPljXPXpSDnrCXwnid6xA8A/ne26y50WkVjnL7fdny6IfYg8i
         QBgRmW2y5hTatduYl7euNFer3KpCxqlY0rXbpC8gF8XGyAjXv8gBy8RkoPEw1XpHHbbo
         z3l7xAMOtdii0tEpIFQH2W84RJkj5rS0CETroKHjYcsFkW3hSDIUE++NAojh4rj8RXN9
         hZSg==
X-Forwarded-Encrypted: i=1; AJvYcCVgHhnTsHDo2yKAJ0glVo5VQPipIgUzaWNu5GlGqmAaaUF70BB2G8zKy/oZwRTwDcqZV3c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlnkdHUdTAzi0eyEiHeCgsI0X523dCRWvcUF8hz3RhYwrqvgfK
	T14zTpGtVK3+6ZU0vWsiSh6X8KAmGMuguwuZbvvj1kFLxSY0Ql/5DfKkEDXgbn4eAssgq0HKE0z
	ls1yrcz10HoazoyrrlDOP5ujRZ5E=
X-Gm-Gg: ASbGncsKD0y8hIqGU0faKIc587HW33lXG4vDi1QqxL/yeapDPOtEQfbhvq+aMh7PhsR
	2WCF7ev/cMrY4a4g14xkxvGU88tj81c9kVNLCQoiEEIuga2SquTo+1kzixfeFgqKTs3E=
X-Google-Smtp-Source: AGHT+IEAe6/h7x6o3qJ0xCVqNyjGR+SVHQ0H51asaQec3gHOqbJzjUWrNJKM8xQtZRwortk2mN/dn1VjPCu4WQ9kFX8=
X-Received: by 2002:a05:6402:35d6:b0:5d0:f9f1:cd73 with SMTP id
 4fb4d7f45d1cf-5d81ddf3befmr47064069a12.13.1735927652918; Fri, 03 Jan 2025
 10:07:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1860.git.git.1735516831782.gitgitgadget@gmail.com> <4060690e-39b0-678a-75ef-af30beb439f3@gmail.com>
In-Reply-To: <4060690e-39b0-678a-75ef-af30beb439f3@gmail.com>
From: "D. Ben Knoble" <ben.knoble+github@gmail.com>
Date: Fri, 3 Jan 2025 13:07:21 -0500
Message-ID: <CALnO6CDpH4w8nOx7YDygtnY+G5NTBRbMGs7HTTDUHguYkCELiw@mail.gmail.com>
Subject: Re: [PATCH] completion: repair config completion for Zsh
To: Philippe Blain <levraiphilippeblain@gmail.com>
Cc: "D. Ben Knoble via GitGitGadget" <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	"brian m . carlson" <sandals@crustytoothpaste.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 3, 2025 at 12:21=E2=80=AFPM Philippe Blain
<levraiphilippeblain@gmail.com> wrote:
>
> Hi Ben,
>
> Le 2024-12-29 =C3=A0 19:00, D. Ben Knoble via GitGitGadget a =C3=A9crit :
> > From: "D. Ben Knoble" <ben.knoble+github@gmail.com>
> >
> > Commit 1e0ee4087e (completion: add and use
> > __git_compute_first_level_config_vars_for_section, 2024-02-10) uses an
> > indirect variable syntax that is only valid for Bash, but the Zsh
> > completion code relies on the Bash completion code to function. Zsh
> > supports a different indirect variable expansion using ${(P)var}, but i=
n
> > `emulate ksh` mode does not support Bash's ${!var}.
> >
> > This manifests as completing strange config options like
> > "__git_first_level_config_vars_for_section_remote" as a choice for the
> > command line
> >
> >     git config set remote.
>
> Sorry for breaking the zsh completion with this change. Tip: it is custom=
ary
> in this project to CC commit authors when you identify a commit that
> caused a regression :)

Once upon a time I knew that ;) thanks for the reminder.

>
> > [wall of text]
>
> I'm not sure this wall of text brings valuable information to the
> commit message.

How about something like the range-diff (pushed to the remote) pasted to th=
e PR?

> Thanks, I verified that this indeed works, at least with on my (old) syst=
em
> with Bash 3.2.57 and Zsh 5.0.8.

Excellent!

>
> I'm wondering what could be done to prevent regressions like this in
> the future. In [1], brian mentions a way to test the whole test suite wit=
h Zsh
> in "sh" mode, which could be added to one of our CI jobs.
>
> But the completion test script (t9902-completion.sh) is really Bash-speci=
fic
> and does 'exec bash' if it detects it is not running in Bash, so this wou=
ld not
> help us anyway...
>
> [1] https://lore.kernel.org/git/20240426221154.2194139-1-sandals@crustyto=
othpaste.net/

I have no real thoughts on the testing bit, but it would be nice to
avoid. Long-term, it may be necessary to either split the completion
scripts (as Bash/Zsh diverge?) or document non-portable constructs
specific to the completion setup? Neither is automatic of the kind you
had in mind :(
