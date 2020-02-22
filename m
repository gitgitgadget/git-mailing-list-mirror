Return-Path: <SRS0=hy0J=4K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 658A2C35666
	for <git@archiver.kernel.org>; Sat, 22 Feb 2020 17:18:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 373AB2071E
	for <git@archiver.kernel.org>; Sat, 22 Feb 2020 17:18:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="PDDiYkYJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726688AbgBVRS2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 22 Feb 2020 12:18:28 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:51301 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726198AbgBVRS1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Feb 2020 12:18:27 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8D869BDC95;
        Sat, 22 Feb 2020 12:18:27 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=pTIy+K0KGcF+3ejODwT0p/y97Vw=; b=PDDiYk
        YJLP/HZjuuznAJfGBEQpkJ6TLs/l/s48DnAWYbH67PD+xPmsFCkcdwe5swGkS8NK
        dodteCAxIabPw/qEjfWugZyth3HLdlQ1Z8aYfGRoWRgIQywpvYBhaQSfosy8S3AE
        uW31UBcYSlkRdavz3FOCrcjU/8T6OYY6bp2Ds=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=AnThAg/i8IX57vo3TcKbMvz5IPkP3Q/G
        jvNjGLdEropPe4s9hoxruho0eUJk9qesFE/omhSjFYzPhnk9JWMgG/o0n7/EXIAy
        cchLx6XjxmvRK6Jtow23hdBKmXVXisyyQ/mjH9iFBswWXkJdMsQgWEBU6RdnahOh
        ixTgCszy70E=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8662EBDC94;
        Sat, 22 Feb 2020 12:18:27 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id AB875BDC93;
        Sat, 22 Feb 2020 12:18:24 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (Feb 2020, #04; Mon, 17)
References: <xmqq36b8lvdl.fsf@gitster-ct.c.googlers.com>
        <CABPp-BEFQs4LL0uwkZSpXb_wxo7Wk-gEQSsv-=4B5ja5H1xXTg@mail.gmail.com>
        <CABPp-BEnt4C_7XyxQKxk4aga=JjM9fXCE-7SFp7azO_v5-pQYw@mail.gmail.com>
Date:   Sat, 22 Feb 2020 09:18:22 -0800
In-Reply-To: <CABPp-BEnt4C_7XyxQKxk4aga=JjM9fXCE-7SFp7azO_v5-pQYw@mail.gmail.com>
        (Elijah Newren's message of "Fri, 21 Feb 2020 19:11:05 -0800")
Message-ID: <xmqq36b27d7l.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5544AC86-5597-11EA-A20B-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

>> > * en/rebase-backend (2020-02-16) 20 commits
>> >  - rebase: rename the two primary rebase backends
>> >...
>> >  - t3404: directly test the behavior of interest
>> >  - git-rebase.txt: update description of --allow-empty-message
>> >
>> >  "git rebase" has learned to use the sequencer backend by default,
>> >  while allowing "--am" option to go back to the traditional "am"
>> >  backend.
>> >
>> >  The last step may be rushing things a bit and may want to be
>> >  taken separately.
>> >  cf. <pull.679.v5.git.git.1581802602.gitgitgadget@gmail.com>
>
> In contrast, this whole series I think is complete and ready to merge
> down.  Both Phillip and Dscho have commented that they agree with the
> direction of the final patch, Phillip has reviewed multiple rounds and
> sounds happy with it, and most of this series already spent some time
> in 'next' during the 2.25 cycle.

Let's merge it down then.  Thanks.
