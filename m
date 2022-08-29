Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4B2CECAAA4
	for <git@archiver.kernel.org>; Mon, 29 Aug 2022 17:41:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbiH2Rld (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Aug 2022 13:41:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiH2Rlc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Aug 2022 13:41:32 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2FD553013
        for <git@vger.kernel.org>; Mon, 29 Aug 2022 10:41:31 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id jm11so8680537plb.13
        for <git@vger.kernel.org>; Mon, 29 Aug 2022 10:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date;
        bh=1JBhyPjNkwubP1ut/M83ilAuFfZfq9Fqu/AShk8eq9Y=;
        b=aid7JW1e9c6ZH2yEeDw6vYvHgl4gayIOa1rg/JyTSRkG+VpIuXU/MP9PDrWEbw7g/3
         J8fxUb+VAp4uj5eUr0949lUu6rTgaVgGGrAIYG/5jRpEjv5BBG99163KszdU9C1bfCS2
         tD90/jxwKw5y39Rt+nusEsNul+uFSRbn+FLfXPxl0TC7cq0AEcb8j/xIfzrSpV0n6Ddj
         OkDRB1vBTJB7NtsFWTX/oICzYdhGXE6OoCFMzdg7iG8fMfI6DK++uK6kR5qs3PQqoDp/
         +uZ9nBhtVB4+jN4ey3s5SkZtMNjEm0ImhNrVi+9JEG7r3idHm8qFbz4QI5nxl1l5E0Ej
         ytaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date;
        bh=1JBhyPjNkwubP1ut/M83ilAuFfZfq9Fqu/AShk8eq9Y=;
        b=PzF1j1e1yzc+IqmGirsW2WzVOG81OgazrJXPRx2ARD+7vbNXzSl7w9c8EByWlXvKtC
         JcGFSIXAuJQdgrB6qsTqtcLFpW6ai0YhokuvjrbEku1XeD8iRI/FxQGHlB2xSg1XaYUu
         TQA/hK2I1rqlY9j3ZurCTJZjKgaDharNOEF5XLVlh4wK/SsVXMF9gWmpWxauhYXhn13Y
         zyJLAkr1UepOG4JLyHmeI4YMvuO4zZy9IrW9njr1s7/mm9rP41oYeFagTgdW6t8YcSM3
         K3OyZZCmQ+nQ/B6StMqDlxYCsjL+vVNUltgsB11NdsrkXSNASxDeEiER2E2i4sjAbzIW
         Y6/g==
X-Gm-Message-State: ACgBeo1kt4TVv7P/srNl/gkHGGCwVW2bOTool7EZmklvboSIgBMxWuCz
        SjK7y7On5MQeqtT0poip+vQ76qhtUgs=
X-Google-Smtp-Source: AA6agR7oOAvYuDqIomrHUaCsNOCz8TTsQ++WRxKndazvzBY1Vwa8eZ2Y0gyPO9nbNRxqq2Dc+vc3sA==
X-Received: by 2002:a17:902:f711:b0:170:9e3c:1540 with SMTP id h17-20020a170902f71100b001709e3c1540mr17197209plo.22.1661794891226;
        Mon, 29 Aug 2022 10:41:31 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id b4-20020a63d304000000b0042c60bef7b5sm1133724pgg.85.2022.08.29.10.41.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Aug 2022 10:41:30 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/2] format-patch: allow forcing the use of in-body
 From: header
References: <20220826213203.3258022-1-gitster@pobox.com>
        <20220826213203.3258022-3-gitster@pobox.com>
        <q84op991-3s0n-r0q5-32pn-096595o03rs8@tzk.qr>
Date:   Mon, 29 Aug 2022 10:41:30 -0700
In-Reply-To: <q84op991-3s0n-r0q5-32pn-096595o03rs8@tzk.qr> (Johannes
        Schindelin's message of "Mon, 29 Aug 2022 13:48:05 +0200 (CEST)")
Message-ID: <xmqqilmbne0l.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> Note.  This is an uncooked early draft.
>
> Did you mean to mark the patch as [RFC], then?

It is mixture between that and WIP.

>> Things to think about include (but not limited to, of course):
>>
>>  * Should this rather be --use-inbody-from=yes,no,auto tristate,
>>    that defaults to "auto", which is the current behaviour i.e.
>>    "when --from is given, add it only when it does not match the
>>    payload".  "yes" would mean "always emit the --from address as
>>    in-body From:" and "no" would mean ... what?  "Ignore --from"?
>>    Then why is the user giving --from in the first place?
>
> I would offer up the suggestion `--in-body-from={never,always,auto}` for
> consideration.

That is essentially the same as the "Boolean plus auto" tristate, a
very common pattern in our UI.  The problem is that false-never-no
does not make much sense in this case, because you do not need it.
You can instead refrain from passing --from to achieve the same
effect.

>>  * Should it be "inbody" or "in-body"?
>
> The latter.

OK.  This cascades up to 1/2 (there is a new helper function with
the phrase in its name).

>>  * Should it have a corresponding configuration variable?
>
> Probably. The commit message talks about mailing lists requiring different
> behavior from the default, which is likely to affect all patches generated
> from a corresponding local checkout. Having a config variable would lower
> the cognitive burden of having to remember this process detail.

OK.

>> diff --git a/builtin/log.c b/builtin/log.c
>> index 9b937d59b8..83b2d01b49 100644
>> --- a/builtin/log.c
>> +++ b/builtin/log.c
>> @@ -1897,6 +1897,8 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
>>  			   N_("show changes against <refspec> in cover letter or single patch")),
>>  		OPT_INTEGER(0, "creation-factor", &creation_factor,
>>  			    N_("percentage by which creation is weighted")),
>> +		OPT_BOOL(0, "force-inbody-from", &rev.force_inbody_from,
>> +			 N_("Use in-body From: even for your own commit")),
>
> Please start the usage text in lower-case, to keep it consistent with the
> rest of the usage texts.

Right.

> Also, I would like to avoid the personal address "you" in that text, and
> also the verb "use". Maybe something like this:
>
> 	show in-body From: even if identical to the header

Much nicer.  I'll take it.

>> diff --git a/pretty.c b/pretty.c
>> index 51e3fa5736..e266208c0b 100644
>> --- a/pretty.c
>> +++ b/pretty.c
>> @@ -483,6 +483,8 @@ static int use_inbody_from(const struct pretty_print_context *pp, const struct i
>>  		return 0;
>>  	if (ident_cmp(pp->from_ident, ident))
>>  		return 1;
>> +	if (pp->rev && pp->rev->force_inbody_from)
>> +		return 1;
>
> It would probably make sense to move this before `ident_cmp()`, to avoid
> unneeded calls ("is the ident the same? no? well, thank you for your
> answer but I'll insert the header anyway!").

I tend to prefer adding new things at the end when all things are
equal, but in this case the new thing is an overriding condition, so
it does make sense to have it before the call.

>> diff --git a/revision.h b/revision.h
>> index bb91e7ed91..a2d3813a21 100644
>> --- a/revision.h
>> +++ b/revision.h
>> @@ -208,6 +208,7 @@ struct rev_info {
>>
>>  	/* Format info */
>>  	int		show_notes;
>> +	unsigned int	force_inbody_from;
>
> The reason why this isn't added to the `:1` bits below is probably the
> anticipation of the tri-state, but if that tri-state never materializes,
> adding it as a bit is still the right thing to do.

It might make sense to turn this into the common "Boolean plus auto"
tristate, but the utility of "no" in this case is dubious, so I was
not planning to go that route.

This member is a full fledged word because the address of it given
to OPT_BOOL(), and we cannot take an address of a bitfield member in
a struct.

Bit-pinching in this struct is not very useful.  Even if we traverse
a million commits in a single run, we will use a single "struct
rev_info" instance.

Thanks for reading it over.
