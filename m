Return-Path: <SRS0=r8De=BV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE0ADC433DF
	for <git@archiver.kernel.org>; Tue, 11 Aug 2020 21:06:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9619420756
	for <git@archiver.kernel.org>; Tue, 11 Aug 2020 21:06:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="FwvbeMtX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726454AbgHKVGL (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Aug 2020 17:06:11 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58552 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726115AbgHKVGL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Aug 2020 17:06:11 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C85F284C06;
        Tue, 11 Aug 2020 17:06:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=bkwjHsZ3Zg0ZjGzWcSoSThOpDtQ=; b=FwvbeM
        tX5Hi1VEWcydueKn6F+90rhFPyahaT7umYKI2A9ckB9olKDkrYCnUwN+reqgVyny
        lJOw9DCZQeGL2lEW/ipveqeCKEeJ3He25N7GBlHFGB/y46/R1otCxISB/lsQxmh4
        wC+mnCVTgzzFq4SDFDPeW9Q1njrb0UJpYdWuM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=d3U0U/QsdjORQtmy4p7HClbXd345d0SB
        COMHv38Hp8Jhw48tqibIktrqhtrSlO83w+yy4ZJBpZbaoMBwvo+4UoE9/T6Mi/Dk
        9pg54dejl0I2W4fMD+elDAtHxO9LEyWK1gaiSdnzaWK8uMIDNOD0I0HJ3/AfJrTF
        iZMOW5+FtaA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BAF7D84C05;
        Tue, 11 Aug 2020 17:06:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.231.104.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 249D684C03;
        Tue, 11 Aug 2020 17:06:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, sluongng@gmail.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH] multi-pack-index: repack batches below --batch-size
References: <pull.698.git.1597159818457.gitgitgadget@gmail.com>
        <20200811155013.GF19871@syl.lan>
Date:   Tue, 11 Aug 2020 14:06:07 -0700
In-Reply-To: <20200811155013.GF19871@syl.lan> (Taylor Blau's message of "Tue,
        11 Aug 2020 11:50:13 -0400")
Message-ID: <xmqqlfik99kw.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 79F4D3AC-DC16-11EA-9B1E-01D9BED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> OK. This '--batch-size' parameter is a little magical to me, but the
> behavior you are describing seems sane. I think that your assessment of
> the down-side is reasonable, too.
>
> Looks fine to me.
>
>   Reviewed-by: Taylor Blau <me@ttaylorr.com>
>
>> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>

Thanks, both.
