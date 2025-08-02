Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A921F1DFCE
	for <git@vger.kernel.org>; Sat,  2 Aug 2025 17:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754154351; cv=none; b=D502lGRRo3RE6bwWQ40P7cFP4MYTB827u1U6El+yyTbkA7URPIZ+t3xuPWXgOxYZDBVN4oBeensbEkT0wd6VF3ckq3p1CELkRULpcZb03sQXPL0X4ayiYrw1F+AgkYziS4y16GnMhkMH0alsc7MhBik7eCbrsk7bhKqjdZT2peE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754154351; c=relaxed/simple;
	bh=1wCWoAFQt/BOYcF3i1lX56xDo/jBdk9BycWkFMY8mPY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aYSqykxhYKLdLtT1AXD4f88/I93I7KVULfVETtVHYDXuVGaRrQgooSTbTCPhs+r5L73K1rgQKRYL1+dL6Mm5LfuX1cJn6ZAGGzuZaGnByKQBtni2YsKWuK5H6Ejg8tzOF+y6R5E0rFF+osLx97a/R9t6Q79EWIcS67oG8baLbno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gkYT1W1A; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gkYT1W1A"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-af9180a11bcso652426366b.0
        for <git@vger.kernel.org>; Sat, 02 Aug 2025 10:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754154348; x=1754759148; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uEZP/btMCgsBKJtkwc9d8ODtlPxFWh3lbIUTfqJEzPw=;
        b=gkYT1W1AZ3qg6ku/FZ1WSw0j0D1YhxY+3cnN7MxVe8LuI+iMynq4b28UbzJ5ERxS1Z
         H3KbXknu9tg7su8IW+TCCxtKU572N+7A2AVcolXXmd+MkvwVmaCWwtWvFqqmHZyisXrK
         g3sjhXbcXLfIiJ9FP8wDEJe8eHs7BOEyVGnYmRqqnq0PU+wtVY5fZpIdRx1RO6MGl3QN
         qfU7r57h26RDw5SziBVK3WtYZg+tyqiiWul+CuuukBNW3CTg5+w4wZDFkGzDEjXLi5eh
         iw6omVVku6q+Sg1D9aA5zyddpcyXIoXmFBvH5rtPSQlfoHMEuCQW2tGnB0kKuVL1XgGe
         ygpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754154348; x=1754759148;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uEZP/btMCgsBKJtkwc9d8ODtlPxFWh3lbIUTfqJEzPw=;
        b=rt84vpI6TRHGModna42VN632+17N63HM3vYArGrXa8M4GXU0A8hx+d6+SGpc3SqXhp
         XqJhjqh/x97Gs02UnqxWfSUo10z6e6OIStM5dw88dkhVCMUuEMT7YD4wS3UMxy56sreY
         ZrGGMY4xAJ89Dmb7DUffIlVHGbGQT29OVWFDEQbpHkO9NN5sC68NgkvJ06X6WTMc7XIP
         lRQptiNbfmsQWWElQzA9bq+KzpRluU/iUKkBlptKyUVUvPty0wkK+CpRlVuGKGRtD6UL
         2CK8enu93HHjTUFrZG/pPMSPh37kq/1sE9UGoNtARPGp8AhYBlSF4PVrvyLDjm14HIpk
         MwBQ==
X-Forwarded-Encrypted: i=1; AJvYcCXKQj2ge+JnmG2qapb8qD1mL0gRdobg/P0Rrv1JjPPAbDBUSiTdKU763mAGg8SEQ1jr9cc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPJjKvHxEqAa0r7W32HHZQVqH6WDeJTzLiObiNnzUhKg3Bofbj
	2JoJiwlrwB5QSSG07mbqiHExGgtCu6sfMFtZcyhm3W/yrCoH4zLNVuusR9HVmW4IzqY/KZaX0TM
	hyNDvA2vECY5yUcZQTn6Eg8MiMzBtlJ4=
X-Gm-Gg: ASbGnct1JadfoeAD+70tQsr48Qm7SDSeHxM7bpjG+Sh3l460+Uwg5gSVla9Z0gcVpsG
	bWbjwx5qrIvw4kwuHajuOk7insM8bfzqPjgOsmV1ONuw6WuQ2NYN+FgwZosS+l1YCuVknXSNBT+
	rNvrjdfjPpfMcTuIbqPyRlYdXbFcK0Bo0D5A+j8tsl/DZ+VmZ1gfo7EXcFcTYhj/1acHSTw2b8d
	GfU9kNSLVQgE/bO4vSKW76YeiCd/ykWblbRaKe+3A==
X-Google-Smtp-Source: AGHT+IFz22JRsT8Dx3meFi3iqE89qn+Dcwip/Sc0CkfkMgJmkuMIs31+C5/E8ij3dW9449cPBaK6e0Jkt56L9el+XTk=
X-Received: by 2002:a17:907:72c6:b0:af9:5b51:2e6d with SMTP id
 a640c23a62f3a-af95b513153mr80436766b.0.1754154347620; Sat, 02 Aug 2025
 10:05:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250726165320.4039-1-ben.knoble+github@gmail.com>
 <20250726165320.4039-5-ben.knoble+github@gmail.com> <xmqqms8qzdd0.fsf@gitster.g>
 <CALnO6CAbTjuFrLbhC24VDmdy4Utx29g92M5eYV9BPahXK+o+1A@mail.gmail.com>
 <20250802092331.GA3721454@coredump.intra.peff.net> <CALnO6CD_=ksmXrzS-k5rQukYcMSDLm0HSLZ35xP-Y1neKc70Xw@mail.gmail.com>
 <20250802162845.GA1203943@coredump.intra.peff.net>
In-Reply-To: <20250802162845.GA1203943@coredump.intra.peff.net>
From: "D. Ben Knoble" <ben.knoble+github@gmail.com>
Date: Sat, 2 Aug 2025 13:05:34 -0400
X-Gm-Features: Ac12FXyzqnJNbszzcK2G2BitHXHfRobqLTGmrMNN7m1nDoVk78Ne11wOsWW_l-E
Message-ID: <CALnO6CCWo6t-SX22XZ62k8jrGdH0gxC=w6B9D=6BB1iLEyc1AA@mail.gmail.com>
Subject: Re: [PATCH 4/4] builtins: show help on "-h"/"--help-all" with more
 than 2 arguments left
To: Jeff King <peff@peff.net>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org, 
	Elijah Newren <newren@gmail.com>, Lessley Dennington <lessleydennington@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 2, 2025 at 12:28=E2=80=AFPM Jeff King <peff@peff.net> wrote:
>
> On Sat, Aug 02, 2025 at 12:10:17PM -0400, D. Ben Knoble wrote:
>
> > >   1. You didn't touch this spot in the parse-options code. Would you
> > >      need to for it to be consistent with the non-parse-options calle=
rs
> > >      that use the if_asked functions?
> > >
> > >   2. We can only get here if we make it past the help check in
> > >      run_builtin(), that you do modify in your patch. That works for
> > >      git-grep because it does not use RUN_SETUP, and calls
> > >      parse_options() before checking whether we are in a repository.
> > >
> > >      So in run_builtin() we do set "help" to 1, but it does nothing
> > >      without the RUN_SETUP flag. But imagine a hypothetical git-foo t=
hat
> > >      takes a "-h" option and does require a repository. It would set =
the
> > >      RUN_SETUP flag, and then:
> > >
> > >        git foo -h bar
> > >
> > >      would show the help before we even get into cmd_foo() to parse t=
he
> > >      options.
> >
> > I think I need to consider both questions in parallel: as you point
> > out, this patch probably doesn't work for a hypothetical command that
> > both needs a repository and has a "-h" option. (I note that ls-remote
> > also is RUN_SETUP_GENTLY, like grep). Since no such command exists
> > today, we /could/ take some version of this patch and refine later if
> > a command needs both RUN_SETUP and a "-h" option. Or we could reject
> > this patch (assuming there's no workaround for now). Given Junio's
> > concern, I'm inclined to just drop the patch from the series=E2=80=A6
> >
> > =E2=80=A6which moots question 1, I think. OTOH, if we keep the patch, i=
t does
> > seem like we might want the parse-options API to be consistent.
> > Fortunately, I don't think this area needs adjusted for 3/4 based on
> > the tests.
>
> I think I mostly share Junio's concern. The issue is that we want to
> detect the "user is asking for help" situation without having access to
> the option-parsing information for the actual sub-command. And so our
> strategy has been to make the rule for triggering "asking for help" to
> be fairly conservative.
>
> If we loosened it now, even though it happens to work for all current
> commands, we'd later potentially have to re-tighten (which is awkward)
> or start carrying extra signals back to git.c (e.g., a HAVE_H_OPTION
> flag).

Sensible. Will drop.

>
> > > BTW, I applied your patch 4 manually to dig into this. I wasn't able =
to
> > > apply the whole series. It doesn't go on top of the current 'master',
> > > and applying with "am -3" mentions "sha1 information is lacking or
> > > useless". Did you build this on some other unpublished series?
> >
> > The base is published and mentioned in the cover letter [1]; if I can
> > make that more explicit in any way going forward, please let me know!
> >
> > [1]: https://lore.kernel.org/git/20250726165320.4039-1-ben.knoble+githu=
b@gmail.com/
>
> Ah, hmm. I was trying on top of ua/t1517-short-help-tests, which still
> fails. But it works if I merge that branch to 'master'. I guess that's
> what you meant by "Merge that branch to a new topic branch".

Ah, yep, that could be clearer (and it didn't occur to me that basing
on a merge would cause application issues relative to basing directly
on the branch). If it helps, the graph I have is pasted below (but
beware GMail whitespace munging?)

    git log --graph --boundary ^origin/master @

* 3099d83cdf (HEAD -> help-all-tweaks) builtins: show help on
"-h"/"--help-all" with more than 2 arguments left
* 352fe87c80 builtin: also setup gently for --help-all
* 56665594a8 parse-options: name flags passed to usage_with_options_interna=
l
* 852a4547af t1517: fixup for ua/t1517-short-help-tests
*   14c7e9dddd Merge remote-tracking branch
'broken-out/ua/t1517-short-help-tests' into help-all-tweaks-tests
|\
| * 344c7067e6 (broken-out/ua/t1517-short-help-tests) t5200: move
`update-server-info -h` test from t1517
| * e552926bc4 t/t1517: automate `git subcmd -h` tests outside a repository
| o 16bd9f20a4 (tag: v2.50.0) Git 2.50
o | e4ef0485fd (origin/master, origin/HEAD, broken-out/master,
broken-out/HEAD) The fourteenth batch
 /

I've also (now) made the series available on GitHub at

    https://github.com/benknoble/git/tree/help-all-tweaks

>
> -Peff
