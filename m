Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B240D1F404
	for <e@80x24.org>; Thu,  8 Feb 2018 21:19:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752237AbeBHVTL (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Feb 2018 16:19:11 -0500
Received: from mail-yw0-f173.google.com ([209.85.161.173]:34524 "EHLO
        mail-yw0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752054AbeBHVTK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Feb 2018 16:19:10 -0500
Received: by mail-yw0-f173.google.com with SMTP id w144so1877ywa.1
        for <git@vger.kernel.org>; Thu, 08 Feb 2018 13:19:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=2Dmi5edFKnPX4dnM61DOQUNsrVuvHZ2V1FWhwrDcbWI=;
        b=CgxTdFnHZBLHDikuSF3prj2UIUJCseTlMYIFvV/cLJs4PAtG64VquTCODtEDzZf+Wl
         3/XkG4SknKudyAR1BJmOhvxQmjw9tBshfdXHXuy1IULyuaGSiExdxRoQsz/Y6NMCKFkS
         im8k8HhLOdTNze1lY+oKzHVtJSp7GI687Lqx/u3vU4HgXW36Wms3zVGJoIClrslcJlAM
         t2y36fAwxwkYt/5DYbsGFu+kLDynPYiACEQNTCukx5G0ybcSCsJeZgMF/PNJZ5p8ygbx
         CbreOwl8MrVN72PiNTjhVFHsq6dcrx9vkACWNSs4oTz6kpim76FBNQxO65rXzU4JwlRs
         W6oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=2Dmi5edFKnPX4dnM61DOQUNsrVuvHZ2V1FWhwrDcbWI=;
        b=fAtlVVKcZgf3ick0P7DV85rsDvSQBh7sW60uVkc8V9nJ3ALGKslaUjcb8BBs2O3BBQ
         tomiGn2TWRstJAoe3cA/9SKjTwCdN4E5blBk27jn9d2mCa0IRb5HhbmIdrsqCu1fDvqo
         J+94KpkJSfyVTORl7pOMutB/KTRc7KN5CWtzwZfLRyt7PGi6FyS2YYoa4D7lKGyEd+VB
         Ui7JYFZ/VBOckctMJ1kLLvF0yOg4n3AhvWIZaI2vY8TJUn81OmgmNIm59Hnyq9nhOAUT
         a7V5HMG6oPqf7Iax3fD75VjO64FV8158ch8B3fjcmjc0LxtqpEjDCqmDrU/Szxw8qm+6
         +LMQ==
X-Gm-Message-State: APf1xPAn03DVUejl5cifhdxtOi8JbZuXycgvWGDKkc5r3DHGzKT6wfvw
        00UkZ8xk8Zx5U3T/3FzsrIOlk/BQdiydNDmBAVkDPMGr83c=
X-Google-Smtp-Source: AH8x225CyOI1ENbLwvUqD6xmintehUxWa1Ekcfqd9IpyibWWsiB64JqIiFAxMhD3ynIOBas86gJovPxyO14P5kK+ySA=
X-Received: by 10.37.59.204 with SMTP id i195mr323522yba.420.1518124749715;
 Thu, 08 Feb 2018 13:19:09 -0800 (PST)
MIME-Version: 1.0
Received: by 10.37.207.9 with HTTP; Thu, 8 Feb 2018 13:19:09 -0800 (PST)
In-Reply-To: <xmqqk1ws87qw.fsf@gitster.mtv.corp.google.com>
References: <20171110011002.10179-1-sbeller@google.com> <20180104224007.214548-1-sbeller@google.com>
 <20180104224007.214548-3-sbeller@google.com> <xmqqk1ws87qw.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 8 Feb 2018 13:19:09 -0800
Message-ID: <CAGZ79kZKaKuvF2mp2r7Vt_3r73m7BmFqc_VPctKezR7gXQTx_A@mail.gmail.com>
Subject: Re: [PATCHv3 2/4] builtin/blame: dim uninteresting metadata
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 8, 2018 at 11:34 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> +color.blame.repeatedMeta::
>> +     Use the customized color for the part of git-blame output that
>> +     is repeated meta information per line (such as commit id,
>> +     author name, date and timezone). Defaults to dark gray.
>> +
>> ...
>
> "Dark gray on default background" may alleviate worrries from those
> who prefer black ink on white paper display by hinting that both
> foreground and background colors can be configured.
>
> Do we want to make this overridable from the command line,
> i.e. --color-repeated-meta=gray?
>
>> +#define OUTPUT_COLOR_LINE    02000
>
> The name of the macro implies that this is (or at least can be) a
> lot more generic UI request than merely "paint the same metadata on
> adjacent lines in a different color".
>
>> +             OPT_BIT(0, "color-lines", &output_option, N_("color redundant metadata from previous line differently"), OUTPUT_COLOR_LINE),
>
> Should this eventually become "--color=<yes,no,auto>" that is more
> usual and generic, possibly defaulting to "auto" in the future, I
> wonder?

This sounds like a good change to make, though what does "yes"
mean here? The following patches introduce other modes of
colorization, such that --color=<no, auto, lines, fields, decayed>
would make sense to me, with "lines" as the mode of this patch,
"fields" implemented in the next patch and "decayed" having the
meaning of the heating algorithm presented in the last patch.

However each of these (except no and auto) would want to have
extra parameters, which as mentioned above could go into its own
separate parameters, such that

  git blame --color=line --color-repeated-meta=cyan

would seem like a good UI. This might look like it could be a good
idea to have --color-repeated-meta imply --color=<line,auto> if no
--color is given. But as different coloring modes will have different
arguments to provide extra color information, I wonder what we
would do with

  git blame --color="mode1" --extra-color-arg-for-mode-2

So I don't think the idea of having separate options would be a
good idea as we'd have to think about the implications as mentioned
above. So maybe

  git blame "--color=lines,cyan yellow"

would work, if you want "cyan yellow" as the color configuration in
the "lines" mode? (bad choice of a background color btw)

>> diff --git a/color.h b/color.h
>> index 2e768a10c6..2df2f86698 100644
>> --- a/color.h
>> +++ b/color.h
>> @@ -30,6 +30,7 @@ struct strbuf;
>>  #define GIT_COLOR_BLUE               "\033[34m"
>>  #define GIT_COLOR_MAGENTA    "\033[35m"
>>  #define GIT_COLOR_CYAN               "\033[36m"
>> +#define GIT_COLOR_DARK               "\033[1;30m"
>>  #define GIT_COLOR_BOLD_RED   "\033[1;31m"
>>  #define GIT_COLOR_BOLD_GREEN "\033[1;32m"
>>  #define GIT_COLOR_BOLD_YELLOW        "\033[1;33m"
>
> How about using CYAN just like "diff" output uses it to paint the
> least interesting lines?  That way we will keep the "uninteresting
> is cyan" consistency for the default settings without adding a new
> color to the palette.

sounds good, I'll take that suggestion once we reach consensus on
the UI for the user.

Thanks,
Stefan
