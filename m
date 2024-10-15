Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D86631D514C
	for <git@vger.kernel.org>; Tue, 15 Oct 2024 17:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729012835; cv=none; b=sw2VExW1y3pLIMZoq2SwEwL+3f6iIbpJdfEC4UzNThezilPPQQk+Bw3Waq6OnNsS5T1SJVV0PQH6nPnObwTj9zRmgV+OVsBEKRYDlIDmvr5yjWYgAlJIJBeL80nfA4kxkSGChffQUeOwfinXiPC+nzSthgpB5CnITCgoM7LXpbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729012835; c=relaxed/simple;
	bh=e0YcnDkxGqMbRr3kig0GDgvEjDvyCLZGnn7jKGn7Gtc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OOkW7pGSQ+X2Ytl9FzZ8gHNfzmVIMoxRfHvpWHHBQrolVRBK/XknUPgI9Jprm/mD6TIGJ2t2Orm6J8rLFJz9GHQ9DvmYWcmyfE0wMElQJpiRHhb2vuA4Rt5/EXC5AIwJLKeu/bVoX15MGW5mr6PNVMqogi0WHVsQ1UnUAj1w4Xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6cbe7374e74so9246706d6.1
        for <git@vger.kernel.org>; Tue, 15 Oct 2024 10:20:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729012832; x=1729617632;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+wWqHMwqgYFtyd96K2rucMa/mHcbZMyymnKbQExxs3o=;
        b=m//GBp5FDMTobvF1FIsseDXJ+WUTOg+QD5HRE6+uClCAk85gby1OYOo3Fx49vXJxKp
         KEjB1iGTW48zqw9ksna+EjlFCPm747sRH4xIfq5IQC35rSEW5mChsbGSbSM4Z5fgj8vV
         byVA4Vqpk//d57XLWRUkhivK0nj2jWBVzj5NP0enJHoUAm86cRYBkJrv42SFZNaveT/E
         RQeIyIoKGStIgxj65YFM87lXNT8SMNLA89QoB4VmHal6wrPjO58pkFAMUEAug8ubnZMz
         kLV9WPJ6dZguYdqsznPdVZoLfvTGUuhzGJYBoKdSo9uBS2TwmHy9aMH5SwSuIh4XlH1w
         g0Hw==
X-Gm-Message-State: AOJu0YxBdAmR9IEvM/UegjYZrjGGDgASs1oJ5vhdPROGRa146Ejd8wHH
	AhndTM34q0Q6dRdudCX1LCKpl48pm2eCoY1b9ItoHizmg+nlMvo9qeeAg+Fp1XB30ZjgTuu0ul7
	JXfs5zbUABeeMCiRkDWWUDqt9qT7YbWEs
X-Google-Smtp-Source: AGHT+IFtdANcBtkG524NbxQvU1fklzmQLM4gaIV3cvk+AlY6fnQjsmxXZtNlQRrhb01xLuoyoLNpMPWV22sVlbrt+To=
X-Received: by 2002:ad4:5966:0:b0:6cb:e610:f8 with SMTP id 6a1803df08f44-6cbf00445fdmr93780496d6.12.1729012831746;
 Tue, 15 Oct 2024 10:20:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241011183445.229228-1-wolf@oriole.systems> <20241015114826.715158-1-wolf@oriole.systems>
In-Reply-To: <20241015114826.715158-1-wolf@oriole.systems>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Tue, 15 Oct 2024 13:20:20 -0400
Message-ID: <CAPig+cSGzgfa+0MbRD10vktmx3O3v3q_TremWs7dANrwALf2Fg@mail.gmail.com>
Subject: Re: [RFC PATCH v2] builtin/shortlog: explicitly set hash algo when
 there is no repo
To: =?UTF-8?Q?Wolfgang_M=C3=BCller?= <wolf@oriole.systems>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 15, 2024 at 7:48=E2=80=AFAM Wolfgang M=C3=BCller <wolf@oriole.s=
ystems> wrote:
> Whilst git-shortlog(1) does not explicitly need any repository
> information when run without reference to one, it still parses some of
> its arguments with parse_revision_opt() which assumes that the hash
> algorithm is set. However, in c8aed5e8da (repository: stop setting SHA1
> as the default object hash, 2024-05-07) we stopped setting up a default
> hash algorithm and instead require commands to set it up explicitly.
>
> This was done for most other commands like in ab274909d4 (builtin/diff:
> explicitly set hash algo when there is no repo, 2024-05-07) but was
> missed for builtin/shortlog, making git-shortlog(1) segfault outside of
> a repository when given arguments like --author that trigger a call to
> parse_revision_opt().
>
> Fix this for now by explicitly setting the hash algorithm to SHA1. Also
> add a regression test for the segfault.
>
> Signed-off-by: Wolfgang M=C3=BCller <wolf@oriole.systems>

Cc:'ing Patrick since I believe he's been patching similar cases.

> diff --git a/t/t4201-shortlog.sh b/t/t4201-shortlog.sh
> @@ -143,6 +143,11 @@ fuzz()
> +test_expect_success 'shortlog --author from non-git directory does not s=
egfault' '
> +       git log --no-expand-tabs HEAD >log &&
> +       env GIT_DIR=3Dnon-existing git shortlog --author=3Dauthor <log 2>=
out
> +'

t/test-lib-functions.sh has a handy nongit() function for running a
command in a non-Git directory:

    nongit git shortlog --author=3Dauthor <log 2>out

By the way, what is the purpose of capturing output to file "out"?
That file is never consulted.

Also, can the original crash be reproduced without having to invoke
the additional `git log`? In my tests, this is sufficient:

    echo | nongit git shortlog --author=3Dauthor
