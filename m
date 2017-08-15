Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EEBA1208CD
	for <e@80x24.org>; Tue, 15 Aug 2017 18:58:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753016AbdHOS6T (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Aug 2017 14:58:19 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50521 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752971AbdHOS6T (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Aug 2017 14:58:19 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 410CFA61D0;
        Tue, 15 Aug 2017 14:58:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=JqfR52HK78I2KfpeZnsNF4PJ8CY=; b=FczizC
        H7V1DhEJ2NMmUdrfhjCU9WpESsGejYjuXI9iR+rhlxwDf3AEP2L/gq4BIK8mkakk
        WoKxiiVeZVdp2+iRIll5Qz8TAGbjtOb+T8VZXHRTeE5aDF0COe/4XJb2LzBsgxPR
        Ucb4SDmdNUmwfYu3UaHRY3dzir8J4adPqCqAQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ODeYYXUudO+0EkWw3FELxAbsa45hvnxW
        06X2Imp2d71GHlb0Pj0ekms1isZIOcvpnDYTThgZhIARzIVqi54EBIGfDTNiLFCQ
        OVA6SMVFU/6TOV1HFrcDSrHQEXBnFG6fzMeZ3Fm3K2sGlumkl5P6/YGio0PzdC8G
        ovxnydo0hzM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 38BE9A61CF;
        Tue, 15 Aug 2017 14:58:13 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 97966A61CD;
        Tue, 15 Aug 2017 14:58:12 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
Cc:     git@vger.kernel.org, martin.agren@gmail.com
Subject: Re: [PATCH v3 1/2 / RFC] builtin/branch: stop supporting the use of --set-upstream option
References: <20170808171136.31168-1-kaarticsivaraam91196@gmail.com>
        <20170814085442.31174-1-kaarticsivaraam91196@gmail.com>
        <xmqqy3qluck4.fsf@gitster.mtv.corp.google.com>
        <772aaebf-81ea-ac22-9d2f-35d0778f502f@gmail.com>
Date:   Tue, 15 Aug 2017 11:58:11 -0700
In-Reply-To: <772aaebf-81ea-ac22-9d2f-35d0778f502f@gmail.com> (Kaartic
        Sivaraam's message of "Tue, 15 Aug 2017 16:26:29 +0530")
Message-ID: <xmqqfucsr73w.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AFE432C4-81EB-11E7-BA15-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kaartic Sivaraam <kaarticsivaraam91196@gmail.com> writes:

> 1. Duplicate the check done in 'builtin/branch.c' in
> 'builtin/checkout.c'. This doesn't
>     sound good to me.

Doesn't sound good to me, either.  Some refactoring to make it
easier to reuse it from the new caller would be necessary.
