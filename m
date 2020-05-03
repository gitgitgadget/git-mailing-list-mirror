Return-Path: <SRS0=AD9v=6R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8F8AC28CBC
	for <git@archiver.kernel.org>; Sun,  3 May 2020 19:51:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1016206E9
	for <git@archiver.kernel.org>; Sun,  3 May 2020 19:51:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="kWYMaJlo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729041AbgECTun (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 3 May 2020 15:50:43 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:65339 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728956AbgECTum (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 May 2020 15:50:42 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8B83B51D39;
        Sun,  3 May 2020 15:50:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=A4pH8WUJmRA5MWlpS7RIyNALMUo=; b=kWYMaJ
        louhtpNxctqydp+ESNyNKHF/S3YOcteE6Wee3vA3VtygUhuDkvdCP6D+mM+r4nkk
        SCKO75r/lGUX+OqPjMi8K2QDhfiPkBfhhoHcGVzgSugfTSZgG8v5hxVA2TupiKgO
        63lCvqiXRMQLUxZlqq6u4P2Ey2F9dfVhVzhkg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=UZ2AVOjT4ALK2Lm7+2JOxfwXwtv+uP2Q
        /lTxBjcLKkKT0J0PUIUenPvfheeN+IJ9F6Jd8RRxoEnpqB+2ZSAdhRhQCfhT8HYX
        xw8BNFKqgwhhOEelcY3K63fP1klVrwX3E+GV2jhsKF9YqjbGtSy4VDQT67cI42ah
        WFVidf2z1js=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 831B851D38;
        Sun,  3 May 2020 15:50:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 15B0951D37;
        Sun,  3 May 2020 15:50:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Konstantin Tokarev <annulen@yandex.ru>
Cc:     Sibi Siddharthan <sibisiddharthan.github@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jeff King <peff@peff.net>, Danh Doan <congdanhqx@gmail.com>,
        Sibi Siddharthan via GitGitGadget <gitgitgadget@gmail.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH 0/8] CMake build system for git
References: <pull.614.git.1587700897.gitgitgadget@gmail.com>
        <xmqqv9lod85m.fsf@gitster.c.googlers.com>
        <CAKiG+9V_nZUXf2a689vZ54rG+xTCFMGcJe_7Av-khaxxuijERg@mail.gmail.com>
        <xmqq8sikblv2.fsf@gitster.c.googlers.com>
        <nycvar.QRO.7.76.6.2004251354390.18039@tvgsbejvaqbjf.bet>
        <20200427200852.GC1728884@coredump.intra.peff.net>
        <20200427201228.GD1728884@coredump.intra.peff.net>
        <20200428135222.GB31366@danh.dev>
        <20200428210750.GE4000@coredump.intra.peff.net>
        <CAKiG+9U2Eg5yvT4XjgpMUXu4OV-8JF9Hp_ou_P6twxfqJ1tEYA@mail.gmail.com>
        <nycvar.QRO.7.76.6.2005012130010.18039@tvgsbejvaqbjf.bet>
        <CAKiG+9UvnLtF7eS9FsPLyRR4ZPNSnakZwyYy3dO7WoAnRpvoMA@mail.gmail.com>
        <xmqq4ksyl4mz.fsf@gitster.c.googlers.com>
        <CAKiG+9Vvwz_ajhJ1KPVWtq25UaGtJOH57eXTA=cgm5qzoZCfGw@mail.gmail.com>
        <xmqqsgghhr32.fsf@gitster.c.googlers.com>
        <689741588534833@mail.yandex.ru>
Date:   Sun, 03 May 2020 12:50:39 -0700
In-Reply-To: <689741588534833@mail.yandex.ru> (Konstantin Tokarev's message of
        "Sun, 03 May 2020 22:42:01 +0300")
Message-ID: <xmqqo8r4iyr4.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5DB61CCA-8D77-11EA-877A-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Konstantin Tokarev <annulen@yandex.ru> writes:

> FWIW, CMakeLists.txt doesn't have to be in the root of source tree in
> order to work. It can perfectly work from contrib/cmake after necessary
> changes in relative paths.

That's great to know---perhaps you can work with Sibi to help
whipping the CMakeLists.txt into shape, placing it in contrib/cmake/
directory?

When that is in place, my answer to Sibi's question, i.e. "what is
the best way to tell users they can use CMake for their Windows
build?" would be "the same way as we advertise contrib/buildsystems
and/or compat/vcbuild to them", I think.

Thanks.
