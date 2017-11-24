Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A611720954
	for <e@80x24.org>; Fri, 24 Nov 2017 07:18:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752016AbdKXHS4 (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Nov 2017 02:18:56 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60074 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751730AbdKXHSz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Nov 2017 02:18:55 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7F9B2AD455;
        Fri, 24 Nov 2017 02:18:55 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=2HQoa5ujSevW4erColN+rCFSmOw=; b=vAx6tM
        ujRqjlzyYIwh7X5UWs2mgug3BuRQVgN25VlZqMvaFC24zdLZwRFUwaFJAkHvF2fH
        ZdV8sLzL+c71mQ1oSCPkQfF3QT46koO3kzstt82WD5U2+vCeikl9zppEP3DL5PWc
        tvj8xii1aGyKbbxC8fITwU1tVrLU9hd4qL77k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=bOi4xWk6/P9KEKvlfU00acSkuPW5Bd/p
        sSFct6kseFqspuYdM3hk8FDpCKLdDssLOhk2lq5SeXMDpd/tDpChFgGk7F2x3xlZ
        kukIh/p+ugTIwgSVz4HOIDTjHXQL1MlGJnpIzDNCHw+MnXIyevDEsIe27hp8Y5oG
        SfjZWIi7EWM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 77864AD452;
        Fri, 24 Nov 2017 02:18:55 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id EE614AD451;
        Fri, 24 Nov 2017 02:18:54 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git <git@vger.kernel.org>, Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCHv5 7/7] builtin/describe.c: describe a blob
References: <20171116020039.17810-1-sbeller@google.com>
        <20171116020039.17810-8-sbeller@google.com>
        <xmqqwp2qx5w6.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kaGGUJSGG6OdfaTepDrvGBGFd17paBNNYuQt7t8XnDfHw@mail.gmail.com>
        <xmqq7euiu4r8.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kZajrugviv60kQA6UepYrQGpJK447BK1fBFd3N5Wnn5rQ@mail.gmail.com>
Date:   Fri, 24 Nov 2017 16:18:53 +0900
In-Reply-To: <CAGZ79kZajrugviv60kQA6UepYrQGpJK447BK1fBFd3N5Wnn5rQ@mail.gmail.com>
        (Stefan Beller's message of "Wed, 22 Nov 2017 09:00:43 -0800")
Message-ID: <xmqqtvxkm9eq.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BAE8B2C6-D0E7-11E7-BB65-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> On Tue, Nov 21, 2017 at 11:55 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Stefan Beller <sbeller@google.com> writes:
>>
>>> ...
>>> fixed.
>>> ...
>>> fixed the text...
>>> ...
>>> I am not fully convinced all descriptions are in recent history, but I
>>> tend to agree that most are, so probably the trade off is a wash.
>>
>> So what do we want with this topic?  I think the "teach 'git log' to
>> highlight commits whose changes involve the given blob" is a more or
>> less an orthogonal thing,
>
> Well, both of them solve our immediate needs, so I'd be fine with pursuing
> just one of them, but I do not oppose taking both.
>
>> and I suspect that it is something users
>> may (although I personally do not) find valuable to have a related
>> but different feature in "git describe".
>
> agreed.

I was reacting to your "fixed".  So will we see a rerolled series or
not?
