Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D840120135
	for <e@80x24.org>; Wed,  8 Mar 2017 23:02:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753908AbdCHXCt (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Mar 2017 18:02:49 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55784 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753010AbdCHXCs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Mar 2017 18:02:48 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 658D26F591;
        Wed,  8 Mar 2017 18:02:46 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=bIt4bBBRsDQS
        e5cGQLKhKZUGyf0=; b=QKP7nBO4m133HMjVVBe0g9Z9Pq/3gp96ujM83Kw6w6FL
        wAgm99vKmsZb9mgxWDsDlAEU4rkbl6ZXZ1wk5XpI3qIt26w7f9GAxsMM26XgG+PV
        RyJJTVk1NH6XiKpgZPDsKMSR83Frp7flSXCg7P20P0sF2YlsVIq+thVn1Wm5ozw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=bXNs4H
        9C3SHD6sXoqDxz4EAm9dgIvRY93vK03vYTKh4PZbX7Lw2agrJ/ug8zoRQML3PqYe
        6Y9W/UjsCPkXRY/pd9E6QmR3jziL7efr2Q+wmPjgNDYeKH7X7NkHXIwkpcDfmiGz
        nMP9gW6IXHhDP5rSuT6d5U7d2qpGMm1QrfDns=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5F0516F590;
        Wed,  8 Mar 2017 18:02:46 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C30176F58F;
        Wed,  8 Mar 2017 18:02:45 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Lars Hjemli <hjemli@gmail.com>,
        Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH] branch & tag: Add a --no-contains option
References: <20170308202025.17900-1-avarab@gmail.com>
Date:   Wed, 08 Mar 2017 15:02:44 -0800
In-Reply-To: <20170308202025.17900-1-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Wed, 8 Mar 2017 20:20:25 +0000")
Message-ID: <xmqqefy71iej.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 57B144E0-0453-11E7-AFE2-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> More notes about this patch:
>
>  * I'm not really happy with the "special attention" documentation
>    example in git-branch.txt, but it follows logically from the
>    description for --contains just above it which I think is overly
>    specific as well. IMO that entire NOTES section in git-branch.txt
>    could just be removed.

The first paragraph of the section is unrelated to the topic and I
do not think anybody would miss it if it goes, but I always feel
uncomfortable between --contains and --merged.  I do not expect
anybody needs lengthy explanation to tell --merged and --no-merged
(similarly --contains and --no-contains) apart, but perhaps because
I often use --with (which is a hidden synonym to --contains) and
almost never --merged, and as we are adding the fourth, I find it a
very good idea to extend the description to tell users what they
want to use "contains" for (i.e. find the set of containers given a
commit) and what they want to use "merged" for (i.e. find the set of
containees given a commit).

>  * I'm adding a --without option as an alias for --no-contains for
>    consistency with --with and --contains. Since we don't even
>    document --with anymore (or test it) perhaps we shouldn't be adding
>    --without.

I do not think anybody other than me uses "--with" to begin with, so
I do not care too deeply about it.  If it makes the patch simpler
not to support "--without", I'd be supportive if you want to drop it.

I'll review the body of the patch later.

Thanks.
