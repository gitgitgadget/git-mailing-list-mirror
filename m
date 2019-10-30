Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7B1451F4C0
	for <e@80x24.org>; Wed, 30 Oct 2019 02:06:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726157AbfJ3CGA (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Oct 2019 22:06:00 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:57593 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726025AbfJ3CGA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Oct 2019 22:06:00 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5399191C51;
        Tue, 29 Oct 2019 22:05:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=CT4GB0IWosjeDaX5OFKmFA/XN9A=; b=JGLzIU
        GDHNrHGc/5inrj9blDpj34kDXsqnmsb5lTferrydtbr/LQnvX/zBwvXuaB7y64Rs
        cPR8oYAegXM/zMdbaHht0E48716mH1qtFn2fvmRxIGasd/idbMPGtgJKpdeKn6no
        oYjc2c62HSXPTIC1SnRtPJqcPrCCgDRQaloaA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=AZ06RQDCh1a/uZ//bealnt2s5+PThJVO
        YJOQQ5sDP8jDCts3l+LIzbdFHNZMj8PRhyP2bWVVq9y3IZE4Uu9slhJoEQ9Ya5fx
        fkNxNKVEpcHwhLVeiaQQ/jEpHatEIdcqLdUC7DdFQZoC0T49t88xOyONMBJN1gAK
        WrVdGPeDLP4=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4BF4B91C50;
        Tue, 29 Oct 2019 22:05:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 796AF91C4F;
        Tue, 29 Oct 2019 22:05:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "george espinoza via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, George Espinoza <gespinoz2019@gmail.com>
Subject: Re: [PATCH 1/1] [Outreachy] merge-ours: include parse-options
References: <pull.425.git.1572306149.gitgitgadget@gmail.com>
        <8c088194f604eac3a6b00c48a7fddfdf807571fc.1572306149.git.gitgitgadget@gmail.com>
Date:   Wed, 30 Oct 2019 11:05:53 +0900
In-Reply-To: <8c088194f604eac3a6b00c48a7fddfdf807571fc.1572306149.git.gitgitgadget@gmail.com>
        (george espinoza via GitGitGadget's message of "Mon, 28 Oct 2019
        23:42:29 +0000")
Message-ID: <xmqqk18n3s3i.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CEB17CB8-FAB9-11E9-9116-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"george espinoza via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: george espinoza <gespinoz2019@gmail.com>
>
> Teach this command which currently handles its own argv to use
> parse-options instead because parse-options helps make sure we handle
> user input like -h in a standardized way across the project.

Sorry, but why do we even want to do this?  merge-ours is an
implementation detail of "git merge" and is never run directly by
end-users.

I am not sure why it even needs "-h" in the first place, but that is
already there, so letting sleeping dog lie would be what I would
prefer.

Is there a plan to add some -Xmerge-backend-option to this program,
and would use of parse-options API make it easier?  That would be a
good reason to start using it in this program, but otherwise...

