Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F35F42095B
	for <e@80x24.org>; Sat, 18 Mar 2017 18:58:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751787AbdCRS6G (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 Mar 2017 14:58:06 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64712 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751406AbdCRS6F (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Mar 2017 14:58:05 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BB40787F90;
        Sat, 18 Mar 2017 14:54:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=PQ6zc++W6VW7
        0T7Rm+6pNTVzsr4=; b=Xwp3ZX7Mi6zPw/3jy2cpZRNGR06Nt2tZTiaTTn1iXIKz
        H3ZEdpH+CQVJxb9t+F0iS65o9JRQ/alNteORZri2iv4dAPJFo3CzwM1pDpj2kYWJ
        ESVn4fgrtcqFRHGFD7IaDLDer0M6LNaFVt+tfHpSKYeJYKVj6hxnfILG6zg1Wa4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=q1//vL
        pPuAa2YxuPjC7JoTx84C/0H3ALKUtT4S55b1MdMAjfuf+SMAI9o5IzRIUTt7Rwpy
        HZzBe09IAZjHM3WrYaC7MaIEqHcdlmdcbBGZy5TVq/gceRJic/C84/peDo/pDcDp
        Fbt5uEuq9hLXLZgwraXoPpH68/yT/JckHjEjc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B316A87F8F;
        Sat, 18 Mar 2017 14:54:08 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2558187F8E;
        Sat, 18 Mar 2017 14:54:08 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Lars Hjemli <hjemli@gmail.com>,
        Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>,
        Carlos Rica <jasampler@gmail.com>,
        Samuel Tardieu <sam@rfc1149.net>,
        Tom Grennan <tmgrennan@gmail.com>
Subject: Re: [PATCH 8/8] tag: Change --point-at to default to HEAD
References: <20170318103256.27141-1-avarab@gmail.com>
        <20170318103256.27141-9-avarab@gmail.com>
Date:   Sat, 18 Mar 2017 11:54:07 -0700
In-Reply-To: <20170318103256.27141-9-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Sat, 18 Mar 2017 10:32:56 +0000")
Message-ID: <xmqqinn62z74.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 44367410-0C0C-11E7-BE97-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Change the --points-at option to default to HEAD for consistency with
> its siblings --contains, --merged etc. which default to HEAD. This
> changes behavior added in commit ae7706b9ac (tag: add --points-at list
> option, 2012-02-08).

Makes a lot of sense to me.

> +test_expect_success '--points-at is a synonym for --points-at HEAD' '
> +	git tag --points-at >actual &&

Even if "expect" is the same one established earlier, it is easier
to read and understand individual tests if you explicitly said what
this one expects.

Thanks.
