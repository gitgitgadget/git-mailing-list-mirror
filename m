Return-Path: <SRS0=bNai=CE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 706B4C433E3
	for <git@archiver.kernel.org>; Wed, 26 Aug 2020 16:28:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 448962078B
	for <git@archiver.kernel.org>; Wed, 26 Aug 2020 16:28:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Mctua0n9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728036AbgHZQ2a (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Aug 2020 12:28:30 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:65303 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727043AbgHZQ22 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Aug 2020 12:28:28 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C79037D404;
        Wed, 26 Aug 2020 12:28:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=kyvN9kDGlVEsBFwAqPAXL16MSzs=; b=Mctua0
        n94pxKqSz8vVXOe1Ovj4MVjuKBsgQrdZRqRgaouywdwBjrdEcknTw3wnMSVKuyAI
        pHPUHQsabTFpcMqopZ+2pvEVrLhnwVsn5FzA0CswrTUk5p3HqLtKRfiNqBXVATmc
        LGLMpW7J5t7TDKEU3h4u/mwQ+OOPmIMfjzKws=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=F3DAyu8tLr36C3TGvLfQmhonh7uxollV
        pGQ4y1alTvWsFI46eARMAs4atxP0mpsO4k4sdYE/wiq6f4HRBiXZDgxmKnlEixYf
        yfe1KJBvK4qhMjpFZGBYjKkYWMockGgrDaLYSVz4z4SFTyRNxJo6jilkEPwDtg08
        J9gP0uz+Zd0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BF1B47D403;
        Wed, 26 Aug 2020 12:28:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 466537D400;
        Wed, 26 Aug 2020 12:28:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v1 2/3] cvsexportcommit: do not run git programs in dashed form
References: <xmqq1rjuz6n3.fsf_-_@gitster.c.googlers.com>
        <20200826011718.3186597-1-gitster@pobox.com>
        <20200826011718.3186597-3-gitster@pobox.com>
        <CAPig+cR-eYCVQLRa0rVhgJ8L60-zCS_aK6_nVERcrXSyApdihw@mail.gmail.com>
        <xmqqa6yhxucq.fsf@gitster.c.googlers.com>
Date:   Wed, 26 Aug 2020 09:28:25 -0700
In-Reply-To: <xmqqa6yhxucq.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Wed, 26 Aug 2020 09:08:53 -0700")
Message-ID: <xmqqlfi1wevq.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2AE7F8D0-E7B9-11EA-8D3E-01D9BED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Eric Sunshine <sunshine@sunshineco.com> writes:
>
>> On Tue, Aug 25, 2020 at 9:17 PM Junio C Hamano <gitster@pobox.com> wrote:
>>> This ancient script runs "git-foo" all over the place.  A strange
>>> thing is that it has t9200 tests successfully running, even though
>>> it does not seem to futz with PATH to prepend $(git --exec-path)
>>> output.
>>
>> t/test-lib.sh takes care of that for us, doesn't it?
>
> Actually, it is "git" itself.  
>
> The tests spawn "git cvsexportcommit" via the "git" dispatcher.  The
> dispatcher adds GIT_EXEC_PATH to PATH in exec-cmd.c::setup_path()
> and that is used to (1) locate "git-foo" from /usr/libexec/git-core/
> that are not builtin and (2) passed to any processes we invoke.  I
> think the latter was originally done primarily for not breaking
> hooks, but that is what allows this script going in this particular
> case.
>
> If this were only a fluke in the test that kept otherwise unrunnable
> script passing, I'd say it is an evidence enough that lets us drop
> the cvsexportcommit immediately, but now I rediscovered how it was
> supposed to work and saw how it actually does work as designed, I
> would not be surprised if it is still used in the wild.

So, the conclusion: the proposed log message needs a large revamp.
Thanks.
