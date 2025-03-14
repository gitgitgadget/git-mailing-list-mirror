Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B54D71FDA9C
	for <git@vger.kernel.org>; Fri, 14 Mar 2025 22:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741991304; cv=none; b=m5no9IlxVZ4caSPWnN4eoSASwBRHrzG3g29lLahMH6B7seqC6s2gK8cac7SgF5I1xQG6YUJverZIQL6QBtmWWQzJuBqGjVzgnscoP+wDA5XEs7aLgtdqKd8wAy0f6Xiub4fvu7yCKAjEvopV89DHUAOL2MT6vG6EJANX9XxzWl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741991304; c=relaxed/simple;
	bh=6xm9JQdEd5ZcTCQWB+r7O3zjILDDI1a5mEnKwlkEkZM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=du7O7c+40NNxkpneAH3DYcvSpe2mswwQY+xjx8ce6gIGi9NRmZo6VlVvmawKvX0C5vkJiJi8D3eYfqYlw8cX6j4+BbGb8dcJO/OZ5HROPpGGmJ5zSOmENt7/6HCjKVf/d4BGFhKEYMYL/tkOAqqDdJx7piiCUJwB2b07jEUeyzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NFmiQB5c; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NFmiQB5c"
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-85afd2b9106so230927239f.0
        for <git@vger.kernel.org>; Fri, 14 Mar 2025 15:28:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741991301; x=1742596101; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6bI21HP/jbtx8DBYj6USMDzjUBmcX3iRJbYNoqK+NOU=;
        b=NFmiQB5cKEcCD82tskN1+84ESf/nKRf7D3Jy7Jwkbw3Mqsy66w1c44+Oo7r34NVwDo
         kwCYkUHpAY7yHOAB+u2SQMUxVJ6b6+M93Yee8qUrcVdJgNSEnQr0yQGZzgi4m9Vft90m
         nZDz22xFfLzg6hK5/77MO6DTonj31h3jLN4Y36yGyWA/RyQa5Hj3dCURzyX/PaReBUuh
         ye9qUrBYYE9neoKoxGMoE2AkvrTE1/Plm45lIMaaEQsmEZK5AYnssySUeTDpbgL2OQaV
         CzeSLNeZ+3+BPuw/liv9SvzDSFnV089acvjQYTjhKwMlLXU6IMiIlhcttqdjxSjoprCW
         GyOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741991301; x=1742596101;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6bI21HP/jbtx8DBYj6USMDzjUBmcX3iRJbYNoqK+NOU=;
        b=bTJ3D+BNKP7w8XnSHbp5JnIhuGLlU3zha87pTDaiZXwZy1nwkMUvt+uuEQafTBqc8b
         m4a+iSfG2fFEf32cbx3s70mOzM5zxgkpfxKDu43pVezSIp3pKufSW6YOzA1b63U2p9pH
         kc5RO7GRrOJOTIzJg8IT1mD/df4KHFIT2FEl3jGS5qrcC3tSB4Ey5zkE5WF74Yg4WqIg
         8N2Op3xo2AvhyaKegDZ+bIzEzeCRcMawSXJ4pcTufRtccoosq79yztxqgwzz/eacuqPQ
         cdrrZQMM5N62pBDFsX+6FjRp3ELhglrczTk8JFYKgTND5+XBYNtSdJ3IyZ9FgO8bZ0Ds
         zGOA==
X-Forwarded-Encrypted: i=1; AJvYcCXfHcKrf11mR/0Ty/WfFZ4X++XL4p6kNi1ktrcqtFGPJnYluXdd4Gw/qZ5o8dUbhHq3pOs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjJNJYuhK3BxLGHoRTZf48mJ6kyQvwsj7d8j8/msClWCIc/VkG
	ID0fJJYU+x8DSIafedrxF3IziCzjrrFJyPcaMtY7m9mOmVggUzZOJ1429p7BfJ3fha+uPVGOPCy
	fzqjed20jZ0QZ+CC6yW2d4xoIZgY=
X-Gm-Gg: ASbGnctRt5qdPu7fagqR1NBuPIc3mSUW2KiiQAIYo8qzVDJ+iby0vif+DNRww3tIuIx
	LIzFUBZI95HnhEDV55XcRMLO9NlRh+04WgUyyT8ux0UAJ+2bIuiKIlI5sfjW1WydkLSL6qnv8rw
	QeM50Wiq50EAP/r7ScTn1tTmXkzSY6K8rt+s+TRHp+4OblYZRDcvKOf//egMw=
X-Google-Smtp-Source: AGHT+IGGZnXeet8RaUcnTQRSqqbMilGrjsnRhlFXBzXscCAOPOkQ6cRKHRViGMjij4EzAd+HX//0DcTfxI/70P2ct3U=
X-Received: by 2002:a05:6e02:3312:b0:3d4:3aba:e5ce with SMTP id
 e9e14a558f8ab-3d483a906ffmr45424055ab.20.1741991300994; Fri, 14 Mar 2025
 15:28:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1876.git.1741395615315.gitgitgadget@gmail.com> <20250314172437.GA16311@coredump.intra.peff.net>
In-Reply-To: <20250314172437.GA16311@coredump.intra.peff.net>
From: Elijah Newren <newren@gmail.com>
Date: Fri, 14 Mar 2025 15:28:09 -0700
X-Gm-Features: AQ5f1Jo9fc38ccVkpChRC6taR4sJzFrOKijWIzKwUB4e6x6stjPXCu5ssTkZImg
Message-ID: <CABPp-BF5R_ob5uAS=m9Vt775-Er2fFqpH7jBjm_=MRmnRVbeew@mail.gmail.com>
Subject: Re: [PATCH] diffcore-rename: fix BUG when break detection and
 --follow used together
To: Jeff King <peff@peff.net>
Cc: Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 14, 2025 at 10:24=E2=80=AFAM Jeff King <peff@peff.net> wrote:
>
> On Sat, Mar 08, 2025 at 01:00:15AM +0000, Elijah Newren via GitGitGadget =
wrote:
>
> > It turns out that making a testcase to trigger this is a bit challengin=
g
> > too.  I added a simple testcase which tickles the necessary area, but
> > running it normally actually passes for me.  However, running it under
> > valgrind shows that it is depending upon uninitialized memory.  I
> > suspect that to get a reliable reproduction case, I might need to have
> > several more paths involved, but that might make the testcase more
> > difficult to understand.  So, I instead just embedded a warning within
> > the testname that the test triggered uninitialized memory use.

Maybe I should have been a little more clear about "a bit
challenging".  I spent hours on it.  And I suspected that the only way
to trigger the reporter's particular manifestation of the issue was to
use an invalid command.  I didn't want to spend any more hours on it,
but...

> I think it's OK for a test case to require extra memory checks to fail;
> after all, these kinds of bugs are usually non-deterministic without
> those checks anyway.
>
> I did verify that it reproduces for me with "--valgrind". I was
> surprised (and a little disappointed) that it doesn't seem to trigger
> with ASan/UBSan. We do run those routinely in CI, but I doubt that
> --valgrind gets used regularly for the whole test suite by anyone these
> days, just because it's so much slower.
>
> I'm puzzled, though, why the test case at the beginning of this
> thread[1] yields the BUG() so readily, but your test case doesn't.
>
> So maybe this is the best we can do, but it feels like we should be able
> to at least trigger the existing BUG() reliably. I couldn't seem to
> figure it out, though. :(

So, after _another_ 7 hours or so on it today...  The BUG() the
reporter triggered only happens when there is no uninitialized memory
use, and is only triggerable when you use invalid flags.  For the
reporter, they passed a directory name for their pathspec along with
--follow, despite the fact that --follow only works when given a
single pathspec that names an individual file.  You can also trigger
their particular manifestation of the issue here when using a glob
pathspec together with --follow.  In either event, the --follow
becomes useless: when the follow logic checks whether filenames are
equal to the given pathspec to see if it might be a relevant rename,
no filename is exactly equal to the pathspec, so it never finds any
relevant files to follow or to include in the rename detection.  The
upshot is the command basically behaves the same as if you hadn't
given --follow, other than the fact that the presence of --follow
makes diffcore_rename throw away rename_dst pairs in a way that
happens to trigger this particular BUG().

The testcase I found is:
    seq 1 127 >numbers &&
    git add numbers &&
    git commit -m "numbers" &&

    printf "%s\n" A B C D E F G H I J K L M N O Q R S T U V W X Y Z >pool &=
&
    seq 1 10 >numbers &&
    git add pool numbers &&
    git commit -m "pool" &&

    git log -1 -B --raw --follow -- "p*"

The BUG will still be triggered if
  * you change the content of pool (you can even make it as similar as
you want to numbers)
  * you change the content of numbers in the second commit while
keeping it sufficiently different from the first commit
The BUG will _not_ be triggered if:
  * you change the log's pathspec to match numbers
  * you change the log's pathspec to not match pool
  * you change the log's pathspec to be exactly "pool"
  * you remove any of the three files (two versions of number and one
of pool) from the testcase
  * you reduce 127 (even if only to 126)
  * you make numbers from the second commit too similar to numbers
from the first commit

In all of these cases (and this is also true for the reporter's
original case), in locate_rename_dst(), idx will be computed as 0, but
rename_dst is NULL, so &rename_dst[idx] is NULL as well.

However, I think the fact that rename_dst =3D=3D NULL implies
&rename_dst[0] =3D=3D NULL should raise alarm bells about the risks of
using memory improperly, even if it doesn't directly use uninitialized
memory in this case.  Which brings us to the bigger more encompassing
issue, which is what I reported in the commit message:

> > In short, when these two rare options are used together, fix the
> > accidental find of the wrong dst entry (which would often be
> > uninitialized memory just past the end of the array), by adding a littl=
e
> > more care around the recorded indices for break_idx.

It's just the special case when rename_dst is empty and, in fact,
NULL, that you trigger the BUG() call.

> Your description of the problem and the solution both seemed sensible to
> me (though I'm not all that familiar with the ins and outs of the rename
> code these days).

Thanks.

>
> -Peff
>
> [1] The simplest I came up with is:
>
>       git clone --bare https://github.com/intel/linux-sgx.git tmp.git
>       cd tmp.git
>       git --no-pager log -B --follow 63d0e65cfa49bb46a8dbe8745bb15aaf226f=
aa97 -- external/ippcp_internal/inc

Yeah, that was the same I was using last week.

>     Curiously, that pathspec is actually a directory, but it only has a
>     single file in it. Feeding the actual file in it _doesn't_ trigger
>     the bug:
>
>       git --no-pager log -B --follow 63d0e65cfa49bb46a8dbe8745bb15aaf226f=
aa97 -- external/ippcp_internal/inc/ippcp20u3.patch

Yeah, I was doing the same thing last week when fixing this bug.
Sorry, I guess I should have mentioned this to avoid you attempting
the same.

>     That just shows the single commit (even though there is a single
>     file before and after that commit, it is not similar enough to find
>     a rename).
>
>     The file that hits the break detection is unrelated. It looks like
>     it's psw/ae/data/prebuilt/le_prod_css.bin.
>
>     I tried variants with break files, subdirs, etc, but I couldn't seem
>     to make anything work.

Maybe what I wrote above helps.  Is this enough information to satisfy
your curiosity?

I suspect adding this second test to the commit makes sense.  Which
parts of my explanation in this email would you like to see added to
the commit message as well, or is it fine as-is?
