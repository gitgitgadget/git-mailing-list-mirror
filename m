Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38526C7EE22
	for <git@archiver.kernel.org>; Thu, 11 May 2023 11:59:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231321AbjEKL7I (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 May 2023 07:59:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbjEKL7G (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2023 07:59:06 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4976576B3
        for <git@vger.kernel.org>; Thu, 11 May 2023 04:59:04 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-4f14f266b72so7346855e87.1
        for <git@vger.kernel.org>; Thu, 11 May 2023 04:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683806342; x=1686398342;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gtU+wwjN+Z1n3veYUMeHF1Z5Ihqve2QYodhlGhbnMqk=;
        b=LxmaCCYqHQKvV1vaxhCaPxvbTRLls6ab4C0ufYTSZE21gQwQnUa/ubBRm/xishPeSX
         HX2ZHNEJxFKrp0sINhTTDoZzGRK3zX5YO61tIgj/+as37G6J1vQNZY7g9JbCmYYsUPkQ
         rnMp8j+8Y8UstSUdc33xa+RM+YeGY1MTFxUwoH8YjHSYyThBdp7RBFwEmviFw3PaLAAg
         K8Jf0r3sppS79QedWKehXg6jN3jQf6EsG/4WyP3C2L4FfA6bt9cPeTWjz6fN6KPIdX1b
         MO67W3e2pyPZyenKqNLWLj3wQxCv+qvKBv1bX7hRNy8uPEXcep3n3Iza7LN/7htK6z+T
         p3Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683806342; x=1686398342;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gtU+wwjN+Z1n3veYUMeHF1Z5Ihqve2QYodhlGhbnMqk=;
        b=lO1mlnsbnP9ljjRKdct4Bs/Oz5Rf63vFaQPfujwVkhXMAOxHfH0fthok9CZTH2Tl4G
         Z+qoc/iCv/VZQtIL4GFfZ7mvhi2SUT27n3rxiuKV+KTimRekoem4RZz28BCSUf/3FLeK
         Pi8ufvtfrl3WKU3bIgV3WMDmgiH1x5XxFm40b118oBpiqj7Xhg/38L8Ak8nR9e4Lk6tr
         MMSEpagB3OrSJt1BuP102r0jT6jxSz0xyH0hhSrRaH+mRF8B0jm2vPrJaEzWTN1YSDcE
         /JdKkTBmdywOoZ5LeyP3ulSbeAlOsWJxU246Bi80sTh8P8D/C1ClWWS/S/04CmwYKcrz
         xMhw==
X-Gm-Message-State: AC+VfDx6mLDFb3iMGE7Fuuo6YElqiuDPx5L9/mU4rYcX4T1jTn+UPfVl
        flEfH04ajgL2ZmKpaTcSPyE=
X-Google-Smtp-Source: ACHHUZ4MSOIPWUjEyFKisERHv+wV30Oi9//xp3kLuJHG/N3qJCrQFbmJNcnBEgr1J3b/dO8KHYZzrA==
X-Received: by 2002:ac2:52b9:0:b0:4f1:1d32:6d67 with SMTP id r25-20020ac252b9000000b004f11d326d67mr2530241lfm.39.1683806342106;
        Thu, 11 May 2023 04:59:02 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id v20-20020ac25594000000b004efef5cf939sm1069259lfg.83.2023.05.11.04.59.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 04:59:01 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org, Matthieu Moy <matthieu.moy@univ-lyon1.fr>
Subject: Re: Can we clarify the purpose of `git diff -s`?
References: <645c5da0981c1_16961a29455@chronos.notmuch>
Date:   Thu, 11 May 2023 14:59:00 +0300
In-Reply-To: <645c5da0981c1_16961a29455@chronos.notmuch> (Felipe Contreras's
        message of "Wed, 10 May 2023 21:14:40 -0600")
Message-ID: <871qjn2i63.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Felipe Contreras <felipe.contreras@gmail.com> writes:

> A recent discussion about a bug in the diff machinery [1] made me dig
> the history of the `-s` option, and turned out to be quite an
> archeological endeavor.
>
> The first indication of such flag comes from e2e5e98a40 ([PATCH] Silent
> flag for show-diff, 2005-04-13), only 54 commits after the initial
> commit.
>
> Not much later after, a `-z` option was added for some machine-readable
> output in d94c6128e6 ([PATCH] show-diff -z option for machine readable
> output., 2005-04-16).
>
> Linus Torvalds wanted to make the machine-readable output the only one
> and wrote 0a7668e99f (show-diff: match diff-tree and diff-cache output,
> 2005-04-26), but Junio Hamano disagreed and added a `-p` option for
> a human-readable patch in 4a6bf9e18a ([PATCH] Reactivate show-diff patch
> generation, 2005-04-27).
>
>   You'll need "diff-tree-helper" to show the full diff, but Junio is
>   dead set on adding a "-p" argument to all three to avoid it. That's
>   next..
>
> Right after that, Junio Hamano deprecated the `-s` flag, since
> `git-show-diff` didn't show the patch by default, so `-s` became a
> no-op. I presume at that point in time they didn't think of the
> possibility of doing `-p -s` together.
>
> The first introduction of DIFF_FORMAT_NO_OUTPUT was in a corner case of
> 6b14d7faf0 ([PATCH] Diffcore updates., 2005-05-22), but later on it was
> used explicitly to replace a global variable of `git-diff-tree -s` in
> d0309355c9 ([PATCH] Use DIFF_FORMAT_NO_OUTPUT to implement diff-tree -s
> option., 2005-05-24).
>
> When the equivalent of the modern `git diff` was added, the `-p` option
> was included by default: 940c1bb018 (Add "git diff" script, 2005-06-13).
> So later on when it was converted to C, DIFF_FORMAT_PATCH was the
> default 65056021f2 (built-in diff., 2006-04-28).
>
> But not for all commands, for example the default of `git diff-tree` is
> DIFF_FORMAT_RAW, and it remains the case to this day.
>
> So at this point it seems pretty clear that `-s` means `silent`, and
> whatever the default format of a diff command is (`--patch` or `--raw`),
> `-s` is meant to silence that format.
>
> Later on in c6744349df (Merge with_raw, with_stat and summary variables
> to output_format, 2006-06-24), the output format changed from an enum to
> a bit field, so now it was possible to do for example
> `DIFF_FORMAT_PATCH | DIFF_FORMAT_RAW`.
>
> This is when things become complicated, because now what is `-s`
> supposed to do? Is it supposed to silence only the default format? Or is
> it supposed to silence all formats?
>
> For example, these two commands are equivalent:
>
>   git diff-tree @~ @
>   git diff-tree --raw @~ @
>
> That's because the default format of `git diff-tree` is DIFF_FORMAT_RAW.
>
> But what happens if we do:
>
>   git diff-tree -s --patch @~ @
>
> Shall we silence only the RAW part, or the PATCH part as well?
>
> And then, should these two be different?
>
>   git diff-tree --patch -s @~ @
>   git diff-tree -s --patch @~ @
>
> This is something that wasn't discussed or explored at the time, so it
> is unclear.
>
> And then, finally, we have d09cd15d19 (diff: allow --no-patch as synonym
> for -s, 2013-07-16), which very clearly says:
>
>   This follows the usual convention of having a --no-foo option to
>   negate --foo.
>
> So, obviously the intention of `--no-patch` is to negate `--patch`, but
> it is linked to `-s`, which was linked to DIFF_FORMAT_NO_OUTPUT, which
> means `--no-patch` negates *all* output, not just the output of
> `--patch`.
>
> So what should the output of this command be:
>
>   git diff-tree --patch --no-patch --raw @~ @
>
> I think it very clearly should output the same as:
>
>   git diff-tree @~ @
>
> And the ordering does not matter, as this should output the same:
>
>   git diff-tree --raw --patch --no-patch @~ @
>
> If we can combine two formats, for example:
>
>   git diff --patch --raw @~
>
> Then we should be able to negate a single format, for example:
>
>   git diff --patch --raw --no-patch @~
>
> Which in my mind should be different from:
>
>   git diff --patch --raw --silent @~
>
> So, in short: I don't think `-s` and `--no-patch` are the same thing at
> all, and it was a mistake to link them together.

First, thanks a lot of the in-depth investigation of the historical
background of the issue!

I entirely agree with your conclusion: obviously, -s (--silent) and
--no-patch are to be different for UI to be even remotely intuitive, and
I'd vote for immediate fix of --no-patch semantics even though it's a
backward-incompatible change.

--patch should obviously produce something more or less suitable for
patching the sources, and then its even move obvious that --no-patch
should turn off this kind of output *only*.

The exact desirable --silent semantics is questionable though. It could
either mean turn off all the --<output_type> flags, i.e. simply a
synonym for --no-patch --no-raw..., as it essentially is right now, or
it could mean suppress actual output not touching any --<output_type>
flags (in which case it probably should have --no-silent counterpart as
well.)

That said, there is another mystery in the diff interface as well: why
do we have --patch-with-raw and --patch-with-stat, yet no
--raw-with-stat, --numstat-with-shortstat, --patch-with-numstat, etc.?
If, say, --patch turned off everything except usual diff output, then
these combinatorical options would make sense, but currently they don't.

Finally, there is another intrinsic problem in current Git CI: the
"defaults to" part, as in "git show" that defaults to --patch for simple
commits, --cc for merge commits, etc., except that it doesn't behave as
if these options were explicitly provided at the beginning of the
command-line. Instead it behaves in a way that "makes sense" in some
definition of "sense", so that

   git show --raw

produces only raw output, whereas

   git show --patch --raw

produces both kinds of output.

So, "git show" does not imply --patch, yet it produces corresponding
output unless any diff format bit option is explicitly given on the
command-line, and it's this behavior that leads to kludges like
DIFF_FORMAT_NO_OUTPUT in the implementation.

Even though such behavior indeed "makes sense" at the first glance, in
fact this is irregularity and it's unfortunate, as it renders wrong
simple interpretations like "git show" being just a synonym for "git log
-n1 --patch --cc".

I'd rather think about generic interface for setting/clearing (multiple)
bits through CI than resorting to such convenience tricks. Once that is
in place, one will be able to say "I need these bits only", "I need to
turn these bit(s) on", and "I need to turn these bit(s) off"
conveniently and universally in any part of Git CI where it's needed.

Overall, the entire CI seems to be built on assumption that it's a good
idea to guess user intentions (hmm, what could the user likely mean when
they said "git show --raw"?), whereas I believe that it'd be better if CI
forced user to strictly specify their intention according to established
basic rules, and then provided convenience shortcuts that adhere to the
same basic rules.

Thanks,
-- Sergey Organov
