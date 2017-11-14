Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 11689201C2
	for <e@80x24.org>; Tue, 14 Nov 2017 01:18:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751336AbdKNBSF (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Nov 2017 20:18:05 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59616 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751161AbdKNBSE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Nov 2017 20:18:04 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E37A0AB55F;
        Mon, 13 Nov 2017 20:18:03 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Ai4x4vkq5fsfOoDh/fb2y8c31GE=; b=LLFmI+
        IWRQMqCPo+ezvnq6dR2+ptyx0A7zCPksPbiHt8NLK/geXXtS92XMFPkRYze5l8dp
        gGEKFG1Rt7QN1pgEwC2zxsCSzq2+IhN1c8JDP+YxK/6aepwEmOoxbUBaMOrb15LN
        Pac74Lk8IfiljiL74c8cBDz/sdQrHwu63cjXI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=hWeFABMCy+fhwpNymzzdp7vQ1wIHS7Bd
        qKBsL4BYvKH1pdY2jIhsNOjB0wp68LkL+qUCPPRcIxD1WlrTvGRnsB8dwYp0CgKT
        N9QlteH3aWM2f5cBkAPyY1ugAUkEYE16cMMOstFI+b/yqstJNNoVLQzVhF0blL/G
        yvx3MeNYO54=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DA8C3AB55E;
        Mon, 13 Nov 2017 20:18:03 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C6316AB55B;
        Mon, 13 Nov 2017 20:18:02 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 3/4] progress: Fix progress meters when dealing with lots of work
References: <20171110173956.25105-1-newren@gmail.com>
        <20171110173956.25105-4-newren@gmail.com>
        <xmqqtvxy92ey.fsf@gitster.mtv.corp.google.com>
        <CABPp-BH1Cpc9UfYpmBBAHWSqadg=QuD=28qx1oV29ZdvF4NbJw@mail.gmail.com>
Date:   Tue, 14 Nov 2017 10:18:01 +0900
In-Reply-To: <CABPp-BH1Cpc9UfYpmBBAHWSqadg=QuD=28qx1oV29ZdvF4NbJw@mail.gmail.com>
        (Elijah Newren's message of "Mon, 13 Nov 2017 12:05:05 -0800")
Message-ID: <xmqqwp2t7j5i.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A914823E-C8D9-11E7-A630-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

>   2) Instead of counting pairs of source/dest files compared, just
> count number of dest paths completed.  (Thus, we wouldn't need a value
> big enough to hold rename_dst_nr * rename_src_nr, just big enough to
> hold rename_dst_nr).

This sounds like the most sensible thing to do even if we do switch
to larger integer size, but that is orthogonal to the main point of
this series.


