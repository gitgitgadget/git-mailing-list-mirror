Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A0215202A0
	for <e@80x24.org>; Wed,  1 Nov 2017 21:43:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934268AbdKAV2d (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Nov 2017 17:28:33 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:54446 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934256AbdKAV23 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Nov 2017 17:28:29 -0400
Received: by mail-qt0-f193.google.com with SMTP id z19so4418824qtg.11
        for <git@vger.kernel.org>; Wed, 01 Nov 2017 14:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=0th0yyhfxnTOlZEBDDKEPgpqNzWoRHwEwAKWDnKGlq8=;
        b=e98kJe2TAWCyx+MNlAxY25c5gIaJedR+XeW+NyeiKMLM2eA1aW19Fdfw+wDfwR9THe
         X8We4cpEHLym/Hicm84DwYaMRpol62c+ay24qY9AAJWTWlPIEp4WE6ggj0gdXzKVOo3v
         Wd34YPX2huDcMjAZQKpsIsgF/1aLFTCncnxBT3gqRJklKftSQkfSMBkwvmc9eHK3PyCi
         LdJsPkOAZ0xqhdNK/+BLGQH4+RySMdAcHm0qrd/fHZSaxJt466JipgEN1vUkg5ozYL20
         23mIyirK0a25cWr1dUhGg/ycASNwP5GyEiyZweKWcUF5FG/0kQtBaIc95KdFG4nkQWAY
         +e4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=0th0yyhfxnTOlZEBDDKEPgpqNzWoRHwEwAKWDnKGlq8=;
        b=nJ1TrcBR9E0yD5X6nw0NFlU/0AzTGcOY8jfJLo8I2usHvMPs0kp7nZLHitX0CyGIzu
         N8wNkGEs6XMHIs2n8YCc5OMESIXLd6CixYnBDSsqQ1mHOtSJ1EDs6qk+0bRsbMpOnvbI
         rpmuJ+0XOtRZHovyfVzKnxCpWADrhBo538q6b0DFd7hKUTz2DrXOtnfg3wTLHI/GrUZ+
         qb4VKWsY4e7r2kYfOzpPZp/6+VBTV6UYIF31Bnzu180nywmfYGeW6STLrjtI3rjNr26E
         xzBx0NgdeRJ3MwEOwUJLbTPOdNVvVlT17302g6V6GZsUuv5XiZpelfDYlsp5A+5W0ukJ
         FsgQ==
X-Gm-Message-State: AMCzsaUhUwJH4f/ZnHD5pHkEHXyl1GG0K1H6pbisK11ldQqpe0muq+rF
        45ySE1/Rf5civixPr/CS3KP/mns/PMDCZcUXbTQJLg==
X-Google-Smtp-Source: ABhQp+QgtTs3u/n3YeUtOLXlNQoimwNHFEBXpoqjhdm1XbI7twDV/LRoTnXG0lFPVnQ3KtU9yeMZhrhu9Xl4goUXRk8=
X-Received: by 10.237.37.132 with SMTP id x4mr1954386qtc.224.1509571708378;
 Wed, 01 Nov 2017 14:28:28 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.102.70 with HTTP; Wed, 1 Nov 2017 14:28:27 -0700 (PDT)
In-Reply-To: <xmqqbmkmvdrq.fsf@gitster.mtv.corp.google.com>
References: <20171031003351.22341-1-sbeller@google.com> <20171031211852.13001-1-sbeller@google.com>
 <20171031211852.13001-7-sbeller@google.com> <xmqqbmkmvdrq.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 1 Nov 2017 14:28:27 -0700
Message-ID: <CAGZ79kbVWWo4YAK74hrJHAtwfMxYMixe1ypdcyaeWEMs8SHQpA@mail.gmail.com>
Subject: Re: [PATCHv2 6/7] builtin/describe.c: describe a blob
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git <git@vger.kernel.org>, Jacob Keller <jacob.keller@gmail.com>,
        Kevin Daudt <me@ikke.info>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 31, 2017 at 9:11 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> +If the given object refers to a blob, it will be described
>> +as `<commit-ish>:<path>`, such that the blob can be found
>> +at `<path>` in the `<commit-ish>`. Note, that the commit is likely
>
> Does the code describe a9dbc3f12c as v2.15.0:GIT-VERSION-GEN, or
> would it always be <commit>:<path>?
>
>> +not the commit that introduced the blob, but the one that was found
>> +first; to find the commit that introduced the blob, you need to find
>
> Because we do not want to descend into the same tree object we saw
> earlier, this "we show the name we happened to find first without
> attempting to refine it for a better name" is a rather fundamental
> limitation of this approach.  Hopefully we can later improve it with
> more thought, but for now it is better than nothing (and much better
> than "git log --raw | grep").

ok.


>
>> +the commit that last touched the path, e.g.
>> +`git log <commit-description> -- <path>`.
>> +As blobs do not point at the commits they are contained in,
>> +describing blobs is slow as we have to walk the whole graph.
>
> Is it true that we walk the "whole graph", or do we stop immediately
> we find a path to the blob?  The former makes it sound like
> completely useless.

Unfortunately we walk the whole graph, as I have not figured out how to
stop the walking from the callback in 'traverse_commit_list'.

I assume I have to modify the struct rev_info that we operate on,
clearing any pending commits?

>
>> -#define SEEN         (1u << 0)
>
> Interesting.  Now we include revision.h this becomes redundant.
>

Correct. In a way this small part is a revert of 8713ab3079
(Improve git-describe performance by reducing revision listing., 2007-01-13)


>> +     argv_array_pushl(&args, "internal: The first arg is not parsed",
>> +             "--all", "--reflog", /* as many starting points as possible */
>
> Interesting.
>
> Do we also search in the reflog in the normal "describe" operation?
> If not, perhaps we should?  I wonder what's the performance
> implications would be.

"normal" git describe doesn't need to walk the whole graph
as we only walk down from the given commit-ish until a land mark
is found.

For --contains, this might be an interesting though, as there we
also have to "walk backwards without pointers to follow".

>
> That tangent aside, as "describe blob" is most likely a "what
> reaches and is holding onto this blob?" query, finding something
> that can only be reached from a reflog entry would make it more
> helpful than without the option.

Yeah that is my reasoning as well.

>
>> +             /* NEEDSWORK: --all is incompatible with worktrees for now: */
>
> What's that last colon about?

will replace with a dot, it ought to hint at the line that follows,
the --single-worktree flag.

>
>> +             "--single-worktree",
>> +             "--objects",
>> +             "--in-commit-order",
>> +             NULL);
>> +
>> +     init_revisions(&revs, NULL);
>> +     if (setup_revisions(args.argc, args.argv, &revs, NULL) > 1)
>> +             BUG("setup_revisions could not handle all args?");
>> +
>> +     if (prepare_revision_walk(&revs))
>> +             die("revision walk setup failed");
>> +
>> +     traverse_commit_list(&revs, process_commit, process_object, &pcd);
>> +     reset_revision_walk();
>> +}
>> +
>
> OK.
>
>> diff --git a/t/t6120-describe.sh b/t/t6120-describe.sh
>> index 1c0e8659d9..3be01316e8 100755
>> --- a/t/t6120-describe.sh
>> +++ b/t/t6120-describe.sh
>> @@ -310,6 +310,21 @@ test_expect_success 'describe ignoring a borken submodule' '
>>       grep broken out
>>  '
>>
>> +test_expect_success 'describe a blob at a tag' '
>> +     echo "make it a unique blob" >file &&
>> +     git add file && git commit -m "content in file" &&
>> +     git tag -a -m "latest annotated tag" unique-file &&
>> +     git describe HEAD:file >actual &&
>> +     echo "unique-file:file" >expect &&
>> +     test_cmp expect actual
>> +'
>> +
>> +test_expect_success 'describe a surviving blob' '
>> +     git commit --allow-empty -m "empty commit" &&
>> +     git describe HEAD:file >actual &&
>> +     grep unique-file-1-g actual
>> +'
>> +
>
> I am not sure what "surviving" means in this context.

Maybe "unchanged", "still kept around" ?


> The word
> hinted that the test would be finding a blob that only appears in a
> commit that only appears as a reflog entry, but that wasn't the
> case, which was a bit disappointing.

oh!
