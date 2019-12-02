Return-Path: <SRS0=5D3W=ZY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E80AFC432C3
	for <git@archiver.kernel.org>; Mon,  2 Dec 2019 06:19:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8795920833
	for <git@archiver.kernel.org>; Mon,  2 Dec 2019 06:19:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="t5FsqaIN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726263AbfLBGTT (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Dec 2019 01:19:19 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51810 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725807AbfLBGTT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Dec 2019 01:19:19 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 447F721305;
        Mon,  2 Dec 2019 01:19:17 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=SLRcq5wZTwycY90MHqch0OJ0/0Q=; b=t5Fsqa
        INEmSOQqAu/D85pOuo/4zGkRnj7LJdbcqNvS8DgRb6F1U/NpqcVsO07UgFoHW8au
        YvOssbVXqEnoo/EuLLrMQxqDfLp3bW69LBXP5mSNLQvyJU1SvFMIILN3Gjjoqb+P
        Z/suxbwr+Nnp/ZUdVwMbSzXI2Wytzq6NEr19M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=SmYtIkQMzbXzu6vU1Zjgv99nioU9wo3z
        XMBHIfe1+mqla3AgiP65M4VcnK+FSovAylAxha6HrQQE7LZ6RNLGrTyfOjPg+XOT
        6XQcICAQWohX8BXXme0FEwV4D4b/WsGK5yRavi23DTjBlnnR2sr4w1LPnKmm0SAp
        qiJ5rDZoiyY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3C08B21304;
        Mon,  2 Dec 2019 01:19:17 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A020621303;
        Mon,  2 Dec 2019 01:19:16 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Jeff King <peff@peff.net>, Ruud van Asseldonk <dev@veniogames.com>,
        git@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] t5150: skip request-pull test if Perl is disabled
References: <4f11b5b3-a68e-642a-c5fb-7b5dae698669@veniogames.com>
        <20191127112150.GA22221@sigill.intra.peff.net>
        <20191128013111.GA76989@google.com>
Date:   Sun, 01 Dec 2019 22:19:15 -0800
In-Reply-To: <20191128013111.GA76989@google.com> (Jonathan Nieder's message of
        "Wed, 27 Nov 2019 17:31:11 -0800")
Message-ID: <xmqqblsrz1uk.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AAEC2540-14CB-11EA-B335-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

>   Not-Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
>
> --- the patch shouldn't be applied as is.
> ...
> Agreed: if we want to follow this approach, we should install stubs in
> place of those scripts when NO_PERL=YesPlease.  Will say more about
> this in a separate reply.

I am just leaving a note here in the thread to make sure I notice if
there is any progress/conclusion, until which time I'll keep the
patch on hold.  Thanks.
