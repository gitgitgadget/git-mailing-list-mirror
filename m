Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 688FFC433F5
	for <git@archiver.kernel.org>; Fri, 25 Mar 2022 16:35:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347960AbiCYQgz (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Mar 2022 12:36:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241341AbiCYQgw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Mar 2022 12:36:52 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41E9935858
        for <git@vger.kernel.org>; Fri, 25 Mar 2022 09:35:18 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 16C951175BE;
        Fri, 25 Mar 2022 12:35:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=DiyHmu74CScLeDcehK0iHY0T2zD/By4MhO2P1A
        K37g4=; b=KcczodYPNgDWJpnXvyIvvL4qRrXlsc0whmfXSau2HuOCddTWrHHTL/
        pCKBEwi3TvNvWPRA2aSU0ZXTH8tDjkkoA+cmpckmHUm0DjLqQERYcsaFTNz4aqEl
        +AioqPQAcsgFAEdpCMCLMqGLKLalWFMeRMa/AH59wOTvN4gPw0juE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0DE4B1175BD;
        Fri, 25 Mar 2022 12:35:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.227.145.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7454E1175BB;
        Fri, 25 Mar 2022 12:35:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Victoria Dye <vdye@github.com>
Subject: Re: [PATCH v2 0/3] reset: make --no-refresh the only way to skip
 index refresh
References: <pull.1184.git.1647894889.gitgitgadget@gmail.com>
        <pull.1184.v2.git.1648059480.gitgitgadget@gmail.com>
        <6d424915-5c63-bebd-f3b5-f153a541d077@gmail.com>
        <xmqqsfr7jmtb.fsf@gitster.g> <xmqq7d8jjlwp.fsf@gitster.g>
        <202ec3ce-76ee-a46b-3235-e801339eb153@github.com>
Date:   Fri, 25 Mar 2022 09:35:15 -0700
In-Reply-To: <202ec3ce-76ee-a46b-3235-e801339eb153@github.com> (Derrick
        Stolee's message of "Fri, 25 Mar 2022 11:04:33 -0400")
Message-ID: <xmqq5yo2c7ng.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8D565F46-AC59-11EC-A1E0-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <derrickstolee@github.com> writes:

> On 3/24/2022 1:33 PM, Junio C Hamano wrote:
>> Junio C Hamano <gitster@pobox.com> writes:
>>> #leftoverbit: we may want to discuss if it is a good idea to teach
>>> OPT_BOOL() to list "--[no-]<option>" in "git cmd -h", instead of
>>> just "--<option>".
>
> Good idea!
>
>> Unfortunately, I merged these already to 'next' before seeing your
>> comment, so we'd need to go incremental.
>> 
>> How about this?
>
>> -		OPT_BOOL(0, "refresh", &refresh,
>> +		OPT_BOOL(0, "no-refresh", &no_refresh,
>>  				N_("skip refreshing the index after reset")),
>
> I'm pleasantly surprised that this still allows --refresh (in addition to
> --no-no-refresh). So, the only meaningful functional change is indeed the
> -h output.

Yeah, it is a pleasant easter egg surprise that --refresh is taken
as the opposite but its cousin that we allow --no-no-refresh is
somehow questionably ugly, albeit it does not hurt anybody, except
for purists who would certainly complain that --no-no-no-refresh is
not understood.


