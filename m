Return-Path: <SRS0=b2TE=AZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09F50C433E0
	for <git@archiver.kernel.org>; Tue, 14 Jul 2020 15:27:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D41BD221ED
	for <git@archiver.kernel.org>; Tue, 14 Jul 2020 15:27:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="dNCJSKgD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726356AbgGNP11 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Jul 2020 11:27:27 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:64891 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725884AbgGNP10 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Jul 2020 11:27:26 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 49B30D59A5;
        Tue, 14 Jul 2020 11:27:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=P3yFXZCqW7RiIl8dGX2RKwHreaE=; b=dNCJSK
        gDpjrW8k1rwezkEBSGIg3KkujyHtwRxcxJl5r7+PlrGlLc5eWiiE3ZOQ2ryvxqTy
        7akJDEpBP38BTvrA5TJA/VbNZn5b6D3Kbgw3/t6PdHyoyf9EGPBXfmx5b1F5fxq3
        77qlknt04qQ0idCQvaBDzbhMgKbiKNWnkzJfg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=XMI3kq5IUSZ9iE56oI42a38NDxv6uGQT
        /VlddKh1ujF8h0lnZsILfGsLtholLhIRKntotH67BNF4WDC/Gtnu14JWsHfX415W
        Qn2DIIu/NbeKyZHacD9mVan741zy0XYlxAqL7i6dIEGna+2ezvoF/xIIPI/Vjvqs
        iHKdSG8iTiM=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 411E5D59A4;
        Tue, 14 Jul 2020 11:27:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 219F8D59A3;
        Tue, 14 Jul 2020 11:27:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] setup: warn about un-enabled extensions
References: <pull.675.git.1594677321039.gitgitgadget@gmail.com>
        <0bede821-139a-d805-934a-142004abaa4c@gmail.com>
        <nycvar.QRO.7.76.6.2007141420300.52@tvgsbejvaqbjf.bet>
Date:   Tue, 14 Jul 2020 08:27:21 -0700
In-Reply-To: <nycvar.QRO.7.76.6.2007141420300.52@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Tue, 14 Jul 2020 14:21:30 +0200 (CEST)")
Message-ID: <xmqqzh82ktgm.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 83BC7926-C5E6-11EA-AB55-843F439F7C89-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> If you don't mind, I was already going to squash Junio's commit into
>> mine (almost completely replacing mine) but I could add a small
>> commit on top that provides the following improvement to the error
>> message:
>
> I don't mind at all. I'd just like to know that v2.28.0 avoids confusing
> users in the same was as v2.28.0-rc0 confused me.

In a nearby thread, Jonathan Nieder raised an interesting approach
to avoid confusing users, which I think (if I am reading him
correctly) makes sense (cf. <20200714040616.GA2208896@google.com>)

What if we accept the extensions the code before the topic in
question that was merged in -rc0 introduced the "confusion" accepts
even in v0?  If we see extensions other than those handpicked and
grandfathered ones (which are presumably the ones we add later and
support in v1 and later repository versions) in a v0 repository, we
keep ignoring.  Also we'd loosen the overly strict code that
prevents upgrading from v0 to v1 in the presence of any extensions
in -rc0, so that the grandfathered ones will not prevent the
upgrading.

The original reasoning behind the strict check was because the users
could have used extensions.frotz for their own use with their own
meaning, trusting that Git would simply ignore it, and an upgrade to
later version in which Git uses extensions.frotz for a purpose that
is unrelated to the reason why these users used would just break the
repository.  

But the ones that were (accidentally) honored in v0 couldn't have
been used by the users for the purposes other than how Git would use
them anyway, so there is no point to make them prevent the upgrade
of the repository version from v0 to v1.

At least, that is how I understood the world would look like in
Jonathan's "different endgame".

What do you three (Dscho, Derrick and Jonathan) think?  



> Thanks,
> Dscho
>
>>
>> diff --git a/builtin/config.c b/builtin/config.c
>> index 5e39f618854..b5de7982a93 100644
>> --- a/builtin/config.c
>> +++ b/builtin/config.c
>> @@ -678,8 +678,9 @@ int cmd_config(int argc, const char **argv, const char *prefix)
>>                 else if (worktrees[0] && worktrees[1])
>>                         die(_("--worktree cannot be used with multiple "
>>                               "working trees unless the config\n"
>> -                             "extension worktreeConfig is enabled. "
>> -                             "Please read \"CONFIGURATION FILE\"\n"
>> +                             "extension worktreeConfig is enabled "
>> +                             "and core.repositoryFormatVersion is at least\n"
>> +                             "1. Please read \"CONFIGURATION FILE\""
>>                               "section in \"git help worktree\" for details"));
>>                 else
>>                         given_config_source.file = git_pathdup("config");
>>
>> Thanks,
>> -Stolee
>>
>>
