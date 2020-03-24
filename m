Return-Path: <SRS0=kv1d=5J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22434C10DCE
	for <git@archiver.kernel.org>; Tue, 24 Mar 2020 23:46:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E88452072E
	for <git@archiver.kernel.org>; Tue, 24 Mar 2020 23:46:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="fUfA3Vak"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727167AbgCXXq0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Mar 2020 19:46:26 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:56120 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726212AbgCXXqZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Mar 2020 19:46:25 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B2595B27A3;
        Tue, 24 Mar 2020 19:46:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=rqszINuDhCSve7rpFeL4/hg+jL0=; b=fUfA3V
        akfAQyK1kaRGPOGO2fpRH/amv+B4HBA0PG02o15aODdGfkCL4fpGy+9Gw0+lVYRY
        w2coeZD26PVBqbWZ3L2x2tPGHonB/kKqq1qns0Xa0EcGqaxCzF8ybVxu8GK+9hiF
        GI40QIYqXwX64w4PKwOC2jLR5IXNi6YmXumzo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=OXU4IBNTVDXgy80iyZihCskB0jwkPcNi
        rEDcjqPr6qus7+RBWYdxkGY8fXd0wuGY0aw6tEORxKl+Po6BC9qXI29iIeqcXcR6
        Q1cMT2MUGjv/xO1I94QSY31YH56WDC2ipGPBCix9t8nur7cP1fMUqr/RulrYNK5d
        IOd+OShk+aY=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A96BBB27A1;
        Tue, 24 Mar 2020 19:46:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id EDA08B279D;
        Tue, 24 Mar 2020 19:46:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH v2 6/8] t7063: drop non-POSIX argument "-ls" from find(1)
References: <cover.1584838148.git.congdanhqx@gmail.com>
        <59e3f73784b2a3bd9ccec87412e6178411c3708e.1584838148.git.congdanhqx@gmail.com>
        <nycvar.QRO.7.76.6.2003231509150.46@tvgsbejvaqbjf.bet>
        <xmqqy2rr5amm.fsf@gitster.c.googlers.com>
        <nycvar.QRO.7.76.6.2003242330540.46@tvgsbejvaqbjf.bet>
Date:   Tue, 24 Mar 2020 16:46:19 -0700
In-Reply-To: <nycvar.QRO.7.76.6.2003242330540.46@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Tue, 24 Mar 2020 23:31:10 +0100 (CET)")
Message-ID: <xmqqk139z584.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A9CF8C80-6E29-11EA-88D8-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi Junio,
>
> On Mon, 23 Mar 2020, Junio C Hamano wrote:
>
>> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>>
>> > diff --git a/t/t7063-status-untracked-cache.sh
>> > b/t/t7063-status-untracked-cache.sh
>> > index 190ae149cf3c..ab7e8b5fea01 100755
>> > --- a/t/t7063-status-untracked-cache.sh
>> > +++ b/t/t7063-status-untracked-cache.sh
>> > @@ -18,7 +18,12 @@ GIT_FORCE_UNTRACKED_CACHE=true
>> >  export GIT_FORCE_UNTRACKED_CACHE
>> >
>> >  sync_mtime () {
>> > -       find . -type d -ls >/dev/null
>> > +       if test_have_prereq BUSYBOX
>> > +       then
>> > +               find . -type d -print0 | xargs -0r ls -ld >/dev/null
>> > +       else
>> > +               find . -type d -ls >/dev/null
>> > +       fi
>>
>> Given that this is only to work around the lazy mtime sync found on
>> BSDs, if we were to have any if/then/else, shouldn't we be rather
>> doing
>>
>> 	if test_have_prereq NEEDS_SYNC_MTIME_BECAUSE_WE_ARE_ON_BSD
>> 	then
>> 		find . -type d -ls >/dev/null
>> 	fi
>>
>> to make it a no-op for most everybody (including Windows)?
>
> I like that approach.

I actually think I was being half stupid --- what are we going to
tell those who want a stripped down system with busybox based on
BSD?  I think the condition for "if" is OK (as long as we have a
real prereq suitable for the approach), but the actual "let's make
sure the inodes are stat(2)ed" should avoid relying on "find -ls".

If we can assume that a typical busybox build offers find with -print0
and xargs with -0, I think the version you sent is probably the best
(with or without "do so only on BSD" I suggested) approach.

Thanks.


