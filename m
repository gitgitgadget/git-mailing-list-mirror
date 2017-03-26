Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 012AB20958
	for <e@80x24.org>; Sun, 26 Mar 2017 23:18:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751743AbdCZXSn (ORCPT <rfc822;e@80x24.org>);
        Sun, 26 Mar 2017 19:18:43 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62417 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751633AbdCZXSm (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Mar 2017 19:18:42 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2D65770CF8;
        Sun, 26 Mar 2017 19:18:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=LPA9B313W/yJcGTFP9VyeEdc/VA=; b=hiQkpk
        bSvrkkQb0e5kyIteWeJy98bUOQB+1vOY/vntWoMghGLQj2VQG9loO5Ukxp5JOcDb
        Uud1UQIz7inor8oVX6eNFws1SmcdD52OKA2HS+froOYVWY+75LIoHhWtMgJ/mtUs
        qKNEc85sVkSuF0nVC/yJdDnhPkvrdaBOrGkwo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Nay2Vr/hI7n1KYk2ZEZqhFOKrgYG9jaj
        eINaMfVaM59J0SFM0fhdN1vAQV+TEIiCCgaWxQG1GKCLU9duMDn6k1E/pGwDXVCm
        PP+3KMY/CXBxNHOHN5X53bQ1cqD8Nol4Qr0Pz75zWMlTFsKElC0Knk5kanr2Jkmm
        +LZ42Hy80JQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 25A5D70CF7;
        Sun, 26 Mar 2017 19:18:39 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8AB0B70CF6;
        Sun, 26 Mar 2017 19:18:38 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Luke Diamand <luke@diamand.org>
Cc:     git@vger.kernel.org, Lars Schneider <larsxschneider@gmail.com>,
        Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] git-p4: Add failing test case for name-rev vs symbolic-ref
References: <20170326091537.2707-1-luke@diamand.org>
Date:   Sun, 26 Mar 2017 16:18:37 -0700
In-Reply-To: <20170326091537.2707-1-luke@diamand.org> (Luke Diamand's message
        of "Sun, 26 Mar 2017 10:15:36 +0100")
Message-ID: <xmqqefxj4ofm.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8B068686-127A-11E7-A295-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Luke Diamand <luke@diamand.org> writes:

> As per the discussion about use of "git name-rev" vs "git symbolic-ref" in
> git-p4 here:
>
> http://marc.info/?l=git&m=148979063421355
>
> git-p4 could get confused about the branch it is on and affects
> the git-p4.allowSubmit <branchname> option. This adds a failing
> test case for the problem.
>
> Luke Diamand (1):
>   git-p4: add failing test for name-rev rather than symbolic-ref
>
>  t/t9807-git-p4-submit.sh | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)

Ahh, thanks for tying loose ends.  I completely forgot about that
topic.

If we queue this and then update the function in git-p4.py that
(mis)uses name-rev to learn the current branch to use symbolic-ref
instead, can we flip the "expect_failure" to "expect_success"?

IOW, can we have a follow up to this patch that fixes a known
breakage the patch documents ;-)?

Thanks.
