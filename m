Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBB4F215182
	for <git@vger.kernel.org>; Thu,  1 May 2025 18:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746123919; cv=none; b=DL5FdGHcx/PehT1mLTlvulWTsuKMaJppAQewWwr7Mdf6U7bhNAA7W45clQLz/HnHg8jE4r3SFVj0AGywwz6JOaB+OIoizTs597wMt0Tpi/r8Br/PPRjhAdRNJPGG1pe/lxqWzJ83WJ+p6u8ahD1zO9usXNzsFk4HfIPFi3og9Rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746123919; c=relaxed/simple;
	bh=aBz/UjftOWAOnD3VCqb/z4MEHfSdo2vc7GXG6DgeGaQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=irM8y8Zc6mKZDJeHKnk9E+6xJ3AlfwmTYX6mKPDAgLGklGKL6A/NnOWWrOxx1+RO4xOK9VKB/Y+U9t+bEzlJsh6nfTnDAypJxUhPRnac2Dn7mleUtw0NTQ1eOuUA5iXoeqS2TUIetstzbIyqjbzIiDw6VS53FbnitFaSAc2PrQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DP32WRY9; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DP32WRY9"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5e6c18e2c7dso2314608a12.3
        for <git@vger.kernel.org>; Thu, 01 May 2025 11:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746123914; x=1746728714; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2ip0s5bQoauGA6C2QIQd5PhVNgBXk2LyssUGsiu7660=;
        b=DP32WRY9b7raD/07KMuhU867w+vONjO11xlmZNU+U1NfnnicVHukX+3ChRIVBOtCtr
         nAgiSzbtfHbhM7+2zEMKA6aMasP0zhw2vHufSaeIO3t/7bAIq4rgSsHK9w5tSnQCUFa5
         cA9OV4BQ5r7TF+Hqgw0FmkgvCmEjUqvYNzHnuhZhf9UEJJgKg8g1L+WuA/cnh1ybGcYs
         RvlzKHfinlb/ZkwGG/oqo+9VV5VwwwsmcoKaAZq/3tFiou4Q8YWb7EzhWJR9/LD70gU9
         4+I4kgjRt+FzQtVVXqJHMIinXlj0rwRPpHpQ9vILnGNgNUYJM6HU/Ajzt+gRO0Fuwvp/
         sayQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746123914; x=1746728714;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2ip0s5bQoauGA6C2QIQd5PhVNgBXk2LyssUGsiu7660=;
        b=FZznqNYImZdu+5yylLJLAVqF1/K7bx0sDXNsMP2yPIcPz+wfhdGXDGc2MVwFSWFFo1
         0bZqPLXW5rSxNB3PlDWNd1snjHQ4bHbEVdCrYhnZa2ejFrQakt6swf/YHRAynFVd7VKD
         nPwFAL9jNASvUrq0thjIQmzK1Uw7P8Weh5vaJ0rCpoE+ZM3RWkBPZd5cqiCAGeRh1BYB
         LC15AQdgXWYu79IARR40gP2Bp/C7RaMlzH3POMcxkJ7IO/t5ewM4M5kvXRUPmkVZUBDB
         kjjuJB8X+Lc9keRXqR9oiM15aWjBxTLrEKERJcKSmPOiNcEHjEtn/JwzhdqeqIJ8/tqG
         Jd5A==
X-Gm-Message-State: AOJu0Yzgqih8ERWYsWQmdoJQliZGQMVSMz+4r6dFJLTdvABfGqBA5XQV
	kh9iZzOkStwEEB+bO6aGpJJs9BvBH1dVMoP+WJwBPPu6Up/026kHiUX2d+OciGjAS/c8SaQ3Q+w
	/A7yd6VrxKI9CI5gy4wFQ95lbjzbpW5AG1jk=
X-Gm-Gg: ASbGncuDaTWN0PxyeHaH84Vi2CyWDhsuLT1r/UxS9gySKG/F9NXcTLW5b+2Rhh/FJHV
	KaW3JMVs7oFwl6ZILusDSDq368DK1zjlgzhvFaM8eCLVGooMxbX3e5o0zjy9OoEr8VOk1qiDd07
	WlEdgXJX2IjQ80jkGt6dCOmoaGHCJejgKOctASadk8CPk9BwrzPG6T8RzD
X-Google-Smtp-Source: AGHT+IH9+cfLgyuw+Ee1zY9EvFinbm6MuqlnItPykPNk00ODq/GKwDi7ABLFjJCXP7AznZpPR3L2wxSUfLFeydK2Wgw=
X-Received: by 2002:a05:6402:849:b0:5f6:2249:d424 with SMTP id
 4fb4d7f45d1cf-5f9135082acmr3702546a12.24.1746123913880; Thu, 01 May 2025
 11:25:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <xmqq4iy8cagi.fsf@gitster.g>
In-Reply-To: <xmqq4iy8cagi.fsf@gitster.g>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Thu, 1 May 2025 14:25:02 -0400
X-Gm-Features: ATxdqUHdn10SshC3uiYreQmpGM5arUiCK_5zN3wghdH1pqAoa_S34pWw8Bf7QDg
Message-ID: <CALnO6CBR2J8YdGgVLHxxpciAHBe5WjwAb3dRr=aUKU8fzRvzYQ@mail.gmail.com>
Subject: Re: response to "git branch -f foo origin/foo"
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 28, 2025 at 4:12=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> When 'X' is a new branch I am creating to automatically (as the
> default for branch.autoSetupMerge is true these days) track the
> corresponding branch at the upstream, this output ...
>
>     $ git branch [-f] X origin/X
>     branch 'X' set up to track 'origin/X'.
>
> ... from the command, with or without -f, makes perfect sense.
>
> It also makes sense if we reset the tip of 'X' to a slightly older
> commit on the branch, i.e. after doing the above, running
>
>     $ git branch -f X origin/X~4

But why not use `git reset --hard origin/X~4` here? (Answering myself:
presumably because this version works whatever the current branch is.)

>
> does not say anything.  The branch is still set up to track
> origin/X after doing the above two operations.
>
> However, after doing these, and 'X' is _already_ tracking its
> corresponding branch at the upstream, resetting the branch with '-f'
> again will give us the same message as the first one:
>
>     $ git branch -f X origin/X
>     branch 'X' set up to track 'origin/X'.
>
> and I think it is wrong for at least two reasons:
>
>  * Does it make sense to say "set up to track" in this case?  If X
>    used to be set to track nothing or some other branch, and if we
>    changed the tracking information with the command, the existing
>    message may make sense, but otherwise, I would say the current
>    message is useless, and it is unnecessarily frustrating, because
>    those who see the message may start to wonder what it was set to
>    track before, but at that point, that information is long lost.

The other perspective is that
- it's nice to know the tracking is setup; if I'm used to seeing that
message and I don't, I might wonder where the tracking has gone?
- use of -f is enough consent to lose the "what was there before"

Though, it might still be nice to do the following [reordered]

>  - We may want to extend the "branch X set up to track origin/X"
>    message so that the message mentions what X used to track, or the
>    fact that X tracked nothing.

This might be "noisy" for confident users, but seems like a nice QoL
improvement to me.

>  - We should give another message when "git branch -f X" resets the
>    commit an existing branch X points at.  Unlike "what was X
>    tracking?" that is forever lost (hence the previous suggestion),
>    what X used to point at can be found out as X@{1}, so it is not
>    necessary to give the exact commit, but the fact that the branch
>    existed already may be significant (especially if you habitually
>    use "branch -f X" whether X exists or not).  Taking inspirations
>    from "git checkout -B X origin/X" that says "Switched to and
>    reset branch 'X'", perhaps "Reset branch 'X'" may be a good place
>    to stop.

Didn't I see you recently suggest someone drop the habit of
unnecessary -r in rm? [1] :) This seems similar to me: don't use
unnecessary -f as a habit. I would personally find it noisy, but again
for newer users it may be helpful. I can't judge that well (only that
it would lose some "silence means success").

[1]: https://lore.kernel.org/git/xmqqecxk3u5l.fsf@gitster.g/

--=20
D. Ben Knoble
