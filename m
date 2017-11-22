Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0A6EB2036D
	for <e@80x24.org>; Wed, 22 Nov 2017 02:13:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751439AbdKVCNe (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Nov 2017 21:13:34 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55854 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751409AbdKVCNd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Nov 2017 21:13:33 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D4A00AFDD4;
        Tue, 21 Nov 2017 21:13:32 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=nxrKdFrdzVk1sCQLjofoRMuSSrc=; b=E1in97
        /tlT0gYgQ8+1FN3qgIPFF8ltnZcoEelzf2ce0i+G3cT9PREGT0/elZWDtlcsReYR
        06Y054LnWyxzrWj9No6vMdbh+66ayfJ0G0F7ALpkU3qOXY/fPpTipB8kbaJnT6H3
        16XB3Bjn3bLAMbjEIe9lQa3L8/ps4UF1sU0e4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=rhxzmWVpK9Foc/SldivSSbOQSRz4+ATh
        NOge/5/Jksh2mh0b7CW5Q9UszX0c/MDCC1gPjNAE55B3MG7l2bfzjawYC+z7Z3yB
        sELVbKw7bLezqk5blsbR/HVWrdH87rmVu4kbF8atb6xvhquTlP30DeQ3JTjEFWn1
        OmVZxFH6BhA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CB154AFDD3;
        Tue, 21 Nov 2017 21:13:32 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3FC8DAFDD1;
        Tue, 21 Nov 2017 21:13:32 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>
Subject: Re: [PATCH] rebase: rebasing can also be done when HEAD is detached
References: <20171121152533.3793-1-kaartic.sivaraam@gmail.com>
Date:   Wed, 22 Nov 2017 11:13:31 +0900
In-Reply-To: <20171121152533.3793-1-kaartic.sivaraam@gmail.com> (Kaartic
        Sivaraam's message of "Tue, 21 Nov 2017 20:55:33 +0530")
Message-ID: <xmqq60a3xdpw.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BCE51D80-CF2A-11E7-B18D-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kaartic Sivaraam <kaartic.sivaraam@gmail.com> writes:

> In a repository when attempting to rebase when the HEAD is detached
> and it is already up to date with upstream (so there's nothing to do),
> the following message is shown
>
>         Current branch HEAD is up to date.
>
> which is clearly wrong as HEAD is not a branch.
>
> Handle the special case of HEAD correctly to give a more precise
> error message.
>
> Signed-off-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
> ---
>  In this patch, I basically assumed that there would be no
>  branch named "HEAD".

Perhaps time to learn "git symbolic-ref HEAD" and use it instead of
depending on the name?
