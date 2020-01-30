Return-Path: <SRS0=gonI=3T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B68EC2D0DB
	for <git@archiver.kernel.org>; Thu, 30 Jan 2020 21:59:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 189CC20708
	for <git@archiver.kernel.org>; Thu, 30 Jan 2020 21:59:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="CIkcvQtK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725972AbgA3V7f (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jan 2020 16:59:35 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:60259 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725855AbgA3V7f (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jan 2020 16:59:35 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 3392AAB93D;
        Thu, 30 Jan 2020 16:59:33 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=WR+4MHlrsFmc5obAS6BAC4QeNKA=; b=CIkcvQ
        tKbU9HKNbIQaZhoxxWt0dwgl5GijCdmegcDXeFnz/pVfwmLcoBosX+FEo4vuXSuu
        FRI9dx9UIDzZGG6zXWGegSVj0Nx0+85inGBICZbF3DWxaqIIMqo0fQEiJiwJ5WG8
        Hqm2F1dVCqwEdemQfieNvUcQhcFk9UIWPoB2I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=VEshmhHlK0EoWL+FRozQENmWndK/LK8o
        dI3xvGg/mjriIi5GI1B1Wzl9U2KW3MDUMRRJAuwYHhwDP269pkm9Q0FIR7cKO4nb
        suTzOUS5CIRM//X/atp9ukzvuO8/IHHxmk09b84Lz+G/a1VK1aRUuBoWr9ZepLL9
        1ecUZ2tb17o=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 2BA23AB93B;
        Thu, 30 Jan 2020 16:59:33 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 558FBAB93A;
        Thu, 30 Jan 2020 16:59:30 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Heba Waly via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Heba Waly <heba.waly@gmail.com>
Subject: Re: [PATCH v3] add: use advice API to display hints
References: <pull.508.v2.git.1578438752.gitgitgadget@gmail.com>
        <pull.508.v3.git.1580346702203.gitgitgadget@gmail.com>
Date:   Thu, 30 Jan 2020 13:59:28 -0800
In-Reply-To: <pull.508.v3.git.1580346702203.gitgitgadget@gmail.com> (Heba Waly
        via GitGitGadget's message of "Thu, 30 Jan 2020 01:11:41 +0000")
Message-ID: <xmqqimksbo73.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CA79A392-43AB-11EA-9AFF-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Heba Waly via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Heba Waly <heba.waly@gmail.com>
>
> In the "add" command, use the advice API to display hints to users,
> as it provides a neat and a standard format for hint messages, and
> the message visibility will be configurable.
>
> Signed-off-by: Heba Waly <heba.waly@gmail.com>
> ---
>     [Outreachy] add: use advise API to display hints
>     
>     In the "add" command, use the advice API to display hints to users, as
>     it provides a neat and a standard format for hint messages, and the
>     message visibility will be configurable.

The topic has been in 'next' for the past week or so already.  If we
need to make further changes, please do so incrementally.

Thanks.
