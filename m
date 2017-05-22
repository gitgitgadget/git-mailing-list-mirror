Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1A1BA2023D
	for <e@80x24.org>; Mon, 22 May 2017 23:36:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1763034AbdEVXgy (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 May 2017 19:36:54 -0400
Received: from mail-pf0-f177.google.com ([209.85.192.177]:32816 "EHLO
        mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1763007AbdEVXgf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 May 2017 19:36:35 -0400
Received: by mail-pf0-f177.google.com with SMTP id e193so96229595pfh.0
        for <git@vger.kernel.org>; Mon, 22 May 2017 16:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=/lYnhrCHo48xfYYvVQV20a24Y8JR572OpwBwWXeYb/w=;
        b=QSscgcS9ffPR+yKxTdda900M0/hox2aJt9J1rimOYqwlsyQtWYaqnjGMul+BkPhlg6
         /I936ExBz2+/IEFR4Z8q+NMO09Ix24Q8/7rgfy4JDydtbCq/WPLlQTaMAuanZO9BRrYh
         El34xVkLS/PAHvlCqLXlOYyK4r9bHsd0ODEbi5oVGMbcNDv7X+91r1JNbTmgTegUfiDX
         3zEx5aLYzLeH+o5zYYJofB/li2kRe/Rmw7iG/JuwAdtggtfQ/tY/A009kkM4qPb5z++t
         39VouJHnUG8ABqnZHMoP0RLCEnmLlL0Sv+4jQIjvWqbT3TeNAOIZ9ILpzbCLKq9j5KoI
         KPzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=/lYnhrCHo48xfYYvVQV20a24Y8JR572OpwBwWXeYb/w=;
        b=Y5RlxzOsg+rAk/fidFQlRsCbn4ljS2PFMzKJleYr0t7sWLb3h83UPKLGlk9APxmKKm
         SLzg60XkPxSXRdREd8qrp3ktj9NRTOgssllDk34UMwkJ9LlzszKj55lsuPSXBb16GG9L
         8euRPj26NUQhpCG6gF1GY8BHs5tISQnaD9rppL6rE4GMWOXUYtjRsTGFr/tgU6M7R8qe
         tWAOMek9c7za68HTybxAhaoLSjwPHVf97QVqeKb1XjXWcZvt6PriL/Ih+PO0kmc8QBx3
         AbnZVj8I0Bx8ybjR+Rp7EYdUGf78E2Qiclqj5Bl2cKlMcUmubUMJH8XyxoSqXQ7GAceX
         9SJw==
X-Gm-Message-State: AODbwcDl5x1VbcreAwBOMibkL71Y0rzYhzJC+XAmIBYGbce/o4K6O3bq
        +M8a4Ycdz8o2JV02Pc3evvQD/+5h+4Zv
X-Received: by 10.99.56.66 with SMTP id h2mr29276572pgn.40.1495496194876; Mon,
 22 May 2017 16:36:34 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.170.200 with HTTP; Mon, 22 May 2017 16:36:34 -0700 (PDT)
In-Reply-To: <20170518163307.657caedc@twelve2.svl.corp.google.com>
References: <20170517025857.32320-1-sbeller@google.com> <20170518193746.486-1-sbeller@google.com>
 <20170518193746.486-5-sbeller@google.com> <20170518163307.657caedc@twelve2.svl.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 22 May 2017 16:36:34 -0700
Message-ID: <CAGZ79kYQj-RECTiGkSV9PS5eD=6_s27CSpaF1tX6Ek34eajH=w@mail.gmail.com>
Subject: Re: [PATCHv3 04/20] diff.c: teach emit_line_0 to accept sign parameter
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Brandon Williams <bmwill@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 18, 2017 at 4:33 PM, Jonathan Tan <jonathantanmy@google.com> wrote:

> I know I suggested the paragraph above, but after rereading your patch
> set, I think I finally understand what you're trying to accomplish.
> I think it's better to combine patches 4/20, 5/20, and 6/20, with the
> following commit message:

and patch 7/20 (diff.c: inline emit_line_0 into emit_line)

>   diff: introduce more flexible emit function
>
>   Currently, diff output is written either through the emit_line_0
>   function or through the FILE * in struct diff_options directly. To
>   make it easier to teach diff to buffer its output (which will be done
>   in a subsequent commit), introduce a more flexible emit() function. In
>   this commit, direct usages of emit_line_0() are replaced with emit();
>   subsequent commits will also replace usages of the FILE * with emit().

ok. sounds reasonable to me. I kept them separate for easier review
originally, but I can certainly combine them again.

>
> And the function itself can be documented this way (with the appropriate
> formatting):

I have some documentation in 19/20 in diff.h for the data structure stored.
We'd want to discuss where to put the documentation. I'd not like to add
such documentation to some static function in diff.c but rather only document
the data structure, and then (after in-lining <...>_0 to emit_line) keep the
function documentation rather short as:

/* see struct buffered_patch_line */
static void emit_line(...lots of args...)
{
    /* work on said data structure */
    ...


> If you do all that, then the buffering patch (19/20) can be improved by
> adding this comment somewhere in the file:
>
>   Buffer the diff output into ??? instead of immediately writing it to
>   "file".
>
>   NEEDSWORK: The contents of the ??? array - in particular, how the diff
>   output is divided into array elements - is not precisely defined; some
>   functions may emit a line all at once (resulting in one element)
>   whereas some others may emit a line piecemeal (resulting in more than
>   one element). Ideally, the code in this file should be structured so
>   that we do not have such imprecision, but in the meantime, callers
>   that request buffering should ensure that the diff output is divided
>   the way they expect (and have tests to ensure that it remains so).

I want to rename that struct to "buffered_diff_piece" or
"partial_diff_output", not implying we have a line or other another
specific piece.

Rethinking the discussion with Junio, what the correct abstraction level is,
we could even name it "one_color_piece", or "colored_diff_part", to
imply we'd want to have as much content as possible in the same
color. (And line endings always being in RESET color, we'd have a
natural separation at EOL)

>
>> With this patch other callers hard code the sign (which are '+', '-',
>> ' ' and '\\') such that we do not run into unexpectedly emitting an
>> erroneous '\0'.
>
> I still don't understand this paragraph - can you rewrite this in the
> imperative tense?

As in this patch the function signature is the same, but just changes
meaning of one of the arguments, one could imagine that there
could be a caller with first='\0' given some interesting data/mode of operation,
which would have instructed to literally output a '\0'. We would not do this
any more as the meaning changed.

However this hypothetical subtle bug was not introduced, because
there are no callers that call the function with a 'first' depending on
user provided data or otherwise hard-coded  expectation of a '\0' output.

Maybe I'll just drop this part.
