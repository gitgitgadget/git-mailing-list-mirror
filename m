Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56AB1C433F5
	for <git@archiver.kernel.org>; Mon, 23 May 2022 08:15:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231487AbiEWIPP (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 May 2022 04:15:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229851AbiEWIPN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 May 2022 04:15:13 -0400
Received: from pb-sasl-trial21.pobox.com (pb-sasl-trial21.pobox.com [173.228.157.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1787819C14
        for <git@vger.kernel.org>; Mon, 23 May 2022 01:15:11 -0700 (PDT)
Received: from pb-sasl-trial21.pobox.com (localhost.local [127.0.0.1])
        by pb-sasl-trial21.pobox.com (Postfix) with ESMTP id 715C6273CE;
        Mon, 23 May 2022 04:15:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=Zx7CZ/BnkU3zEmatfcrkeY6pt
        IQ=; b=hK/HTtMkCHQwDDDQ4ooToLgsDOfoXmp5bGplGyYYLxgB0t0YcR7r7z+8n
        Z3MOC9eYrRjuV5fxcLgMoz8GERhxeOR5mJSNXBsjYJYTBn6l8l2T2zoFSCBmK9jF
        rF6ewOUTedcwzvOA0hfMDftxb4mP0xC7koqVGUmNpwAYClQIlw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; q=dns; s=sasl; b=a7HzOKpQHFE6V9JRKRS
        1MoL+KuooEUoKbBvB0XyI07eJt9mcqdQUdxzsl6jx5nixJOD8UMffLCM2zsSOI15
        FU2QiRjjiW2qgnGNhLdPkZPmJxuodFJLDTqueNlcYkwRausBBWOr9mi98NRBswJw
        hpkkvO1iSAPNX62ZsaCRWayU=
Received: from pb-smtp21.sea.icgroup.com (pb-smtp21.pobox.com [10.110.30.21])
        by pb-sasl-trial21.pobox.com (Postfix) with ESMTP id 54FB6273CC;
        Mon, 23 May 2022 04:15:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id DB0D11AE8A8;
        Mon, 23 May 2022 04:15:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jiang Xin <worldhello.net@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
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
        Daniel Santos <dacs.git@brilhante.top>,
        Dimitriy Ryazantcev <DJm00n@mail.ru>,
        Peter Krefting <peter@softwolves.pp.se>,
        Emir SARI <bitigchi@me.com>,
        =?utf-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>,
        Fangyi Zhou <me@fangyi.io>, Yi-Jyun Pan <pan93412@gmail.com>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: Re: [PATCH v3 3/9] Makefile: have "make pot" not "reset --hard"
References: <20220519081548.3380-1-worldhello.net@gmail.com>
        <20220523012531.4505-4-worldhello.net@gmail.com>
Date:   Mon, 23 May 2022 01:15:05 -0700
Message-ID: <xmqq8rqsu0l2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 749B9076-DA70-11EC-8D83-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jiang Xin <worldhello.net@gmail.com> writes:

> From: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
>
> Before commit fc0fd5b23b (Makefile: help gettext tools to cope with our
> custom PRItime format, 2017-07-20) we'd consider source files as-is

", we'd consider".

> with gettext, but because we need to understand PRItime in the same way
> that gettext itself understands PRIuMAX we'd first check if we had a

"PRIuMAX, we'd first"

> clean checkout, then munge all of the processed files in-place with
> "sed", generate "po/git.pot", and then finally "reset --hard" to undo
> our changes.
>
> By generating "pot" snippets in ".build/pot/po" for each source file
> and rewriting certain source files with PRItime macros to temporary
> files in ".build/pot/po", we can avoid running "make pot" by altering
> files in place and doing a "reset --hard" afterwards.

Good.

> This speed of "make pot" is slower than before on an initial run,
> because we run "xgettext" many times (once per source file), but it
> can be boosted by parallelization. It is *much* faster for incremental
> runs, and will allow us to implement related targets in subsequent
> commits.

This is to show my ignorance, but is there any downside, other than
increased overhead coming from runing many instances of the program,
in the "one file at a time" approach?  I was wondering if two or
more identical translatable strings appear in multiple source files,
where they are coalesced into a single entry in the resulting .pot
file, and if xgettext having visibility into all these files would
somehow help the process, but presumably we'd use msgcat to unify
them into one entry so there wouldn't be such a downside there.  But
are there others?

Thanks.

