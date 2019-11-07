Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1C8241F454
	for <e@80x24.org>; Thu,  7 Nov 2019 11:09:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387858AbfKGLJm (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Nov 2019 06:09:42 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:51529 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727707AbfKGLJm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Nov 2019 06:09:42 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id F289F9381B;
        Thu,  7 Nov 2019 06:09:39 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=au7u6lKV+mb3Z6ivnDK8zWwajw8=; b=CMUBn7
        hMuVeGZMUk/aQ3uc8OEDnkeUTt326WcHCTgkMVgF3jztWdk5Jazo3jLwfv8eGxXK
        qPUJBTufxyvfZ7RoRsDHAijPRflKzOjhWLJz9hsbcwUqql5Pnij8Lo3cDfHc9B01
        0APwxtkaD4LSdbX4HR+TPfOWy/tBO4s05NBxI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=YXKi/xEAWvAzOvzf9IN53yZnSoem/dq/
        lXNio3EVuNLlolYL1DAs37ecr30aKzq+QtkdXWZKfbcmElcWx/I/w9y18HR6Ri9Y
        R/ahdBNQLBIAymm8+cfzSzmEb5mFIdCmt4BsFXsd6Io+Gzv87CPTZBcPjLvzZhdF
        8CCYpr4YjTw=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id EACE49381A;
        Thu,  7 Nov 2019 06:09:39 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 1FF2793816;
        Thu,  7 Nov 2019 06:09:36 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Eric N. Vander Weele" <ericvw@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] status: teach "status --short" to respect "--show-stash"
References: <20191104100334.60537-1-ericvw@gmail.com>
        <xmqq36f1wx6h.fsf@gitster-ct.c.googlers.com>
        <20191107103141.GA87008@helium>
Date:   Thu, 07 Nov 2019 20:09:34 +0900
In-Reply-To: <20191107103141.GA87008@helium> (Eric N. Vander Weele's message
        of "Thu, 7 Nov 2019 18:31:41 +0800")
Message-ID: <xmqqimnwoscx.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 16016790-014F-11EA-9A90-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Eric N. Vander Weele" <ericvw@gmail.com> writes:

>> Isn't this information available to scripts that want to read from
>> porcelain v2 output format (which is meant to be extensible by
>> allowing easy-to-parse optional headers, which this stash thing
>> exactly is).
>
> It is not available in Porcelain Format v2... yet :).
>
>
> I'm happy making '--show-stash' congruent with '--branch' in v1', which
> is would be in line with documented behavior, displaying something in
> v2 only, or both.  Let me know how you would like to proceed and I'll
> rework the patch accordingly.

Quite honestly, you do not want to ask _me_.  If you left it to
me, I may say that, among the possible next step you listed, the
best one is to do nothing, as I do not want to see the stash info in
the "status --short" output ;-)

It probably is the safest to make it available first only in v2
format.  I do not know if that makes its utility too limited for the
purpose of the application you have in mind.

