Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B0DAC433EF
	for <git@archiver.kernel.org>; Fri, 10 Sep 2021 20:20:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B2CE6101A
	for <git@archiver.kernel.org>; Fri, 10 Sep 2021 20:20:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233672AbhIJUVU (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Sep 2021 16:21:20 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50892 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233664AbhIJUVU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Sep 2021 16:21:20 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7DA45E7B42;
        Fri, 10 Sep 2021 16:20:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=77eEdwlP1yOD
        QUtIYDxjMxtjIWQg5ccrx3PA1uEOJX4=; b=KelMxjqSKWU5CVHWs074oNzu0U4O
        MJucVpOBhe0eQIgClw9552TnXpdi+X3cIph+HdUbleIV4YdfSgtfvEhQZYF7D0Uq
        craayiPTV55cUK89w3dAcP2fHRCBBdPuf0viO0sVzQ9c5VzL26xpSBgMKcVR/6BU
        7EUI2lW6UFDGstw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 64456E7B40;
        Fri, 10 Sep 2021 16:20:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9917BE7B3F;
        Fri, 10 Sep 2021 16:20:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Oddidies in the .mailmap parser & future syntax extensions
References: <20210910130236.40101-1-me@fangyi.io>
        <YTt4RymWg+TOEmUf@tilde.club> <877dfocps2.fsf@evledraar.gmail.com>
        <xmqq1r5wti5a.fsf@gitster.g> <87h7esb3ig.fsf@evledraar.gmail.com>
Date:   Fri, 10 Sep 2021 13:20:06 -0700
In-Reply-To: <87h7esb3ig.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Fri, 10 Sep 2021 21:50:28 +0200")
Message-ID: <xmqqk0jorxmx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 7DB94474-1274-11EC-B37A-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> Who wants to use mailmap, *and* map one e-mail address to another, *and=
*
> has an entry explicitly mapping the name, but *would* mind having git b=
e
> auto-smart and follow the chain of that explicit name mapping if there'=
s
> an entry after that with an an e-mail -> that-earlier-email mapping?

Would it make a difference if I point out that at least for our
project, we want to keep the .mailmap lines be sorted?  I suspect
that a "list must be mechanically sorted" requirement may make it
awkward to also have an "if name is missing, use the last matching
explicit name".  Also, it makes removing one entry among many for
the same person less straight-forward (if you are removing the one
that happens to be listed first, you need to move the name to the
next entry in order to avoid losing it).

