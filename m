Return-Path: <SRS0=LBHq=C6=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7FA4C4727C
	for <git@archiver.kernel.org>; Mon, 21 Sep 2020 22:31:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F46A22574
	for <git@archiver.kernel.org>; Mon, 21 Sep 2020 22:31:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="nK7EuHEz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728581AbgIUWbU (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Sep 2020 18:31:20 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:51392 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726467AbgIUWbU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Sep 2020 18:31:20 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 908BAF69F2;
        Mon, 21 Sep 2020 18:31:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=8glhH2jJf/afOFe/rbTEhxPlUUA=; b=nK7EuH
        EzGmNhRFcpcO61DsV5Uc/dcoPd4SFL1mk/q0j++vfSxxdlpzNn8sAo+jAIdUpm/e
        /F4pe0k4dKe37id9YqQSIerGNH0HW+uf/0CpgbA/VTSz8Up+xVIEtJ2lDRnqYfFQ
        RXfkuUjc7NMLM2K2dAta2vxD8/bcSUxmlxPD0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=AKEq83faSnGUzWh0qDWFbolXwKWeCdYq
        ctKSLleCQEd1uVomHdHeEI3oabVOuC9sQDihaZWoyQdGx6T1Up3UFRigpIndixDH
        dK3WYQ9eRE6S1ttwAM9GRisPQdrAdXPKHRDGxtoB2C+W6VsjrD8pAu8xJw4LThSp
        LyQ132NVliI=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 89E89F69F1;
        Mon, 21 Sep 2020 18:31:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.190.152.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id CB505F69F0;
        Mon, 21 Sep 2020 18:31:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 4/5] tests: avoid variations of the `master` branch name
References: <pull.734.git.1600279853.gitgitgadget@gmail.com>
        <pull.734.v2.git.1600725687.gitgitgadget@gmail.com>
        <8f59e19b9562f2673c4fab5509ad8e8e2d48c19c.1600725687.git.gitgitgadget@gmail.com>
Date:   Mon, 21 Sep 2020 15:31:14 -0700
In-Reply-To: <8f59e19b9562f2673c4fab5509ad8e8e2d48c19c.1600725687.git.gitgitgadget@gmail.com>
        (Johannes Schindelin via GitGitGadget's message of "Mon, 21 Sep 2020
        22:01:25 +0000")
Message-ID: <xmqq4knqep8t.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 294E99C4-FC5A-11EA-93AF-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> diff --git a/t/t3427-rebase-subtree.sh b/t/t3427-rebase-subtree.sh
> index 79e43a370b..ba27e9d603 100755
> --- a/t/t3427-rebase-subtree.sh
> +++ b/t/t3427-rebase-subtree.sh
> @@ -15,12 +15,12 @@ commit_message() {
>  # this test script tries to document them.  First, the following commit history
>  # is generated (the onelines are shown, time flows from left to right):
>  #
> -# master1 - master2 - master3
> +# main1 - main2 - main3

The improvement between v1 and v2 made to t3200 (the previous step)
would equally apply here, no?  IOW, master1 didn't have to have a
name derived from master but could just have been called topic-1.
So replacing master[0-9] with topoic[0-9] may be more appropriate
here.

