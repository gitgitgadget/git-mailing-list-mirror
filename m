Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 67F3B20193
	for <e@80x24.org>; Thu,  4 Aug 2016 16:55:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965341AbcHDQzr (ORCPT <rfc822;e@80x24.org>);
	Thu, 4 Aug 2016 12:55:47 -0400
Received: from mail-it0-f41.google.com ([209.85.214.41]:35471 "EHLO
	mail-it0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965122AbcHDQzp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Aug 2016 12:55:45 -0400
Received: by mail-it0-f41.google.com with SMTP id u186so805501ita.0
        for <git@vger.kernel.org>; Thu, 04 Aug 2016 09:55:45 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=S1+tMGl8Tz1pUQ7Vli9deOweDWRY1rxzGlDLU4UGCdA=;
        b=pYaKbjpQIC2+q7Y6moNhuM0OTxqh2sBJNBnYw0OItQ3QNvnWuBuOb99DNlDzKFUE6v
         xpiTEFEwO7R+phgZe4ARkrbN207IIporjGWrevvFhxSBC/wdyD1zmcVUrlY5ngMK+sMr
         5Cj7S5dH1JC7iCY6VZXRp8cJ/4Ufk+aM9nWapXA/ClMcWtynAKxTexXR5Ms/NvEyPROr
         OIu+ZhQcau3stqTg9jMEK+EYeVGbaNPGYt/gp52b1/BtBRbOo2CLxp5vLDvTG88S7Lj/
         r0zW7jtYFQc7pgXMhWwu6MtC9Z4iZrlFUNK34Q8VcNUGqgw2sspl/SElmfwEnyDU3sni
         ol/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=S1+tMGl8Tz1pUQ7Vli9deOweDWRY1rxzGlDLU4UGCdA=;
        b=aJnMp992Ou6ow9eCVtutPpEOIs7b5nDDsKKZRfcKD1cFptvfuNeTyuX7ilHqhNra0u
         ehHdjRumgWiU2x5u9mRmpz2RXUlLMYVMriiB0Bflbo4dai7USmiweMqumVgkgcPa9XRH
         XDKrEkbEcSrSvKEfG8wcIwlAfkBABfa5na/k6tdg3P/6D6NHCS9ozBc+uHpp7beSdHUe
         RqEJMVJJj5/qfDMrGfFG9y8gm9JrxwaPxmUFeniv0wKHGIoPe3Y7L+yx+ttAo2z3nQ03
         eSX3cY2apP26eEKLqpc8lb9fKWiCXTzeGRNcLyrxzcWdN5t1HcaLFGew8NgpqzlXdZ42
         KFyg==
X-Gm-Message-State: AEkooutucRh55CtyI5LW4/BK6YkuHUN22loWYpigxlyqS0CKOUXllUmRwjZmTEDVcNZCqZxbtvKtfxBweI1BgnX0
X-Received: by 10.36.189.7 with SMTP id x7mr36967348ite.97.1470329739709; Thu,
 04 Aug 2016 09:55:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.128.66 with HTTP; Thu, 4 Aug 2016 09:55:39 -0700 (PDT)
In-Reply-To: <20160804075631.jakbi5dbsbxsqcpr@sigill.intra.peff.net>
References: <cover.1470259583.git.mhagger@alum.mit.edu> <7b0680ed7a10fc13acd8d7816a75ed05a5f9e28c.1470259583.git.mhagger@alum.mit.edu>
 <20160804075631.jakbi5dbsbxsqcpr@sigill.intra.peff.net>
From:	Stefan Beller <sbeller@google.com>
Date:	Thu, 4 Aug 2016 09:55:39 -0700
Message-ID: <CAGZ79kYCwoo6sYefu++KyCdgHfKvRsUp98ZAur+E7E4o_FLtEw@mail.gmail.com>
Subject: Re: [PATCH 8/8] diff: improve positioning of add/delete blocks in diffs
To:	Jeff King <peff@peff.net>
Cc:	Michael Haggerty <mhagger@alum.mit.edu>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
	Jacob Keller <jacob.keller@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Thu, Aug 4, 2016 at 12:56 AM, Jeff King <peff@peff.net> wrote:
> On Thu, Aug 04, 2016 at 12:00:36AM +0200, Michael Haggerty wrote:
>
>> This table shows the number of diff slider groups that were positioned
>> differently than the human-generated values, for various repositories.
>> "default" is the default "git diff" algorithm. "compaction" is Git 2.9.0
>> with the `--compaction-heuristic` option "indent" is an earlier,
>
> s/option/&./
>
>>  static int diff_detect_rename_default;
>> +static int diff_indent_heuristic; /* experimental */
>>  static int diff_compaction_heuristic; /* experimental */
>
> These two flags are mutually exclusive in the xdiff code, so we should
> probably handle that here.
>
> TBH, I do not care that much what:
>
>   [diff]
>   compactionHeuristic = true
>   indentHeuristic = true
>
> does. But right now:
>
>   git config diff.compactionHeuristic true
>   git show --indent-heuristic
>
> still prefers the compaction heuristic, which I think is objectively
> wrong.
>
> So perhaps we need a single variable:
>
>   enum {
>     DIFF_HEURISTIC_COMPACTION,
>     DIFF_HEURISTIC_INDENT
>   } diff_heuristic;
>
> and set it in last-one-wins fashion (it would be nice if the config and
> command line options were shaped the same way so it's clear to the user
> that they are exclusive, but we may have to keep --compaction-heuristic
> around for compatibility, as an alias for --diff-heuristic=compaction).
>
>> diff --git a/git-add--interactive.perl b/git-add--interactive.perl
>> index 642cce1..ee3d812 100755
>> --- a/git-add--interactive.perl
>> +++ b/git-add--interactive.perl
>> @@ -45,6 +45,7 @@ my ($diff_new_color) =
>>  my $normal_color = $repo->get_color("", "reset");
>>
>>  my $diff_algorithm = $repo->config('diff.algorithm');
>> +my $diff_indent_heuristic = $repo->config_bool('diff.indentheuristic');
>>  my $diff_compaction_heuristic = $repo->config_bool('diff.compactionheuristic');
>
> Nice touch.
>
> Unfortunately the mutual-exclusivity handling will probably bleed over
> to here, too.
>
>> +/*
>> + * If a line is indented more than this, get_indent() just returns this value.
>> + * This avoids having to do absurd amounts of work for data that are not
>> + * human-readable text, and also ensures that the output of get_indent fits within
>> + * an int.
>> + */
>> +#define MAX_INDENT 200
>
> Speaking of absurd amounts of work, I was curious if there was a
> noticeable performance penalty for using this heuristic (just because
> it's a lot more complicated than the others). I couldn't detect any
> differences running "git log -p --no-merges -3000" on git.git with no
> heuristic, compaction, and indent. There may be other repositories that
> behave more pathologically (it looks like having 20 blank lines at the
> end of each hunk?), but I'd guess in most cases this will always be
> drowned out in the noise of doing the actual diff.
>
>> +#define START_OF_FILE_BONUS 9
>> +#define END_OF_FILE_BONUS 46
>> +#define TOTAL_BLANK_WEIGHT 4
>> +#define PRE_BLANK_WEIGHT 16
>> +#define RELATIVE_INDENT_BONUS -1
>> +#define RELATIVE_INDENT_HAS_BLANK_BONUS 15
>> +#define RELATIVE_OUTDENT_BONUS -19
>> +#define RELATIVE_OUTDENT_HAS_BLANK_BONUS 2
>> +#define RELATIVE_DEDENT_BONUS -63
>> +#define RELATIVE_DEDENT_HAS_BLANK_BONUS 50
>
> I see there is a comment below here mentioning that these are empirical
> voodoo, but it might be worth one at the top (or just moving these below
> the comment) because the comment looks like it's just associated with
> the function (and these are sufficiently bizarre that anybody reading is
> going to double-take on them).
>
>> +        return 10 * score - bonus;
>
> I don't mind this not "10" not being a #define constant, but after
> reading the exchange between you and Stefan, I think it would be nice to
> describe what it is in a comment. The rest of the function is commented
> so nicely that this one left me thinking "huh?" upon seeing the "10".

After a night of sleep I agree with Peffs statement here, it's not about the
#define, it's about the comment. (which the #define would have given in a
short cryptic way in angry capital letters).

I have just reread the scoring function and I think you could pull out the
`score=indent` assignment (it is always assigned except for indent <0)

        if (indent == -1)
               score = 0;
        else
               score = indent;
        ... lots of bonus computation below, which in its current implementation
        have lots of "score = indent;" lines as well.

Thanks,
Stefan
