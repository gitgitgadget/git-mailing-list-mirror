Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DD00C433EF
	for <git@archiver.kernel.org>; Mon, 10 Jan 2022 17:56:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238652AbiAJR4v (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Jan 2022 12:56:51 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61456 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238610AbiAJR4t (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jan 2022 12:56:49 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9700810189A;
        Mon, 10 Jan 2022 12:56:49 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=6BhRjeIqgot6nwFbfA5Jss/gmFbcFE753UaTvI
        ujaMs=; b=PZOCkpHGPeoO0/GKNN1KfxUecDOVlGtwqDR2OsSP9w/FXLUjOOIeJx
        dev4GhULFdOrS2PHuQnxeW+xiycwu5wFHeOI831Ae2/hS9SR9LKFBqB3C7XY/PMa
        Tkndk1Ujsh3QEex5ywRZkzTrLQIgAA8TZU+WirASYl8jkaAd2/nJc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8E415101899;
        Mon, 10 Jan 2022 12:56:49 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id F3568101898;
        Mon, 10 Jan 2022 12:56:48 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Elijah Newren <newren@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmo=?= =?utf-8?B?w7Zyw7A=?= Bjarmason 
        <avarab@gmail.com>, Taylor Blau <me@ttaylorr.com>
Subject: Re: [RFC PATCH 0/2] Introduce new merge-tree-ort command
References: <20220105163324.73369-1-chriscool@tuxfamily.org>
        <CABPp-BFh7UnQtPM=tO8rfp5bPK4-7esouv5KCx1sUSESwEA=Rw@mail.gmail.com>
        <CAP8UFD0wKnAg5oyMWchXysPTg3K9Vb4M1tRcPzPE81QM903pYg@mail.gmail.com>
        <CABPp-BHpuLjCYycBwweMW_NdQrS_r3ECmvLb8XjNW-_Rau5NTw@mail.gmail.com>
        <nycvar.QRO.7.76.6.2201101427440.339@tvgsbejvaqbjf.bet>
Date:   Mon, 10 Jan 2022 09:56:47 -0800
In-Reply-To: <nycvar.QRO.7.76.6.2201101427440.339@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Mon, 10 Jan 2022 14:49:26 +0100 (CET)")
Message-ID: <xmqq8rvn1nkw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AEF086D6-723E-11EC-9906-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> I am against a new command for what essentially serves the original
> purpose of `merge-tree`.
>
> The fact that `merge-tree` has not seen any work in almost 12 years is
> testament not only to how hard it was to disentangle the work-tree
> requirement from the recursive merge (it is one of my favorite
> counterexamples when anybody claims that you can easily prototype code in
> a script and then convert it to C), but the fact that there is no user
> within Git itself (apart from t/t4300-merge-tree.sh, which does not count)
> speaks volumes about the design of that `merge-tree` tool.
>
> So it's only fair to breathe life into it by letting it do what it was
> meant to do all along.

My "Yup" would not weigh as much as one that Linus (whose original
merge-tree survived this long without seeing much enhancements)
might give us, but he is busy elsewhere so you guys have to live
with mine ;-)

As to its output, I do agree that "we give a tree when it is already
usable to record in a new commit" is a valuable option to have.  The
original behaviour should be made available somehow, for those who
built their workflow (including scripts) around it, though.
