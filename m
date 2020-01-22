Return-Path: <SRS0=mjbR=3L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57E0CC32771
	for <git@archiver.kernel.org>; Wed, 22 Jan 2020 20:48:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C06924655
	for <git@archiver.kernel.org>; Wed, 22 Jan 2020 20:48:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="dXG3kTD3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729093AbgAVUsD (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Jan 2020 15:48:03 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:51201 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725827AbgAVUsD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Jan 2020 15:48:03 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A4673AC779;
        Wed, 22 Jan 2020 15:48:02 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=M0xZVmMQFYuKs6pM+66Bcmkb/aE=; b=dXG3kT
        D3vNsTEi4zNGLMXyh49CnOiUz3L/scqkkbw6lDIzUtwmAav4PA0nAVzUYili5OJ3
        LRHISRXN0K+RdcfaFLG84U3SWuv+YbgKKj96Btj2+2OjjW6ySNUaPixjLPah2YM3
        g6ofC3VI0gR8pPUuunTrZYps16C9agaP9cAgU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=KZPDgtCLxKP/CGRoqqaTg96PZgrCgnf5
        MHYaTmvBRsbaECVVKFpJX1e32iqRpoOOBM47kTScHHC1T0YhyCE42Vnkl++UezoY
        NWwHRBpNtgH3ueAqvpovBriJX/bX6QJoEY0iE65KPTlVV3xdioeaPZ7b9/Xzf2wN
        4iboxUAj4eA=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9D79AAC778;
        Wed, 22 Jan 2020 15:48:02 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id BFAAAAC776;
        Wed, 22 Jan 2020 15:47:59 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Alban Gruin <alban.gruin@gmail.com>
Cc:     git@vger.kernel.org, phillip.wood@dunelm.org.uk,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v1] builtin/rebase: remove a call to get_oid() on `options.switch_to'
References: <20200121193226.24297-1-alban.gruin@gmail.com>
Date:   Wed, 22 Jan 2020 12:47:57 -0800
In-Reply-To: <20200121193226.24297-1-alban.gruin@gmail.com> (Alban Gruin's
        message of "Tue, 21 Jan 2020 20:32:26 +0100")
Message-ID: <xmqq1rrr6ww2.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 79CB17F4-3D58-11EA-82C5-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alban Gruin <alban.gruin@gmail.com> writes:

> When `options.switch_to' is set, `options.orig_head' is populated right
> after.  Therefore, there is no need to parse `switch_to' again.
>
> Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
> ---
>  builtin/rebase.c | 10 +---------
>  1 file changed, 1 insertion(+), 9 deletions(-)

Sounds good.
