Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5E07F1F667
	for <e@80x24.org>; Sat, 19 Aug 2017 17:42:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751673AbdHSRmf (ORCPT <rfc822;e@80x24.org>);
        Sat, 19 Aug 2017 13:42:35 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56693 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751659AbdHSRme (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Aug 2017 13:42:34 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 15A3FA88CF;
        Sat, 19 Aug 2017 13:42:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=6rFmbOLUECHL
        gvHWne665aM0Mdk=; b=fPElNDRzhcgfGU9ONoBlReLWHNw3fCLN1Qg4t2xH0rmj
        /pdwQRUekJeTCaxoEeSiL3PDbPjX5sbJb9043cvK1ehjO7K7F9jY/SJSuSaqierg
        lBGdJEn3hu1XRz8fDWmhsBSNhvFjKm8octfeYxxI8cTf3K0jjMp5pzl4XLIlE74=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=Kz6stY
        rqtJqQ3h/tjVf0dNE63aj/eIAUfZdjAp4J7rOO731gtywVUvixdZ2hs84ucIsLun
        C4F9DvQJEFni7+4AuPqAYYmd8jErfaNe9X7Oqo7ZOpIWkUAFTbMXQrsbguI08r2r
        kRzMd+h30pLhx7KBa3oj7/tEatS14ejRXwKq4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0E194A88CD;
        Sat, 19 Aug 2017 13:42:27 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 70D02A88CC;
        Sat, 19 Aug 2017 13:42:26 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     git@vger.kernel.org, David Adam <zanchey@ucc.gu.uwa.edu.au>,
        Duy Nguyen <pclouds@gmail.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH 4/4] archive: queue directories for all types of pathspecs
References: <alpine.DEB.2.11.1708131240360.15538@motsugo.ucc.gu.uwa.edu.au>
        <ae893c19-652d-1c8f-50ba-1242b95be84e@web.de>
        <887652a4-3f03-e2dd-2c68-cff4f7194898@web.de>
        <0432c7cc-a2a5-12bd-bf65-a16186313d5b@web.de>
        <33fa4f08-8f06-5a98-e492-3f05cc742555@web.de>
        <798212ae-ffb8-2ffb-8b59-fa307424b48a@web.de>
Date:   Sat, 19 Aug 2017 10:42:25 -0700
In-Reply-To: <798212ae-ffb8-2ffb-8b59-fa307424b48a@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Sat, 19 Aug 2017 18:58:11 +0200")
Message-ID: <xmqqtw138nem.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: C3D232E6-8505-11E7-B751-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> No, it's "archive empty subtree by direct pathspec" that's broken.  Gah=
!
>
>> omitting the empty directory from the archive.  Sorry for missing that=
!
>>=20
>> This is kind of a bonus patch, so please discard it for now; the first
>> three are OK IMHO.

Ah, our mails crossed.  Thanks; will drop the last one for now.
