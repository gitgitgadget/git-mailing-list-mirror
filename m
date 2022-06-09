Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9826C433EF
	for <git@archiver.kernel.org>; Thu,  9 Jun 2022 17:34:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237357AbiFIRe3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Jun 2022 13:34:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232387AbiFIRe1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Jun 2022 13:34:27 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF6EE2D9375
        for <git@vger.kernel.org>; Thu,  9 Jun 2022 10:34:25 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 53F2B1A91C3;
        Thu,  9 Jun 2022 13:34:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=Y3K8Gl5hcB2E
        UcLywng7rt/6RQBH1OHlJh+H6+bzC0c=; b=fuA+9Bsjhc+1iKp8QyPxWE1AtPfs
        hqSLWlZE0R3RzUOySf8McqNrjts+LJ+fuJmyosKYbwoROptT8WluhFySIvniPtBr
        pB7LMNSpd8Ev5m374QdOFUdB5epMO/FK9QSJSrjhr1jkL1yConqcjX8h369BtSnl
        OSgYyZjjkCrPRGs=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4D8C61A91C2;
        Thu,  9 Jun 2022 13:34:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id F13021A91BE;
        Thu,  9 Jun 2022 13:34:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Li Linchao via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Cactusinhand <lilinchao@oschina.cn>
Subject: Re: [PATCH] remote-curl: send Accept-Language header to server
References: <pull.1251.git.1654678407365.gitgitgadget@gmail.com>
        <220609.86leu6thon.gmgdl@evledraar.gmail.com>
Date:   Thu, 09 Jun 2022 10:34:20 -0700
In-Reply-To: <220609.86leu6thon.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Thu, 09 Jun 2022 09:30:35 +0200")
Message-ID: <xmqq1qvxn3kz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 6604AA86-E81A-11EC-B220-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> I may be missing something, but this is just the "Accept-Language" part
> of this change, i.e. there is no "round-tripping" here of actually doin=
g
> the work on the server of doing setlocale(), no?

I think the wish is that if Accept-Language is interpreted by the
HTTP(s) server and it gets turned into LC_something=3D<locale> when
the HTTP server spawns us, we'd know what language to issue our
error messages.


