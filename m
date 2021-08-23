Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91218C4338F
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 21:43:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 634BD6103C
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 21:43:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232932AbhHWVoC (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Aug 2021 17:44:02 -0400
Received: from pb-sasl-trial3.pobox.com ([64.147.108.87]:57260 "EHLO
        pb-sasl-trial3.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232829AbhHWVn6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Aug 2021 17:43:58 -0400
X-Greylist: delayed 411 seconds by postgrey-1.27 at vger.kernel.org; Mon, 23 Aug 2021 17:43:58 EDT
Received: from pb-sasl-trial3.pobox.com (localhost.local [127.0.0.1])
        by pb-sasl-trial3.pobox.com (Postfix) with ESMTP id 136712D46D;
        Mon, 23 Aug 2021 17:36:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=GWzFi6Hoi/1o7dX8FNGJq9PxwR8=; b=Y6ZtvE
        Ufe92WNBuxsj5ZddbMooanGN//SazPNlxjCzSdAAFsoN9wljQ1GHiB5JW22sfmsI
        +thV9A3mum/8nslnRq2WWtSkcZGlf2bZTEb9jyDN2e+SItVNYzqLNjpBuaFTGoiT
        k9M74IcijD+nBsD+cZhKkxssRlIVzXNB+a0pk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Uj/VxEkI0+DqI/5Ivzn7zOKmepIe1Wlq
        hMbewDxmGsXSQs3cEbB+IPNWU2fZmAhngMTkwP4iOqLql7e9uSyfQssAODyS6iIC
        Rh4d9SGYKZlGndg+gOFCs8VvrN9LTD4uoV9m2r8rZktu5qp/7Gyxm4DMRFA5yP6b
        YQweNdymnJw=
Received: from pb-smtp1.nyi.icgroup.com (pb-smtp1.pobox.com [10.90.30.53])
        by pb-sasl-trial3.pobox.com (Postfix) with ESMTP id E64172D46A;
        Mon, 23 Aug 2021 17:36:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.116.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5097CE9571;
        Mon, 23 Aug 2021 17:36:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Jiang Xin <worldhello.net@gmail.com>,
        Git List <git@vger.kernel.org>,
        Alexander Shopov <ash@kambanaria.org>,
        Jordi Mas <jmas@softcatala.org>,
        Matthias =?utf-8?Q?R=C3=BCster?= <matthias.ruester@gmail.com>,
        Jimmy Angelakos <vyruss@hellug.gr>,
        Christopher =?utf-8?Q?D=C3=ADaz?= 
        <christopher.diaz.riv@gmail.com>,
        =?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Alessandro Menti <alessandro.menti@alessandromenti.it>,
        Gwan-gyeong Mun <elongbug@gmail.com>, Arusekk <arek_koz@o2.pl>,
        Daniel Santos <hello@brighterdan.com>,
        Dimitriy Ryazantcev <DJm00n@mail.ru>,
        Peter Krefting <peter@softwolves.pp.se>,
        Emir SARI <bitigchi@me.com>,
        =?utf-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>,
        Fangyi Zhou <me@fangyi.io>, Yi-Jyun Pan <pan93412@gmail.com>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: Re: [PATCH 1/1] ci: new github-action for git-l10n code review
References: <20210822161325.22038-1-worldhello.net@gmail.com>
        <20210822161325.22038-2-worldhello.net@gmail.com>
        <nycvar.QRO.7.76.6.2108232232460.55@tvgsbejvaqbjf.bet>
Date:   Mon, 23 Aug 2021 14:36:21 -0700
In-Reply-To: <nycvar.QRO.7.76.6.2108232232460.55@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Mon, 23 Aug 2021 23:02:50 +0200 (CEST)")
Message-ID: <xmqqsfyzq1wq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 29072FF4-045A-11EC-BE53-8B3BC6D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> For a push event, it will scan commits one by one. If a commit does not
>> look like a l10n commit (no file in "po/" has been changed), it will
>> immediately fail without checking for further commits. While for a
>> pull_request event, all new introduced commits will be scanned.
>>
>> "git-po-helper" will generate two kinds of suggestions, errors and
>> warnings. A l10n contributor should try to fix all the errors, and
>> should pay attention to the warnings. All the errors and warnings will
>> be reported in the last step of the l10n workflow as two message groups.
>> For a pull_request event, will create additional comments in pull
>> request to report the result.
>
> It is a good idea to automate this.
>
> I am a bit concerned that the `ci-config` approach, even if we use it in
> the Git project itself, is quite cumbersome to use, though. So I hope that
> we can find an alternative solution.
>
> One such solution could be to make the `git-po-helper` job contingent on
> part of the repository name. For example:
>
>   git-po-helper:
>     if: endsWith(github.repository, '/git-po')
>     [...]
>
> would skip the job unless the target repository's name is `git-po`.

Nice.

Can this be made into a matter purely local to git-l10n/git-po
repository and not git/git repository?  I am wondering if we can ee
if the current repository is git-l10n/git-po or its fork and run it
only if that is true.

Thanks.

