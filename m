Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2B9CC433EF
	for <git@archiver.kernel.org>; Mon,  7 Mar 2022 17:11:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237853AbiCGRMo (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Mar 2022 12:12:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229938AbiCGRMn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Mar 2022 12:12:43 -0500
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E2C783021
        for <git@vger.kernel.org>; Mon,  7 Mar 2022 09:11:48 -0800 (PST)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BAFA210CEC6;
        Mon,  7 Mar 2022 12:11:47 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=jCdhyjl3/GcfgNmZ0HvEceqiBEP7tKP/P4u0dq
        GWMRA=; b=Ufa3WnM7t7Fz8VSKVhjUoG5wE1HAaaXSFlIFKn3mxXlnAqGrv3tJ35
        rPwJvMpxrL/0DOKLxH0UTBSYerZ0iiaCTurrz02uaXsMt2/kpqzAa9bNX0ffwVId
        M+zdSmUWF9sVJ2CYEwkNqCRJFcmpaSb6Yj4JcR4OA/LyrRHh+brk8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B31FB10CEC5;
        Mon,  7 Mar 2022 12:11:47 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.230.65.123])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 25CE110CEC4;
        Mon,  7 Mar 2022 12:11:47 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     phillip.wood@dunelm.org.uk,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 0/9] ci: make Git's GitHub workflow output much more
 helpful
References: <pull.1117.git.1643050574.gitgitgadget@gmail.com>
        <nycvar.QRO.7.76.6.2202200043590.26495@tvgsbejvaqbjf.bet>
        <220220.86bkz1d7hm.gmgdl@evledraar.gmail.com>
        <nycvar.QRO.7.76.6.2202221126450.4418@tvgsbejvaqbjf.bet>
        <220222.86tucr6kz5.gmgdl@evledraar.gmail.com>
        <505afc19-25bd-7ccb-7fb2-26bcc9d47119@gmail.com>
        <nycvar.QRO.7.76.6.2202251440330.11118@tvgsbejvaqbjf.bet>
        <30dbc8fb-a1db-05bc-3dcb-070e11cf4715@gmail.com>
        <nycvar.QRO.7.76.6.2203071657180.11118@tvgsbejvaqbjf.bet>
Date:   Mon, 07 Mar 2022 09:11:46 -0800
In-Reply-To: <nycvar.QRO.7.76.6.2203071657180.11118@tvgsbejvaqbjf.bet>
        (Johannes Schindelin's message of "Mon, 7 Mar 2022 17:07:41 +0100
        (CET)")
Message-ID: <xmqqilspu1pp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: ABA5DA4A-9E39-11EC-979B-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> One thing I forgot to mention was that when you expand a failing test it shows
>> the test script twice before the output e.g.
>>
>> Error: failed: t7527.35 Matrix[uc:false][fsm:true] enable fsmonitor
>> failure: t7527.35 Matrix[uc:false][fsm:true] enable fsmonitor
>>   				git config core.fsmonitor true &&
>>   				git fsmonitor--daemon start &&
>>   				git update-index --fsmonitor
>>
>>   expecting success of 7527.35 'Matrix[uc:false][fsm:true] enable fsmonitor':
>>   				git config core.fsmonitor true &&
>>   				git fsmonitor--daemon start &&
>>   				git update-index --fsmonitor
>>
>>  ++ git config core.fsmonitor true
>>  ++ git fsmonitor--daemon start
>>  ...
>>
>> I don't know how easy it would be to fix that so that we only show "expecting
>> success of ..." without the test being printed first
>
> It's not _super_ easy: right now, the patch series does not touch the code

In other words, it is not a new issue introduced by this series, right?

> The easiest workaround would probably to add a flag that suppresses the
> header `expecting success` in case we're running with the
> `--github-workflow-markup` option.

If that is the case, let's leave it outside the series.

If we do not have to hide the solution behind any option specific to
"--github-workflow-markup", then even users (like me) who reguarly
run "cd t && sh ./t1234-a-particular-test.sh -i -v" would benefit if
we no longer have to look at the duplicated test script in the
output.

Thanks.
