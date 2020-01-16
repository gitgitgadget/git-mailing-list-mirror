Return-Path: <SRS0=75zt=3F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6433BC33CAF
	for <git@archiver.kernel.org>; Thu, 16 Jan 2020 20:18:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36E2F2077B
	for <git@archiver.kernel.org>; Thu, 16 Jan 2020 20:18:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="vVCb4Ii1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729654AbgAPUSF (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jan 2020 15:18:05 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:65512 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727065AbgAPUSE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jan 2020 15:18:04 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3A35237C3C;
        Thu, 16 Jan 2020 15:18:00 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=huOvDPifoDglzKb+67F+9n2R5Gk=; b=vVCb4I
        i1ZglQdFL7HFdzZNHDk10xcytZMdO1cACCkzMyiO70VEuzb0BFRPxdzpB8zHj9S+
        8FllbXaQFGVtGXlHPmpXaYgznL9CPePhbw5m2ZpRZ/weTUSVHUnDbzzks3tYyv/H
        eZmQtd1h7eYgRgu5Ys02er4MmgpI1wZ2FMaZE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=tM5Z0TO2moF0f/lffzpr+r6jSR1LCeUi
        4dNU13k8FIEO0PRjwjaSybx5Gdgt4oJvLzbJ7s3gGaeogWXn/V+YVnA/B7Rav7S0
        zW7T9BKmVpSgztg3QhSFpl/aklPhgvlyqw5iV96jHKjFu5eDXYpCR3l5S/43W0SV
        UK9k71HVKdI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2FB4537C3B;
        Thu, 16 Jan 2020 15:18:00 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 92A9837C3A;
        Thu, 16 Jan 2020 15:17:59 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] msvc: accommodate for vcpkg's upgrade to OpenSSL v1.1.x
References: <pull.527.git.1579129054234.gitgitgadget@gmail.com>
        <xmqqmuaoia15.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.2001161107050.46@tvgsbejvaqbjf.bet>
Date:   Thu, 16 Jan 2020 12:17:58 -0800
In-Reply-To: <nycvar.QRO.7.76.6.2001161107050.46@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Thu, 16 Jan 2020 11:24:52 +0100 (CET)")
Message-ID: <xmqqo8v3gnpl.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4A524CAA-389D-11EA-8A4A-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> Should this patch directly go to 'master' (or even 'maint' for v2.25
>> maintenance track)?  I do not see much point in cooking it in 'next'
>> for an extended period of time.
>
> That would be nice. As long as this patch is not merged, we will be stuck
> with failing Azure Pipelines.

OK, so let's take it to 'maint' directly and merge it down to
'master' (and all the "more recent" integration branches).

Thanks.
