Return-Path: <SRS0=Hc2o=CM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60385C433E2
	for <git@archiver.kernel.org>; Thu,  3 Sep 2020 21:31:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 355E4206D4
	for <git@archiver.kernel.org>; Thu,  3 Sep 2020 21:31:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Ut1vZTEj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728309AbgICVby (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Sep 2020 17:31:54 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58729 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726679AbgICVbw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Sep 2020 17:31:52 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0E09F75796;
        Thu,  3 Sep 2020 17:31:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=XqXL7uTsPU+FGRiRX2LGDT1j8x0=; b=Ut1vZT
        EjfOE0ulNM+33xMdCtgs09PeTMtOXi4T/0aEtaXxnmVytVsDEP7dJlK+Pw+oigrO
        VmK+rW4TJe3Rl7cwVFkCivcTCrnYfg5ErgD44wKHFqFzmk264l6UGmso+zUZAcm+
        i8YDRepEEt8TXuYCyy/4D2R5zzMVFFZgod04k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=tSKYEdXdMoNBntJ9RyJhswMaqWlLCDLi
        ZcxkW2ON73Yl0AyODQr9wuZuqUYxSVt/ybV1LYvLhKG7EiJB0bovGmNKTZc/rUUy
        tXBFbnuNOwd9mwd9JTpv7mAmPvWWxkfLeBxCJlZzirkQGsrErZ5RB3lmwqpC6QYx
        cjrvF7b6WQw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 04BA675795;
        Thu,  3 Sep 2020 17:31:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8561775794;
        Thu,  3 Sep 2020 17:31:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Philippe Blain <levraiphilippeblain@gmail.com>
Cc:     Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>,
        Git mailing list <git@vger.kernel.org>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] Makefile: add support for generating JSON compilation database
References: <pull.714.git.1598815707540.gitgitgadget@gmail.com>
        <pull.714.v2.git.1599001759548.gitgitgadget@gmail.com>
        <xmqq1rjkccw8.fsf@gitster.c.googlers.com>
        <41D647C5-BC9E-431F-BEF9-C0040F4E0C94@gmail.com>
Date:   Thu, 03 Sep 2020 14:31:48 -0700
In-Reply-To: <41D647C5-BC9E-431F-BEF9-C0040F4E0C94@gmail.com> (Philippe
        Blain's message of "Thu, 3 Sep 2020 17:17:23 -0400")
Message-ID: <xmqqpn728s3f.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E0331A98-EE2C-11EA-9CD2-01D9BED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Philippe Blain <levraiphilippeblain@gmail.com> writes:

> This addition to the .gitignore is for the individual JSON files (one per source file), 
> that are placed in the $(compdb_dir). 
> I think naming "rebase.o.json" the JSON file that describes how to compile "rebase.c"
> into "rebase.o" makes sense. I don't know what is the convention for other projects.

I agree rebase.o.$somesuffix does make sense, but I do not know
'json' is a great value for $somesuffix.  I wouldn't be surprised if
'cdb' or some other silly abbreviation for "compilation database" is
how other people use this feature.

Those watching from the sidelines.  Does anybody know if there is an
established convention used by other projects?  If we hear nothing
by early next week, let's declare 'json' is good enough and move on.

> The name `compile_commands.json` for the database itself is standard. 
> The name of the directory where the '*.o.json' files are placed is a name
> I chose, and I don't feel strongly about it. I thought it made sense to name
> it like that, then its purpose is clear.  We could make it a hidden directory 
> if we don't want to add a new folder to the root of the repo when using this feature.

I think both of these are sensible.  Again if we hear nothing about
common practice, let's move on with these constants as-is.

>>> +ifdef GENERATE_COMPILATION_DATABASE
>>> +compdb_check = $(shell $(CC) $(ALL_CFLAGS) \
>>> +	-c -MJ /dev/null \
>>> +	-x c /dev/null -o /dev/null 2>&1; \
>>> +	echo $$?)
>>> +ifeq ($(compdb_check),0)
>>> +override GENERATE_COMPILATION_DATABASE = yes
>> 
>> This feels strange.  If the end user said to GENERATE and we find we
>> are capable, we still override to 'yes'?  What if the end user set
>> 'no' to the GENERATE_COMPILATION_DATABASE macro?  Shouldn't we be
>> honoring that wish?
>
> We should. I'll tweak (and simplify) that for v3.

I think

 - GENERATE_COMPILATION_DATABASE is set to 'no': don't even probe

 - GENERATE_COMPILATION_DATABASE is set to 'yes': probe and turn it
   to 'no' if unavailable.

 - GENERATE_COMPILATION_DATABASE is set to anything else: either
   error out, or turn it into 'no' (I have no preference between
   them).

would cover all the cases.

>>> +compdb_file = $(compdb_dir)$(subst .-,,$(subst /,-,$(dir $@)))$(notdir $@).json
>> 
>> This detail does not matter as long as the end result ensures unique
>> output for all source files, but I am having trouble guessing what
>> the outermost subst, which removes ".-" sequence, is trying to make
>> prettier.  Care to explain?
>
> Yes, it is because the `$(dir $@)` Makefile function will return `./` for source files 
> at the base of the repo, so the JSON files get named eg. `.-rebase.o.json` and then they are 
> hidden. So it's just to make them non-hidden, so as not to confuse someone that would
> count the number of source files and compare with the number of (non-hidden)
>  '*.o.json' files in $(comdb_dir) and get a different number.

Hmph.  Would $(subst /,-,$@) instead of "only substitute leading
directory part, and concatenate the basename part unmolested" work
better then?  After all, by definition the basename part would not
have a slash in it, so substituting all '/' to '-' in the whole
pathname should do the same thing and we won't have to worry about
the spurious './', no?

