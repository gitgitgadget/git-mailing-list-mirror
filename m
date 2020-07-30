Return-Path: <SRS0=t8Cj=BJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DDDFC433DF
	for <git@archiver.kernel.org>; Thu, 30 Jul 2020 23:31:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DDBCC2082E
	for <git@archiver.kernel.org>; Thu, 30 Jul 2020 23:31:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="s2cmH8Oj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730743AbgG3Xbi (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jul 2020 19:31:38 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:50006 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730217AbgG3Xbh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jul 2020 19:31:37 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 6C783E070C;
        Thu, 30 Jul 2020 19:31:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=k152cnNmxgTYAchA9/sEQdMaW40=; b=s2cmH8
        Oj7/bRrMNNLcitU5eVQt7s5Plvb8WO0/VdgUs4ck/sG72jHu8kaQZihNLTSCkDHr
        k/JqzO82+LPK8HD2Rw1NdAcMgVZsH/KG87oOdLbjHXqOd0ATP42amBrFGnAWnCdn
        /STV4kB+OeJSOtSLxFOakKSkAruuFBRLr4ySk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=foeIFMoanCvsjv9tLMYiu5buWpGa2odd
        gUj4FOzzSCfTR5OFcVWG9uVb+m9F4Gq9UyJOJAZPZHrVnYKIG1ptKTiKKxEbVtZc
        3Q82Q+JfG9Q+cJAtd0Ey/8cM43buDDgBtu3odDvYRVfVgwsECg4LVtVGuiZWvd2q
        mfWY2HPZIwM=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 641D6E070B;
        Thu, 30 Jul 2020 19:31:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 8D511E070A;
        Thu, 30 Jul 2020 19:31:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Johannes.Schindelin@gmx.de,
        sandals@crustytoothpaste.net, steadmon@google.com,
        jrnieder@gmail.com, peff@peff.net, congdanhqx@gmail.com,
        phillip.wood123@gmail.com, emilyshaffer@google.com,
        sluongng@gmail.com, jonathantanmy@google.com,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v3 00/20] Maintenance builtin, allowing 'gc --auto' customization
References: <pull.671.v2.git.1595527000.gitgitgadget@gmail.com>
        <pull.671.v3.git.1596147867.gitgitgadget@gmail.com>
Date:   Thu, 30 Jul 2020 16:31:31 -0700
In-Reply-To: <pull.671.v3.git.1596147867.gitgitgadget@gmail.com> (Derrick
        Stolee via GitGitGadget's message of "Thu, 30 Jul 2020 22:24:06
        +0000")
Message-ID: <xmqqzh7g60mk.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CDC25FA8-D2BC-11EA-AFDC-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

>  * This series is now based on jk/strvec, as there are several places where
>    I was adding new callers to argv_array_push* and run_command_v_opt()
>    which have been replaced with strvec_push*() and run_command(), using a
>    'struct child_process'.

It probably has been a good way to gain experience with the renamed
API for you to rebase this series, but I think we'd have to spend a
similar amount of effort yet again, as I expect that the jk/strvec
series would be rerolled at least once more, with the items[] array
renamed to something else, like v[].

Let's see how it goes.

Thanks.

