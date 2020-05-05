Return-Path: <SRS0=nPiP=6T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD4D7C47254
	for <git@archiver.kernel.org>; Tue,  5 May 2020 21:29:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5A37206A5
	for <git@archiver.kernel.org>; Tue,  5 May 2020 21:29:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="f1cTkmL6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728642AbgEEV3Q (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 May 2020 17:29:16 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51439 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726593AbgEEV3P (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 May 2020 17:29:15 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6FC126647F;
        Tue,  5 May 2020 17:29:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=kIm04Za2zXUF+Fuc2OOZ5dYGMEM=; b=f1cTkm
        L6tpecsxhjqFwYuLXRbpCYAlGbRruVameJKGyG08gqShVyMvew4cqKXQtmMdlU0o
        YIQeeJ4v/DKUE/3uannuSYHxDNUHdt/J4MWheQMWa2qrjb1FM3LvTb0M3co9Xhhq
        eKva0q6EXgkDbNMUhr6vyDbnfH6e0CeXGDb/s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=iycB8wdR0X5JeOo+NkMrLn/Zz4bF5mPp
        Sn1E6jYBOMU5kAWd+/4ZdOirFXL36pJZDJ3TJdKwkty2FZQEeexlGJKJ93jMJpi4
        tW29eSNLTrtipzxgrXOzwKGzDCFrsTPZcSZGoDs43y+F53MSMzXS+bMLxvGmeo0F
        MXQQ8wN+x7g=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 637AB6647E;
        Tue,  5 May 2020 17:29:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CAE676647D;
        Tue,  5 May 2020 17:29:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, git@vger.kernel.org,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 1/2] CI: limit GitHub Actions to designated branches
References: <20200504150105.GB11373@coredump.intra.peff.net>
        <cover.1588607262.git.congdanhqx@gmail.com>
        <73de97dfebfccabe9f1bf32ea41aea5008a949cd.1588607262.git.congdanhqx@gmail.com>
        <20200504162311.GE12842@coredump.intra.peff.net>
        <20200504215824.GC45250@syl.local>
        <20200504233634.GB39798@coredump.intra.peff.net>
        <20200505002055.GC64230@syl.local>
        <20200505164326.GA64077@coredump.intra.peff.net>
        <xmqqo8r2b6y4.fsf@gitster.c.googlers.com>
        <20200505182418.GA66702@coredump.intra.peff.net>
        <20200505210451.GA645290@coredump.intra.peff.net>
Date:   Tue, 05 May 2020 14:29:09 -0700
In-Reply-To: <20200505210451.GA645290@coredump.intra.peff.net> (Jeff King's
        message of "Tue, 5 May 2020 17:04:51 -0400")
Message-ID: <xmqqlfm69il6.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7504EBDA-8F17-11EA-98B1-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Tue, May 05, 2020 at 02:24:18PM -0400, Jeff King wrote:
>
>> But _if_ we can read from other refs in the repository, I would be very
>> happy if we parsed config out of refs/ci/branches or something. It feels
>> like that's something that ought to be possible, but I haven't quite
>> figured out a way to do it.
>
> OK, I finally figured this out. The result is the patch below, which I
> think should make everybody happy. Or at least has the ability to do so
> if they're willing to push a config ref. ;)

That sounds good.

> Subject: [PATCH] ci: allow per-branch config for GitHub Actions
>
> Depending on the workflows of individual developers, it can either be
> convenient or annoying that our GitHub Actions CI jobs are run on every
> branch. As an example of annoying: if you carry many half-finished
> work-in-progress branches and rebase them frequently against master,
> you'd get tons of failure reports that aren't interesting (not to
> mention the wasted CPU).

OK.

> This commit adds a new job which checks a special ref within the
> repository for CI config, and (optionally) causes all of the other jobs
> to be skipped.

Nice---that way, all existing jobs do not even need to know about
the special controlling ref.

> Right now the logic is to run CI for all branches by default, unless a
> whitelist exists, in which case the branch must be mentioned there
> (using its fully qualified ref name).

So there is no wildcard?  Not really complaining, but am wondering.

> We could easily add in a
> blacklist, as well.

OK.

> Or since we're running a shell in a VM, we really
> could just run "./allow-ref $refname" and let individual forks specify
> whatever shell code they like.

I presume that you are saying "checking out the tree of refs/ci/config
and there is a program allow-ref that can tell which one to run ci on"?

> After writing that, I think we probably ought to just do the allow-ref
> thing from the start, and skip this whitelist logic. Then we should
> never need to change this workflow file again. People can implement
> whatever weird custom logic they want to.

Probably.

>  jobs:
> +  check-ci:
> +      runs-on: ubuntu-latest
> +      outputs:
> +        enabled: ${{ steps.check-ref.outputs.enabled }}
> +      steps:
> +        - uses: actions/checkout@v2
> +          continue-on-error: true
> +          with:
> +            ref: refs/ci/config
> +        - id: check-ref
> +          name: check whether CI is enabled for ref
> +          run: |
> +            enabled=yes
> +            if test -e ref-whitelist &&
> +               ! grep '^${{ github.ref }}$' ref-whitelist
> +            then
> +              enabled=no
> +            fi
> +            echo "::set-output name=enabled::$enabled"
> +
>    windows-build:
> +    needs: check-ci
> +    if: needs.check-ci.outputs.enabled == 'yes'
>      runs-on: windows-latest
>      steps:
>      - uses: actions/checkout@v1

Oh, quite nice.  Simple and clean.

