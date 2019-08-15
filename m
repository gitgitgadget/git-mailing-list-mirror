Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0D1EB1F45A
	for <e@80x24.org>; Thu, 15 Aug 2019 16:58:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730466AbfHOQ60 (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Aug 2019 12:58:26 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:61571 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728828AbfHOQ60 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Aug 2019 12:58:26 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 242EF854FA;
        Thu, 15 Aug 2019 12:58:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=a4llFp+jJKA/
        DAmEmryFLB9ocsA=; b=gkBCmXSKcYgcTNpIYnMiyIe3aWpN7UDAUuw4BQlnjZiL
        FcRXMkgdZK1HFGu0lrQALWklbV6x4KI7mJsXvwKWI/3eiIJFabmmpar/zM47FS3G
        1yJs92CTQacciJy/7VSp3hAmo8oKQLSxovkR06jJfR40KgE97SZYPctU3r/Jk9s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=DWWIUi
        EAAxELrKO5AacD4kzZgV+b7bR06J+RdR2dDY2JMExzZ+qFroM49gXcpKBZNSze64
        /1EVsKtcNPwv18sjPvEm5nwXpUmYk87Kyolen82D5n31Dxj+lkJpd/AnQVuk50aq
        W9aUgk/qe4CqhVPok01OiE1Nj2MgqQdERgMrU=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 1AE7B854F9;
        Thu, 15 Aug 2019 12:58:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 337F6854F8;
        Thu, 15 Aug 2019 12:58:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Hong Xu <hong@topbug.net>, git@vger.kernel.org
Subject: Re: [PATCH] diff: 'diff.indentHeuristic' is no longer experimental
References: <58aafeaa-72b0-25ce-27b6-f8480fe48b5e@topbug.net>
        <20190815091245.16525-1-szeder.dev@gmail.com>
        <20190815135628.GA27091@sigill.intra.peff.net>
Date:   Thu, 15 Aug 2019 09:58:18 -0700
In-Reply-To: <20190815135628.GA27091@sigill.intra.peff.net> (Jeff King's
        message of "Thu, 15 Aug 2019 09:56:28 -0400")
Message-ID: <xmqqa7ca4b85.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: E307BF00-BF7D-11E9-B489-B0405B776F7B-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Thu, Aug 15, 2019 at 11:12:45AM +0200, SZEDER G=C3=A1bor wrote:
>
>> The indent heuristic started out as experimental, but it's now our
>> default diff heuristic since 33de716387 (diff: enable indent heuristic
>> by default, 2017-05-08).  Alas, that commit didn't update the
>> documentation, and the description of the 'diff.indentHeuristic'
>> configuration variable still implies that it's experimental and not
>> the default.
>>=20
>> Update the description of 'diff.indentHeuristic' to make it clear that
>> it's the default diff heuristic.
>>=20
>> The description of the related '--indent-heuristic' option has already
>> been updated in bab76141da (diff: --indent-heuristic is no
>> longer experimental, 2017-10-29).
>
> Yeah, this makes perfect sense.

OK.  Thanks, all.
