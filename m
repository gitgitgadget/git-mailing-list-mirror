Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6D4711F461
	for <e@80x24.org>; Thu, 18 Jul 2019 16:03:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726649AbfGRQDR (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Jul 2019 12:03:17 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:50481 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726040AbfGRQDR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Jul 2019 12:03:17 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4E5937D713;
        Thu, 18 Jul 2019 12:03:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=XVykWYRK0J9MPZUupPyszGNaifw=; b=iHcNFP
        bYKRLcAGSNbJtquUwp6CQc1KW5PlwL1fdMcWPZ0HtrjivwLoNK0h4d1TCj5kYVG1
        1TnIMYt+w/ambsouIxUMLOwH/2dTccR7yPy+BTFEmjC7zbQgwNsvScfGQu+jnStx
        wkSZVrPZIiusOwq1clvuMNXuRCTBsRNcx82ps=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=GFRSqs5YbHSGhG2q/Vn7nzDSaBz43Oq4
        NicvzpFZaaCS1Sl3hs5HuhHwYH+hkT4ounMxyqqUcqcCMl+lPTOvQbJ3o4+1VxQB
        6GyYVEhftgtPc2Iy8h4+prCoYIGrk3O3864a1cCVJkF6RfQRFKQd+nk1ltww4K8p
        cFCPx6VBBH4=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 468AC7D712;
        Thu, 18 Jul 2019 12:03:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 517C17D711;
        Thu, 18 Jul 2019 12:03:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?Q?Ren=C3=A9_Scharfe_=3Cl=2Es=2Er=40web?=
         =?utf-8?Q?=2Ede=3E=2C_SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 1/1] clean: show an error message when the path is too long
References: <pull.219.git.gitgitgadget@gmail.com>
        <pull.219.v2.git.gitgitgadget@gmail.com>
        <c7b11fe410196c14e142756a036e2bdae5d4bcab.1563442231.git.gitgitgadget@gmail.com>
Date:   Thu, 18 Jul 2019 09:03:09 -0700
In-Reply-To: <c7b11fe410196c14e142756a036e2bdae5d4bcab.1563442231.git.gitgitgadget@gmail.com>
        (Johannes Schindelin via GitGitGadget's message of "Thu, 18 Jul 2019
        02:30:33 -0700 (PDT)")
Message-ID: <xmqqef2nz5xe.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8A9FC1A0-A975-11E9-A1B9-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> Without an error message when `lstat()` failed, `git clean` would
> abort without an error message, leaving the user quite puzzled.

Let's drop the first three words ;-)  Sorry for not catching it
earlier and parrotting the same mistake in my variant yesterday.

> In particular on Windows, where the default maximum path length is quite
> small (yet there are ways to circumvent that limit in many cases), it is
> very important that users be given an indication why their command
> failed because of too long paths when it did.

s/it is very important that users be given/it helps to give users/

