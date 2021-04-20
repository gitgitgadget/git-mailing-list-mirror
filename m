Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 299C9C433ED
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 21:52:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4CAC61413
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 21:52:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234189AbhDTVwo (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Apr 2021 17:52:44 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64324 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234355AbhDTVvi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Apr 2021 17:51:38 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 31085D0F18;
        Tue, 20 Apr 2021 17:51:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=YMJDLbV7OX+XAZBCMTIpRfpJmu0=; b=aNLXYV
        a1pevOLxX9INatnYbU/Ni2IJpKtQFqeWArD1Oq4Wleqy7n6AqfjgSdSFMmRI6Ipr
        KnkfMMb/Beco0NcR72oN0ivlYxb62nfCf0R8FYJPJiieEKVQ1uLNuAcjofuBLEpy
        terk8+gedBQ3z7w2x3LGlpr2/2QEiOBdMdksA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=nz8zyJ20zJgnoxposIL3y4LyCoAqOzjK
        dCdqo/oPQ+bL/rKJP1pinIL4fNd4ZOxnLMSmCK10MdTYV1qDL0ZK1gy7PpF7e/L1
        /Yd9VUPzgFaAxXgoxqojyP4XKnNADqJInw6eAuXOG7zp57IXtT0VnHJ/a2IiLbnn
        Vb/RXWGc8ds=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 164E5D0F15;
        Tue, 20 Apr 2021 17:51:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B6884D0F14;
        Tue, 20 Apr 2021 17:51:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Robin H. Johnson" <robbat2@gentoo.org>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] Document how we do embargoed releases -
 improving mail template
References: <pull.917.git.1616796767.gitgitgadget@gmail.com>
        <pull.917.v2.git.1617025385.gitgitgadget@gmail.com>
        <565d7982d870fb1b7644a9777aef6be7ee174dba.1617025385.git.gitgitgadget@gmail.com>
        <robbat2-20210420T193302-520335089Z@orbis-terrarum.net>
Date:   Tue, 20 Apr 2021 14:51:02 -0700
In-Reply-To: <robbat2-20210420T193302-520335089Z@orbis-terrarum.net> (Robin
        H. Johnson's message of "Tue, 20 Apr 2021 19:50:44 +0000")
Message-ID: <xmqq5z0g4oc9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 80CD02A8-A222-11EB-A2A0-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Robin H. Johnson" <robbat2@gentoo.org> writes:

> On Mon, Mar 29, 2021 at 01:43:04PM +0000, Johannes Schindelin via GitGitGadget wrote:
>> Whenever we fix critical vulnerabilities, we follow some sort of
>> protocol (e.g. setting a coordinated release date, keeping the fix under
>> embargo until that time, coordinating with packagers and/or hosting
>> sites, etc).
>> 
>> Similar in spirit to `Documentation/howto/maintain-git.txt`, let's
>> formalize the details in a document.
> ...
>> +Notifying the Linux distributions
>> +---------------------------------
> As one of the Gentoo maintainer for Git, I was wondering if the
> embargoed-releases process could be tweaked slightly.
>
> Specifically, in the embargo email, could you please publishing the
> exact size & digests of the to-be-released tarballs, esp. the htmldocs &
> manpages tarballs.

HTMLdocs and Manpages are as far as I am concerned part of SOURCES.

They are generated from the true sources, I do not give signed tags
to them, and as a source-based distribution, Gentoo shouldn't
consider them as such, either.  When release tags are signed, their
sizes or digests are simply unavailable, since they have not even
been generated yet (I tag the releases, run make in the tagged
release tarball extract and that is what is tarred up as HTMLdocs
and or Manpages).


> Gentoo, as a source-based distribution, intends users to download the
> upstream tarballs (we mirror them as well), and verify the digests of
> the tarballs vs a signed copy of what the digests should be.
>
> This has meant some delay at the end of embargoed releases because we
> have to wait for the official files to be available, then update the
> build instructions (specifically "Manifest" which contains the matching
> digests), and get that out to users.
>
> Fields in of the Gentoo side of the digests:
> name, size, digests w/ prefix.
>
> Example:
> DIST git-2.31.1.tar.xz 6413368 BLAKE2B ...  SHA512 ...
> DIST git-htmldocs-2.31.1.tar.xz 1357592 BLAKE2B ...  SHA512 ...
> DIST git-manpages-2.31.1.tar.xz 487784 BLAKE2B ...  SHA512 ...
>
> The minimum set of hash algorithms for this Gentoo code right now is
> BLAKE2B, which should be easy to script into the announcement mail via:
> openssl dgst -blake2b512 "$FILENAME"
