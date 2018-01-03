Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 96C1B1F406
	for <e@80x24.org>; Wed,  3 Jan 2018 23:32:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751378AbeACXcP (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Jan 2018 18:32:15 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53416 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751268AbeACXcO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Jan 2018 18:32:14 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3E2E9D451E;
        Wed,  3 Jan 2018 18:32:14 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=8qu3WHHP5C8W
        ayHHACfJI2YRRLI=; b=Lm+Mf6kimzILJ1KlY7kk9qaV45cO0U1iiJCxVjrvEC6J
        FhQyU2h4TZFCZRSj0NRe6MHUr3ZOJscHw+r1IQ6nu6RGRNVU24ddvivmb3Qb2/Zh
        MzhoujInmo2ax1lKN1uaA/P2Nn1cUZsOu2Hreugyg0+JGnG02wBPfkAFSK4mn10=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=YdJas/
        npLuC4IXlnCpIZdcAu97EDqAMs9b0G0Gvaj+hfiHOR8QXK10a/gRRe48R0SijFgQ
        xwP+NWqUSnEDcCvCj9l8qr6DE2rGz5xU5j5fH7xzwy9n8hFuPqGGPedoWURp1TQC
        pqZn1IHWLneTFkRHpBs2THH/9Y7GTAh6MLZAY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 350A3D451D;
        Wed,  3 Jan 2018 18:32:14 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9A9D4D4515;
        Wed,  3 Jan 2018 18:32:13 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        Jeff King <peff@peff.net>, Segev Finer <segev208@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [RFC/PATCH] connect: add GIT_SSH_{SEND,RECEIVE}{,_COMMAND} env variables
References: <20180103102840.27897-1-avarab@gmail.com>
Date:   Wed, 03 Jan 2018 15:32:12 -0800
In-Reply-To: <20180103102840.27897-1-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Wed, 3 Jan 2018 10:28:40 +0000")
Message-ID: <xmqq373mh62r.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 53C80C1A-F0DE-11E7-B321-8EF31968708C-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> This is useful for talking to systems such as Github or Gitlab that
> identify user accounts (or deploy keys) by ssh keys. Normally, ssh
> could do this itself by supplying multiple keys via -i, but that trick
> doesn't work on these systems as the connection will have already been
> accepted when the "wrong" key gets rejected.

You need to explain this a lot better than the above. =20

I am sure systems such as Github have more than dozens of users who
push over ssh and these users identify themselves by which key to
use when establishing connection just fine (presumably by using a
"Host" entry for the github URL in ~/.ssh/config), and presumably we
are not sending "wrong" keys over there.  So there needs to be a lot
more clear description of the problem you are trying to solve in the
first place.
