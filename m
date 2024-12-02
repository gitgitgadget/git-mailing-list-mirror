Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C6331D958E
	for <git@vger.kernel.org>; Mon,  2 Dec 2024 12:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733143169; cv=none; b=dlsvchz4/xdPsR9FQHFQL6VnoGueJq/LhdhOQcBD3ZEY80+V6mfhH8pmoEEOgU6N4aLi9zUYd4ZOjX60IQrGnm+1L+4K4SXv+h7sUogVIwYNhGSgschMql9VM294Gi39btpuOMzd+GCHZJoEHnc6VcLhL3vgkHxNlYOZfQhU3o0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733143169; c=relaxed/simple;
	bh=ozelSoAr0AvC4JbpYU7f9u0PVjonQ8bxKaQuPiuxQm8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iFm3mNtFP0S9W+enV6p+mKPdr1cZn7RcVBHsXo8SYyu9Cvvwti0lV0PiBV/R+g7yFbfyjG2PZzer0RwBcqYtd+7nEHyA7DT8R71YyBkVuZhs/uMmiJvcm9Uxaz/GsPgT6C84cYjOj3ynDpqzafwtwCI1qOrQ72kzLlLQNI+jwSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FYmgYXs9; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FYmgYXs9"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-53dd57589c8so5464817e87.1
        for <git@vger.kernel.org>; Mon, 02 Dec 2024 04:39:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733143166; x=1733747966; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BB66bBzHfHweP7wZ3tnG0cDxuY/8Ze1T/fIgvX++N5I=;
        b=FYmgYXs9K+xOKtO5FflfUHdiiTBMeRKGFgX8tMGhgfcTYqjccuZXNo6GpfMGSmN1i+
         riuG/w/n0jAB/ytI95W1gMRNQv9kWS52HxSRGuHbq9I86W0lX8Otv5W9czUWIMdPb4d5
         lYQnK1yfm9BPWBKAw29NakgjAHhEJiboeNm4wy0Jo0F+GyY8eL0GJY/TTldxESoktA/U
         Znxm4M0PTC6q2ZUQWBVgCDjok2x73GNRrwL7i6dBO4qbOnfoIodhRG87xWybDUZpq316
         +5lPdNZdcWxa9TwSU+0pG9xPrNpv894jhF18fNIfG2Kpl9EElEOdGIItU6mt3TrcqDvC
         EVCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733143166; x=1733747966;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BB66bBzHfHweP7wZ3tnG0cDxuY/8Ze1T/fIgvX++N5I=;
        b=R0L200fvnezOeZzir2leT0f2eYCST58oitDkSvTqhUCHtsFys9yw/HdDW9o1U1T3Ew
         /l2QAxc2pHqIX0YolxIWWWpKKWGytTHfxEyh9pQ/j8Opic4Q/XWDdNnsORpVCBonHq/c
         A18nt2JmHQKqYlkfWNM/0LJZvs45GIKJD/QYZtehfiWmB7WeYJ4ypLzTlGxD/4U0APok
         N8e3ONYCRax/b4b6v7nUWoP/km2qpP0IbhuyRNN5kfRx91EudiSN5atSfbrUV4gsWLAd
         xg7DLamP7ulMzqSBlUJJloxiFsn0oTTu/4gnWsAaKn/VQQ3mSqGdlN7sW6lqaMFFdMaE
         OlYg==
X-Gm-Message-State: AOJu0YxMOjLb7zQosS/baPYSMeyKN/F46fwqENEoCE5YUl3lIUiP+9Km
	dOV/QQq4k/bcbqxMmWF9YT3BH22D6g2aSYNL3NAj+0lk8PJfbGYmVNiU0KBdbOFmaUkjsmYI6UK
	sQDB56KnSUqK1J3rnjR+YSAI6xVc=
X-Gm-Gg: ASbGncvaNFEnhpPXYvDf3KZToRza20wMB0yySJxk7BclrrxRCJpIT3hjTtHMIy1CvEr
	bXFepNmGP3r+f2ywSG7+b5amK2LhWNJC1
X-Google-Smtp-Source: AGHT+IFA8pPkuIjdgZ+cmHdl8sO8EEPzaJzcodaht+w3pd3uABhX4BhFyHyFlHYwLRQMYealmrl5N6yLo2vmC5z5kS0=
X-Received: by 2002:a05:6512:2806:b0:53d:f7f5:bede with SMTP id
 2adb3069b0e04-53df7f5bef1mr5790224e87.25.1733143166029; Mon, 02 Dec 2024
 04:39:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFePT4zytyuLB0TgyJ+mbrNvz=Xt1x+gJv4e-2j07YK7Cg1bzw@mail.gmail.com>
In-Reply-To: <CAFePT4zytyuLB0TgyJ+mbrNvz=Xt1x+gJv4e-2j07YK7Cg1bzw@mail.gmail.com>
From: Chris Torek <chris.torek@gmail.com>
Date: Mon, 2 Dec 2024 04:39:13 -0800
Message-ID: <CAPx1Gve_dCRux9_cF7NTspomS4K=Hp_y74d94S-Hm0amuovUqQ@mail.gmail.com>
Subject: Re: How to revert to a specific commit?
To: tao lv <thebookofunknowable@gmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 2, 2024 at 4:15=E2=80=AFAM tao lv <thebookofunknowable@gmail.co=
m> wrote:
> I want to revert the code to a specific commit. ...

OK, first some background:

 * A commit _is_ a full snapshot of every file, as of the state
   it had at the time you (or whoever) made that particular
   commit. Hence, if you want the particular files from a
   particular commit, you simply check out that (historical)
   commit.

Now:

> I don't want to revert each individual commit; I just want to restore
> the code to this specific commit while retaining all the current
> history commits.
>
> How can I achieve this? Is there a better way than using the revert funct=
ion?

Yes.

The mechanics of:

    git checkout <hash-ID-or-other-commit-specifier>

are twofold, and mean the same thing as:

    git switch --detach <same-hash-ID-etc>

That is, you are asking Git to:

 1) switch to the saved snapshot, and
 2) "detach HEAD".

Step 2 is your problem here because the jargon phrase
"detach HEAD" means "stop being on any branch at all,
just go to some historical commit". But you seem to want
to subsequently make a *new* commit that contains the
*old snapshot*, as if you had removed all the work you
(or anyone else) had done since that point in time and put
all the files back the way they were in the historical commit,
*while remaining on your branch*, so that you are now
ready to commit all the old versions of the files.

Note that this new commit, if and when you make it,
simply sits atop the history (and / but, since every commit
is a full snapshot of all files, it undoes all the *work* done
since the restored commit -- though, since all commits
are also *permanent*, that undone work can be redone
trivially as well).

So, at this point, you have several options for
achieving this goal, provided I have recapitulated
your goal correctly.  The most obvious, I think, is:

    git checkout [--detach] <hash>   # or git switch --detach <hash>
    git reset --soft <branch-name>

The checkout-or-switch does what it does, including
detaching HEAD, and then the `git reset --soft` tells Git
that it should re-attach `HEAD` to the given branch name,
but not alter *either* the index / staging-area, *or* the
working tree, leaving the historical versions of all files
as "ready to commit".

=3D=3D=3D=3D=3D

A different, and more direct, option is to use:

    git restore --no-overlay -S -W <hash>

The `git checkout` command can be used in place
of this `git restore`, because `git checkout` itself is (in
my opinion) overly complicated and stuffed full of modes,
so that it has a mode in which it *doesn't* affect `HEAD`.
Understanding this requires keeping in mind the way
I described `git checkout` has having a step-1-then-step-2,
even though the two-step `git checkout` actually very
carefully *combines* the two steps (to avoid making any
changes should the second step be about to fail for some
reason). I find that describing checkout as two separate
steps, and literally using an additional `git reset --soft`
step, more explainable (Git is complicated! Nobody learns
all of it, it is always changing over time! Those new to it
find it very mysterious, and this is part of why).

Chris

(PS: the fact that you need `--no-overlay` with the
single-step methods is another one of those picky
little details that make Git tricky.)
