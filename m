Return-Path: <SRS0=YePV=76=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97F63C433DF
	for <git@archiver.kernel.org>; Wed, 17 Jun 2020 18:21:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 637CD21532
	for <git@archiver.kernel.org>; Wed, 17 Jun 2020 18:21:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Hy6BIZ9E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727859AbgFQSVI (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Jun 2020 14:21:08 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53458 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726926AbgFQSVH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Jun 2020 14:21:07 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0A45F71BB2;
        Wed, 17 Jun 2020 14:21:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=yo79gAMDKWEG
        6BaJoYFv3mPLF6U=; b=Hy6BIZ9E6Ho2MbNQuyKPVAk6QzaMcikDp8U+E93EhP93
        A8EY1kPDIhOlRGOeHTzGlS1tCsh+oGzM+46DcVy0wj7QHDQetXq0l/1rPfP39aOx
        aqffE+5m0OSDv/mivgW3QVwL5pKeU3MI/fCs/fC4QX19raNUJofZRxrvg6MgCNI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=wMrc3q
        StVX9WlhT+ZzjQs8vct57rmwf9Rkd8X/nLtqY1PwI5BFbwLEIk2qiNCBNY5R9Zkq
        k45zv8KhlWXRdOI7BFn92iEALKmY1BYM9kNylabls0EDoFTxWzWcZX2Bqs+5G/GP
        YUoP+TxJc2J7sY3PWeZ/IuxgR+YLBhY82vdBA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id ECD6171BB1;
        Wed, 17 Jun 2020 14:21:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 37D1371BB0;
        Wed, 17 Jun 2020 14:21:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, don@goodman-wilson.com, stolee@gmail.com,
        peff@peff.net, sandals@crustytoothpaste.net,
        Matt Rogers <mattr94@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 02/12] fmt-merge-msg: introduce a way to override the main branch name
References: <pull.656.git.1591823971.gitgitgadget@gmail.com>
        <pull.656.v2.git.1592225416.gitgitgadget@gmail.com>
        <f4d547391537e5c3b0b4a07adb41b6aa56541fc3.1592225416.git.gitgitgadget@gmail.com>
        <877dw7csa0.fsf@evledraar.gmail.com>
Date:   Wed, 17 Jun 2020 11:21:03 -0700
In-Reply-To: <877dw7csa0.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Tue, 16 Jun 2020 10:46:15 +0200")
Message-ID: <xmqqimfpv9io.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 4E0AF05C-B0C7-11EA-B935-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Mon, Jun 15 2020, Johannes Schindelin via GitGitGadget wrote:
>
>> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
>> +core.mainBranch::
>> +	The name of the main (or: primary) branch in the current repository.
>> +	For historical reasons, `master` is used as the fall-back for this
>> +	setting.
>
> Everywhere else in git-config(1) we just say something to the effect of
> the more brief:
>
>     The name of the main (or: primary) branch in the current repository
>     (`master` by default).
>
> I think we should do the same here for consistency & ease of reading.
>
> As you note at the start of this series we're not changing the default
> yet, so referring to the current default as historical is putting the
> cart before the horse as far as producing self-contained patch serieses
> goes.

Very good point. =20

In [*1*], I gave a potential outline of how a transition plan might
look like (if we were to transition, that is), but what is written
as step 1. in there should be split into two: step 0, in which the
mechanisms (1) to change the default name used for the first branch
and (2) to specify the primary branch that is special-cased by a few
commands are introduced, without any future plan, and step 1, in
which warning and/or advice messages knudge the users and hint the
future direction.

Thanks.


[Reference]

*1* https://lore.kernel.org/git/xmqqeeqiztpq.fsf@gitster.c.googlers.com
