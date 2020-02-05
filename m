Return-Path: <SRS0=lBg5=3Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7F67C352A1
	for <git@archiver.kernel.org>; Wed,  5 Feb 2020 21:01:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67E2220720
	for <git@archiver.kernel.org>; Wed,  5 Feb 2020 21:01:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="dbE090Ko"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727501AbgBEVB5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Feb 2020 16:01:57 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:60898 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727499AbgBEVB5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Feb 2020 16:01:57 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 828B3AFA46;
        Wed,  5 Feb 2020 16:01:56 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=P+5++40PlvI1fRSneavS51TKIKs=; b=dbE090
        Ko7r4K9S1JhaJfi8tjM8YAeKiRmq89tDKbzPrY5GBeQTsYMSECliQIUjL3JpmO4E
        wKzmqfW0Es3Looo9INzuH0wKG1XAFkqkW0FI4LbLlkyK8dkfeTmW78+k0DSJen9q
        cMOP1VcqdhwM6uS8K4XKFQVF3r2c5EDRzbu0c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=L9dQ2jbB92YB+E4MQA+i+Asot/wu/SQC
        hNZtb1qc5W/G+Sr6Muyyh13Fyc51aQhXhZZdYuyiWFuGD2XkaVaokd2RbTWOc07Y
        1gwoBwyNs4GFPXzRD2e+gslF+45bnUeXvOMdOV8R/cLTbpBJ0ww/NTqf01uUT3AM
        qVFJ6r2oUnM=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 7A2B3AFA45;
        Wed,  5 Feb 2020 16:01:56 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 79857AFA42;
        Wed,  5 Feb 2020 16:01:52 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org, Yang Zhao <yang.zhao@skyboxlabs.com>
Subject: Re: What's cooking in git.git (Jan 2020, #04; Wed, 22)
References: <xmqqr1zr5e5e.fsf@gitster-ct.c.googlers.com>
        <20200122235333.GA6837@szeder.dev>
        <xmqqftg6671g.fsf@gitster-ct.c.googlers.com>
        <20200123141626.GB6837@szeder.dev> <20200123175645.GF6837@szeder.dev>
        <nycvar.QRO.7.76.6.2001232237590.46@tvgsbejvaqbjf.bet>
        <20200124120240.GG6837@szeder.dev>
        <nycvar.QRO.7.76.6.2001250133510.46@tvgsbejvaqbjf.bet>
Date:   Wed, 05 Feb 2020 13:01:50 -0800
In-Reply-To: <nycvar.QRO.7.76.6.2001250133510.46@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Sat, 25 Jan 2020 01:35:03 +0100 (CET)")
Message-ID: <xmqqeev8694x.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BBE9E63A-485A-11EA-B456-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> Do they have to shout that loudly in the name?
>>
>> We could rename these jobs to e.g. 'linux-clang-py2' and the like, but
>> I think it would bring little benefit, if any.  In our Travis CI
>> builds these Linux/OSX Clang/GCC jobs come from the build matrix,
>> therefore the jobname is not visible on the Travis CI web interface or
>> API, only in the build logs.  There are some pages on Azure Pipelines
>> that do show the jobname (and some that could, but hide it instead),
>> but it's just too convoluted (or sometimes even impossible, well, for
>> me anyway) to get there.
>>
>> And if the requested Python binary can't be found, which will
>> eventually happen with 'python2', then the non-zero exit code of
>> 'which' will abort the build, no matter how the job is called.
>
> I am mostly worried about contributors whose PRs break for "magic"
> reasons. If it is not clear where the difference between `linux-gcc` and
> `linux-clang` lies, that can cause unintended frustration, and I do not
> want to cause that.

So, what, if any, decision have we reached?

If linux-gcc and linux-clang labels are not visible, linux-clang-py2
and osx-py3 would not be, either, so...
