Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5764F1F461
	for <e@80x24.org>; Wed, 26 Jun 2019 19:51:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726360AbfFZTvr (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Jun 2019 15:51:47 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:55373 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726227AbfFZTvq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jun 2019 15:51:46 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id CD1CB7503B;
        Wed, 26 Jun 2019 15:51:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=PpIHnLNN83v1
        BBiWgFI9EtaYQlw=; b=j4ePt6d3IyGG7ezBe5luaQanj9uq7d6RRUe45MMtpOPq
        Iz+nAD3Sp6xEk0ALaMpZ7JP6LUVQP5PtWAciQrH6HNj9gmQ1Eoy/1lYkloejCfJk
        m6X20p4N7KicqLyZElbd+iKGIc5ldau3eVxpHQzFBD44WrqJzdNHF9Eel/RE7hc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=YuQKmy
        tnHzU2GNhG4F2kbLC7tcyrwwhtTrFx0oxle34MNR93CmTTm79IqXLKzCpYNSOU3i
        L14f8ghLJyOSZaqXRvlHZZcgaTyLTeVq2Aq+yQI9F5/KI7ANim6JtOVqIuYeWxwo
        rItK2skJoUzv3Lcf6xN9eRUwM4wUAXoZMUmCY=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C4D3A7503A;
        Wed, 26 Jun 2019 15:51:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id EF32C75039;
        Wed, 26 Jun 2019 15:51:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Derrick Stolee <stolee@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 01/10] ls-files: add --json to dump the index
References: <20190624130226.17293-1-pclouds@gmail.com>
        <20190624130226.17293-2-pclouds@gmail.com>
Date:   Wed, 26 Jun 2019 12:51:39 -0700
In-Reply-To: <20190624130226.17293-2-pclouds@gmail.com> (=?utf-8?B?Ik5n?=
 =?utf-8?B?dXnhu4VuIFRow6FpIE5n4buNYw==?=
        Duy"'s message of "Mon, 24 Jun 2019 20:02:17 +0700")
Message-ID: <xmqqd0j0cegk.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: D1B7B0BA-984B-11E9-AFD6-8D86F504CC47-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> This --json is supposed to help that. It dumps the index in a human

This and another one on the title need to become "--debug-json".

Are we expecting a reroll to introduce another layer above the most
primitive json writer that knows the schema used to represent both
system standard and our application-specific structures, or is the
current arrangement to have them in json-writer.c until there are
enough of them to warrant such a split good enough?
