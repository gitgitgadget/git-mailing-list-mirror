Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CE5DD2036D
	for <e@80x24.org>; Wed, 22 Nov 2017 02:28:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752356AbdKVC2E (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Nov 2017 21:28:04 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59838 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752069AbdKVC2C (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Nov 2017 21:28:02 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3DD3AB00D4;
        Tue, 21 Nov 2017 21:28:02 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=mI8DSHIWlDYTnOSPTTHdKI71mUs=; b=iGuG3l
        qRIi1wHlUsnm/4J6BxJIJl3x1NpdDjk9dPuXha4qISDyRK1EsEczatP/HdVWe7IS
        1st3M+XzjyNNAuMFRVw8HqD2bQXsV+KJKVf5FIQTpbBRmy6xMvkJ5nODTC7Gxv/H
        xWVO6vastOnyIzM6wFwsabPsJ75t1xdQauEAw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=gVj0cDxopI5poJvBbPreZuTMAmlKb6Hz
        anmNrQXyMRi3J0qtO7b5xLV5GVYL6vqnJpq/ZRSg12VQcWjSadAKSpU2KiX+cxHq
        yYYWDUWB82btnl0dAiF9ObDvrJUJXL2zvVY1RzuntY1UzIkljwQphiPzk+s/77dZ
        5LV+XH/RyHI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 34A64B00D3;
        Tue, 21 Nov 2017 21:28:02 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4963CB00CE;
        Tue, 21 Nov 2017 21:28:01 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC PATCH] xdiff/xpatience: support anchoring a line
References: <20171121221717.155301-1-jonathantanmy@google.com>
Date:   Wed, 22 Nov 2017 11:27:59 +0900
In-Reply-To: <20171121221717.155301-1-jonathantanmy@google.com> (Jonathan
        Tan's message of "Tue, 21 Nov 2017 14:17:17 -0800")
Message-ID: <xmqqwp2jvyhc.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C2F0A530-CF2C-11E7-80A8-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> Teach the patience diff to support prohibiting a user-specified line
> from appearing as a deletion or addition in the end result.
>
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> ---
> I'm sending this out to see if a change similar to this would be
> welcome. It is useful to me as a reviewer (to check my own code, e.g.
> when checking [1]). Probably more design needs to go into this,
> including the best way to specify the "anchor" line, and the correct
> behavior when the anchor is either not found or appears more than once.
>
> Any thoughts?

This is a natural extension of the idea the patience algorithm is
built upon.  If this were a cumulative command line option that can
be given to specify multiple lines and can be used across the diff
family, it would make a welcome addition, I would think.
