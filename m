Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2CD1C388F9
	for <git@archiver.kernel.org>; Sat, 21 Nov 2020 19:44:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 58C79221F1
	for <git@archiver.kernel.org>; Sat, 21 Nov 2020 19:44:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="gTysKB5j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728470AbgKUToG (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 Nov 2020 14:44:06 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:63503 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728459AbgKUToF (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Nov 2020 14:44:05 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E80EC10FB23;
        Sat, 21 Nov 2020 14:44:03 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=dv0Rqe8Cer8P
        YU8fmVeYaO68o6w=; b=gTysKB5jsDYx8Ych4idkZ2VwavMGXmBUFfmcbLkscHay
        5WgOnXkpA4PuDHSIRrMxHnfGa9+j4ESfdfapUbvSebfV9X2NF/WBcM8DoLmHE9vG
        ySZaKadpTvlUJjjVWsllX964GnN8VQVf2csdDeZjtsJJQCOcSdKEtoCy+5O9m48=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=Xoi9tT
        mwTlDVAmigiW+Xu2Lt9zpySYMZcxDBgo5wC7ADBV8RSpdCBSNv5uB75iPxJ0glN9
        GPuMTa27djva4Tpwx5R5s/qhaHPx7EmIrJGrD0Ffz0/4gNaVa10omtR8fZBfkCot
        ojx1Cywlz3BBOvcu7wfwIE+ZN5n4Sd3FFITFI=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D76E910FB22;
        Sat, 21 Nov 2020 14:44:03 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 19D2210FB20;
        Sat, 21 Nov 2020 14:44:01 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH 1/2] gc docs: change --keep-base-pack to
 --keep-largest-pack
References: <20200806214929.22qgjg3o2noosjuo@ltop.local>
        <20201120115522.23617-1-avarab@gmail.com>
Date:   Sat, 21 Nov 2020 11:43:59 -0800
In-Reply-To: <20201120115522.23617-1-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Fri, 20 Nov 2020 12:55:21 +0100")
Message-ID: <xmqqtutisdfk.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: E757C984-2C31-11EB-A249-D609E328BF65-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> The --keep-base-pack option never existed in git.git. It was the name
> for the --keep-largest-pack option in earlier revisions of that series
> before it landed as ae4e89e549 ("gc: add --keep-largest-pack option",
> 2018-04-15).

Is it a sign that this hasn't been used by or useful to our users
that this documentation bug did not get noticed by anybody for the
past 30 months, I wonder.

"git gc -h" does report the option with correct name, which is the
beauty of automation ;-)

Thanks, both.  Will queue, together with [2/2] which also makes
sense.
