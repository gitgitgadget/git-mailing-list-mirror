Return-Path: <SRS0=ZKiS=2H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84901C43603
	for <git@archiver.kernel.org>; Tue, 17 Dec 2019 18:28:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DCF62072D
	for <git@archiver.kernel.org>; Tue, 17 Dec 2019 18:28:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="m+zLhkcA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727005AbfLQS2N (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Dec 2019 13:28:13 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61291 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726646AbfLQS2N (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Dec 2019 13:28:13 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C68C11C7B5;
        Tue, 17 Dec 2019 13:28:10 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Lk8Qm53Q8EOc8zTrvr6aAy7gIr8=; b=m+zLhk
        cAVCrU2WqpTSfWx8+G6suHt1FcyZOFIJB9SX1ey6tWOup7ley3vYNdFByyKS48YK
        BInyj+nhF3lKdpq5EBFkCg8UyDEhq9+I5uxEiv07Vmq6a2omBDp7upP5vFYgE+nq
        +lOvFuu+LunrZuBI1JVM+lsSEtLcL+PQRyHjo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=OlB12HmdOrpqboWsw8UPO/KdTuAoss0r
        gXOACKFe3SXcF5Jz4lnfSOXL/Vbigh2wRBWlVLaCNQCzBvcEyYxlyGcr3k1QFm71
        YkJ3cfWqqz15bfPOz1BCUyqEWNQNtzwH7S4IfewGLyTty5j03w/iIsDWwCm5SlM4
        Aw/GeseRhEw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id AF9751C7B4;
        Tue, 17 Dec 2019 13:28:10 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A4CD21C7B2;
        Tue, 17 Dec 2019 13:28:09 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 00/15] t: replace incorrect test_must_fail usage (part 1)
References: <cover.1576583819.git.liu.denton@gmail.com>
Date:   Tue, 17 Dec 2019 10:28:08 -0800
In-Reply-To: <cover.1576583819.git.liu.denton@gmail.com> (Denton Liu's message
        of "Tue, 17 Dec 2019 04:01:25 -0800")
Message-ID: <xmqqwoauhknb.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FA0AC538-20FA-11EA-9C07-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> The overall scope of these patches is to replace inappropriate uses of
> test_must_fail. IOW, we should only allow test_must_fail to run on `git`
> and `test-tool`. Ultimately, we will conclude by making test_must_fail
> error out on non-git commands. An advance view of the final series can
> be found here[1].

Wow.  It is a bit sad to see that we had so many of them.

