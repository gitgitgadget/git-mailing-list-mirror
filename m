Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C97122B594
	for <git@vger.kernel.org>; Thu, 15 May 2025 16:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747326480; cv=none; b=LwOS68RC59VEkXnvWmEON9FmVG28C/XhE6Kwn19lUz+2+RuCRa3WUZNm1bpDtwtOxQou5fLhpMkcDNfj/PiLgtQGGsYHwgQ28luSN40dlGKpGFaNB36NZ/Zxi6AE0ULcqsVmGlix5dTUcs4C1ncY6ix1/qYrp6d82p10eWEhy1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747326480; c=relaxed/simple;
	bh=8EU1AM/2O5zY5zgA6DIdoIDUZ4Zi266UGcU7p21v5tg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XUA+P3Nl0VEU75xMUZpEq6OkGyu3UYbLdGBqRPL2bSFNfQ0lNH2Ns6Mo7yk0Ez6Vh2ZQeVt+kJKMzTBSSP5YpDpEKu1/5sXVhaJMskQXw/dd0hZr4DewQzFZMVa7j967PIf3ailXrfeXrWv3Xf7GHT0RE8V7lczHtb+8QnZGUtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PuYHNgNG; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PuYHNgNG"
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-7311a8bb581so1108571a34.0
        for <git@vger.kernel.org>; Thu, 15 May 2025 09:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747326477; x=1747931277; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6xxi19tQ/Gd0vucQB5YX2RiKSEdD0ExzJJFlSIQao1M=;
        b=PuYHNgNG9XPyshp83zAhULJMhq22IFtG+wvsPlYOAPJcvEM876rBMa4pc099A4zkcI
         xqO3rdHAGxmxdIikU9T3WzEYgNCF5GuQkL/2E8ENoQQj1nd5IGOWhHaxLUCQwB/bSLda
         FgiExDCUYkJ5tMmzcolXNQ4yxDpqNalrnLAidtqU7yAHZUZ0e0a60CNswsNI5Nk+jY7s
         1F0K90rDIzWEiFKczBTZ7dMZfYL71ZQnkOF71t4bvRHn5ydZdfmEiAuLC2Q3lwFcP61o
         5iegdBJtAUzhRWJUptWNtbC4rGJUcRm6m6H7tjUQbpl3ghHb//Av9CA8azPqT57Hf4Gi
         N7mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747326477; x=1747931277;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6xxi19tQ/Gd0vucQB5YX2RiKSEdD0ExzJJFlSIQao1M=;
        b=BKkO5xeaagfCmCPnI1Tx8pzn08SxWd0Jrp6WroElHPEoSuOKFHhJVOWmIGwFCGKa8Y
         rKzRm/4fCh+4K85TDw7r5TDnvI18DDmvh9cbonJpAGSmDOEzzt5yAQwj7KhixKATl4tH
         zP6Kmeq2syX8JXHclvVLeCsYmLY5/BIxNYAdW3q3uGJs2+QMUV9l78A9D4rjIkw9bi1g
         AAUID53/aBk/ow8hjMNAGGNobw+wD+6vLdCLj8JXjGGXMyvZ/JQOzY/MCs78g5tAQUyu
         DCDNTd+zisgku2XB6akMtjJlYYWU3Py345sml33dLu67yYFiMysOmbWd0klxEXRKo8Cs
         klHg==
X-Forwarded-Encrypted: i=1; AJvYcCXmWB8bR7Q7pHz4muy5ZF24xoInpogv4TTnKzyZGs0OqXmW7ps/SfQhtIfeVELIjKs29H0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUtSfWSJhYxJ06etjVW4YRYF5L5zaguZjAZUhxy2v3XLjiKDgu
	DP49Hn/nNZLI7F2N8MOmoBgEbejFtV4aorcdSLmwlo/wyz0vv4PQ0roL9OiiJBMc/Ri4lVxYtwe
	QHsBTBvhyWWQF2Ja3hcVQDq+PEy8mvp8=
X-Gm-Gg: ASbGncsBGFO6JWNv5NvwyrneXzuD6m8Q2uBSI9Xo22EnDdMHBdnNJ+5vL3JuaVXvpK9
	3Rt1lE+XEO0CXmXCLDVnrCkWPaiFxvSgrltquz+Kgt+uD1dvC2sdk8l0CPQAfIHLQFKC4yIpsDG
	Rxhw3yCfjuuWQr/zJwEMR+Z5kVTtdPeXf3cQ==
X-Google-Smtp-Source: AGHT+IHVpHNwgyxFWSJbB8mn4mTHmHJf2d0iolTgMnWVMyKFLn0LVltYb0mL2D95UXevpfItReegkYq1kz7FWDsBDdI=
X-Received: by 2002:a05:6871:62c5:b0:2d8:957a:5165 with SMTP id
 586e51a60fabf-2e3c1c7f606mr74476fac.17.1747326477248; Thu, 15 May 2025
 09:27:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250514204014.3106177-1-jacob.e.keller@intel.com> <xmqqzffe7vbh.fsf@gitster.g>
In-Reply-To: <xmqqzffe7vbh.fsf@gitster.g>
From: Jacob Keller <jacob.keller@gmail.com>
Date: Thu, 15 May 2025 09:27:45 -0700
X-Gm-Features: AX0GCFtuDhv4RBZpMs7_a66X6v9RdF9vJy4DpBrThNFeRyBrhFhzxsxQ4J1AMvk
Message-ID: <CA+P7+xqg3S0q=n3nrTUJJuYicooDm83Q32AkpzRt1u7rH3n3Pw@mail.gmail.com>
Subject: Re: [PATCH RFC] diff --no-index: teach option to exclude files by pattern
To: Junio C Hamano <gitster@pobox.com>
Cc: Jacob Keller <jacob.e.keller@intel.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 14, 2025 at 2:10=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Jacob Keller <jacob.e.keller@intel.com> writes:
>
> > From: Jacob Keller <jacob.keller@gmail.com>
> >
> > Teach git diff --no-index the ability to exclude files by wildmatch
> > pattern when recursing through directories. The '--exclude' option
> > builds up a string list containing the patterns. These are checked with
> > wildmatch() in the read_directory_contents function. If any pattern
> > matches, then the file is not included in the directory contents.
>
> A quite natural question that comes to mind is:
>
>     How would we do this for the normal "git diff" that is not the
>     bolted on '--no-index' mode?
>
> but ...
>
> > The --exclude option is only supported by the --no-index mode. Standard
> > diff modes support negative pathspecs which is more powerful. I tried t=
o
> > see if there was a way to add support for negative pathspecs themselves=
,
> > but haven't yet figured out if this is possible.
>
> ... of course you have thought about it already.  I do agree with
> you that we should figure out how and teach this mode to also use
> pathspec, not necessarily only the negative ones but positive ones.
>

Sure, though I think we might need either an option or some other way
to distinguish pathspec vs the existing non-pathspec mode.

> After all,
>
>     $ git diff --no-index [<option>...] dirA dirB
>
> is like running
>
>     $ diff -r [<option>...] dirA dirB
>
> after preparing these two directories like so:
>
>     $ git archive revA | ( mkdir dirA && tar Cxf dirA - )
>     $ git archive revB | ( mkdir dirB && tar Cxf dirB - )
>
> Hence it is natural for users to expect that anything you can do
> with
>
>     $ git diff revA revB
>
> should be doable, in
>
>     $ git diff --no-index dirA dirB
>
> and vice versa.  And as you said, when comparing two revisions,
> you'd use pathspec for this kind of thing.
>
>     $ git diff revA revB -- Documentation/ t/ ':!po/'
>
> So, I pretty much agree with the need to be able to exclude some
> parts of the tree(s) from comparison in "diff --no-index" mode, but
> I doubt it is a good idea to tell what to exclude the "--no-index"
> mode in a completely different way.
>

Right. My main issue was that pathspec seemed to have a bunch of stuff
baked into assuming it has a repository.

> The last time I looked at it, I got an impression that the command
> line argument parsing of "git diff --no-index" was messy (which is
> sort of inevitable, since unlike the normal "git diff", it can
> compare more than just two "collections"---it can take two paths to
> regular files, for example, and in such a case pathspec arguments
> can play no role), so teaching it pathspec parsing might be a bit of
> work, though.
>

Right. It currently requires finding two paths to compare, and some
DWIM logic to make directory and file comparisons work.

pathspec capability is about specifying which things to include or
exclude from a given search. Hmm..

Actually, I think I have a path forward:

we teach git diff --no-index to treat the first 2 arguments as they
are now: pointers to the things to compare.

We check if either or both of those are directories. If they aren't,
then additional arguments won't be accepted.

If we have at least one directory, then instead of rejecting commands
with >2 arguments, we interpret any remaining arguments as pathspecs,
which apply to any directory path provided. These can limit the search
when scanning through a directory, so both positive and negative ones
would apply in the same say.

I guess the one weirdness is that pathspecs must come after the first
2 arguments, since we need to find 2 paths first. But this matches the
way that treeish must come first in git diff-tree -r takes treeish and
then pathspecs, and you can't re-order them arbitrarily either.

Does this sound like a reasonable extension to the existing 2 argument
form of git diff --no-index?

> Thanks for starting an interesting topic.
