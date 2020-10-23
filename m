Return-Path: <SRS0=cWhr=D6=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8289EC4363A
	for <git@archiver.kernel.org>; Fri, 23 Oct 2020 15:19:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2083A21D47
	for <git@archiver.kernel.org>; Fri, 23 Oct 2020 15:19:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="yWXa7BnB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S465670AbgJWPTm (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Oct 2020 11:19:42 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:64755 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S461904AbgJWPTm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Oct 2020 11:19:42 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 36B04F0352;
        Fri, 23 Oct 2020 11:19:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=FEenK8AQR/b6WslaJnkEv2iaXjw=; b=yWXa7B
        nB06Oj/z+2unoWyIXtCeumX9R3D5RPHRD2MAabetTssDT1ESTErdWBIBgk6CnMVr
        c2xFGwiZyUk8ZsRu8kz4pDjMe7qkg9dlUj/rWXxNon/AdakExCEQU9kqOOmArouH
        O1NJ98YVu6IAqeY+m/T5SUZODVbre+aNubJSM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=pH3LPiga/AcDs+hCwma+E96GalMagcuA
        VRwASGz7V0TM8Lnorxms3cRV58Pzua0bj4zV8xx0FjC3gkqa/EorrIIjRfYvF5Kh
        HFVEHhU8mKSF51YzBQ6zV93Er9O0zOsfCJXChTqQAZ7zWDp+llgEGHCfS5VaQeY5
        tXfEBIOsJ8Y=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2EFFCF0350;
        Fri, 23 Oct 2020 11:19:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 78A5DF034F;
        Fri, 23 Oct 2020 11:19:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Sangeeta NB <sangunb09@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [Outreachy] [PATCH v3] diff: do not show submodule with
 untracked files as "-dirty"
References: <pull.751.git.1602781723670.gitgitgadget@gmail.com>
        <20201022112201.51459-1-sangunb09@gmail.com>
        <xmqqft66m8wm.fsf@gitster.c.googlers.com>
        <CAHjREB4qGO1=XCy-F+H39FP_KU_zZjKCDA=b9JxCe0WZdM06KQ@mail.gmail.com>
Date:   Fri, 23 Oct 2020 08:19:35 -0700
In-Reply-To: <CAHjREB4qGO1=XCy-F+H39FP_KU_zZjKCDA=b9JxCe0WZdM06KQ@mail.gmail.com>
        (Sangeeta NB's message of "Fri, 23 Oct 2020 10:53:19 +0530")
Message-ID: <xmqqr1pphsvs.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 29E9B222-1543-11EB-9DEB-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sangeeta NB <sangunb09@gmail.com> writes:

> Sorry for sending it over and over again. I couldn't figure out why
> the mail is not reaching the community.

FWIW, I'm seeing it for the first time, so no worries ;)

>> This new boolean is meant to be set only when non-default
>> ignore-submodules option is given either from the command line or
>> from the configuration---when the bit is unset, we are told to do
>> whatever it is that is the default for us.
>
> I fear I might not get your question clearly here. But from what I
> understood this boolean( flags.ignore_submodule_set )  is set only
> when diff.ignoreSubmodules is set in user-config.

The four-line paragraph I wrote above is not a question.  It is
normal to "think aloud" to express what the reader understood what
the patch does/intends to do during the review, which gives the
contributor a chance to spot misunderstanding by the reviewer.

In any case, when "git diff --ignore-submodules=<when>" command line
option is parsed, diff_opt_ignore_submodules() gets called, which in
turn calls handle_ignore_submodules_arg(), and you set the bit
there.

So this is not limited to configuration, I think.  Command line
option given by the user can also affect it.

Moreover, wt-status.c:wt_status_collect_changes_index() hardcodes
a call to handle_ignore_submodules_arg() with hardcoded "dirty"
unless the caller specifies s->ignore_submodule_arg.  This is not
even user-config or any user action---it is more like a hardcoded
default.

>> And the default is to flip only this bit on.  Do we need to turn off
>> other bits that submodule.c::handle_ignore_submodules_arg() function
>> touches?  [*1*]
>>
>
> We are not flipping the bit, we are setting it to 1.

Yeah, flipping it to on is setting it to 1.  We are saying the same
thing, aren't we?

> I guess we don't
> have to turn off other bits because in case if
> submodule.c::handle_ignore_submodules_arg() is called we don't have to
> set the default value.
>
> So there's no point in flipping any other bits
> as if any of them is set, the user should have added some arguments in
>  ignoreSubmodules and therefore flags.ignore_submodule_set would be
> set to 1 and we won't be setting the default value.

The reason why a helper function handle_ignore_submodules_arg()
exists in the first place is because the way ignore_* bits are
managed in the diff_options.flags is tricky and with a helper in
between the callers and the actual bits, is easier to update in the
future if needed.

So even if we assume that everybody who reacted to end-user
preference would have called handle_ignore_submodules_arg(), hence
we do not want to force our default when the .ignore_submodule_set
bit set and we do want to do so when the bit is unset, we should
do

	if (!options->flags.ignore_submodule_set)
		handle_ignore_submodules_arg("untracked");

instead of only toggling the .ignore_untracked_in_submodules bit on
manually.

>> I like the general idea of having one bit that is set if and only if
>> the command line or configuration told us specifically what to do,
>> so that we can dictate the default after they were taken care of.
>> ...
>> Even without anticipating such a change in the future, there already
>> is a callsite of this function in wt-status.c that hands a hardcoded
>> string "dirty" to it.  That is *not* caused by an end-user request
>> (be it a configuration variable or a command line option), so in a
>> sense, the assumption is already broken.
>
> I couldn't fully understand what assumption are you talking about. I
> would be glad if you can explain it to me in a little more detail.

Have you looked for "dirty" (with double-quote around the word) in
wt-status.c already?  The call to handle_ignore_submodules_arg(),
which would cause your new bit set, is made not as a reaction to any
end-user input.  Rather it is "if end-user did not say anything, use
this hardcoded setting".  And it overrides the "if the end user did
not specify anything, we want to use this default" logic you added
with this change, because it dictates "dirty" there without end-user
asking.

Is that desirable?  I dunno.

>> Noise.
>>
> I hope this is a substitute for nice. XD. Hearing this after a long
> time. I used to hear this more frequently when I was in college.

I found this change a "noise":

 	strvec_pushl(&cp.args, "status", "--porcelain=2", NULL);
 	if (ignore_untracked)
-		strvec_push(&cp.args, "-uno");
+		strvec_push (&cp.args, "-uno");

If it were going the other direction, "we fix coding style violation
while at it" may be a good justification to do so, but this
particular change (1) is not neeeded for the purpose of this patch,
and (2) is making the code worse by deviating from the coding
guideline.  Please drop it.

Thanks.
