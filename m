Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB9B0C433ED
	for <git@archiver.kernel.org>; Sun, 11 Apr 2021 19:10:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9646B6109F
	for <git@archiver.kernel.org>; Sun, 11 Apr 2021 19:10:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235496AbhDKTKw (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 11 Apr 2021 15:10:52 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57888 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235420AbhDKTKv (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Apr 2021 15:10:51 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1AF31BDCC7;
        Sun, 11 Apr 2021 15:10:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=ZHevjvXNRqYK
        sSpvLEThJjfeBm4=; b=qstf3Z9uJraxWJKWgptrDULU0in1nRJjzmkApnvBMf03
        WjJkrXw/D3cH1z/dEA97bDEqEGEyc39JKpcZoT6AkCtloCAj3bkxA9iRGaOgg4Rp
        jNtykaOVv57dNiDT9ozxm/wb0F+jTrqiVee7cY9TkHPGxVXAZ2vXIFcWVb+fQr0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=v8Pn5m
        cLQEoWdhJvLH3l5uWSKcB/eb+CyYt2moMsgpPj4BAkAQOTJ+8Rffj9QzBQsI5a/L
        bd+UnM/dL2F3OVXDbQqauFXDzisUnFDEVv0naYjMa03WIAHEI5ztgnvBJXi4OGpS
        gv/mP7IYJct8WRKut6sjJ0nx0dxuOpB5oiyXk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 11BBCBDCC6;
        Sun, 11 Apr 2021 15:10:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 872B7BDCC5;
        Sun, 11 Apr 2021 15:10:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?zqPPhM6xz43Pgc6/z4Igzp3PhM6tzr3PhM6/z4I=?= 
        <stdedos@gmail.com>
Cc:     git <git@vger.kernel.org>,
        =?utf-8?B?zqPPhM6xz43Pgc6/z4Igzp3PhM6tzr0=?= =?utf-8?B?z4TOv8+C?= 
        <stdedos+git@gmail.com>, Bagas Sanjaya <bagasdotme@gmail.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v3] pathspec: advice: long and short forms are incompatible
References: <20210326024411.28615-1-stdedos+git@gmail.com>
        <20210403122604.19203-1-133706+stdedos@users.noreply.github.com>
        <xmqqr1jq7bzc.fsf@gitster.g>
        <CAHMHMxUVy4MUarT-q5EHwf_6cPNn+TSmNDuQbuxXvYPpnQTmpg@mail.gmail.com>
Date:   Sun, 11 Apr 2021 12:10:33 -0700
In-Reply-To: <CAHMHMxUVy4MUarT-q5EHwf_6cPNn+TSmNDuQbuxXvYPpnQTmpg@mail.gmail.com>
        (=?utf-8?B?Is6jz4TOsc+Nz4HOv8+CIM6dz4TOrc69z4TOv8+CIidz?= message of "Sun,
 11 Apr 2021 18:07:16
        +0300")
Message-ID: <xmqqfszwhc2e.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 97975FAE-9AF9-11EB-AFBD-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=CE=A3=CF=84=CE=B1=CF=8D=CF=81=CE=BF=CF=82 =CE=9D=CF=84=CE=AD=CE=BD=CF=84=
=CE=BF=CF=82  <stdedos@gmail.com> writes:

> The author *is* Stavros Ntentos <133706+stdedos@users.noreply.github.co=
m>;
> I don't know why it is messed up.

Hmph, that is unfortunate.  As authorship and sign-off is a part of
the mechanism we use to keep track of provenance of our codebase,
we'd prefer to be talking to somebody whom we can reach when needed;
the noreply address apparently is designed to be unreachable, no?


