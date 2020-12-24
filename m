Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EB48C433DB
	for <git@archiver.kernel.org>; Thu, 24 Dec 2020 09:25:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7C4322287
	for <git@archiver.kernel.org>; Thu, 24 Dec 2020 09:25:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727270AbgLXJZJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Dec 2020 04:25:09 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50018 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726746AbgLXJZI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Dec 2020 04:25:08 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 12F3E9D7F3;
        Thu, 24 Dec 2020 04:24:26 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=UG/HPFik0lDuXtDbIOGUbw59wO8=; b=cqFrn0
        USBSK7Cos4Drtgn8GHQR78Gco+We7nX2rEXG3/crQN2AkcyMB7gScFZ47q70DgMe
        fJPimB6uzyyhtjze4jM9m4/ZgHxd+cmpCO1ISEbb8+FJo1y8NeZ5eyDhmstoTEwV
        LrqrPYjJQO/2n8Xn1tap8iwSWxLU0fZjfA6hw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=BcKSm/SHMmRbx1zAF4JE0NrhWH3Jek1m
        B7+RQeVRVn7QsJibW21I5nBUI8pBRxnyzeK0DS0OEucQk+By6GImbR3mkKTzeLGC
        yTic1Iu64kfLgOhWGtwIWbNmeU6tV437EdivGyOek/LJn2QYPPAh/gfZ5TcamyLQ
        aWYFEp0AE1Y=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 095A39D7F2;
        Thu, 24 Dec 2020 04:24:26 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8348C9D7EF;
        Thu, 24 Dec 2020 04:24:25 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, David Aguilar <davvid@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>, Seth House <seth@eseth.com>
Subject: Re: [PATCH v5 0/1] mergetool: remove unconflicted lines
References: <20201223045358.100754-1-felipe.contreras@gmail.com>
Date:   Thu, 24 Dec 2020 01:24:25 -0800
In-Reply-To: <20201223045358.100754-1-felipe.contreras@gmail.com> (Felipe
        Contreras's message of "Tue, 22 Dec 2020 22:53:57 -0600")
Message-ID: <xmqqim8r36ba.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D09C2A58-45C9-11EB-A286-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Felipe Contreras <felipe.contreras@gmail.com> writes:

> There's not much to say other that what the commit message of the patch says.
>
> Note: no feedback has been ignored; I replied to all the feedback, I didn't hear anything back.
>
> Changes since v4:
>
>  * Improved commit message with suggestions from Phillip Wood.
>
> Felipe Contreras (1):
>   mergetool: add automerge configuration

This breakage is possibly a fallout from either this patch or
1e2ae142 (t7[5-9]*: adjust the references to the default branch name
"main", 2020-11-18).

  https://github.com/git/git/runs/1602803804#step:7:10358

I cannot quite tell how the two strings compared with 'test' on
output line 10355 are different in the output, though.

Thanks.
