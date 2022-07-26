Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 719DAC433EF
	for <git@archiver.kernel.org>; Tue, 26 Jul 2022 07:32:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238441AbiGZHcC (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Jul 2022 03:32:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238446AbiGZHbV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jul 2022 03:31:21 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4979B2A961
        for <git@vger.kernel.org>; Tue, 26 Jul 2022 00:27:45 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id z18so10083752qki.2
        for <git@vger.kernel.org>; Tue, 26 Jul 2022 00:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I6LaVFPK0RKfNfm+oC3vtvrg1070vj9Qx9m/doR8o/w=;
        b=NVyyCTPGelIiOmtXFu+R6xP9I2E/jJQDbzvFcgiaqrt047VuNPcIoNScrtyEptZtJR
         NN3PgGcTmoiGcU8IJjUsQDpj1vQhN4akeZX5pjodG24Djrwe3pHeOvq3umXRFEoSUrQc
         ud1GEQDeB61dv6wjwERrPQwk/7AdbaQbZKvZeJ/XGTzuqasBo6+gc2SRoyyVBo0Xbfxp
         T6PZ2JbhYeZO+KYCOpPLEk4q9e/cRy42+kkAXMgmqTgGtfDakKvJUXa96Oxi1UGjoOpK
         iSBYNqJVMuK/E+IdrHGvDo25UfyImGokDeBQCwvcfDR9rSFNCkndh/938Yw1u2TbxZ4t
         A/3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I6LaVFPK0RKfNfm+oC3vtvrg1070vj9Qx9m/doR8o/w=;
        b=CUiDAJxtBv7my2XHRgdTZHlYOOap258gFEWlhIC39i/ujax8kNcXi+vqKV+mJ5MGLF
         hICoz1hGpBS/+2J7fZsfCo3pj3NrFxCpxZTGzjqGCkestgOd8HxIk9u9orzEaR3C+qMI
         j/X2md7PXtVbTVpuSSiuxD4JkKyUrBF/LbQB6Di1Nd/IT/cAGRo1/s/c8aS+EcPygPJE
         pG8OESHdV0XIg0wex5x/clYtQmkLWKTEBJPW0dQK0xh+d/pw+Azlfyk7nlJfueGc5lRl
         yeMYygL9BY/Wa3P0LuYp4NpEoo2JW7jpgjvkMrrwxE/aUD3C+PAvZZxjX07bQ2s3IodQ
         Ea6g==
X-Gm-Message-State: AJIora/zxzexZJC0LqI3d6Eu3tm/6VaTT1Pz72Hk5J2FvpdVycv7+QO5
        4wTm0REYjWZZxWwjGwIJ2ocynKsWdlC2jgYyHNqlaGm9YaA=
X-Google-Smtp-Source: AGRyM1vqjkeAWETXyLr59TShX553G0Q2o11tXRA9E08ML7OrbTOwnoUPPEh/48WoVJbdFm55B0JI8EuvJ1IdGuv4ZVg=
X-Received: by 2002:a05:620a:754:b0:6b5:eb92:42e5 with SMTP id
 i20-20020a05620a075400b006b5eb9242e5mr11747833qki.183.1658820457854; Tue, 26
 Jul 2022 00:27:37 -0700 (PDT)
MIME-Version: 1.0
References: <CAJ6X7_UNOMusKKbFzS12DRhrOkVXAEgED8djA2kxjfFmbv4GwA@mail.gmail.com>
In-Reply-To: <CAJ6X7_UNOMusKKbFzS12DRhrOkVXAEgED8djA2kxjfFmbv4GwA@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 26 Jul 2022 00:27:27 -0700
Message-ID: <CABPp-BFFir4iM1y3=Fjfcj3OVT0sgSW49796aKvTNWbWoK+LGg@mail.gmail.com>
Subject: Re: Pre-computed similarity indexes
To:     Philip <philip.c.peterson@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jul 24, 2022 at 7:29 AM Philip <philip.c.peterson@gmail.com> wrote:
>
> Hello all,
>
> I noticed that Git LFS-tracked files cannot correctly detect renames,

"correctly"?  I was expecting you to say that it just wouldn't detect
renames at all for LFS files.  Does the wording of your question imply
that Git is detecting LFS files as renames that aren't actually
renames?

You got me curious.  It appears the LFS pointer files are three lines
long (unless I'm misreading the spec; I have virtually no experience
with LFS).  The first line appears to always be the same for practical
purposes, the second line holds the hash, and the third line holds the
real file length.  What counts as far as rename detection isn't the
number of matching lines, though, but the number of matching
characters from matching lines.  So if one pointer file had e.g.

    version https://git-lfs.github.com/spec/v1
    oid sha256:4d7a214614ab2935c943f9e0ff69d22eadbb8f32b1258daaa5e2ca24d17e2393
    size 12345

and you have another that looks like

    version https://git-lfs.github.com/spec/v1
    oid sha256:aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa24d17e2393
    size 12345

then, since git splits lines into 64-byte chunks, then our "matching lines" are:
    version https://git-lfs.github.com/spec/v1
    24d17e2393
    size 12345
(for a total of 66 bytes, including newline characters), and the
"unmatching lines" are
    oid sha256:4d7a214614ab2935c943f9e0ff69d22eadbb8f32b1258daaa5e2ca
    oid sha256:aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
(neither of which has a trailing newline)

The longest of these two pointer files is 130 bytes (actually, both
files are 130 bytes).  Since the matching bytes from matching lines is
66, we check that 66/130.0 > 0.5, so Git will consider this a rename
using the default similarity threshold of 50%.

So, for LFS files to be detected as a rename, the real file size has
to be at least 100 bytes (so that the real file size has at least
three digits), the real files have to be the same size (e.g. in our
example they were both 12345 bytes), and the last 10 hex digits of
their sha256 must match.

The first condition is probably trivial to satisfy.  The second is a
little unlikely, but it's pretty easy to imagine random matches.
However, you'd have to have an awful lot of LFS files in a repository
before there's any realistic chance of meeting the third condition,
though.  Somewhere on the order of a million of them (based on
birthday paradox approximations) -- all with the same underlying file
size on the third line.  (Or, if you had lots of different underlying
file sizes, then dramatically more LFS files would be required to get
a collision.)  Given that each file is large, that'd have to be a
ginormous repository if fully checked out.  So, is this actually an
issue in practice?  (Perhaps there's a risk of a dedicated disgruntled
employee generating trailing hash collisions just to make git log show
misleading rename output for LFS files...but if so, that seems pretty
tame for the amount of effort put in?)

Or did I read too much into your "correctly" wording, and were you
simply not getting any LFS files detected as renames despite knowing
some of the underlying large files are actually renames?

> probably because Git is not doing a similarity check on the content.
> Doing so would require having the content (instead of just the LFS
> pointer), and that would require running the smudge filter, which
> could take a very long time due to network requests, very expensive if
> done on every file in the repo.

...and it probably wouldn't return meaningful results anyway since the
'L' in "LFS" stands for 'Large' and Git's rename detection only works
for small to medium sized files.  (I mean, it'll technically operate
on large files, at least those smaller than core.bigFileThreshold, but
the quality of its answers degrades linearly with file size until it's
essentially meaningless at about 8MB...with the exception that it does
notice that files with dissimilar sizes can't be renames.)

> When doing a `git log` for example, it
> would need to run the smudge filter on all LFS files in all revisions,
> potentially pulling down all the content from the LFS server, just to
> decide if there were any renames.
>
> I wonder if there has been any thought given to whether a similarity
> index can be pre-computed somewhere? (Maybe upon commit with each of
> the commit's ancestors.)

Computing for each commit relative to each of its ancestors would only
help with 'git log'; it wouldn't help with
diff/merge/rebase/revert/etc.  If you want rename handling it to work
in general for these files, you'd have to precompute it for each
commit with each other commit in history.  And for it to be reliable,
you'd have to update it with every new commit.  That'd make `git
commit` take time relative to the number of commits in history.  It'd
make `git pull` and such take an amount of time relative to the number
of commits in history multiplied by the number of commits being
downloaded.  And, of course, that "relative" consideration in both
those places includes a factor scaled by the average sizes of the
large files being compared, so the "constant" is pretty big too.

> Or if this limitation has been discussed
> before here.

I did a quick search and didn't see anything.  However, I have thought
about the idea of precomputing similarities in general before, but
realized that it ends up just shifting performance problems elsewhere
and quite likely making them worse overall.  So, I think you'd need a
different solution of some sort here if you want rename detection for
LFS files.
