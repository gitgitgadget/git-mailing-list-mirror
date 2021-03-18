Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC558C433E0
	for <git@archiver.kernel.org>; Thu, 18 Mar 2021 19:21:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8CD4264F65
	for <git@archiver.kernel.org>; Thu, 18 Mar 2021 19:21:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232642AbhCRTVX (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Mar 2021 15:21:23 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:57321 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232873AbhCRTUu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Mar 2021 15:20:50 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B4B2510DFE7;
        Thu, 18 Mar 2021 15:20:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=9WNTNZ7ALm2w
        Hxjryph17MEGzE0=; b=CBnMUoW5zIWNzkzduvSBwM2BvHCRwCZWTUm16pG5rnhh
        HVK2X0o/WP7jxK5zYIauNU/tN1bqrYybYkYaZi5vIgH4Pz1zUo9Bn51XF45xEAqO
        GvFGhpM590GnmSnEVgBug5NXzka+WTpkPTACajm2QCuj0gm8sn6Nx+E1km5CdLU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=T3fuB/
        QdqqaknKymbrv4vhxZPnncE2pPCnQtWu4xbv/Fe36ezBlCdmnemS6YJ4V/E3cTud
        E5wqG4OVjLvudMAZOcVS3Ljw8FNCKHbXqVuewSGp/cQ/cBCb82PxpOHoa/QM9y4J
        vPpoyt600MYhLY3+uGDvcE0TeTykJSDcOwOZQ=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id ABD9510DFE4;
        Thu, 18 Mar 2021 15:20:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 69F0510DFE3;
        Thu, 18 Mar 2021 15:20:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, "Bradley M. Kuhn" <bkuhn@sfconservancy.org>,
        Brandon Casey <drafnel@gmail.com>,
        Shourya Shukla <periperidip@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Rafael Silva <rafaeloliveira.cs@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Subject: Re: [PATCH v10 2/3] interpret-trailers: add own-identity option
References: <pull.901.v9.git.1615891183320.gitgitgadget@gmail.com>
        <pull.901.v10.git.1616066156.gitgitgadget@gmail.com>
        <42590e95deeece6ba65e0432c3a59746e717fee3.1616066156.git.gitgitgadget@gmail.com>
Date:   Thu, 18 Mar 2021 12:20:44 -0700
In-Reply-To: <42590e95deeece6ba65e0432c3a59746e717fee3.1616066156.git.gitgitgadget@gmail.com>
        (ZheNing Hu via GitGitGadget's message of "Thu, 18 Mar 2021 11:15:55
        +0000")
Message-ID: <xmqq1rcctgj7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 0A628AD8-881F-11EB-AC6A-E43E2BB96649-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: ZheNing Hu <adlternative@gmail.com>
>
> Beacuse `git commit --trailer=3D"Signed-off-by: \
> $(git config user.name) <$(git config user.email)>"`
> is difficult for users to add their own identities,
> so teach interpret-trailers a new option `--own-identity`
> which allow those trailers with no value add the user=E2=80=99s own
> identity. This will help the use of `commit --trailer` as
> easy as `--signoff`.

I have a suspicion that this is too narrowly focused to be useful in
practice, and I find that the proposed "--own-identity" is quite a
mouthful.

> +--own-identity::
> +	Used with `--trailer`. Those trailers without value with the
> +	`--own-identity` option all will add the user's own identity.

So, the assumption here is that the name of the trailer tag alone,
without the ':' separator, can identify which trailer the user is
talking about, and it can be distinguished from the tag name plus ':'
and nothing else which is calling for a trailer entry with an empty
string as its value?

OK.

The reason why this looks too narrowly focused on oneself alone to
be useful to me is because I often need to add various -by trailers
to incoming patches, and have a script to do exactly that (which
does not use interpret-trailers, as I do not think
interpret-trailers can accept a patch email as its input, and the
script predates interpret-trailers) but it will be useless if that
script were limited to add -by for myself.

Wouldn't it be a lot more useful if

	git commit --trailer=3D"Helped-by:@Ch.*Couder"

is expanded (note: I am not married to the syntax, but only for
illustration purposes, I am using "a value prefixed by @ triggers
the 'name expansion'" convention in this example.  People can come
up with better convention) by finding an author or a committer whose
name matches the given pattern from "git log"?  Then, instead of

	git commit --own-identity --trailer=3DSigned-off-by

I can say

	git commit --trailer=3DSigned-off-by:@gitster

and I can even add more than one, e.g.

	git commit --trailer=3DHelped-by:@peff --trailer=3DSigned-off-by:@gitste=
r

