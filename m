Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 58CCF208CA
	for <e@80x24.org>; Mon, 14 Aug 2017 22:46:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752725AbdHNWqk (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Aug 2017 18:46:40 -0400
Received: from mail-yw0-f169.google.com ([209.85.161.169]:33987 "EHLO
        mail-yw0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752892AbdHNWqi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Aug 2017 18:46:38 -0400
Received: by mail-yw0-f169.google.com with SMTP id s143so63385348ywg.1
        for <git@vger.kernel.org>; Mon, 14 Aug 2017 15:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Vvr3ZEqq/SWg92RMpqUnJDZ1Y1UImb7LG2DSX0DAluM=;
        b=oY3D6T35ZBj5VQRwCAlvlAqc6C8hHweCvLLnJyxctu7hZ6grqT0+T9MyjUHPL+TlrO
         qYo0HNAcB1YRHiZc1wTzAsfPQ0a8OwCDlT/cJpOVvqd65UWHrgcYv52LhkMiZwQ0H+VK
         upVB3LpeAipVZvPc6sk87+tLnhYx7M8Lk6SS3SmdKP0dkPqzFKWpQLse1eUbiSle0j9w
         FBZjFgHIoxR9ug/VXL8LmX96Wo2qLQMVsyo7vAV9HpsIJr1MCSnnML1NHBmENEcgrCW2
         K+L4OOV4QfWZWhijViUHbqKisZBipgh9Za8j74QtnCWhDRJdbnUuYqjSCOa1ErCqptV3
         VFOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Vvr3ZEqq/SWg92RMpqUnJDZ1Y1UImb7LG2DSX0DAluM=;
        b=c6U+MtBtcmOGtYQg6WcphY3odYaKGUKZFbaiIgYfU9ZZOMl5vaI1GtWUdARnee8FcU
         tCcsTIKestP0IYN1fEoTwfnCAHWoDpVwcfWXIlWfDoHGA3EKvddIX6xkS0MFRuPzZBjm
         zebOHWz3rYHbMASNNpb8L/bQ8WK9h1RQ7cJmFnxRNDYfl1ovs2sC/sitKelQRbJVV0Ws
         T1ddi5MZH+BhUkuYy9Lu3vuTskg2XYDhOU4iRpJYUbcaNyutOOFTUa5DqT6pmS2ZQqpj
         P4dxlCbwrLwBX3YZuROKQQPyvRsnZgzKc9AvJ8SL+QNWEqkQ6v9QZDc7H3dGgY+EJHMf
         C3jA==
X-Gm-Message-State: AHYfb5g6toueevM2UVMMe7Us11vJKqWZ8yp4umJvRd9fatIHLUMFaL+Z
        VNy/11agD5bSsSLPtwkDc3nNoSqJjnyh
X-Received: by 10.13.229.3 with SMTP id o3mr21053172ywe.137.1502750797694;
 Mon, 14 Aug 2017 15:46:37 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.56.142 with HTTP; Mon, 14 Aug 2017 15:46:37 -0700 (PDT)
In-Reply-To: <288c6c29d212088175b13074dba23c9dbdaa2c67.1502745892.git.jonathantanmy@google.com>
References: <cover.1502491372.git.jonathantanmy@google.com>
 <cover.1502745892.git.jonathantanmy@google.com> <288c6c29d212088175b13074dba23c9dbdaa2c67.1502745892.git.jonathantanmy@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 14 Aug 2017 15:46:37 -0700
Message-ID: <CAGZ79kbpdPcyCO9L0o27xOrSEFNy6tn-QFsxrkXJoXzQEbCcBQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] diff: check MIN_BLOCK_LENGTH at start of new block
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 14, 2017 at 2:31 PM, Jonathan Tan <jonathantanmy@google.com> wrote:
> The existing documentation states "If there are fewer than 3 adjacent
> moved lines, they are not marked up as moved", which is ambiguous as to
> whether "adjacent moved lines" must be adjacent both at the source and
> at the destination, or be adjacent merely at the source or merely at the
> destination. The behavior of the current code takes the latter
> interpretation, but the behavior of blocks being conceptually painted as
> blocks and then "unpainted" as lines is confusing to me.
>
> Therefore, clarify the ambiguity in the documentation in the stricter
> direction - a block is completely painted or not at all - and update the
> code accordingly.
>
> This requires a change in the test "detect malicious moved code, inside
> file" in that the malicious change is now marked without the move
> colors (because the blocks involved are too small), contrasting with
> the subsequent test where the non-malicious change is marked with move
> colors.
>
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>

I wonder if these changes ought to be a new mode
(C.f. "mountain zebra" and "imperial zebra" for slight
changes in coloring ;) or if we can settle on one true way.

The 3 lines heuristic is a bad heuristic IMHO (it works reasonable well
for little effort but the fact that we discuss this patch makes it a bad
heuristic as we discuss corner cases that are not relevant. The heuristic
originally wanted to filter out stray single braces that were "moved",
it did not want to suppress small original moved pieces of code),
which this covers up a bit.

Maybe we'll cook this in next for a while to see how people
react to it?

> ---
>  Documentation/diff-options.txt |  6 ++--
>  diff.c                         |  6 +++-
>  t/t4015-diff-whitespace.sh     | 71 +++++++++++++++++++++++++++++++++---------
>  3 files changed, 65 insertions(+), 18 deletions(-)
>
> diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
> index bc52bd0b9..1ee3ca3f6 100644
> --- a/Documentation/diff-options.txt
> +++ b/Documentation/diff-options.txt
> @@ -257,10 +257,10 @@ zebra::
>         Blocks of moved code are detected greedily. The detected blocks are
>         painted using either the 'color.diff.{old,new}Moved' color or
>         'color.diff.{old,new}MovedAlternative'. The change between
> -       the two colors indicates that a new block was detected. If there
> -       are fewer than 3 adjacent moved lines, they are not marked up
> +       the two colors indicates that a new block was detected. If a block
> +       has fewer than 3 adjacent moved lines, it is not marked up
>         as moved, but the regular colors 'color.diff.{old,new}' will be
> -       used.
> +       used instead.

Thanks for clarifying the docs.

> diff --git a/diff.c b/diff.c
> index f598d8a3a..20b784736 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -923,7 +923,6 @@ static void mark_color_as_moved(struct diff_options *o,
>                 }
>
>                 l->flags |= DIFF_SYMBOL_MOVED_LINE;
> -               block_length++;
>
>                 if (o->color_moved == COLOR_MOVED_PLAIN)
>                         continue;
> @@ -953,8 +952,13 @@ static void mark_color_as_moved(struct diff_options *o,
>                         }
>
>                         flipped_block = (flipped_block + 1) % 2;
> +
> +                       adjust_last_block(o, n, block_length);
> +                       block_length = 0;
>                 }
>
> +               block_length++;
> +
>                 if (flipped_block)
>                         l->flags |= DIFF_SYMBOL_MOVED_LINE_ALT;
>         }

This changes the algorithm in a non-obvious way.
When the min-length heuristic is strictly bound to each block,
the function can be simplified more than adding on these tweaks,

1) remove variable block_length, needing to count in the adjust function

2) assign DIFF_SYMBOL_MOVED_LINE either in
    COLOR_MOVED_PLAIN case (and continue) or later (where
    block_length is increased in this patch)

No need to do these, just as thoughts on how to reduce complexity.

> diff --git a/t/t4015-diff-whitespace.sh b/t/t4015-diff-whitespace.sh
> index 6f7758e5c..d0613a189 100755
> --- a/t/t4015-diff-whitespace.sh
> +++ b/t/t4015-diff-whitespace.sh
> @@ -1097,13 +1097,13 @@ test_expect_success 'detect malicious moved code, inside file' '

This test would not 'detect malicious moved code, inside file'  any more,
I think instead we'd rather want to have a more realistic test case,
which has more lines in it? (This test is about the block detection
not about the omission of short blocks, which was an after thought)

> +test_expect_success '--color-moved treats adjacent blocks as separate for MIN_BLOCK_LENGTH' '

Thanks for providing a test here! For testing MIN_BLOCK_LENGTH
for each block I would have imagined the tests would have a block of
length (1,)2,3(,4) lines and then we'd see that the blocks are
highlighted or not.
This only has length=1 blocks?
