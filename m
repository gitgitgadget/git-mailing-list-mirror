Return-Path: <SRS0=24D7=6H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A60BFC54FD0
	for <git@archiver.kernel.org>; Thu, 23 Apr 2020 21:43:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67CA420724
	for <git@archiver.kernel.org>; Thu, 23 Apr 2020 21:43:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="YWCxVVGV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726706AbgDWVnZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Apr 2020 17:43:25 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52962 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726056AbgDWVnY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Apr 2020 17:43:24 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8EF594D3D3;
        Thu, 23 Apr 2020 17:43:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=dwpJ/BMS/pw+tk4Qap0IVdgU5QI=; b=YWCxVV
        GVaE38UgphU6Ws9FtGN8FdpCPV17NYcrvR6fNQAupMQXrdk91THAVXQAl2XMJrve
        WDpEK4x4NqPwwmBLAe610zFPtg38uxmnlNDnH3aqE2Sv62o4HkhhY+x67JzNAYOW
        AyffF7WMWcBm+tnGclpXBeeqUfC6weNJNluck=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=iOMnDZ5G/clNoKeShFmRlRu55FIbjGRT
        eb9niV6HEwg04KXnQrS9KoOQN2Hq3CL0O/NqIhO+7RB0bKMzUfxlVoQhWI6FkL6Q
        5E6SQyD2hktZUgTLwSVD/IQDr54I/GFe52cYGFfFgJ5nG16vRlN7b0OUkNOaLXNv
        wfstrmwTN9g=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 85CC54D3D2;
        Thu, 23 Apr 2020 17:43:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0B9D24D3CF;
        Thu, 23 Apr 2020 17:43:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Han-Wen Nienhuys <hanwen@google.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: [PATCH v9 00/10] Reftable support git-core
References: <pull.539.v8.git.1585740538.gitgitgadget@gmail.com>
        <pull.539.v9.git.1587417295.gitgitgadget@gmail.com>
        <xmqqmu74mwaw.fsf@gitster.c.googlers.com>
        <CAFQ2z_OhWDzc40WMy=bwUKRJQ4rcvnFmYvk-ga_cTtCjviMoBg@mail.gmail.com>
Date:   Thu, 23 Apr 2020 14:43:21 -0700
In-Reply-To: <CAFQ2z_OhWDzc40WMy=bwUKRJQ4rcvnFmYvk-ga_cTtCjviMoBg@mail.gmail.com>
        (Han-Wen Nienhuys's message of "Thu, 23 Apr 2020 23:27:40 +0200")
Message-ID: <xmqqftctg9om.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 74057D1E-85AB-11EA-A089-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Han-Wen Nienhuys <hanwen@google.com> writes:

> For example,
>
> not ok 10 - check rev-list
> #
> # echo $SHA >"$REAL/HEAD" &&
> # test "$SHA" = "$(git rev-list HEAD)"
> #
>
> What is the right way to approach this? Should the test use
>
>   git update-ref HEAD $SHA
>
> instead of writing to the loose ref?

Preferred.  

I didn't bother checking the context, but if the test is checking
"the history leading to $SHA has only one commit, i.e.  $SHA, and
rev-list can handle that correctly", certainly that would be a
preferred rewrite, rather than skipping the check for reftable,
which may risk not noticing that HEAD is broken with reftable.

> Or should we skip it in case of
> reftable? Similarly
>
>   git update-ref $m $A &&
>   test $A = $(cat .git/$m)

Ditto.  

We have "git show-ref -s --verify" for that; "cat .git/$m" certainly is wrong.

Thanks.
