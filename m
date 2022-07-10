Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DA45C433EF
	for <git@archiver.kernel.org>; Sun, 10 Jul 2022 16:39:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbiGJQjY (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 10 Jul 2022 12:39:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiGJQjY (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Jul 2022 12:39:24 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F37110FDE
        for <git@vger.kernel.org>; Sun, 10 Jul 2022 09:39:23 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E0DC919D4C6;
        Sun, 10 Jul 2022 12:39:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=1t/B+w/ouUU1
        yad5rpM7QZ/HOC+KuWQ8OuXbOj+0xrc=; b=s/hfOqv67qMncICZlYWnozE2/RVi
        llHCz3aMOLx5MaRH222Mx1D1DHcKsHm/i0qyvv0fq0DJ7djJ+2E35DUysPi58H8Y
        QU6RIz6cU72SbbpWOWXxajk0hXBZqMBpSwIxRsf5pISclcrA6fMXTC8XSOgFtnGe
        8EKLlsPHVVz9BF4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D9FED19D4C5;
        Sun, 10 Jul 2022 12:39:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 8CB0519D4C4;
        Sun, 10 Jul 2022 12:39:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org, Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] sha256: add support for Nettle
References: <20220705230518.713218-1-sandals@crustytoothpaste.net>
        <20220710132907.1499365-1-sandals@crustytoothpaste.net>
        <220710.86mtdh81ty.gmgdl@evledraar.gmail.com>
Date:   Sun, 10 Jul 2022 09:39:18 -0700
In-Reply-To: <220710.86mtdh81ty.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Sun, 10 Jul 2022 16:41:23 +0200")
Message-ID: <xmqqwnckrkg9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: D86F6428-006E-11ED-AD6B-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> This just carries forward existing technical debt, but it's unfortunate
> that we don't catch OPENSSL_SHA256 overridding NETTLE_SHA256, and error
> if both are defined.

You are mistaken, unless I am ;-) =20

Allowing users to list whatever is available, instead of requiring
all users to choose only one, is a deliberate feature in the
arrangement, so it is not unfortunate and it would be breaking
end-user expectation if we gave an error when more than one is
given (and it would be easier to write and maintain autoconf rules
for the feature---we do not want to have two places that makes
decisions on precedence).


