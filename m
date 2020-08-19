Return-Path: <SRS0=/SyM=B5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01820C433E1
	for <git@archiver.kernel.org>; Wed, 19 Aug 2020 22:50:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A59E120674
	for <git@archiver.kernel.org>; Wed, 19 Aug 2020 22:50:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="G+W+aELw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727079AbgHSWuz (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Aug 2020 18:50:55 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:51483 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726362AbgHSWuy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Aug 2020 18:50:54 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 2BFF0F69A2;
        Wed, 19 Aug 2020 18:50:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=Qj99maLWa+2J
        xMKOWifaREye5uE=; b=G+W+aELwgndQ1GgV36hE3XU0fuEave/78D84lVzQrB0g
        ngLGVHMtlSYJoNVm2hNvbhLcJ8eiYvnzvfaPsBca8Zr8VW+j3H2ak57kb3OEBKj7
        1CQLDLTwPNEoyPK0X/G5PMKClCIq3yh3c4ahiMKfHyGrpCUshkk7Tt69p461bNo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=wKie/L
        sWmK9kJI0tp4Ss6bp7pcG8C9vNJcUOeORnoTRjpDErDnHRr7+8mRUsjA1Rob+nkM
        fYagdX9QXxg4URzUf8zhQOILSV20/B8nYzgdH50D2uFkYUVGUVan8Wk58uMvSzOf
        55uzLK2CUEY/NIja9+pMpcCJQ7UugPQN4A++U=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 2481EF699F;
        Wed, 19 Aug 2020 18:50:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 5BD10F6999;
        Wed, 19 Aug 2020 18:50:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 1/2] revision: differentiate if --no-abbrev asked explicitly
References: <cover.1596887883.git.congdanhqx@gmail.com>
        <cover.1597364493.git.congdanhqx@gmail.com>
        <9a26c5b6110081cd8d029f2ab0327c4a1d228ef7.1597364493.git.congdanhqx@gmail.com>
        <xmqq8sei125k.fsf@gitster.c.googlers.com>
        <20200814005947.GA9518@danh.dev>
        <xmqqzh6yyr1t.fsf@gitster.c.googlers.com>
        <20200814145043.GB9518@danh.dev>
Date:   Wed, 19 Aug 2020 15:50:47 -0700
In-Reply-To: <20200814145043.GB9518@danh.dev> (=?utf-8?B?IsSQb8OgbiBUcg==?=
 =?utf-8?B?4bqnbiBDw7RuZw==?= Danh"'s message
        of "Fri, 14 Aug 2020 21:50:43 +0700")
Message-ID: <xmqq4koycks8.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 6D28EC68-E26E-11EA-922D-843F439F7C89-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh  <congdanhqx@gmail.com> writes=
:

>> What am I missing?
>
> No, you didn't miss anything.
>
> It's obviously me, who screwed up the logical thinking.
>
> Originally, I come up with something along the line in 2/2:
>
> 	int abbrev =3D o->flags.full_index ? hexsz : DEFAULT_ABBREV;
> 	if (!o->abbrev)
> 		abbrev =3D o->abbrev;
>
> I couldn't recalled what I wrote, but that logic requires 1/2,
> after I come up with 1/2, I re-analysed 2/2 and come up with current
> logic.
>
> I failed to re-visit 1/2 to check if it's necessary.
> It's all MY fault.
>
> Sorry for wasting everyone's time in 1/2.
>
> Please eject 1/2 from this series.

OK.  2/2 would work without this step.

