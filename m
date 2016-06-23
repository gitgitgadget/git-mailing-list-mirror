Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CD47F1FF40
	for <e@80x24.org>; Thu, 23 Jun 2016 17:25:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751121AbcFWRZS (ORCPT <rfc822;e@80x24.org>);
	Thu, 23 Jun 2016 13:25:18 -0400
Received: from mail-it0-f48.google.com ([209.85.214.48]:34918 "EHLO
	mail-it0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750953AbcFWRZR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jun 2016 13:25:17 -0400
Received: by mail-it0-f48.google.com with SMTP id g127so75666445ith.0
        for <git@vger.kernel.org>; Thu, 23 Jun 2016 10:25:16 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=F9OgcC/Ui/QMhD0j9yYPYCeTWszB/bIE+VoTAOZXUvE=;
        b=oVBJlE4R4BetFL04avltzx7LavsbP9Uu15clZvFeUauOvP1d/jHYf3j6dGfXQjR//L
         1++xDupVkExHLmxdPOcoqq+EhEEkuSwGgnbsfdI61egvnDVOLNi+E8mPQDYIRe46kgLz
         jtE/+jyRz8KqjfplJTbM7JzxuZlVA5i4iMQ5Lg5/uDsg6Z4nASHh1LFmxFxWYKP4GNo1
         ACM2ilNreBknbs1QHMAMbglPOP3VhMB7HL3+n0cRYnoOKGKpsZuTRKb4OBo+aXlG93mp
         ctvKDxJemErQAEfxufCYo1945o8/ZP9bYi8SEvI3iXm1wUALrWcwZN24N0DTS7dLC7yH
         UJTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=F9OgcC/Ui/QMhD0j9yYPYCeTWszB/bIE+VoTAOZXUvE=;
        b=GtCiJjhiOU0pQzxl3bGkn3f5wQ1T6gV3QNiLIo2RWZGE0gURGhzyXVvo9H/JXMGi3Q
         aqtpr93iTeoGM5AUkw9dHJeMkDQtjlY4sVAWxw0ay7Lgjlwx8yPPmF1h4KNmxHYxgt29
         sbRrsnEAOyhW95axDzwcv+N1ou0SLb/LFE4ISXIiLOrylJRiibDeh887Rv7r8KNI3D0W
         joxU/sGej+omgGzD8q0D3llXQ49xHCYauMe6EJ7L4T9SF3UdoCqRdu/YaMwFb3fc6JjM
         MTz/HdiaxiJHzqIQy67R1T01ycFIqpXtkRxMkS22p6NsVCm//J8oLX07xOkNVXN7/zWy
         jgHA==
X-Gm-Message-State: ALyK8tIdnMjERTmdEojaDBKJ2fwDz12GfRuCW+elwo5TdYy2M0Zjap3uo95ZTXiSWwkdNIZP0FSDzP+3FNMm/HJ/
X-Received: by 10.36.219.70 with SMTP id c67mr22490397itg.46.1466702715838;
 Thu, 23 Jun 2016 10:25:15 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.136.16 with HTTP; Thu, 23 Jun 2016 10:25:15 -0700 (PDT)
In-Reply-To: <576C1803.5050905@alum.mit.edu>
References: <20160616174620.1011-1-sbeller@google.com> <20160617153637.GA9314@sigill.intra.peff.net>
 <CAGZ79kZgdbqnWW9uqeBHNDbyGVfc0x5gTJbyD0Nyi1i3SNvENQ@mail.gmail.com> <576C1803.5050905@alum.mit.edu>
From:	Stefan Beller <sbeller@google.com>
Date:	Thu, 23 Jun 2016 10:25:15 -0700
Message-ID: <CAGZ79katU2w-aDcoyPtyESu33FFzVUv2+V=rq2pNcxZJG9NSng@mail.gmail.com>
Subject: Re: [PATCH] diff compaction heuristic: favor shortest neighboring
 blank lines
To:	Michael Haggerty <mhagger@alum.mit.edu>
Cc:	Jeff King <peff@peff.net>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Jacob Keller <jacob.keller@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Thu, Jun 23, 2016 at 10:10 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> On 06/17/2016 06:09 PM, Stefan Beller wrote:
>> I think before spending more time on discussing and implementing new
>> (hopefully better) heuristics, I'd want to step back and try to be a bit more
>> systematic, i.e. I'll want to collect lots of test cases in different languages
>> and use cases. A mini test suite, maybe?
>
> Stefan,
>
> I've also been playing around with diff heuristics and also trying to
> find some good test data. Have you put together some test cases yet?

I started with that and had 2 or 3 test cases written out, but the
diffs of diffs
confused me and then I got distracted, so I am stalling on putting together
a mini test suite. You'll find my attempt at [1] as an integration of our
test suite. Maybe we don't need to have these tests in tree, but once we're
done developing the heuristic, we can put the test suite in the commit message
of that commit? (Assuming the tests are short and as for a heuristic there is
no right and wrong, but only a better or worse)

[1] https://github.com/stefanbeller/git/tree/diff_heuristic_improvements


>
> In case you are interested, the current iteration of my heuristic
> considers six things to determine a "score" for breaking a diff above a
> particular line:
>
> * `blank` -- is the line blank?
> * `indent` -- the indentation of the line (if it is not blank)
> * `pre_blank` -- is the preceding line blank?
> * `pre_indent` -- the indentation of the closest preceding non-blank
>   line
> * `post_blank` -- is the following line blank?
> * `post_indent` -- the indentation of the closest following non-blank
>   line
>
> The meat of the scoring algorithm is below. I compute the score for the
> beginning and the end of the insert/delete block for each candidate
> shift of an insertion/deletion hunk, then choose the one that has the
> lowest score.
>
> There are some adjustable "bonus" values below. The values shown give
> quite good results for C, shell, Python, XML, Ruby, CSS, YAML, and HTML
> in the couple of projects that I've tried it on. But I haven't done
> enough systematic testing over a large enough corpus to know whether the
> parameters could be improved or whether there are types of code that it
> performs really terribly on.

I think the corpus doesn't have to be large, but rather diverse.

The current heuristic was tested by Jacob and Jeff over the history of the
linux kernel, (and some other C projects), which I consider a large corpus --
But it's all well formed C, i.e a well known coding style. [2]

[2] don't read this too seriously:
http://codegolf.stackexchange.com/questions/42510/reverse-indentation

>
> Right now my program doesn't output diffs in the usual format, but
> rather as a diff notated with various information. So it's not in a form
> that other people could use so easily. Here's an example:
>
>> vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
>>                   *
>>                   * Default behaviour is to initialize the notes tree from the tree object
>>                   * specified by the given (or default) notes ref.
>>                   */
>>                  #define NOTES_INIT_EMPTY 1
>>     |     -4
>>     |     -6 +   /*
>>     ||    28 +  + * By default, the notes tree is only readable, and the notes ref can be
>>     ||       +  + * any treeish. The notes tree can however be made writable with this flag,
>>     ||       +  + * in which case only strict ref names can be used.
>>     ||       +  + */
>>     ||       +  +#define NOTES_INIT_WRITABLE 2
>>      |       +  +
>>      |          +/*
>>                   * Initialize the given notes_tree with the notes tree structure at the given
>>                   * ref. If given ref is NULL, the value of the $GIT_NOTES_REF environment
>>                   * variable is used, and if that is missing, the default notes ref is used
>>                   * ("refs/notes/commits").
>>                   *
>>                   * If you need to re-initialize a notes_tree structure (e.g. when switching from
>> ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>
> The two columns of vertical bars show the highest and lowest range of
> lines that this insertion block can be shifted to. The numbers show the
> score for breaking the diff above that line. The first column of +/- is
> where this version of the heuristic would place the diff, and the second
> column is where the master version of Git would place it.

This is very valuable for understanding and testing different
patterns! Great work!

>
> My program can also search for and output "slideable" insertion/deletion
> blocks, so it can be used to find diffs that are theoretically capable
> of being optimized, even if they don't happen to be handled differently
> by two different algorithms.

Oh right, that is what we can use to find good examples to test on.

I wondered if we could "machine learn" the coefficients for these 6
parameters that you outline above to bring the best matches in most of the time.

>
> Let me know if you want to collaborate on this somehow.

I am interested, but I dropped the ball last week. I'll pick it up again. :)

Stefan

>
> Michael
>
> Scoring heuristic:
>
>>     # A place to accumulate bonus factors (positive makes this
>>     # index more favored):
>>     bonus = 0
>>
>>     # Bonuses based on the location of blank lines:
>>     if pre_blank and not blank:
>>         bonus += 3
>>     elif blank and not pre_blank:
>>         bonus += 2
>>     elif blank and pre_blank:
>>         bonus += 1
>>
>>     # Now fill in missing indent values:
>>     if pre_indent is None:
>>         pre_indent = 0
>>
>>     if post_indent is None:
>>         post_indent = 0
>>
>>     if blank:
>>         indent = post_indent
>>
>>     if indent > pre_indent:
>>         # The line is indented more than its predecessor. It is
>>         # preferable to keep these lines together, so we score it
>>         # based on the larger indent:
>>         score = indent
>>         bonus -= 4
>>
>>     elif indent < pre_indent:
>>         # The line is indented less than its predecessor. It could
>>         # be that this line is the start of a new block (e.g., of
>>         # an "else" block, or of a block without a block
>>         # terminator) or it could be the end of the previous
>>         # block.
>>         if indent < post_indent:
>>             # The following line is indented more. So it is likely
>>             # that this line is the start of a block. It's a
>>             # pretty good place to split, so score it based on the
>>             # smaller indent:
>>             score = indent
>>             bonus += 2
>>         else:
>>             # This was probably the end of a block. We score based
>>             # on the line's own indent:
>>             score = indent
>>
>>     else:
>>         # The line has the same indentation level as its
>>         # predecessor. We score it based on its own indent:
>>         score = indent
>>
>>     return 10 * score - bonus
>
