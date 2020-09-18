Return-Path: <SRS0=7xvA=C3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC918C43463
	for <git@archiver.kernel.org>; Fri, 18 Sep 2020 16:35:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A01E20872
	for <git@archiver.kernel.org>; Fri, 18 Sep 2020 16:35:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rFGjmfwn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726367AbgIRQfC (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Sep 2020 12:35:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726311AbgIRQfC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Sep 2020 12:35:02 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC7C2C0613CE
        for <git@vger.kernel.org>; Fri, 18 Sep 2020 09:35:01 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id w3so5609077ljo.5
        for <git@vger.kernel.org>; Fri, 18 Sep 2020 09:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7SFfU6Bs3EYfWmAZxudGpnH1Jx+SUGAX8guF8Ut5d/o=;
        b=rFGjmfwnRZEgqM5O7CosmQq+bez3CdJysopwbLa2/tjPY4Cl9fbCoREp1FFJnyLTKL
         Vt8ycC2GofkpwD2d9zf+6hDX4G1dxF/R5rQrkpY6hamn7cY3BtcXoi95NsLI57mklnsZ
         8RdsJ0SH+PdRWiW3lgPFMEeLpg2HcJmFuui5Qk7Ij+HXnnbsxz0gH2ufheLiwqviIfln
         UIjkdMFeMGRH1NylyOsa+Z76J2TZc6uMUdYUSYdBwqpX2bcCDCae+RSyBdolPpgxA87n
         pgEqrglCsa3J9mPSZf6ZGSz1A7iUumBLCX0NJ41NMYlWe1Wda/NtQebpu7QatU0orGIW
         v8uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7SFfU6Bs3EYfWmAZxudGpnH1Jx+SUGAX8guF8Ut5d/o=;
        b=iitVGrvLFZgg5Zgp/BnFMMqy3ZmF7qA1KEa72ASmU1UtzTJGe4UVeOnTy1ZZs5Exoi
         Lt61zqPznoW3K1HkJIWfavfld1DMjVhwzjyiIeGZCbRaVpzlrT+5yae3HmjJ4C8EB9Wd
         +img/aSuaqpf+pDEmx9x8X2xK+9x671mVsbRG4jX1l3pIz4CM5E5QM4EQKjPKquxgdE6
         K2lKO9O/hKNavCSZT5vDvUX96FpYyqNyPIPCbhl2ECsG0B3XjgUOeNPPbf80/UbQuZNG
         meUQY75QPuJcQ/aESdzpMENRIWqRL5KvwCId3uPE+/Nu/0QPOCa7F6iCY62WJ3b+42Uj
         9dvQ==
X-Gm-Message-State: AOAM530FTybXjuUjjNxZu4ihkg9B44/LZqRvQlezquTqr0tqup57iXK7
        oS0X6C4FjBtv+5Q8WwnByLeFbz/A9LaB4HTg6dc=
X-Google-Smtp-Source: ABdhPJxw3GDh0U9Xovw6fsWgnhHqORmTwT/PtyLivGnYC7aphwsq7zOn8UDr1Id22AhoZ3zGEqUCe98DrSBVSNRd/Ko=
X-Received: by 2002:a2e:350a:: with SMTP id z10mr10985709ljz.150.1600446899859;
 Fri, 18 Sep 2020 09:34:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200918113256.8699-1-tguyot@gmail.com> <20200918113256.8699-3-tguyot@gmail.com>
 <20200918143647.GB1606445@nand.local>
In-Reply-To: <20200918143647.GB1606445@nand.local>
From:   Thomas Guyot-Sionnest <tguyot@gmail.com>
Date:   Fri, 18 Sep 2020 12:34:48 -0400
Message-ID: <CALqVohfFjsh-2jZLNNwON_V95Dfh-aEh1aMb53t4NQrM0qz1tQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] Allow passing pipes for input pipes to diff --no-index
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Thomas Guyot-Sionnest <dermoth@aei.ca>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Taylor,

On Fri, 18 Sep 2020 at 10:36, Taylor Blau <me@ttaylorr.com> wrote:
> On Fri, Sep 18, 2020 at 07:32:56AM -0400, Thomas Guyot-Sionnest wrote:
> > A very handy way to pass data to applications is to use the <() process
> > substitution syntax in bash variants. It allow comparing files streamed
> > from a remote server or doing on-the-fly stream processing to alter the
> > diff. These are usually implemented as a symlink that points to a bogus
> > name (ex "pipe:[209326419]") but opens as a pipe.
>
> This is true in bash, but sh does not support process substitution with
> <().

Bash, ksh, zsh and likely any more moden shell. Other programming
languages also setup such pipes. It's much cleaner than creating temp
files and cleaning them up and in some cases faster too (I've ran
diff's like this over GB's of test data, it's very handy to remove
known patterns that would cause needless diffs).

> > +/* Check that file is - (STDIN) or unnamed pipe - explicitly
> > + * avoid on-disk named pipes which could block
> > + */
> > +static int ispipe(const char *name)
> > +{
> > +     struct stat st;
> > +
> > +     if (name == file_from_standard_input)
> > +             return 1;  /* STDIN */
> > +
> > +     if (!lstat(name, &st)) {
> > +             if (S_ISLNK(st.st_mode)) {
>
> I had to read this a few times to make sure that I got it; you want to
> stat the link itself, and then check that it links to a pipe.
>
> I'm not sure why, though. Do you want to avoid handling named FIFOs in
> the code below? Your comment that they "could block" makes me think you
> do, but I don't know why that would be a problem.

I'll admit the comment was written first and is a bit naive  - i'll
rephrase that. Yes you don't want to block on pipes like if you run a
"grep -R" on a subtree that has fifos - but as I coded this I realized
the obvious: git tracks symlinks name so the real bugger would be to
detect one as a pipe and try reading it instead or calling readlink().

> > +                     /* symlink - read it and check it doesn't exists
> > +                      * as a file yet link to a pipe */
> > +                     struct strbuf sb = STRBUF_INIT;
> > +                     strbuf_realpath(&sb, name, 0);
> > +                     /* We're abusing strbuf_realpath here, it may append
> > +                      * pipe:[NNNNNNNNN] to an abs path */
> > +                     if (!stat(sb.buf, &st))
>
> Statting sb.buf is confusing to me (especially when followed up by
> another stat right below. Could you explain?

The whole block is under lstat/S_ISLNK (see previous chunk), so the
path provided to us was a symlink.

Initially I looked at what differentiate these - mainly, stat() st_dev
- but that struct is os-specific, you'd want to check major(st_dev) ==
0 (at least on linux) and even if we knew how each os behaves, the
code isn't portable and would be a pain to support. Gnu's difftools
have very incomplete historical source code in git but there's
indications they have gotten rid of it too.

So what I'm doing instead is trying to resolve the link and see if the
destination exists (a clear no). Luckily strbuf_realpath does the
heavy lifting and leaves me with a real path to the file the symlink
points to (especially useful for relative links), which is bogus for
the special pipes we're interested in.

Then the block right after (not shown) do a stat() on the initial name
and return whenever it's a fifo or not (if it is, but the link is
broken, we know it's a special device).

Now you mention it, maybe I could do that stat first, rule this out
from the beginning... less work for the general case.

*untested*:

    if (!lstat(name, &st)) {
        if (!S_ISLNK(st.st_mode))
            return(0);
        if (!stat(name, &st)) {
            if (!S_ISFIFO(st.st_mode))
                return(0);

            /* We have a symlink that points to a pipe. If it's resolved
             * target doesn't really exist we can safely assume it's a
             * special file and use it */
            struct strbuf sb = STRBUF_INIT;
            strbuf_realpath(&sb, name, 0);
            /* We're abusing strbuf_realpath here, it may append
             * pipe:[NNNNNNNNN] to an abs path */
            if (stat(sb.buf, &st))
                return(1); /* stat failed, special one */
        }
    }
    return(0);

TL;DR - the conditions we need:

- lstat(name) == 0  // name exists
- islink(lstat(name))  // name is a symlink
- stat(name) == 0  // target of name is reachable
- isfifo(stat(name))  // Target of name is a fifo
- stat(realpath(readlink(name))) != 0  // Although we can reach it,
name's destination doesn't actually exist.

BTW is st/sb too confusing ? I took examples elsewhere in the code, I
can rename them if it's easier to read.

> > +test_expect_success 'diff --no-index can diff piped subshells' '
> > +     echo 1 >non/git/c &&
> > +     test_expect_code 0 git diff --no-index non/git/b <(cat non/git/c) &&
> > +     test_expect_code 0 git diff --no-index <(cat non/git/b) non/git/c &&
> > +     test_expect_code 0 git diff --no-index <(cat non/git/b) <(cat non/git/c) &&
> > +     test_expect_code 0 cat non/git/b | git diff --no-index - non/git/c &&
> > +     test_expect_code 0 cat non/git/c | git diff --no-index non/git/b - &&
> > +     test_expect_code 0 cat non/git/b | git diff --no-index - <(cat non/git/c) &&
> > +     test_expect_code 0 cat non/git/c | git diff --no-index <(cat non/git/b) -
> > +'
>
> Indeed this test fails (Git thinks that the HERE-DOC is broken, but I
> suspect it's just getting confused by the '<()'). This test (like almost
> all other tests in Git) use /bin/sh as its shebang. Does your /bin/sh
> actually point to bash?
>
> If you did want to test something like this, you'd need to source
> t/lib-bash.sh instead of t/test-lib.sh.

Thanks for the tip - indeed I think I ran the testsuite directly with
back, but the make test failed.

> Unrelated to the above comment, but there are a few small style nits
> that I notice:
>
>   - There is no need to run with 'test_expect_code 0' since the test is
>     marked as 'test_expect_success' and the commands are all in an '&&'
>     chain. (This does appear to be common style for others in t4053, so
>     you may just be matching it--which is fine--but an additional
>     clean-up on top to modernize would be appreciated, too).
>
>   - The cat pipe is unnecessary, and is also violating a rule that we
>     don't place 'git' on the right-hand side of a pipe (can you redirect
>     the file at the end instead?).

Cleanup, no pipelines (I read too fast / assumed last command was ok) - will do!

> Documentation/CodingGuidelines is a great place to look if you are ever
> curious about whether something is in good style.
>
> > +test_expect_success 'diff --no-index finds diff in piped subshells' '
> > +     (
> > +             set -- <(cat /dev/null) <(cat /dev/null)

Precautions/portability. The file names are somewhat dynamic (at least
the fd part...) this is to be sure I capture the names of the pipes
that will be used (assuming the fd's will be reallocated in the same
order which I think is fairly safe). An alternative is to sed "actual"
to remove known variables, but then I hope it would be reliable (and
can I use sed -r?). IIRC earlier versions of bash or on some systems a
temp file could be used for these - although it defeats the purpose
it's not a reason to fail....

I cannot develop this on other systems but I tested the pipe names on
Windows and Sunos, and also using ksh and zsh on Linux (zsh uses /proc
directly, kss uses lower fd's which means it can easily clash with
scripts if you don't use named fd's, but not our problem....)

Thanks,

Thomas
