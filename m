Return-Path: <SRS0=27Fn=A3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AA13C433E1
	for <git@archiver.kernel.org>; Thu, 16 Jul 2020 22:10:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 101A4207FB
	for <git@archiver.kernel.org>; Thu, 16 Jul 2020 22:10:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="HLeWgL8H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726890AbgGPWJ7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jul 2020 18:09:59 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:64344 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726007AbgGPWJ6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jul 2020 18:09:58 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E9D0FE8522;
        Thu, 16 Jul 2020 18:09:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=hqhu3Ze4hs5Uh3IXksEPho7p+Ls=; b=HLeWgL
        8HHraiBTGwnV8MKFSfZWGIshyYdG6fMhzHQXvmEHSGNQG9/ySIttQRCM85pf9x93
        aLAG0k1CTodi8YRErISe52n7LBr1JZ1Qy49JuZr7X6Djq3jmBa8bQENgLZGluGEH
        TBzdmQNc516/XH9THDk41Qwq1l1eyLIvvIdyY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=l3iHZy6m4/5GVqdcDVgpzJYeqSazuaXz
        1M1Fxdttml3M4O4rlTNYEU4Sr1ppDegNlWyLAappcFrk43lNboxi5EN79oPwEbIl
        ff++Z61f9w47V/dILgU7kDcSxFppr8cgMJd2phVL1mD2CsZfmU2mCojdlvg5h4Vm
        zHoEm4HoZJM=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E26B9E8521;
        Thu, 16 Jul 2020 18:09:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.231.104.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 37B01E8520;
        Thu, 16 Jul 2020 18:09:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: [PATCH v3 0/3] Remove special casing for PSEUDOREF updates
References: <pull.673.v2.git.1594329108.gitgitgadget@gmail.com>
        <pull.673.v3.git.1594925141.gitgitgadget@gmail.com>
Date:   Thu, 16 Jul 2020 15:09:52 -0700
In-Reply-To: <pull.673.v3.git.1594925141.gitgitgadget@gmail.com> (Han-Wen
        Nienhuys via GitGitGadget's message of "Thu, 16 Jul 2020 18:45:38
        +0000")
Message-ID: <xmqqwo33f6xb.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 13BBDA78-C7B1-11EA-B44A-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com> writes:

> This gets rid of the special casing code for pseudorefs in refs.c
>
> This is in preparation for reftable.
>
> v3
>
>  * tweak git-update-ref.txt description for logAllRefUpdates
>
> Han-Wen Nienhuys (3):
>   t1400: use git rev-parse for testing PSEUDOREF existence
>   Modify pseudo refs through ref backend storage
>   Make HEAD a PSEUDOREF rather than PER_WORKTREE.

I reviewed some codepaths that deal with FETCH_HEAD recently.  

As the file is quite different from all the other pseudo references
in that it needs to store more than one object name and in that each
ref in it needs more than just the object name, I doubt that it
makes much sense to enhance the refs API so that its requirements
can be covered.

It would probably make sense for FETCH_HEAD to stay "a text file
directly underneath $GIT_DIR", but get_oid() needs to be able to
read it and return the first object name recorded in the file.
