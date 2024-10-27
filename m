Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71C1A1428E0
	for <git@vger.kernel.org>; Sun, 27 Oct 2024 14:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730038086; cv=none; b=p7lr3sYIe2n2lDu+moXL/tce12wCIxPozNG8JYbBH9oaw4XpRud8ehksFclhI3/xRUrM8OQQyvndWdPiS+S1KQb+BQOrHkj8SGcufiru6RFc3lP9XQgdAstm6O+sJFrTdmhJz3fD1a9o4RFjnXjDV1oEB89kaVCSyu/Bp15gZok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730038086; c=relaxed/simple;
	bh=I8kClpu/ks3yt9YFNE4V5e+YNlOfr2cXpZSznZLM0XU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bszJOzCJ+B2btY/8Wv5riRSYD6wIN0s4znWyZncG9+Y7NSTgs9pGpFZxngaJqMl9OyRM/K4RC2vwl/jTA/CGoLABT7du7utmLrVfLAmOYO1pjLUcYeBGBGafIztZpUVAjBuEECSLLgH2kusG0opYoemVMxBcVi3d+mqgb1LDRHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RpdpgM2r; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RpdpgM2r"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-20c77459558so28324375ad.0
        for <git@vger.kernel.org>; Sun, 27 Oct 2024 07:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730038084; x=1730642884; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=aXK/iHXWioxuHZ9wl5kE5lRlZ3CEWbUJ3PcibikpuO4=;
        b=RpdpgM2rp/+XURlNuzIbV5UWiXPNGxpukaNJ+etaFh+Cexfh22ryiYmo+B+057WNUH
         3/zX1QzVQdn9Quk7jgMa/Z0sC/LQMECjfaU+i6MgP7INdAtU/rSnZ78X4UYKLNIBSJTC
         vpqqE5JnSnmhJgJcFE5oGHDNphFYUg4LtYVbYyV54e6Wnh9SY/Nb4/1vygY6HzVDF42P
         I4ac7J46YvwklrYpgrV/TRYBxjwE1JtQiUDhClrTLKids8z+uPxTzQF4pF3VxwcFzFVU
         IRMqEik5cFL6UX+c/kUtgXPURAJZx4sHI1wkRE2JcS9BNrRiBCWVfxRqtD4fqRWjEq2O
         LEqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730038084; x=1730642884;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aXK/iHXWioxuHZ9wl5kE5lRlZ3CEWbUJ3PcibikpuO4=;
        b=pzX2fWuNTHetRUXrrj5E939rxUkWp/7QxQ/tdZcqRupOXLtSoXwo0MsmoAYCPuRMh+
         1bWGJm1Hng1oWomJSFN5bol2Q1SschznZhIRN2mkwbXigU2ZQktAJWQMsIlLCo3Ke3Ns
         vjss1L5NSw+5JwKAJeZOuAQvj7SgwFZgGW7+7C5QWNBtxqy+gSezKekHpwC3n0lnCGNp
         f2CDZ/qtxP7Z927zbLsg0KGFGn+8zHzfAf95lqoIaVRzdv93SDItAX3/fKhS9MXdgkrr
         tLfgjIxaKjcT3M/VprpFtQJnjmVpaF/JcKuuNVmHek8Tw+xTueU2XONPPjQPHCcS5CmS
         ZdWQ==
X-Gm-Message-State: AOJu0YxdPOR2L2YOpS2zqrhxoA67zvuPXGLtjiZBhERdLNkg1DT0+9Cr
	TgESrPQaKX2RmocZQpNuPCSA2iv8FRnyH2uh2czZIfzNDDnb1uOL29fOAJv+WbWBBO1wG2Opih7
	EvKuKwmcOsbsg2cSeW0To0283Ab+8kQZOojA=
X-Google-Smtp-Source: AGHT+IEsocm0XZUBGCS26+C5atuYR9fQaMuvgJz7rQAcbCuQFYCllzy9KYibkG7h5DApumBykOu8hsdysDcmJZvXUX0=
X-Received: by 2002:a17:90b:4a84:b0:2da:8c28:6561 with SMTP id
 98e67ed59e1d1-2e8f107d512mr6777313a91.22.1730038083801; Sun, 27 Oct 2024
 07:08:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALCpNBqfGRh3U6HpJDfUQyLOckz-hRJw2_2GRZfSFqXAyRY12g@mail.gmail.com>
 <3701837d-d9d3-422e-82f2-567a6f832dca@kdbg.org>
In-Reply-To: <3701837d-d9d3-422e-82f2-567a6f832dca@kdbg.org>
From: Christian Sattler <sattler.christian@gmail.com>
Date: Sun, 27 Oct 2024 15:07:51 +0100
Message-ID: <CALCpNBoZfugMQuuDoAELxkipZjYdhznJw3XzuxDC6XGYbJ9=AA@mail.gmail.com>
Subject: Re: [BUG] spurious failure when adding tracked file in ignored directory
To: Johannes Sixt <j6t@kdbg.org>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 27 Oct 2024 at 14:45, Johannes Sixt <j6t@kdbg.org> wrote:
> I cannot reproduce your claim "despite actually adding the file": the
> file is not added. So, everything works as intended. What does `git
> status` tell after `git add`?

Here is the example with modifications before the add.

git init
mkdir dir
touch dir/file
git add dir/file
echo dir >.gitignore
echo content >dir/file

Output of git status:
> On branch main
>
> No commits yet
>
> Changes to be committed:
>   (use "git rm --cached <file>..." to unstage)
> new file:   dir/file

> Changes not staged for commit:
>   (use "git add <file>..." to update what will be committed)
>   (use "git restore <file>..." to discard changes in working directory)
> modified:   dir/file

> Untracked files:
>   (use "git add <file>..." to include in what will be committed)
> .gitignore

git add dir/file  # fails with warning and exit code 1

Output of git status:
> On branch main
>
> No commits yet
>
> Changes to be committed:
>   (use "git rm --cached <file>..." to unstage)
> new file:   dir/file

> Untracked files:
>   (use "git add <file>..." to include in what will be committed)
> .gitignore
