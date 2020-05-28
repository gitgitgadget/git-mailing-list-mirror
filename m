Return-Path: <SRS0=eul5=7K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC7EFC433E0
	for <git@archiver.kernel.org>; Thu, 28 May 2020 23:01:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A61B2074B
	for <git@archiver.kernel.org>; Thu, 28 May 2020 23:01:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="W0FEB+o9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391507AbgE1XB0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 May 2020 19:01:26 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62024 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391479AbgE1XBP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 May 2020 19:01:15 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 96DCF7F2AC;
        Thu, 28 May 2020 19:01:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=T5LJkkTUQAkVoIE9rW9o5mCM1Io=; b=W0FEB+
        o9qa1ubBY+V4JsHXtlKfYziLL37sjw9hUbl9cD3AFgNj63nnrSCrriVM2ZRQWP8q
        YTeeMT+FX5caRqLHTjD+cK4zCRuWbjnRB8mQ5QhShUOb1StqGXQ6LlHPr4NU/oQz
        Go62uBQ93U02r9S3+BzhS1PJQ3a8ctExLt8G8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=jH+OpG6+uvdCW6QlGE/JITzC8jrINHiW
        t0WJW+clEwUewlatzbvf2PDjoEs1gGS2JIQyKvy85OSF62O2mDmOELxZ6+qcuIT6
        GK7QEv0dQgAd2zlBNA9Oll/D0B76r9aTunK71EJW9H9E0brmxcCITpbxwXJzV/TZ
        bFJ40LnuePU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8183D7F2AB;
        Thu, 28 May 2020 19:01:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5CC657F2A9;
        Thu, 28 May 2020 19:01:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>,
        Marco Trevisan via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Marco Trevisan <mail@3v1n0.net>
Subject: Re: [PATCH] completion: use native ZSH array pattern matching
References: <pull.645.git.1590520398132.gitgitgadget@gmail.com>
        <20200526235834.GG1915090@camp.crustytoothpaste.net>
        <20200527061359.GB40564@Carlos-MBP>
        <20200528021727.GH1915090@camp.crustytoothpaste.net>
        <xmqqd06o3vhy.fsf@gitster.c.googlers.com>
        <20200528225733.GI1915090@camp.crustytoothpaste.net>
Date:   Thu, 28 May 2020 16:01:05 -0700
In-Reply-To: <20200528225733.GI1915090@camp.crustytoothpaste.net> (brian
        m. carlson's message of "Thu, 28 May 2020 22:57:33 +0000")
Message-ID: <xmqqtuzz1x72.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1CA3ECF2-A137-11EA-9825-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> On 2020-05-28 at 15:54:49, Junio C Hamano wrote:
>> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>> > Yes, that is what I meant.  I'm glad to know my question has been
>> > answered and things work.  I'm okay with the patch as it is in that
>> > case, although I'd give bonus points for mentioning that this syntax
>> > doesn't regress bash.
>> 
>> True.  And we would want to also have tested-by on more recent
>> versions of bash, no?
>
> Sure, such testing would be welcome, but I believe those are tested with
> our tests on most platforms.  macOS is special because it uses the last
> GPLv2 version of bash, which is less capable in some ways.  I assumed
> that bash would not be more likely to break here in newer versions, but
> perhaps I shouldn't make that assumption.

In any case, a few integration into 'pu' with the patch have been
already made e.g. https://travis-ci.org/github/git/git/builds/692290894
so we should be good ;-)

