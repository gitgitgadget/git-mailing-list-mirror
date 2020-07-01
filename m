Return-Path: <SRS0=EAeL=AM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A13BC433DF
	for <git@archiver.kernel.org>; Wed,  1 Jul 2020 00:03:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A20A20780
	for <git@archiver.kernel.org>; Wed,  1 Jul 2020 00:03:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="STW8gOFW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726024AbgGAADm (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Jun 2020 20:03:42 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:58343 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725930AbgGAADm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Jun 2020 20:03:42 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8FF6FEC347;
        Tue, 30 Jun 2020 20:03:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=5cikigrZHzkix/2baqUkx17Ci5A=; b=STW8gO
        FWtuj980iSeqTf4D5nRYbne+tq53ibjOtaTFkWlqniCggBlBhPT6VsR2c/IXbSbQ
        nisdze0Sfa/bt6pxnRcVaX4BOuyRD1GH1xxQTtsw6/GBNoimo1Q4n2zf+WBSkj9N
        vdjaf7xFvkelj/xfgbyZ9lsDeIEJ+YQJ9qiSg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=SXUoHtcx8XL07kwyG9VUkPdQLp57jp9h
        tBE8uebyivLKxa5KPfoZCD0qvYQ5+61Jor7p9PYgaXLhrNY+GE9+9VewyvO2FEuM
        i8Vz8OxuoTkXURmK+uIp84TfLb7X/tduVx00fyg3GLDtA1iDt37BX1hi9QktPGQx
        Qx6rXA4Wi7w=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 87D77EC346;
        Tue, 30 Jun 2020 20:03:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id CB261EC345;
        Tue, 30 Jun 2020 20:03:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Han-Wen Nienhuys <hanwen@google.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: [PATCH v19 00/20] Reftable support git-core
References: <pull.539.v18.git.1592862920.gitgitgadget@gmail.com>
        <pull.539.v19.git.1593457018.gitgitgadget@gmail.com>
        <xmqqimf9fppn.fsf@gitster.c.googlers.com>
        <CAFQ2z_MbiTEzztU9a8beMAQFn1-ozBUwKD1JyhXHUnoTTto0TA@mail.gmail.com>
Date:   Tue, 30 Jun 2020 17:03:36 -0700
In-Reply-To: <CAFQ2z_MbiTEzztU9a8beMAQFn1-ozBUwKD1JyhXHUnoTTto0TA@mail.gmail.com>
        (Han-Wen Nienhuys's message of "Tue, 30 Jun 2020 11:28:21 +0200")
Message-ID: <xmqqbll0drtz.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 504EE4A6-BB2E-11EA-84FF-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Han-Wen Nienhuys <hanwen@google.com> writes:

> On Tue, Jun 30, 2020 at 12:54 AM Junio C Hamano <gitster@pobox.com> wrote:
>>
>> "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com> writes:
>>
>> > base-commit: b9a2d1a0207fb9ded3fa524f54db3bc322a12cc4
>>
>> This is based on 'next', which usually is a sure way for a topic to
>> stay forever out of 'next', but we have impactful dependence only on
>> two topics, I think, and a good news is that both of them are in
>> pretty good shape.  I think Brian's part 2 of SHA-256 work should be
>> on the 'master' branch soon, and Dscho's "customizable default
>> branch" is also ready---it just would, like all other topics, want
>> to spend at least one week on 'next' to be safe.  And after that,
>> this topic can be directly on 'master' (there is another trivial
>> conflict around bisect--helper, but I am not worried about it),
>> which looks quite good.
>
> ok. For the next time, I should keep basing myself on master, even if
> I know there are conflicts?

Right now we know there won't be and that is why I said the above.
If your next round would change the code drastically, or somebody
sends changes that deliberately conflicts with what you are doing
to sabotage you, the situation would become different.

> Do you have an opinion on
> https://public-inbox.org/git/pull.665.git.1592580071.gitgitgadget@gmail.com/
> ?
>
> There is some overlap with in sequencer.c, and Phillip's approach is
> likely more principled, so I'd like to base reftable on that.

I assumed that these were offered to you as possible improvements to
be folded into your series, so I didn't read them very carefully and
I didn't queue them myself.  I expected that I would see them,
possibly modified to fit the context better, as part of your series
sent from you, perhaps to become a part of early clean-up portion of
your topic.

Thanks.

