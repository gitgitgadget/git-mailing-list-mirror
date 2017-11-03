Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C38A320450
	for <e@80x24.org>; Fri,  3 Nov 2017 15:05:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754503AbdKCPFn (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Nov 2017 11:05:43 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63025 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752159AbdKCPFm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Nov 2017 11:05:42 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 50F4DA6124;
        Fri,  3 Nov 2017 11:05:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=SA/GnNb0A5QCj4+4ERyPgdH5kyY=; b=BbVF8U
        78BURloPVzPbyAp3dNxcf+wCONlEcEZyMW/bHBHJqUj4DpKSVChJ0ybSdpkQd6je
        cS8JFPRrSz11PLEcKYlieHHn5tckqmfRKudHXZKdjIAwd/T2wf5bb/tbknz86Cz2
        roCmpmwG/Bo2FjBnQ1GA3CCmcMDlr3X3cW7uQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=KmG+YawQE4b07rv4YDRdZeEv0FaAEnMO
        /2kIvAWi+oJOOXfzuVDv2ipGt4U6sCo3xspomm8kvYhMwZJ4TPAxFT+/aHKwEVP7
        ngRms71Xl9dkppGOg5zlts90OZ6l6Nht+9Fwr8ybDRlnjyr9SZQm49Hy+7Kzc3Xk
        2dmMihabfBw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 48FE0A6122;
        Fri,  3 Nov 2017 11:05:42 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9EA44A611E;
        Fri,  3 Nov 2017 11:05:41 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        peff@peff.net, Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v2 0/6] Partial clone part 1: object filtering
References: <20171102175013.3371-1-git@jeffhostetler.com>
        <20171102124445.fbffd43521cd35f6a71e1851@google.com>
        <bd41699f-19c7-02a0-0af1-8f22b3277a1b@jeffhostetler.com>
Date:   Sat, 04 Nov 2017 00:05:40 +0900
In-Reply-To: <bd41699f-19c7-02a0-0af1-8f22b3277a1b@jeffhostetler.com> (Jeff
        Hostetler's message of "Fri, 3 Nov 2017 09:43:21 -0400")
Message-ID: <xmqq7ev7pfln.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 758D1DA6-C0A8-11E7-AD12-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff Hostetler <git@jeffhostetler.com> writes:

> Yes, I thought we should have both (perhaps renamed or combined
> into 1 parameter with value, such as --exclude=missing vs --exclude=promisor)
> and let the user decide how strict they want to be.

Assuming we eventually get promisor support working, would there be
any use case where "any missing is OK" mode would be useful in a
sense more reasonable than "because we could have such a mode" and
"it is not our business to prevent users from playing with fire"?
