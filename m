Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A5DCD1F597
	for <e@80x24.org>; Thu, 19 Jul 2018 16:29:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731812AbeGSRNb (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Jul 2018 13:13:31 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:50187 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731690AbeGSRNa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jul 2018 13:13:30 -0400
Received: by mail-wm0-f65.google.com with SMTP id v25-v6so6860363wmc.0
        for <git@vger.kernel.org>; Thu, 19 Jul 2018 09:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=Vp+bztCppc6RnMBptSy4EKy3/eDwVHP0StYzX3c2Z1s=;
        b=bnHyyn1ZwdjDumG/c6DilDo/vhX0VMLXZNUHDN+gDTEl4iWA4kYEkzuVi+C+BnYShB
         Xm71nyvEBLMfzMoxuLhXCziC9hsizbR0DlboyVS4qYiSt8L/ydE1UATJLPn/VNh2kCbc
         iwdurwFqB0azUKCCc7tChVOlpunHsmfjd8MAhUNISZ3R3EYVQgNf1r+aGsJP7Gl76RCM
         J7Sky6BGAunCNgxUZCXNzB2O4gTlZNy+caA4R6TW3OoY7s7UtTVJmU04i1YDgg03+SVF
         jztHgmmYMovVsgboegPOz6obcZyOy+9O8HK4Lq3ZmlPDEehDyUI+KFQmkOkZKA6paBFW
         s8ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=Vp+bztCppc6RnMBptSy4EKy3/eDwVHP0StYzX3c2Z1s=;
        b=DRMjiq8mo6kTcy9biBRSJinU8Bp08n0zwZ7dH1iKD9+bymOk6zUm64h2IGhoYLCHnA
         6TQhliKCzUPFlffCGEgfl7AG351WvoKQCnDQ9LHGsXK1sdi+g1aiBxMiQWNOwXQlk+yf
         XrMmNkDeRLaIGTSJtFv4S+akCKEg65xc/ympbzdBn7IFsSqaE0kfTtFmIxrVt0WhLbPl
         oKb/PTidFrFcxTb4jaNxdRx7L29bPc6pOt6ktTvGfMh5XU9tVVwZmzXoJdpmT5FFZx/B
         Z1iZ5jON+ogRHMmx9uFyJ3uFa4chohxObxo0Gsvfi3ptq5ATIWVAAlOvpwTgeYTwtpdQ
         EbzQ==
X-Gm-Message-State: AOUpUlFHrEUplfMfy5T/iWX5IbIP185RaP23ZxFMFjySqE56CzDg/Dip
        +ZlSFjYsCsu6YcIRaMens7o=
X-Google-Smtp-Source: AAOMgpfNoU8oYqgvuICXiewO06KCunM+dG15nB7kO06p49TdmN4/ma2VMKbDsXk+O0GMMDhbNJXHgg==
X-Received: by 2002:a1c:3:: with SMTP id 3-v6mr52305wma.99.1532017773267;
        Thu, 19 Jul 2018 09:29:33 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id r1-v6sm6927998wrs.39.2018.07.19.09.29.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 19 Jul 2018 09:29:31 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git <git@vger.kernel.org>
Subject: Re: [PATCH] diff.c: offer config option to control ws handling in move detection
References: <20180718005311.136329-1-sbeller@google.com>
        <xmqqy3e8jv4x.fsf@gitster-ct.c.googlers.com>
        <CAGZ79kbOxD-GomEYGkOPe9bPT8sgik77hLaTHK1xN9Hk=g+BvA@mail.gmail.com>
Date:   Thu, 19 Jul 2018 09:29:30 -0700
In-Reply-To: <CAGZ79kbOxD-GomEYGkOPe9bPT8sgik77hLaTHK1xN9Hk=g+BvA@mail.gmail.com>
        (Stefan Beller's message of "Wed, 18 Jul 2018 11:16:47 -0700")
Message-ID: <xmqqtvovgped.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> On Wed, Jul 18, 2018 at 10:45 AM Junio C Hamano <gitster@pobox.com> wrote:
>>
>> Stefan Beller <sbeller@google.com> writes:
>>
>> > diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
>> > index 143acd9417e..8da7fed4e22 100644
>> > --- a/Documentation/diff-options.txt
>> > +++ b/Documentation/diff-options.txt
>> > @@ -294,8 +294,11 @@ dimmed_zebra::
>> >
>> >  --color-moved-ws=<modes>::
>> >       This configures how white spaces are ignored when performing the
>> > -     move detection for `--color-moved`. These modes can be given
>> > -     as a comma separated list:
>> > +     move detection for `--color-moved`.
>> > +ifdef::git-diff[]
>> > +     It can be set by the `diff.colorMovedWS` configuration setting.
>> > +endif::git-diff[]
>>
>> The patch to diff.c::git_diff_ui_config() we see below does not seem
>> to make any effort to make sure that this new configuration applies
>> only to "git diff" and that other commands like "git log" that call
>> git_diff_ui_config() are not affected.
>
> That is as intended. (We want to have it in git-log)

Ah, I think what is going on here, and I think I asked a wrong
question.

 * diff-options.txt is used by the family of diff plumbing commands
   (which actively do not want to participate in the coloring game
   and do not call git_diff_ui_config()) as well as log family of
   commands (which do pay attention to the config).

 * "git grep '^:git-diff:'" hits only Documentation/git-diff.txt.

What the system currently does (which may not match what it should
do) is that Porcelain "diff", "log", etc. pay attention to the
configuration while plumbing "diff-{files,index,tree}" don't, and
use of ifdef/endif achieves only half of that (i.e. excludes the
sentence from plumbing manual pages).  It excludes too much and does
not say "log", "show", etc. also honor the configuration.

I think the set of asciidoc attrs diff-options.txt files uses need
some serious clean-up.  For example, it defines :git-diff-core: that
is only used once, whose intent seems to be "we are describing diff
plumbing".  However, the way it does so is by excluding known
Porcelain; if we ever add new diff porcelain (e.g. "range-diff"),
that way of 'definition by exclusion' would break.  The scheme is
already broken by forcing git-show.txt to define 'git-log' just like
git-log.txt does, meaning that it is not possible to make "show" to
be described differently from "log".  But let's leave that outside
this topic.

Back to a more on-topic tangent.

How does this patch (and all the recent "color" options you added
recently) avoid spending unnecessary cycles and contaminating "git
format-patch" output, by the way?  builtin/log.c::cmd_format_patch()
seems to eventually call into git_log_config() that ends with a call
to diff_ui_config().

Thanks.
