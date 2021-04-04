Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 602CAC433B4
	for <git@archiver.kernel.org>; Sun,  4 Apr 2021 05:35:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1EFD461365
	for <git@archiver.kernel.org>; Sun,  4 Apr 2021 05:35:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232303AbhDDFe6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 4 Apr 2021 01:34:58 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:50743 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbhDDFe5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Apr 2021 01:34:57 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id CF6D210E075;
        Sun,  4 Apr 2021 01:34:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=H6kL86zpJ1lix6JWfM52kc54UOk=; b=xa59VC
        Qy6H3HTuvfK26z3A7rFdStc9nFpxx11NFvzrvYD3lJuqo9KBTpQZydjUiofp5DSr
        2dSuAZwBH3qw4zNUb3pAloLm6Xwcldgyy3rWnanGzIArZeu0SFLiZSO2SakrT5zI
        e7SmI2aDOwHacYE83iiZuvS21U1GeLd2NsmN4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=UQ2uSgn/dmMdqO+4PX2pj5+eyZBf50YO
        2swU8oj8QV3FGxATBqCbcqheFnbCsCdobDDFqTaYr0DBgHTQuVs2Ha9sCTC4jSlP
        78KSXKBJWfuy5zEi1KjKNxOMm5UE6eUKsWZgWXdgDYk51egbDvExrqLRe3BQuNMe
        06QvmsGTy6Q=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id BAF3310E074;
        Sun,  4 Apr 2021 01:34:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id E057A10E072;
        Sun,  4 Apr 2021 01:34:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     ZheNing Hu <adlternative@gmail.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v6] [GSOC] trailer: add new trailer.<token>.cmd config
 option
References: <pull.913.v5.git.1617185147.gitgitgadget@gmail.com>
        <pull.913.v6.git.1617369973328.gitgitgadget@gmail.com>
        <xmqqim544dl4.fsf@gitster.g>
        <CAOLTT8Tq+-tRzgG1AFD2cE2Vp9z3E94eW1eyN2BxKKg17FzTng@mail.gmail.com>
Date:   Sat, 03 Apr 2021 22:34:47 -0700
In-Reply-To: <CAOLTT8Tq+-tRzgG1AFD2cE2Vp9z3E94eW1eyN2BxKKg17FzTng@mail.gmail.com>
        (ZheNing Hu's message of "Sat, 3 Apr 2021 13:08:05 +0800")
Message-ID: <xmqqa6qezk7c.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 78D2CF1A-9507-11EB-B409-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

ZheNing Hu <adlternative@gmail.com> writes:

>> >  If some '<token>=<value>' arguments are also passed on the command
>> >  line, when a 'trailer.<token>.command' is configured, the command will
>> >  also be executed for each of these arguments. And the <value> part of
>>
>> This talks about 'trailer.<token>.command'.  Should this be changed
>> to '.cmd'?
>>
>> Or does everything after "When this option is specified, if there is
>> no trailer with ..." apply to both the old .command and new .cmd?
>> If so, that was not clear at all---we'd need to clarify this part.
>>
>
> Because ".command" will be eliminated, may be only leave those
> description Information to ".cmd" is better.

Not really.

Until .command goes away, people who want to migrate a config file
written in the .command days to .cmd would need to know what rules
govern .command variant.  Otherwise they would not know what the
original they inherited, using .command, wanted to do, and have no
way to emulate it with the new .cmd approach.  If something is
shared between the two, at least you need to mention that it applies
to both.

Until .command actually gets removed, that is.

>> Unusual indentation here.  But more importantly, I am not sure if
>> having both 'see' and 'help' examples is worth it---they are similar
>> enough that the second one does not teach anything new to those who
>> studied the first one already, aren't they?
>>
>
> Ok, I will think about other examples.

Or just use one, and let somebody else in the future encounter real
world example that is different enough to come up with a follow up
patch to describe that example.

>> > diff --git a/trailer.c b/trailer.c
>> > index be4e9726421c..6aeff6a1bd33 100644
>> > --- a/trailer.c
>> > +++ b/trailer.c
>> > ...
>> > -     strvec_push(&cp.args, cmd.buf);
>> > +     if (conf->cmd) {
>> > +             // cp.shell_no_implicit_args = 1;
>>
>> Do not add new code that is commented out.  Besides we do not use // comment.
>>
>> > +             strbuf_addstr(&cmd, conf->cmd);
>> > +             strvec_push(&cp.args, cmd.buf);
>> > +             if (arg)
>> > +                     strvec_push(&cp.args, arg);
>>
>> Thanks.
>
> Thanks.

