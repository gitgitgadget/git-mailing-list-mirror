Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 523D0C433EF
	for <git@archiver.kernel.org>; Wed,  5 Jan 2022 19:52:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243725AbiAETwH (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Jan 2022 14:52:07 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51670 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243691AbiAETwG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jan 2022 14:52:06 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 266C3FD520;
        Wed,  5 Jan 2022 14:52:06 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=0N+6HIp6LKj4xkLN8OuHyXovAvr2yXotVOSuJT
        uKFm0=; b=SlIHj8nAFeikcKMsb3xG3N4kQPhYkaT0lGrF37IAbbeiJqr1lZzOZI
        NJcLoNBYcSN7L3ksryNYRC7s0nUV9Hr2LIC54fTDLdnItDG0ZV8QSv2lD8TaKXfJ
        i4d9LuuoXU9sMekhjRfGBOB6gFNZCufShqsT5MPuvTbC6goSAn1QE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1EC71FD51F;
        Wed,  5 Jan 2022 14:52:06 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 7C276FD51A;
        Wed,  5 Jan 2022 14:52:05 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     John Cai via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        John Cai <johncai86@gmail.com>
Subject: Re: [PATCH v4 1/2] name-rev: deprecate --stdin in favor of
 --annotate-stdin
References: <pull.1171.v3.git.git.1641221261.gitgitgadget@gmail.com>
        <pull.1171.v4.git.git.1641307776.gitgitgadget@gmail.com>
        <4e9200922a4c2c91e69e3b497fbf4c8702046a27.1641307776.git.gitgitgadget@gmail.com>
        <16666d32-833a-f3d7-351a-eeef7f25b002@gmail.com>
Date:   Wed, 05 Jan 2022 11:52:04 -0800
In-Reply-To: <16666d32-833a-f3d7-351a-eeef7f25b002@gmail.com> (Phillip Wood's
        message of "Wed, 5 Jan 2022 11:15:57 +0000")
Message-ID: <xmqqmtkahsez.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F56F8E18-6E60-11EC-A9E2-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

>> @@ -539,6 +539,7 @@ int cmd_name_rev(int argc, const char **argv, const char *prefix)
>>   		OPT_GROUP(""),
>>   		OPT_BOOL(0, "all", &all, N_("list all commits reachable from all refs")),
>>   		OPT_BOOL(0, "stdin", &transform_stdin, N_("read from stdin")),
>
> If the intention is to deprecate this option then it might be worth
> marking it as PARSE_OPT_HIDDEN so that it is not shown by 'git
> name-rev -h'. (You need to change OPT_BOOL to OPT_BOOL_F to pass the
> flag)

Whether we want to do HIDDEN now or not, it is probably a good idea
to update the help text to 

	N_("deprecated synonym to --annotate-stdin")

or something like that.
