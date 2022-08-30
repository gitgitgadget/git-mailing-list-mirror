Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BD9CECAAD5
	for <git@archiver.kernel.org>; Tue, 30 Aug 2022 21:11:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230257AbiH3VLc (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Aug 2022 17:11:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbiH3VLb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Aug 2022 17:11:31 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E8CA832D2
        for <git@vger.kernel.org>; Tue, 30 Aug 2022 14:11:30 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id r22so11762004pgm.5
        for <git@vger.kernel.org>; Tue, 30 Aug 2022 14:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date;
        bh=KUG8Pu571lfTVcL2faU36JTJqgoOOzAcDXEmYu9K8jQ=;
        b=JmP/YQ7Ps0TU6inzXBhwIu1Wq4juHH33e/fWdRLdV99g5M6S/8G3RZjywb6Rq7vHMc
         s2GnLCTv0mPQl+048wK4PpF4tOZ6FckKn+wS+USK+GR0ioYiGNR6zwbg0IZvgkRPyX4c
         WwvJf3a+Iyhn4oK5hyWEGJBhPXcVMhb6ovCZaZacWeC8wM53u6W4Wz+/Vsj4va08Jusn
         l5prQNj2PBqXMhNf/DkujFBVyobRDkQz7IHRBRXFEH2cTxmsZdx11eK+77IBJoRhTKtO
         1WHE1PO18ASiH1NnHOQYB/Q+X3+rRcQOtvDrSxi4z8uC3Ytu9lB8grh/vh85PiLkvlfW
         BaHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date;
        bh=KUG8Pu571lfTVcL2faU36JTJqgoOOzAcDXEmYu9K8jQ=;
        b=TPp62bT9rnx3YRJVhfkKnIAtWgjzFs+4aUqhzLMe6UZjlBizxT6+5ceHk0jw7inKQw
         SmYa1LGR7QLjbWE3Gn7WV1UL76gp/uEcY1giayf8pQ/xlb2z0p97BaI9t2iO5P1atO7B
         5XfQqrpEFU5gYHcS3gC6M/CUBZAZCLs82/mNVguCxpOiTGSl7koPCQs7Q+KNi2OmIpY2
         dF/WVA3mzUuT9UHRn2UHft9CQkG95K1akhenYJ2uD40G6Y0S71dGYo/vpdEPFbHekkE2
         YMAuszVNtdzED5K5Tb/xy/IWak7j0/3yWXeoHAJpBVNzsAbZhnR89KPUPl0tDjdwooXU
         IbRQ==
X-Gm-Message-State: ACgBeo0x56/Kq+QBQj4qz1sj/NzWq8pBpL5dKHnZpi4Ljx7VKe515jjs
        7j70DfPrjde4HYpev0Uj5eIAOvTNy40=
X-Google-Smtp-Source: AA6agR5+4aq7GLKgPaFd4D0e6o081DIF+Wi3eb5K5zn+KFACjkC7GSnKEhZVJw3fstFMSw0bv81bHw==
X-Received: by 2002:a05:6a00:e16:b0:537:40a7:b095 with SMTP id bq22-20020a056a000e1600b0053740a7b095mr23263632pfb.64.1661893889509;
        Tue, 30 Aug 2022 14:11:29 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id x5-20020aa79a45000000b0053826eaa1c7sm5482213pfj.22.2022.08.30.14.11.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 14:11:28 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Pranit Bauva <pranit.bauva@gmail.com>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Miriam Rubio <mirucam@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v6 05/16] bisect--helper: make `terms` an explicit
 singleton
References: <pull.1132.v5.git.1661604264.gitgitgadget@gmail.com>
        <pull.1132.v6.git.1661885419.gitgitgadget@gmail.com>
        <92b3b116ef8f879192d9deb94d68b73e29d5dcd6.1661885419.git.gitgitgadget@gmail.com>
Date:   Tue, 30 Aug 2022 14:11:28 -0700
In-Reply-To: <92b3b116ef8f879192d9deb94d68b73e29d5dcd6.1661885419.git.gitgitgadget@gmail.com>
        (Johannes Schindelin via GitGitGadget's message of "Tue, 30 Aug 2022
        18:50:08 +0000")
Message-ID: <xmqqmtblighr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> We tried very hard to keep code in `builtin/bisect--helper.c` in as
> libifyable a state as possible.
>
> However, we are about to migrate this built-in to the `OPT_SUBCOMMAND()`
> API, which does not allow for passing any context (e.g. via a `void
> *data` parameters as they are used in the config API).
>
> Therefore, we _have_ to move the `terms` variable outside of
> `cmd_bisect__helper()` and explicitly make it a singleton (as it
> currently is, anyway).

Well, I do not find the above all that convincing.

I can see that the top-level functions that are called from
OPT_SUBCOMMAND(), because the only thing they get may be argc, argv,
and prefix, may need to access a global variable to keep track of
other states.  But all the helper functions that are called by them,
which are already "kept as libifyable as possible", can be called
with a pointer to that global variable by these subcommand functions
like cmd_bisect_{terms,start,...}().  As long as the libification
boundary is left relatively clean, I do not see the need to churn
this much code to change even the lowest level of helpers to access
the global.

I was actually imagining that these functions that (used to) take a
pointer to "struct bisect_terms" can be moved to the top-level
"bisect.c", together with the code already libified that drive the
"git bisect" program, as part of the "libified part of bisect
engine".

> -static void free_terms(struct bisect_terms *terms)
> +static void free_terms(void)
>  {
> -	FREE_AND_NULL(terms->term_good);
> -	FREE_AND_NULL(terms->term_bad);
> +	FREE_AND_NULL(terms.term_good);
> +	FREE_AND_NULL(terms.term_bad);
>  }

For example, at the tip of 'seen', free_term() are called by
get_terms() and cmd_bisect() and nothing else.  get_terms(), before
this patch deliberately made it less libifiable, used to take a
pointer to "struct bisect_terms", so it is just the matter of
passing what it got from its callers down to free_terms().

get_terms() in turn are called from many places, but as far as I can
see, all the callers are either

 - functions that are OPT_SUBCOMMAND() handler, which should take
   the pointer to the global &global_terms and pass it down to the
   callchain that are "kept libifiable" until this step, or

 - functions that used to take a pointer to "struct bisect_terms"
   before this step, and can just pass it down the callchain.

That is the impression after I tentatively modified the file at the
tip of 'seen' to

    static struct bisect_terms {
            char *term_good;
            char *term_bad;
    } global_terms;

and tried resurrect the "as libified as possible" state for some
call graphs.

Is there a function I missed that MUST access the global *and* also
access pointer given as a parameter?  If there is such a codepath,
that would indeed cause a confusion for future developers and leave
a maintenance burden because developers do not have a clear guidance
which one to use, but I do not think the current (i.e. the state
before this step) "as libifiable as possible" state is not that bad.

Thanks.
