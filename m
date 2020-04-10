Return-Path: <SRS0=1KXq=52=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4753C2D0EC
	for <git@archiver.kernel.org>; Fri, 10 Apr 2020 21:29:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 758A720757
	for <git@archiver.kernel.org>; Fri, 10 Apr 2020 21:29:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="rzwc9jPY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726687AbgDJV3N (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Apr 2020 17:29:13 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59244 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726638AbgDJV3N (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Apr 2020 17:29:13 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D40914A0E0;
        Fri, 10 Apr 2020 17:29:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=J11MhelPfx7tdQLmmtbFzbzs9Kc=; b=rzwc9j
        PYHXSvPsq4W9t9CjUX9Vsx6rjRxdId3zvMrbwrACkapLjBV6+zx+FnoEsSPPaOCm
        Utn2KMvUwOGE7zic6Y+a7FWHO1DaUavRmEg4JQpiY1mWs2P7D6VLPqcVrn1cVs/r
        u1k8lBmmmBhDqMsY4CNAyApt7hjzzAp3/NSOg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=BshHMMIV17Zj8bgh2w7/xw5mqf5CRSao
        PkwWZoZr8FstfUv4p0oQsiVWohL4cRg8ks+FNnMmWT+Y4ri2J/S04X0XKRc1Gu/6
        dDZ5R4JfmbHPZE9nu+4Bz5dhnE3zXHg6tYXUKtoQ3kxPhgyauXtq/xDd7hmNj9cD
        EeVudGFPBkM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C64E54A0DF;
        Fri, 10 Apr 2020 17:29:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4D2E14A0DE;
        Fri, 10 Apr 2020 17:29:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, phillip.wood123@gmail.com,
        Johannes.Schindelin@gmx.de, bturner@atlassian.com,
        sami@boukortt.com,
        "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Subject: Re: [PATCH v2 0/3] rebase -i: mark commits that begin empty in todo editor
References: <pull.757.git.git.1586474800276.gitgitgadget@gmail.com>
        <pull.757.v2.git.git.1586541094.gitgitgadget@gmail.com>
        <xmqqpncfhy3g.fsf@gitster.c.googlers.com>
Date:   Fri, 10 Apr 2020 14:29:10 -0700
In-Reply-To: <xmqqpncfhy3g.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Fri, 10 Apr 2020 13:42:11 -0700")
Message-ID: <xmqqd08fhvx5.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 51943BF0-7B72-11EA-860F-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> So I am OK to rebase the other topic to v2.26.0; would that help?  I
> already saw there was some entanglement with the other topic in one
> of the patches in this series, so...

So I've done such a rebasing and queued the result to 'pu'.
jt/rebase-allow-duplicate used to be directly on v2.25.0 but now it
is on top of 'master'==9fadedd6, and these three patches are queued
directly on top of that.  Hopefully I can push out the result of
today's integration with other topics in an hour or so.

Thanks.
