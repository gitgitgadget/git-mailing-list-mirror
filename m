Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4335C43381
	for <git@archiver.kernel.org>; Wed, 23 Dec 2020 01:58:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9966522583
	for <git@archiver.kernel.org>; Wed, 23 Dec 2020 01:58:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727378AbgLWB6k (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Dec 2020 20:58:40 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:50491 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727039AbgLWB6j (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Dec 2020 20:58:39 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id BC4D8104AE0;
        Tue, 22 Dec 2020 20:57:57 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=zGnP0z4VdMls
        VrtU7esHjdKzk8w=; b=JPvkLUQ3KslcxA0bRawTmSS3+LxkItZnE5YriiC5O5wT
        /7ws052dCdoI9p8siw2Arda2Ec8+75Koyo7QLvpad8t0rZfm9gBzVTMJiO1ILr/L
        cDUyNx2th1LymAosQQepiYg8QerPrGRibNhHDOYzKszHmjeIC+Y9OI5DBVTBxlY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=wimwOv
        xIw2BXT6djEO97VH0Sm010I1O0cWmQP9aqF7x2s17t5gkRlYmFPz6lOd+Yqyj7td
        7dRorrckSyEEoEuYxH2nljbuCNk3DYnN6wqC9Q3s3rnHY00mI+ayUUzHY3Kn8mmb
        FM99yLAxSLwScY8UPxUSuY2zCXBKdyRLkseiM=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B470E104ADF;
        Tue, 22 Dec 2020 20:57:57 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id AD168104ADE;
        Tue, 22 Dec 2020 20:57:53 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v4 03/20] mktag doc: update to explain why to use this
References: <20201209200140.29425-1-avarab@gmail.com>
        <20201223013606.7972-4-avarab@gmail.com>
Date:   Tue, 22 Dec 2020 17:57:51 -0800
In-Reply-To: <20201223013606.7972-4-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Wed, 23 Dec 2020 02:35:48 +0100")
Message-ID: <xmqqy2hpe128.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 45051B92-44C2-11EB-9BC8-E43E2BB96649-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Change the mktag documentation to compare itself to the similar
> "hash-object -t tag" command. Before this someone reading the
> documentation wouldn't have much of an idea what the difference
> was.
>
> Let's allude to our own validation logic, and cross-link the "mktag"
> and "hash-object" documentation to aid discover-ability. A follow-up
> change to migrate "mktag" to use "fsck" validation will make the part
> about validation logic clearer.

We do not add links to refer to commands like "git commit-tree",
"git mktree" or "git add" just because these other commands can
create commit, tree and blob objects like hash-object does, so
adding a link to mktag in the hash-object documentation feels a
bit fishy, but the extended description in mktag that highlights
the added value of the command over hash-object reads very well.

>  Tag Format
>  ----------
> @@ -34,6 +43,10 @@ exists, is separated by a blank line from the header=
.  The
>  message part may contain a signature that Git itself doesn't
>  care about, but that can be verified with gpg.
> =20
> +SEE ALSO
> +--------
> +linkgit:git-hash-object[1],

Comma,

> +
>  GIT
>  ---
>  Part of the linkgit:git[1] suite
