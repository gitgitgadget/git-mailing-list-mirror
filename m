Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 009151F45F
	for <e@80x24.org>; Fri, 10 May 2019 13:51:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727814AbfEJNvA (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 May 2019 09:51:00 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:50235 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727787AbfEJNu7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 May 2019 09:50:59 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C38956E8A2;
        Fri, 10 May 2019 09:50:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=Eq/OypYETv7y
        MxywFjo55ksmP5w=; b=AxIrZfQtiKYoSzlUCl9G3grvGWR+tTPwozV1JLMiDH/m
        +oPKMlSwx5Vh7BnyKiwxEjiaOkHcE7yWOuUNs41eTsw141NMUkbVEskdKgM76mlK
        O6rI7dbBn6rGHpPD7/96IUOGxH8xrCYOeMkIMucfalw9J7Dr1YDDCaAlev4cXIY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=up5UAu
        Tohu6McbNXdAHrdTfXo0Tj9i9x6Gdbb5nI1Ztn+r39CuA+sopN22FAvCYVokjMuu
        +qhNvHf5eXjXj+Xk31YNIZJn/TT5wo/vb47ZrTEPmySVca+pqsOdm5+ZHl7pv5E/
        DjePesKOy7GQETgnqQeRzS5wcGXSPFz3KcoEA=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id BB9006E8A1;
        Fri, 10 May 2019 09:50:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.255.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id EDA576E878;
        Fri, 10 May 2019 09:50:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Brian M Carlson <sandals@crustytoothpaste.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 0/3] send-email: fix cli->config parsing crazyness
References: <20190508105607.178244-1-gitster@pobox.com>
        <20190509114830.29647-1-avarab@gmail.com>
Date:   Fri, 10 May 2019 22:50:52 +0900
In-Reply-To: <20190509114830.29647-1-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Thu, 9 May 2019 13:48:27 +0200")
Message-ID: <xmqqr296e7ur.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: A1AE548C-732A-11E9-8971-B0405B776F7B-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> This is a proposed replacement for Junio's version of the
> ... the
> root cause is that we're needlessly doing the config->cli parsing in
> the wrong order, so let's just fix that.

Yup, that's absolutely the right approach.  I just wanted to avoid
restructuring that heavily, but I have no problem as long as it is
somebody else, and somebody who is more competent in writing Perl
than I am, doing the heavy lifting ;-)

