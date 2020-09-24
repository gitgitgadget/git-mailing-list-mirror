Return-Path: <SRS0=EnZj=DB=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD44AC4363D
	for <git@archiver.kernel.org>; Thu, 24 Sep 2020 17:11:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 637CE238A1
	for <git@archiver.kernel.org>; Thu, 24 Sep 2020 17:11:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="GQcDMQ6u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728533AbgIXRLO (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Sep 2020 13:11:14 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:55872 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726477AbgIXRLO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Sep 2020 13:11:14 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 43184E1603;
        Thu, 24 Sep 2020 13:11:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=L0XWGbS4PqaG
        WNYjSh2eHFQcEiU=; b=GQcDMQ6ud2lQW/BhIzSUxTHCR+V1vcFSyifnM28yY1Xz
        aw9/laD39+s2nTWxtGEV360otEqU35ApS7jDbeJTt45GcAShzl/rep8AqJuR/Wvo
        LkvVBYY/Qf0HVHetYumG5T/gUrP8UStriQyOk9B5qCwpsTiIT52olx0SF1PIgg0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=RJSjDv
        0W0ft3cPreH4BfeGlDTRTM9vZudtGcFVJyYMoU4yvkZNL9NI87eroaYyAN3Z7leA
        FylIlxL5/c2nwmWncj5V3ImglLiSImgcn5zSlai3SQ67NMCcetxjyxSou/+OBbcp
        ZjNamuojHOE03B4A/p4rc+QJKBZmb9AaI5fJs=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 3B625E1601;
        Thu, 24 Sep 2020 13:11:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 79CCCE15FC;
        Thu, 24 Sep 2020 13:11:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] cmake: ignore generated files
References: <pull.735.git.1600375065498.gitgitgadget@gmail.com>
        <xmqqtuvwoyz5.fsf@gitster.c.googlers.com>
        <nycvar.QRO.7.76.6.2009181510240.5061@tvgsbejvaqbjf.bet>
        <xmqqft7fnlxr.fsf@gitster.c.googlers.com>
        <nycvar.QRO.7.76.6.2009201914330.5061@tvgsbejvaqbjf.bet>
        <xmqqr1qud9zl.fsf@gitster.c.googlers.com>
        <nycvar.QRO.7.76.6.2009231502430.5061@tvgsbejvaqbjf.bet>
        <20200924091901.GA24954@szeder.dev>
Date:   Thu, 24 Sep 2020 10:11:07 -0700
In-Reply-To: <20200924091901.GA24954@szeder.dev> ("SZEDER =?utf-8?Q?G?=
 =?utf-8?Q?=C3=A1bor=22's?= message of
        "Thu, 24 Sep 2020 11:19:01 +0200")
Message-ID: <xmqqblhvgkwk.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: F0AD9FEE-FE88-11EA-97E8-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:

> On Wed, Sep 23, 2020 at 03:08:26PM +0200, Johannes Schindelin wrote:
>> In any case, `git clean -dfx` strikes me as a perfectly acceptable
>> equivalent of `make clean` when no `make` is available, as is the case=
 in
>> Visual Studio's case.
>
> Not at all: 'make (dist)clean' only removes build artifacts and leaves
> untracked files intact, while 'git clean -dfx' removes untracked files
> as well, so using the latter instead of the former might easily lead to
> data loss.

Well, with the patch in question applied, "git clean -f" would be usable
as a poor-man's replacement that removes "ignored and expendable" paths
that match patterns listed in the file, so...
