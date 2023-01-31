Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4E6EC54EAA
	for <git@archiver.kernel.org>; Tue, 31 Jan 2023 00:06:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbjAaAG5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Jan 2023 19:06:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbjAaAGy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Jan 2023 19:06:54 -0500
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4D0F3C1A
        for <git@vger.kernel.org>; Mon, 30 Jan 2023 16:06:52 -0800 (PST)
Received: by mail-il1-x12b.google.com with SMTP id k12so846108ilv.10
        for <git@vger.kernel.org>; Mon, 30 Jan 2023 16:06:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MPWK8CMZOhZ4oBvMZsj+3Ky03MwQUWKf4nUh3nEwg2w=;
        b=RcadiSYqe1u3iANWmKLW2rjFz5NfE6kfR6BlKkjpG2C8M8WAobCh9UHcsjoRStHMOv
         haFtAsh0zWfyd+ieeIFhfJu15J9d2xRBj89TFF4w5NhZGLoBBXPp+rNP3Z2jY5PH/kDD
         Wq9jxV50wJ/6aPxns1oDfQkY9Jy0qiH2OsS6riY/aYxVG3ttV5Oyji6eqRN1gbq1cjPe
         UmkXP4afdAMxNf7EYGWKxHAPtXxa/E/etj8eXn71Gn1Ycs2ZMdK3L2kLe0eH3mj3jusr
         7JUIejVXQTGqVhoIRZsBxRLi7VHIAlw0RoJdBp8ZTn7p6NVcUULzfExZfFjMpzgTYH39
         hPcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MPWK8CMZOhZ4oBvMZsj+3Ky03MwQUWKf4nUh3nEwg2w=;
        b=RcQ4RYc9vSMXSmkeZRJpEf2BvhDk9de+ITRu0P4RLuJ78M3/fvPwRGM9J7tPED/zxB
         9KUo6WqsW98WPTgaGxl12Pfi0Ef6Wpm+ij+oB3b8SwVYssikNxldBjkhalcwq091XPO5
         yqZbqg93RXFZtboGtVu3/6++zZ8081lxVNzDhC8lvEUahEu8pujBri97e5x3KH6sMH63
         L7NgPiLH6E4+RURYs/t/94C0dRo/H823mkGj+y72C1zFHBDigUwMdUyACqMDbyI9RENX
         wsazerAnY5LcIFdFAuxchlqbM05RZh+3xugXFcJuCRdrWtmMyq7QchnyZwiFIzgoPd5I
         ziiQ==
X-Gm-Message-State: AO0yUKX2Hh2SSkGTTDVKkTDzCUQxBV2ZeAgSWfjr8XtEp2cd/I50X8dS
        b48Zad0VwKh79zz8gc7FcWzKzy/5G/4=
X-Google-Smtp-Source: AK7set8yN+negBhCLRywVY6h8J6/PwhQ/5D1t3u8ytYL0Y7wETSQ8J7y92veACj7TFz92H3YK57kvw==
X-Received: by 2002:a05:6e02:1747:b0:310:b84b:c884 with SMTP id y7-20020a056e02174700b00310b84bc884mr13919256ill.18.1675123611591;
        Mon, 30 Jan 2023 16:06:51 -0800 (PST)
Received: from [192.168.1.72] (108-200-163-197.lightspeed.bcvloh.sbcglobal.net. [108.200.163.197])
        by smtp.gmail.com with ESMTPSA id u185-20020a0223c2000000b0039e2deb748fsm5214113jau.168.2023.01.30.16.06.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Jan 2023 16:06:51 -0800 (PST)
Message-ID: <a812a664-67ea-c0ba-599f-cb79e2d96694@gmail.com>
Date:   Mon, 30 Jan 2023 19:06:44 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Content-Language: en-US-large
To:     Git List <git@vger.kernel.org>
From:   Eli Schwartz <eschwartz93@gmail.com>
Subject: Stability of git-archive, breaking (?) the Github universe, and a
 possible solution
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>
X-Clacks-Overhead: GNU Terry Pratchett
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

For those that haven't seen, github changed its checksums for all
"source code" artifacts attached to any git repository with tags. This
change is now reverted due to widespread breakage -- and the lack of
advance warning. The technical details of the change appear simple: they
upgraded git.

Probably the main discussion, complete with Github employees from this
mailing list responding:

https://github.com/bazel-contrib/SIG-rules-authors/issues/11#issuecomment-1409438954

Consequences of that discussion, attempting to mitigate issues by
warning people that it already happened:

https://github.blog/changelog/2023-01-30-git-archive-checksums-may-change/

And where I first saw it: https://github.com/mesonbuild/wrapdb/pull/884

Historically speaking, git-archive has been stable minus... a bug fix or
two in rare cases, specifically relating to an inability to transcribe
the contents of the git repo at all, I think? And the other factor is
the compression algorithm used, which is generally GNU gzip, and
historically whatever the system `gzip` command is.

And gzip is a stable format. It's a worn-out, battle-weary format, even
-- it's not the best at compressing, and it's not the best at
decompressing, and "all the cool kids" are working on cooler formats,
such as zstd which does indeed regularly change its byte output between
versions. But the advantage of gzip is that it's good *enough*, and it's
probably *everywhere*, and it's *reliable*.

GNU gzip is reproducible. busybox gzip was fixed to agree with GNU gzip
(this is relevant to the handful of people running software forges on,
say, Alpine Linux):

https://reproducible-builds.org/reports/2019-08/#upstream-news

...

Nevertheless, I've seen the sentiment a few times that git doesn't like
committing to output stability of git-archive, because it isn't
officially documented (but it's not entirely clear what the benefits of
changing are). And yet, git endeavors to do so, in order to prevent
unnecessary breakage of people who embody Hyrum's Law and need that
stability.

Even with the new change to the compressor, git-archive is still
reproducible, it's the internal gzip compressor that isn't. (This may be
fixable, possibly by embedding an implementation from busybox or from
GNU gzip? I'm not going to discuss that right now, though I think it's
an interesting avenue of exploration.)

I've thought about this now and then over the last couple of years,
because I think I have a reasonable compromise that might make everyone
(or at least most people) happy, and now seems like a good idea to
mention it.

What does everyone think about offering versioned git-archive outputs?
This could be user-selectable as an option to `git archive`, but the
main goal would be to select a good versioned output format depending on
what is being archived. So:

- first things first, un-default the internal compressor again
- implement a v2 archive format, where the internal compressor is the
  default -- no other changes
- teach git to select an archive format based on the date of the object
  being archived
  - when given a commit/tag ID to archive, check which support frame the
    committer date falls inside
  - for tree IDs, always use the latest format (it always uses the
    current date anyway)
- schedule a date, for the sake of argument, 6 months after the next
  scheduled release date of git version X.Y in which this change goes
  live; bake this into the git sources as a transition date, all commits
  or tags generated after this date fall into the next format support
  frame


The end result is that for all historic commits or tags, `git archive`
will always produce the same output. This can be documented in the
git-archive manpage: "the produced archive is guaranteed to be
reproducible, unless you override the `tar.<format>.command` or your
system compressor is not reproducible".

For *new* commits or tags, everyone gets the benefit of fascinating,
cool new archive formats with useful improvements at the tar container
level, which is apparently a very desirable feature. The git project no
longer has to worry, at all, about whether users will come to complain
about how their build pipelines suddenly fail with checksum issues. The
git project can simply, fearlessly, go implement innovative new changes
without giving any thought to backwards compatibility.

It is, simply, that those new changes only apply to projects which are
still under active development, and which push new commits or tag new
releases after the transition date.

Old states of existing projects (regardless of whether they are still
actively updating) can go have their old and apparently inefficient
archives and don't get cool new stuff. That's fine. They're also
increasingly rarely used, because they are, after all, old -- and most
likely only used for historic archival purposes. If the worst comes to
worst, well, they managed to produce a somehow useful archive with an
older version of git -- nothing will *break* if they don't get the cool
new stuff.

And for the vast majority of new downloads for new stuff, the in-process
compressor saves one fork+exec and is a bit more efficient, I guess?

A note on the transition date: I suggested 6 months after the scheduled
release date, because this gives everyone running a software forge time
to update git itself, and have everything ready, in time to handle the
first wave of commits and tags that naturally occur after the transition
date. And you don't want it to be immediate, because then people will
take days or weeks to deploy and the most recent archives will change


For the purposes of this thought experiment, we assume that people don't
routinely set the system time to a year in the future. This will only be
done in situations such as, say, testing a git upgrade deployment for a
software forge.

...


"And then no one ever complained about archive checksums changing again."

🤞🙏🥺

-- 
Eli Schwartz
