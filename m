Return-Path: <SRS0=xyTh=BY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85A52C433DF
	for <git@archiver.kernel.org>; Fri, 14 Aug 2020 20:47:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 538322074D
	for <git@archiver.kernel.org>; Fri, 14 Aug 2020 20:47:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="PoqStWzj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726362AbgHNUrd (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Aug 2020 16:47:33 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52050 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbgHNUrd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Aug 2020 16:47:33 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5C29A6C420;
        Fri, 14 Aug 2020 16:47:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=TAWVzz1euwqA
        QLRHLum8Dh/EiRQ=; b=PoqStWzjWXIBBDwhiu6LCwo6YiXAy+FMhmqm1UFBUEta
        eNTB8ipXy/NHy4e6TSb41mzMIY4m0g/h3AjPWypPImhSMp0MvcMxID9J+p4/qoMP
        Sm9sIdIJEpbGO1U/WkYsQdGGAN+XUPJ4Sh3znLbv81K+THRMoYx7yFgkmTXdGc8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=SFqAxU
        uzUGekkSMwdFAm09b8uZAANOzzB3XcMUeWxZwVQOsIstuEEKtLcM01IAKwrdwH6r
        LFJ3EwjHAY2q3f62Z+23Cn8IJBL9N3ToUhat+AT+VdBvHub++nzGsDmtGIza3ju2
        gKDkCSa3XrabujbmztCYCoIO4MaxrW8Ux4PyA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 533506C41F;
        Fri, 14 Aug 2020 16:47:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.231.104.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D1E2B6C41D;
        Fri, 14 Aug 2020 16:47:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH 1/5] http-protocol.txt: document SHA-256 "want"/"have" format
References: <20200813224901.2652387-1-sandals@crustytoothpaste.net>
        <cover.1597406877.git.martin.agren@gmail.com>
        <5590a68c5ba7081cd7e64c708b5c25db23f5e95b.1597406877.git.martin.agren@gmail.com>
        <xmqqk0y1xhl0.fsf@gitster.c.googlers.com>
        <20200814202347.GN8085@camp.crustytoothpaste.net>
        <xmqqo8ndufli.fsf@gitster.c.googlers.com>
Date:   Fri, 14 Aug 2020 13:47:30 -0700
In-Reply-To: <xmqqo8ndufli.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Fri, 14 Aug 2020 13:39:37 -0700")
Message-ID: <xmqqft8puf8d.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 5F3D0376-DE6F-11EA-8853-2F5D23BA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>
>> On 2020-08-14 at 17:28:27, Junio C Hamano wrote:
>>> Martin =C3=85gren <martin.agren@gmail.com> writes:
>>>=20
>>> > Document that in SHA-1 repositories, we use SHA-1 for "want"s and
>>> > "have"s, and in SHA-256 repositories, we use SHA-256.
>>>=20
>>> Ehh, doesn't this directly contradict the transition plan of "on the
>>> wire everything will use SHA-1 version for now?"
>>
>> SHA-256 repositories interoperate currently using SHA-256 object IDs.
>> It was originally intended that we wouldn't update the protocol, but
>> that leads to much of the testsuite failing since it's impossible to
>> move objects from one place to another.
>>
>> If we wanted to be more pedantically correct and optimize for the
>> future, we could say that the values use the format negotiated by the
>> "object-format" protocol extension and SHA-1 otherwise.

Yes, that's wonderful.  I was confused when I said about the
evolution path.  We still would want to eventually do the on-the-fly
migration over the wire to make SHA-1 and SHA-256 repositories
interoperate, but at least we already can allow SHA-256 repositories
safely attempt to talk to SHA-1 repositories and gracefully fail.

Thanks.

