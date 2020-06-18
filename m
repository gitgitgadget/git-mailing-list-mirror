Return-Path: <SRS0=1Nmv=77=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21BE8C433E0
	for <git@archiver.kernel.org>; Thu, 18 Jun 2020 06:30:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F35E9217A0
	for <git@archiver.kernel.org>; Thu, 18 Jun 2020 06:30:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Cfjs+Zkl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727877AbgFRGay (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Jun 2020 02:30:54 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:63548 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725898AbgFRGax (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Jun 2020 02:30:53 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 95062CD0EB;
        Thu, 18 Jun 2020 02:30:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=PYTkMfIw9jrTwS0D3bhx/FRlUiI=; b=Cfjs+Z
        klT9rCMzPwcc9eNuIzp9zGEAY3Y2P8BPLVdz7tVUMQ/h2kuHyun3r284gACkcAPR
        MHzeKBEC40yvhIvnuynrqLYHXNF+Dx5UJL3QN+yHi3SiIccFFKoyuPCBXXLmG9Gb
        806AeBcG3ftXlhrvzTsfgaWHMW1PyiNtG/Lpw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=vbZ4xrSWjTI7WuQSR/NBrzjjaYQNzEO5
        x07e4k0QI6Se6vv5zM6UEXavff0nQSCQwG73k9LvaQGO7Ed07QBLSdt9jZf7pw0E
        I42i8D1oaGzKtGz7E4wvuQYM86xkEkYweiRAjXyp7woKpvzCN/u3b1cg6IAjD5N0
        OMy8njbbh9o=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8CA81CD0EA;
        Thu, 18 Jun 2020 02:30:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id D3ED5CD0E9;
        Thu, 18 Jun 2020 02:30:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Jeff King <peff@peff.net>,
        Junio C Hamano via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Don Goodman-Wilson <don@goodman-wilson.com>,
        Derrick Stolee <stolee@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Matt Rogers <mattr94@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 01/12] fast-export: do anonymize the primary branch name
References: <pull.656.git.1591823971.gitgitgadget@gmail.com>
        <pull.656.v2.git.1592225416.gitgitgadget@gmail.com>
        <ebd10f73cd73a8fca84d1862e5a4b7b62a549bcd.1592225416.git.gitgitgadget@gmail.com>
        <20200616125833.GE666057@coredump.intra.peff.net>
        <xmqqmu51v9qy.fsf@gitster.c.googlers.com>
        <20200617212333.GB2809@coredump.intra.peff.net>
        <CABPp-BETyMYm=5APqAA3D1JmkurDFNkKLDrcF4MUgEfqEuVKFA@mail.gmail.com>
Date:   Wed, 17 Jun 2020 23:30:47 -0700
In-Reply-To: <CABPp-BETyMYm=5APqAA3D1JmkurDFNkKLDrcF4MUgEfqEuVKFA@mail.gmail.com>
        (Elijah Newren's message of "Wed, 17 Jun 2020 19:06:26 -0700")
Message-ID: <xmqqzh90q414.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3FB73608-B12D-11EA-8709-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

>> That leaves us in the interim with a "fast-export --anonymize" that is a
>> little harder to use (you have no way to know which branch was which).
>
> Why does fast-export special case on "master" rather than on HEAD?
> Isn't it more relevant to know the active branch than what _might_
> have been the initial branch?  It kind of feels like a bug to me that
> HEAD isn't the special case construct.

I am torn on that one.  Surely HEAD is often the branch that has our
current attention.  It may well be what we are exporting and we may
want to see the topology formed by other refs relative to it.

On the other hand, the current branch may not necessarily be what we
are exporting.  Historically a project has a single branch that is
the focus of most users' attention when they talk about the general
state of the project's progress, so it is understandable to expect
that the topology may want to be seen relative to that one central
line of development.

> (Speaking as someone whose company a number of years ago had most
> their big repos and lots of little repos switch their main branch to
> be named "develop", and in some of those repos deleted "master" but
> didn't in others.  If I had needed some steps to reproduce a problem,
> and hadn't been on the inside, any special casing from fast-export
> would make more sense to me to apply to "develop" than to "master".)

Yes, absolutely.  You either check "develop" out temporarily just to
take anonymized export to make "develop" discoverable in the output,
or you would have set core.primaryBranch to "develop" once sometime
in the past to tell Git that "develop" is that special one, not
"master", so you can take such an export from any branch.  As the
anonymized export is primarily/solely a debugging aid, convenience
would not be of much value, but the latter feels more convenient to
me.

