Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E22A1CDFD3
	for <git@vger.kernel.org>; Thu, 10 Oct 2024 18:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728586307; cv=none; b=atks9F63E+qW8lxbAOzMswXfAF6EDAV96XO6jQJ9nYgieF2gYUphU0Ay1XutLQvp6hcPxWzc9MN35vlLuf7zUoMHZ2ygE9ZSlz23uJbNynt1nQSYgs4ldGsrvVFP4CumW/hV/TdJnt590nYyh+dRV+qdlKvDb2ZdHkjQJaBoKUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728586307; c=relaxed/simple;
	bh=SYV0N3VizFUs3Ddq5nuGxwgVfac8IB/Fv1hPiRqoZTQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RMwDuUkAkcirXl43dhhksl/ZmPxtrD9m7OTPv8FGi9i5OQMv1qr4hF+a+oNB3A7INqUROxrK0hUFc7uHC2Cq7UTjXwAYdUKvx4oRQWcDQNu+fZRM6Yqwur6qLU2pXSzHfX+9WPntsLPrkfSBFEkvXwSRonEX4S7NX8tnJ5QdHN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nMHP2fwJ; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nMHP2fwJ"
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2facf481587so10163251fa.1
        for <git@vger.kernel.org>; Thu, 10 Oct 2024 11:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728586303; x=1729191103; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5fgu4nuAYbwfY29xUjZ70tVx8DCOtsVuqPOnUjJfAPo=;
        b=nMHP2fwJz7odV+6aNyIsxlCYyg3rWKgXoBXygC+bkgGzFWzlyJF4eR8t5dSjYwAMB6
         scUmZNgwfsA8ARARn0sUx4u2UsEz61K8z/lHcBkxZShnCLXFCfxClQyNYAoRXyQxqFe/
         RZKJVAjUPlHbOg7FKgJZRLGzdEeC8TAAXS/je/JiFwREciacz0q1D8RV3uNqRJTtFeO6
         F7JAJW7mxaZ3coPt/1PclXzREJ8jV5oJ0pY+MOLgF+5gb9Jua9KI1rlAb9UqJHw2bSLX
         fmS8p48CuexLnIbsHJdlyvKaxeXPo6MhJa6zS1qof4AXcyjdmSFH9ODjqKh9O7FFbiIb
         eHLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728586303; x=1729191103;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5fgu4nuAYbwfY29xUjZ70tVx8DCOtsVuqPOnUjJfAPo=;
        b=bbVQx30VnqOkuyYj9gKQ+/5qoPK0d4kVlBcVGb2yAnXouRLkjwyiWZzTSE+d6V5okq
         ggkeowHn7XJoFfoKyYRZmHL8gIhYAkOLk91tmTLGu+BckG0zyq4fT09LIX7OO7av7ulr
         C/g2SZHK9iXgL12F87FxmUzy/uCaRk+/YU5hyMiippX6Q5VJrLKPiAXNBn3ZDnUu1lcl
         nRA4qpRO3vEP2ta1Btyox5BP4OkBSR8qHV5UdJfLgvCiUfBls2RzGPUyaoVTKV+0hSk+
         ctmKAC/D7pZLWoTIjgLojeNZkdSZ/9TNm6Y33+Z+0tYvTDtPMkXslksDYmMkVSbNVOwH
         M8IA==
X-Gm-Message-State: AOJu0YwrH3V64HJgbshLHwC4YeGqL7ef43L58/T/3zWKYhBw8JoN4gHX
	jTJTWamocF0kv77t4Rxobho5dYNK0zUvCz8CMj1LS+owvuQ3J2QzwNs+NCOf0TwB227PbhR6a8Y
	Zt9rBnXdlwzyn6y6Jg/Zzlp4r
X-Google-Smtp-Source: AGHT+IF4AaZEvYwcTxrtdEMtR9MCedYIpYcrjbLi72sq7y+NjjMm2QxChmK20U4c2PclpL41DcCL01oXN5KtOI5q04k=
X-Received: by 2002:a2e:bc24:0:b0:2fa:d3d8:e991 with SMTP id
 38308e7fff4ca-2fb2f3d1ebemr2560541fa.6.1728586302895; Thu, 10 Oct 2024
 11:51:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241008162117.6452-1-chizobajames21@gmail.com>
 <20241010063906.51767-1-chizobajames21@gmail.com> <90dea722-0762-4a37-a216-6883f4889c67@gmail.com>
In-Reply-To: <90dea722-0762-4a37-a216-6883f4889c67@gmail.com>
From: Chizoba ODINAKA <chizobajames21@gmail.com>
Date: Thu, 10 Oct 2024 19:51:31 +0100
Message-ID: <CACwP9aqEoRchNN-4iuSxrhtt5k-yHMsjmyQjaG9uV4xUsQ7geg@mail.gmail.com>
Subject: Re: [Outreachy][PATCH v2] t6050: avoid pipes with downstream Git commands
To: phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org, ps@pks.im
Content-Type: text/plain; charset="UTF-8"

Hi Philip,
On Thu, 10 Oct 2024 at 15:08, Phillip Wood <phillip.wood123@gmail.com> wrote:
>
> Hi Chizoba
>
> On 10/10/2024 07:39, chizobajames21@gmail.com wrote:
> > From: Chizoba ODINAKA <chizobajames21@gmail.com>
> >
> > In pipes, the exit code of a chain of commands is determined by
> > the downstream command.
>
> I would perhaps say "final command" rather than "downstream command" as
> in a pipeline "cmd1 | cmd2 | cmd3" cmd2 and cmd3 are downstream of cmd1
> but it is the exit code of cmd3 that will be used
>
Yes, final command is a more appropriate explain.
> > In order not to loss the entire result code of tests,
> > write output of upstreams into a file.
>
> We're interested in checking the exit code of git, but not other
> commands so it would be helpful to make that clear. Usman's patch [1]
> has a good explanation of this.
>
I just read that sentence again, it obviously needs some clarity. "In order not
to miss the exit code of any Git command, avoid using pipe and write
output into a file"
has more clarity. I will look up on Usman's patch [1], before my next changes.

> This patch also changes instances of "grep" to "test_grep" so the commit
> message needs to explain the reason for that change which is that it
> gives a better debugging experience if the test fails.
>
I had included that in my "Changes in v2", appended beneath my "Sign-off-by".
"Changes in v2:
- split multiple commands chain on the same line across multiple line,
  for easier readability
- replace "grep" with "test_grep", for more context in case of a "grep"
  failure"
Maybe it was not so obvious that you didn't notice, or it is not the
traditional way of including it.

> The patch is looking pretty good, most of the conversions look correct.
> I've left a few comments below
>
>
> [1]
> https://lore.kernel.org/git/bfff7937cd20737bb5a8791dc7492700b1d7881f.1728315124.git.gitgitgadget@gmail.com
>
> >   test_expect_success 'replace the author' '
> > -     git cat-file commit $HASH2 | grep "author A U Thor" &&
> > -     R=$(git cat-file commit $HASH2 | sed -e "s/A U/O/" | git hash-object -t commit --stdin -w) &&
> > -     git cat-file commit $R | grep "author O Thor" &&
> > +     git cat-file commit $HASH2 >actual &&
> > +     test_grep "author A U Thor" actual &&
> > +     git cat-file commit $HASH2 >actual &&
>
> You don't need to repeat this command now that we are saving the output
> of "git cat-file commit $HASH2"
>
> > +     R=$(sed -e "s/A U/O/" actual | git hash-object -t commit --stdin -w) &&
> > +     git cat-file commit $R >actual &&
> > +     test_grep "author O Thor" actual &&
>
> >   test_expect_success 'push branch with replacement' '
> > -     git cat-file commit $PARA3 | grep "author A U Thor" &&
> > -     S=$(git cat-file commit $PARA3 | sed -e "s/A U/O/" | git hash-object -t commit --stdin -w) &&
> > -     git cat-file commit $S | grep "author O Thor" &&
> > +     git cat-file commit $PARA3 >actual &&
> > +     test_grep "author A U Thor" actual &&
> > +     git cat-file commit $PARA3 >actual &&
>
> We can drop this line for the same reason as above
>
> > +     S=$(sed -e "s/A U/O/" actual | git hash-object -t commit --stdin -w) &&
> > +     git cat-file commit $S >actual &&
> > +     test_grep "author O Thor" actual &&
>
> > @@ -260,14 +291,14 @@ test_expect_success 'fetch branch with replacement' '
> >               cd clone_dir &&
> >               git fetch origin refs/heads/tofetch:refs/heads/parallel3 &&
> >               git log --pretty=oneline parallel3 >output.txt &&
> > -             ! grep $PARA3 output.txt &&
> > +             ! test_grep $PARA3 output.txt &&
>
> test_grep will print an error message the pattern does not match. In
> this case we expect it not to match so we want to print an error if it
> does match. We can do that with
>
>         test_grep ! $PARA3 output.txt &&
>
> >   test_expect_success 'index-pack and replacements' '
> > -     git --no-replace-objects rev-list --objects HEAD |
> > +     git --no-replace-objects rev-list --objects HEAD >actual &&
> >       git --no-replace-objects pack-objects test- &&
>
> This command has lost its input - you need to use '<actual' to get it to
> read output from "git rev-list". This test itself could probably do a
> better job of checking that index-pack does what we expect but that is
> outside the scope of this patch.
>
> >       git index-pack test-*.pack
> >   '
>
> Everything that I've not commented on looks correct to me.
>
Thanks Philip for the review, I will make the needed changes in my
next patch. And look into
the index-pack proposal in a new patch, since it is outside this scope.
> Best Wishes
>
> Phillip

Thanks
Chizoba
