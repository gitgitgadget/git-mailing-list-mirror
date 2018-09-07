Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A94C21F404
	for <e@80x24.org>; Fri,  7 Sep 2018 22:01:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726354AbeIHCod (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Sep 2018 22:44:33 -0400
Received: from mail-wm0-f47.google.com ([74.125.82.47]:40096 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726289AbeIHCod (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Sep 2018 22:44:33 -0400
Received: by mail-wm0-f47.google.com with SMTP id 207-v6so15809461wme.5
        for <git@vger.kernel.org>; Fri, 07 Sep 2018 15:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=XAWvBHFAply+ztRKSuyyV8beLRAqHhu6NUjlaTdWpWY=;
        b=NPLy5xWT7n3VZJePIssIzaXCKxmfgqwUKMrAZipm6Fzc7tMIKhaxIzUYTy6uKR4GUE
         YKnospcCHFhYPRSct1CoZRj/7XKSDP6ZHQW81fueeeWSBbnClU4USZPmx/i2SwyM0YOC
         OJjMx8ghMEshe0/HCjV5Zg1r2k5+fVYcZdgJSP4nhadKbIC0ZMT2SgX5jlv6vTmSWo9s
         ND5/RXoEf88gXjD7oziFLtLz4HjYzNg7E0wTBcSMf4S93KbTVj4z2K0SI7/AqrTl6aU8
         r+nf3lXm+/TSdOhG+/JvpPhKQtttmM56yaSTE5Yj0OOUkuclMZGgkd6+0XvHIXWuWltj
         YWmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=XAWvBHFAply+ztRKSuyyV8beLRAqHhu6NUjlaTdWpWY=;
        b=rS8Yyut5kn5Gm7pUWSvkRZVlfFLznhC0xC6WTr9TFnwxqG6fioV+mG9VVZmG3MayCZ
         dUPd3ZXJyBBwcYq8QlzTvyls/mQZPsjlYO5kPfht3G14QK+x1tGjFFTzmHkPTMrEv8M+
         akx3rK4P5Pk9CDZtPYEfV0QKux3z8jm8m42/x85GfaAzXd2HJ+FSPJ56axahuv6fQTYd
         BeaTdaVQzgH0xl21r4G1RBhE4wcG6C8TnXK8rv2RAXphWmczpAGWIx1qNVNAypvAK7W8
         oGiCis7TZF1PAhVWL8ClFtFzAVN4b/00NUKMR3eU3kK1lnKp4BVFqaYYZ3UJVeE6PcIh
         PdYw==
X-Gm-Message-State: APzg51Dhy3QPZxA5eXPFRogfDOH6lk55JulrbqXu9O/RfIiDvji3KEPs
        Zn8YLEISXAN0M2ZVosZn/6w=
X-Google-Smtp-Source: ANB0VdbedFazRWAOFLAPvtHOb7AxwCTZaX5ep4gxKKUhm360QKZyISSpyqcrZ6optWMSbPMlO/i9pg==
X-Received: by 2002:a1c:a8d0:: with SMTP id r199-v6mr5912482wme.97.1536357690161;
        Fri, 07 Sep 2018 15:01:30 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id t132-v6sm8565001wmf.16.2018.09.07.15.01.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Sep 2018 15:01:29 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Stephen P. Smith" <ischis2@cox.net>
Cc:     Git List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v3 4/4] wt-status.c: Set the committable flag in the collect phase.
References: <20180906005329.11277-1-ischis2@cox.net>
        <20180906005329.11277-5-ischis2@cox.net>
Date:   Fri, 07 Sep 2018 15:01:28 -0700
In-Reply-To: <20180906005329.11277-5-ischis2@cox.net> (Stephen P. Smith's
        message of "Wed, 5 Sep 2018 17:53:29 -0700")
Message-ID: <xmqqworxufuv.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Stephen P. Smith" <ischis2@cox.net> writes:

>  void wt_status_collect(struct wt_status *s)
>  {
> +	struct wt_status_state state;
>  	wt_status_collect_changes_worktree(s);
>  
>  	if (s->is_initial)
> @@ -746,6 +752,11 @@ void wt_status_collect(struct wt_status *s)
>  	else
>  		wt_status_collect_changes_index(s);
>  	wt_status_collect_untracked(s);
> +
> +	memset(&state, 0, sizeof(state));
> +	wt_status_get_state(&state, s->branch && !strcmp(s->branch, "HEAD"));
> +	if (state.merge_in_progress && !has_unmerged(s))
> +		s->committable = 1;
>  }

I do not think this is wrong per-se, but now we have three calls to
wt_status_get_state() in wt-status.c, and it smells (at least to me)
that each of these callsites does so only because their callers
do not give them enough information, forcing them to find the state
out for themselves.

Given that the ideal paradigm to come up with the "work tree status"
is to do the collection followed by printing, and among three
callers of get_state(), two appear in the "printing" side of the
callchain [*1*], I wonder if it makes a better organization to

 - embed struct wt_status_state in struct wt_status

 - make the new call to wt_status_get_state() added above in this
   patch to populate the wt_status_state embedded in 's'

 - change the other two callers of wt_status_get_state() in
   wt_longstatus_print() and wt_porcelain_v2_print_tracking(), both
   of which will receive 's' that has been populated by a previous
   call to wt_status_collect(), so that they do *not* call
   get_state() themselves, but instead use the result recorded in
   wt_status_state embedded in 's', which was populated by
   wt_status_collect() before they got called.

That would bring the resulting code even closer to the ideal,
i.e. the "collect" phase learns _everything_ we need about the
current state that is necessary in order to later show to the user,
and the "print" phase does not do its own separate discovery.

What do you think?

Thanks.


[Reference]

*1* Here are the selected functions and what other functions they
    call.

    wt_status_collect()

     -> wt_status_collect_changes_initial()
     -> wt_status_collect_changes_index()
     -> wt_status_collect_untracked()
     -> wt_status_get_state()

    wt_longstatus_print()

     -> wt_status_get_state()

    wt_porcelain_v2_print_tracking()

     -> wt_status_get_state()


    wt_status_print()

     -> wt_porcelain_v2_print()
        -> wt_porcelain_v2_print_tracking()
     -> wt_longstatus_print()


    run_status()

     -> wt_status_collect()
     -> wt_status_print()

    cmd_status()

     -> wt_status_collect()
     -> wt_status_print()


    prepare_to_commit(), dry_run_commit()

     -> run_status()


    Most notably, wt_status_collect() always happens before
    wt_status_print(), which is natural because the former is to
    collect information in 's' that is used by the latter to print.

    And in various functions wt_status_print() calls indirectly, the
    two other callers of wt_status_get_state() appear.
