Return-Path: <SRS0=kKTt=BD=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40337C433E0
	for <git@archiver.kernel.org>; Fri, 24 Jul 2020 20:54:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F0682070B
	for <git@archiver.kernel.org>; Fri, 24 Jul 2020 20:54:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="gAFj2SPn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726593AbgGXUye (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Jul 2020 16:54:34 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50179 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726411AbgGXUyc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Jul 2020 16:54:32 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 37985753BC;
        Fri, 24 Jul 2020 16:54:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=TvzFt5lhl+aGWSkPqfPyLCwCvWo=; b=gAFj2S
        PnIxJPflN8opMdN/8SqDf2Rzw9sNrGK/m0XGX2c6p6vyDXczofLJGPZ0ISd8V8bf
        7OK/N6/bNEnzO1/76PjIDKaVBP3GaZ/n/KfzG1/jdKBpKTEARKVqque0Hhn1Sn6V
        tA6YgvnnAfSFi/mb8ME8rA/UZdBAhtIXcPmow=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=qxzNHXFFaq2M8evtZ9osfn7NIehmgmgB
        9TLHgMIdzc84YZTTd7WtbsZp5/hDGYZ16rLc2/7K/r9KrPQDZkeoQ4z3a5TVNSXc
        Es7miZVdotKe43qXbCqcJFdgeBhTwGC65SJQq2pJhEm6fClMyyad+/oXLNCrsBaR
        Gb7YeVSVuNA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 30B5F753BB;
        Fri, 24 Jul 2020 16:54:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B521B753BA;
        Fri, 24 Jul 2020 16:54:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     starlord via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        starlord <bojun.cbj@gmail.com>,
        Bojun Chen <bojun.cbj@alibaba-inc.com>
Subject: Re: [PATCH] githooks.txt: use correct "reference-transaction" hook name
References: <pull.681.git.1595599077623.gitgitgadget@gmail.com>
        <20200724142156.GB1032@xps.pks.im>
Date:   Fri, 24 Jul 2020 13:54:29 -0700
In-Reply-To: <20200724142156.GB1032@xps.pks.im> (Patrick Steinhardt's message
        of "Fri, 24 Jul 2020 16:21:56 +0200")
Message-ID: <xmqqmu3ok516.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DE3CB242-CDEF-11EA-AD64-01D9BED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Patrick Steinhardt <ps@pks.im> writes:

> Hi Bojun,
>
> On Fri, Jul 24, 2020 at 01:57:57PM +0000, starlord via GitGitGadget wrote:
>> From: Bojun Chen <bojun.cbj@alibaba-inc.com>
>> 
>> The "reference transaction" hook was introduced in commit 6754159767
>> (refs: implement reference transaction hook, 2020-06-19). The name of
>> the hook is declared as "reference-transaction" in "refs.c" and
>> testcases, but the name declared in "githooks.txt" is different.
>> 
>> Signed-off-by: Bojun Chen <bojun.cbj@alibaba-inc.com>
>
> Indeed, thanks for catching this!
>
> Reviewed-by: Patrick Steinhardt <ps@pks.im>

Thanks.
