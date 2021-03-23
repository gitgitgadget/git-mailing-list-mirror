Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16AEAC433E0
	for <git@archiver.kernel.org>; Tue, 23 Mar 2021 06:20:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1B24619BF
	for <git@archiver.kernel.org>; Tue, 23 Mar 2021 06:20:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbhCWGTx (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Mar 2021 02:19:53 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:51898 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbhCWGTa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Mar 2021 02:19:30 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id DE8671283B9;
        Tue, 23 Mar 2021 02:19:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=TY6kkNPwC9A+DxRQUNpgy+qpbXQ=; b=XPW6+G
        pK43dHGhGIx+TTZUk3ckl9eb3oqkF0Br6zNAZNu78Fgf3kEXxLAGyRcCqMn3j5m0
        y71N/btLXZDCbiLugPyvPRdsl3zgb0QRJ737ubLLVeRKozhmgGqRVnODVSdZ3QFc
        AJFZ2T8J6n7hq9mM2eHQ4pFrsa5ZGnlobG2sk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=MDErWFk6HDuvhgMiJiDVvdWOFYdkVH4F
        WvZzosynF/SM5S14dbGpwlAtnvUM8zLpM+elVjHKM2SY+FoK2GDERFEyYB0mrl0u
        SOwLEa+C17JDXPInDM9uPPkYv7Y7yVrp8MPWc3pVwiygShUKPvD+GYY0tkgVJDw+
        l/h/6e69nhU=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D6B881283B8;
        Tue, 23 Mar 2021 02:19:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 2A29B1283B6;
        Tue, 23 Mar 2021 02:19:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     ZheNing Hu <adlternative@gmail.com>,
        ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>,
        "Bradley M. Kuhn" <bkuhn@sfconservancy.org>,
        Brandon Casey <drafnel@gmail.com>,
        Shourya Shukla <periperidip@gmail.com>,
        Rafael Silva <rafaeloliveira.cs@gmail.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, Jeff King <peff@peff.net>,
        =?utf-8?B?w4Z2YXIg?= =?utf-8?B?QXJuZmrDtnLDsA==?= Bjarmason 
        <avarab@gmail.com>
Subject: Re: [PATCH v13] [GSOC] commit: add --trailer option
References: <pull.901.v12.git.1616247681211.gitgitgadget@gmail.com>
        <pull.901.v13.git.1616387093662.gitgitgadget@gmail.com>
        <CAP8UFD0rtX0m+fGcvGFtsFFKZ2LVyxHx8dptYFvM9kWnbxEwFA@mail.gmail.com>
        <CAOLTT8Ty5kabU6ivX946=FDWJ4SEXBzPinq2aG5t7Rp9jCCEPA@mail.gmail.com>
        <CAP8UFD3fYTc8=y+kru-mN5KmTsnqc6X8mf14VtyWf1Nj9CJ1EQ@mail.gmail.com>
Date:   Mon, 22 Mar 2021 23:19:25 -0700
In-Reply-To: <CAP8UFD3fYTc8=y+kru-mN5KmTsnqc6X8mf14VtyWf1Nj9CJ1EQ@mail.gmail.com>
        (Christian Couder's message of "Mon, 22 Mar 2021 22:34:21 +0100")
Message-ID: <xmqqv99i4ck2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B83B6F52-8B9F-11EB-8507-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

> If you want nothing to happen when $ARG isn't set, you can change the
> config option to something like:
>
> $ git config trailer.sign.command "NAME='\$ARG'; test -n \"\$NAME\" &&
> git log --author=\"\$NAME\" -1 --format='format:%aN <%aE>' || true"
>
> (This is because it looks like $ARG is replaced only once with the
> actual value, which is perhaps a bug. Otherwise something like the
> following might work:

I do not know the origin of that code in trailers.c but it feels
quite confused and error prone to use textual replacement with
strbuf_replace().  Why doesn't the code, which knows it will use
shell to execute the command line given by the end user in the
configuration, to just export ARG as an environment variable and
be done with it?  It would also avoid quoting problem etc.

