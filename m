Return-Path: <SRS0=tECa=DD=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB285C2D0A8
	for <git@archiver.kernel.org>; Sat, 26 Sep 2020 22:40:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 873A82388E
	for <git@archiver.kernel.org>; Sat, 26 Sep 2020 22:40:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="UlD6cl7r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727263AbgIZWkR (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 26 Sep 2020 18:40:17 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:51776 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726382AbgIZWkR (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 Sep 2020 18:40:17 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 77ABBFCDC9;
        Sat, 26 Sep 2020 18:40:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=MNQGsCY5C7WkHGCIWeheWKpIMxY=; b=UlD6cl
        7r8gWJPErkiTdjQmWuwInjtDfLsu/eyjrOn+d2MYWrWgN0VuC+hrD0Vng8AfP0F5
        4jU1qywY1qj3KPqC0361EjrDjdhVCVXvvYB5PUKmWtwX+I1l7opsV9KtmpnCXeu/
        IcMoKAcn6N4bFxr7BSaK5v53LQnPcUK483ZDg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=aw6Ada8lMPlwzzNXjFxttyk+Y5ArDzHZ
        AgRgl2WbzsQfbSslirLb4vVsJLa0QVkEDA3EaD7sp023jk5Bs7pHBO5+nDUvoGmd
        SOamOF9FC5QbDEC/UW2F6HbRRwrbUYzMEoIJ2AxUEXr+VkotpaiXpNvnQG1iFUWy
        yyHpQ7bhTcc=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 6FFF8FCDC8;
        Sat, 26 Sep 2020 18:40:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 9A59BFCDC7;
        Sat, 26 Sep 2020 18:40:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Aaron Lipman <alipman88@gmail.com>
Cc:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] ref-filter: plug memory leak in reach_filter()
References: <d9922bbe-4e34-45fe-66a5-d7b5bf42117a@web.de>
        <CAEJZ43hYgdCWGOaMHc=V_YBz0S3LCnSP6tZ1=ZTEwiNBwbHFqw@mail.gmail.com>
Date:   Sat, 26 Sep 2020 15:40:10 -0700
In-Reply-To: <CAEJZ43hYgdCWGOaMHc=V_YBz0S3LCnSP6tZ1=ZTEwiNBwbHFqw@mail.gmail.com>
        (Aaron Lipman's message of "Sat, 26 Sep 2020 10:53:09 -0400")
Message-ID: <xmqqft74i2lx.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3D543102-0049-11EB-B00F-843F439F7C89-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Aaron Lipman <alipman88@gmail.com> writes:

> Thanks for catching that!

Yeah, looks good.  Thanks, both.
