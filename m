Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AA8CC433EF
	for <git@archiver.kernel.org>; Thu,  3 Feb 2022 18:05:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350895AbiBCSFH (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Feb 2022 13:05:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233598AbiBCSFG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Feb 2022 13:05:06 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D090C061714
        for <git@vger.kernel.org>; Thu,  3 Feb 2022 10:05:06 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id w14so7702254edd.10
        for <git@vger.kernel.org>; Thu, 03 Feb 2022 10:05:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=oYW0fb5L8Wwdrz9gSDxiIs+O7hCK6KYTzihVLErUxiY=;
        b=SBfFi1RExUFaMgrIqUZl4208TkpT2y1q/2r3WlZm260TnmAexYuegDgjSx1oQ7EGvy
         DsbnjleWjEA6MTGtmmXl1+WNiHLQ9YYhj6ivfeqxqScYOa1CVZWr5NZiLzFxCGATzfuO
         oQj2p8G6Rbdfj7zKGWHRfevJoKzUP3q9nVBnlXHqwn15xkVRo1urYaT80ErUihgux0pc
         cqZhUVYIWm2uCQTeZkHw2j1wvCqnUirN6LpVGwOWP70EX3fFarem92LLFjO0CVhixA6j
         NTBfV+o9fJjkrZM3ZgF8VfIUFxFG7r4f3fk/7Ucc/gEFpkGO1xrM1tT6be0TwMe2UBj1
         Yq3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=oYW0fb5L8Wwdrz9gSDxiIs+O7hCK6KYTzihVLErUxiY=;
        b=XtoqqzLO5M6G3evd1SPeDcduC4qlngu0VCXfm3phOGVOGL/X2mLcLdIMqZBlXwaB0D
         WOv3yE8/E/x5NAu4dnwWEh1N0YQ5QYf+yHLIYdAEt5zvkgXd2TmH02sf6cazpZiQjrg2
         sNUQB46M1pzV6LdXf49bRy63xSxUKKjiq/pPQdBG17yN84HpRPmeJ8HKiNbxwsEf1/bv
         yDnb/v2tDUuCRgHProVI0liOhJnTo7dwQ2O/FG/LrWkC1TFeyZnWRPjcu916Ay6XcyIn
         kufkfBzYy5xoNK0TM6pMq2oZQH+/qiQK2kenj1thVgqKEWg53VCl3SVAmNvP7DUDVgJ2
         cnIg==
X-Gm-Message-State: AOAM533xV98KnNv4/2IoVPf5MmJY56e4KWt1kgtxNmvanfvgfu85+mLl
        X0qT/KP03wMMNgx4xvaDvS0=
X-Google-Smtp-Source: ABdhPJyH+qwKfI7vp4ympmRuMCPgYHamvUVneC/wVX+UiMcLXn0HMPRV8aIDJTBKdlP3T4Ig1x6/Fg==
X-Received: by 2002:a05:6402:1617:: with SMTP id f23mr36431665edv.252.1643911504942;
        Thu, 03 Feb 2022 10:05:04 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id g15sm22668215edy.77.2022.02.03.10.05.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Feb 2022 10:05:04 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nFgTf-0057Zg-2r;
        Thu, 03 Feb 2022 19:05:03 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Han-Wen Nienhuys <hanwen@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: [PATCH v2] refs.h: make all flags arguments unsigned
Date:   Thu, 03 Feb 2022 18:53:55 +0100
References: <pull.1210.git.git.1643660136530.gitgitgadget@gmail.com>
 <pull.1210.v2.git.git.1643719616840.gitgitgadget@gmail.com>
 <220201.86ilty9vq2.gmgdl@evledraar.gmail.com> <xmqq8ruub35i.fsf@gitster.g>
 <CAFQ2z_Oxq67XO20oG7Tokk48wm5ZzHRR3GDi4PG5wg7FMJ89aA@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <CAFQ2z_Oxq67XO20oG7Tokk48wm5ZzHRR3GDi4PG5wg7FMJ89aA@mail.gmail.com>
Message-ID: <220203.8635kz6d2o.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Feb 03 2022, Han-Wen Nienhuys wrote:

> On Wed, Feb 2, 2022 at 12:03 AM Junio C Hamano <gitster@pobox.com> wrote:
>>
>> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>>
>> > The post-image LGTM, but I'm also a bit "meh" on the churn just for
>> > signed->unsigned, especially given the conflict with my in-flight
>> > ab/no-errno-from-resolve-ref-unsafe. But it's not too bad, and if Junio
>> > hasn't complained about it...
>>
>> I won't complain myself.  I'd still try to help newer developers,
>> but my intention is to make it the responsibility for individual
>> developers to make sure their topic works well with topics in
>> flight ;-)
>
> I'm sending v3 based on seen.
>
>> Between "enum" and #define that is stored in "unsigned", neither
>> gives us much type safety in C; "enum" may be somewhat worse by
>> giving a false sense of having a type safety that does not really
>> exist, than "unsigned int" that is more honestly defeats such a
>> false sense of safety.  So I have no strong preference either way.
>
> Neither gives true type safety, and I don't know if an enum is kosher
> at all; shouldn't the value always be one of the enumerees, strictly
> speaking?

No, it's nice so you can use it in switch/case, but it's also a
perfectly legit use-case to use it for bitfields.

And as I noted e.g. gdb will understand that and give you pretty-printed
flags based on that, which is very nice for debugging.

And it's also just nice for readability and source navigation. I.e. if
it's "unsigned int foo_flags" and I find "foo_flags" with [ce]tags I'll
only find all other uses of "foo_flags".

Whereas the enum will give me its definition, which usually has comments
etc.

To be fair it's usually easy to find it even without that, because
you'll find a use of a relevant "#define" pretty soon, and can navigate
to that. But sometimes that's 1-2 functions away if the flag is being
passed along.

So being able to navigate straight from the function arguments is nice,
as you can do with structs and other types.

> I proposed both options because a distinct typename lets me jump to
> the definition of the flags easily through ctags.

I'm not sure I understand you here. I use ctags (via Emacs) and it's
perfectly capable of finding both "enum xyz" and "typedef enum { ... }
xyz":
=20=20=20=20
    $ make TAGS
    $ grep -e rewrite_result -e parse_opt_option_flags TAGS
    static enum rewrite_result line_log_rewrite_one(1285,32804
    enum parse_opt_option_flags 39,772
            enum parse_opt_option_flags flags;137,4133
    static enum rewrite_result rewrite_one_1(3608,101152
    static enum rewrite_result rewrite_one(3645,102081
    enum rewrite_result 445,12193
    typedef enum rewrite_result (*rewrite_parent_fn_t)rewrite_parent_fn_t45=
1,12279

Hrm, that's etags actually, but the same is true of "make tags":
=20=20=20=20
    $ grep -e rewrite_result -e parse_opt_option_flags tags
    line_log_rewrite_one    line-log.c      /^static enum rewrite_result li=
ne_log_rewrite_one(st/
    parse_opt_option_flags  parse-options.h 39
    rewrite_one_1   revision.c      /^static enum rewrite_result rewrite_on=
e_1(struct re/
    rewrite_one     revision.c      /^static enum rewrite_result rewrite_on=
e(struct rev_/
    rewrite_result  revision.h      445

In any case, both [ce]tags find a typdef'd and non-typedef'd variant,
don't they?

> Another idea is to mark the type of the flags by its name, eg.
> transaction_flags, resolve_flags, reftype_flags etc. This wouldn't
> help with ctags, but it does help with readability.

Yes, enums or not, what I was also pointing out in
https://lore.kernel.org/git/220201.86ilty9vq2.gmgdl@evledraar.gmail.com/
is that changing just one logical set of flags at a time would make this
much easier to review.

It doesn't matter for the end result as long as we end up with "unsigned
int" everywhere, but would with enums.

