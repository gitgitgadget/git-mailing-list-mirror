Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD0A8C43334
	for <git@archiver.kernel.org>; Fri, 17 Jun 2022 17:42:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382992AbiFQRmM (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Jun 2022 13:42:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234564AbiFQRmJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Jun 2022 13:42:09 -0400
Received: from pb-sasl-trial21.pobox.com (pb-sasl-trial21.pobox.com [173.228.157.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E55CE3F30C
        for <git@vger.kernel.org>; Fri, 17 Jun 2022 10:42:06 -0700 (PDT)
Received: from pb-sasl-trial21.pobox.com (localhost.local [127.0.0.1])
        by pb-sasl-trial21.pobox.com (Postfix) with ESMTP id 27C9A19FBC;
        Fri, 17 Jun 2022 13:42:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=GQjaSnGniKQhglOfEjvXZbinvG8=; b=rtGUpD
        HE2mTgCBNU60RSImspolS81SyXofuN0z8r3tShzAj5Z+JbmSjFYPm6oOf9pe9WMH
        +sny/Gwu7Bqs8wjt9JIZ/USuZsUZqEVF3S2IXADXvjBd4PVyNMdebqSah1s9ThE5
        6xRoJ3u7W70w/GvT9qGoTuNiqCbs6Qc2qGIo8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=hVSq33zbIJuwQpwRs5i0Ro/HEbfEgNIz
        +f20Z4EDA+7lwMaMOe0oQiwl/6AURL2uTcmUZL4j43MfBSVuVuj2M0Ivgyxlf8Pz
        JzxsVO5uoBrSFoDfWIxlDO2b4RUB0F9Y3p6q6TZSkzO+g2LCGHVQzejj+EEr7Iro
        QxToMzbQ2k8=
Received: from pb-smtp21.sea.icgroup.com (pb-smtp21.pobox.com [10.110.30.21])
        by pb-sasl-trial21.pobox.com (Postfix) with ESMTP id 1662519FBB;
        Fri, 17 Jun 2022 13:42:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 9B02019856B;
        Fri, 17 Jun 2022 13:41:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jiang Xin <worldhello.net@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Alexander Shopov <ash@kambanaria.org>,
        Jordi Mas <jmas@softcatala.org>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Matthias =?utf-8?Q?R=C3=BCster?= <matthias.ruester@gmail.com>,
        Ralf Thielow <ralf.thielow@gmail.com>,
        Phillip Szelat <phillip.szelat@gmail.com>,
        Jimmy Angelakos <vyruss@hellug.gr>,
        Christopher =?utf-8?Q?D=C3=ADaz?= 
        <christopher.diaz.riv@gmail.com>,
        =?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
        =?utf-8?Q?S=C3=A9bastien?= Helleu <flashcode@flashtux.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Alessandro Menti <alessandro.menti@alessandromenti.it>,
        Gwan-gyeong Mun <elongbug@gmail.com>,
        Changwoo Ryu <cwryu@debian.org>,
        Sihyeon Jang <uneedsihyeon@gmail.com>,
        Arusekk <arek_koz@o2.pl>, Daniel Santos <dacs.git@brilhante.top>,
        Dimitriy Ryazantcev <DJm00n@mail.ru>,
        insolor <insolor@gmail.com>,
        Peter Krefting <peter@softwolves.pp.se>,
        Emir SARI <bitigchi@me.com>,
        =?utf-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Fangyi Zhou <me@fangyi.io>, Ray Chen <oldsharp@gmail.com>,
        =?utf-8?B?5L6d5LqR?= <lilydjwg@gmail.com>,
        Yi-Jyun Pan <pan93412@gmail.com>,
        Franklin Weng <franklin@goodhorse.idv.tw>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH] i18n: fix mismatched camelCase config variables
References: <20220617100309.3224-1-worldhello.net@gmail.com>
        <xmqqtu8jpa7p.fsf@gitster.g>
Date:   Fri, 17 Jun 2022 10:41:58 -0700
In-Reply-To: <xmqqtu8jpa7p.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
        17 Jun 2022 08:43:06 -0700")
Message-ID: <xmqqpmj7nq55.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CA1BF308-EE64-11EC-92F2-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Jiang Xin <worldhello.net@gmail.com> writes:
>
>> Mismatched camelCases, choose the former:
>>
>>  * Documentation/config/fetch.txt: fetch.credentialsInUrl
>>    remote.c:                       fetch.credentialsInURL
>
> We renamed this with "fetch" -> "transfer", didn't we?
>
> Everything else looks good, though.

I've applied after tweaking it a bit.

Will be pushing the result out shortly.
