Return-Path: <SRS0=4khD=CT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26784C43461
	for <git@archiver.kernel.org>; Thu, 10 Sep 2020 04:52:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CAC5E2076C
	for <git@archiver.kernel.org>; Thu, 10 Sep 2020 04:52:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ogIbT5s1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726534AbgIJEwr (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Sep 2020 00:52:47 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:54837 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725981AbgIJEwq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Sep 2020 00:52:46 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 19F1EFAA66;
        Thu, 10 Sep 2020 00:52:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=WVKBnV3J4bkDOyr2ImutyCg+d5A=; b=ogIbT5
        s15RLGg31G+Ex7due3Ie4gPvolpFOFbRWahkGRL6UDHr19t2x+W7Z285eFQwQ+AA
        TulfRJWaHoXQrnvADosaHDPAhd4CC0kC9wyRK8XXUnDXNtFRXaQyrn4/xVSkuARy
        4jC5OJBCi2lYF6LPpGCd175uQQSUrbdWr+U6w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=KWM00tUpJxYJL8NqE8nWeVGc2cSciJ1H
        eX1QLTOcVSse0VAz0uPcwfT8z793x04pgUuMWZoBh6DoG6DAADDti+xbcQN4W6v4
        mZaEYaEn5cXk7I1HGLdyU9Ql+D0NAgwRNDqcgSjp8q9wjo5mSl+gN5tY5wbdYfG0
        d99XAGBxV3A=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 03A6CFAA65;
        Thu, 10 Sep 2020 00:52:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.190.152.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 393F8FAA64;
        Thu, 10 Sep 2020 00:52:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (Sep 2020, #03; Wed, 9)
References: <xmqq4ko6twc9.fsf@gitster.c.googlers.com>
        <CAPig+cQnnukVoJTgsu1sGFWkAYv7V38-0s-CgYuMyizYHhSFQQ@mail.gmail.com>
Date:   Wed, 09 Sep 2020 21:52:38 -0700
In-Reply-To: <CAPig+cQnnukVoJTgsu1sGFWkAYv7V38-0s-CgYuMyizYHhSFQQ@mail.gmail.com>
        (Eric Sunshine's message of "Wed, 9 Sep 2020 19:07:22 -0400")
Message-ID: <xmqqimcms06h.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7483B97A-F321-11EA-AEB0-843F439F7C89-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Wed, Sep 9, 2020 at 6:33 PM Junio C Hamano <gitster@pobox.com> wrote:
>> * es/format-patch-interdiff-cleanup (2020-09-08) 3 commits
>>  - format-patch: use 'origin' as start of current-series-range when known
>>  - diff-lib: tighten show_interdiff()'s interface
>>  - diff: move show_interdiff() from its own file to diff-lib
>>
>>  Code cleanup with a slight behaviour change when "format-patch
>>  --range-diff=<prev> origin..HEAD" gives a single revision to
>>  <prev>.
>
> Perhaps this could be a bit more precise by saying something like:
>
>     Code cleanup and make "format-patch --range-diff=<prev>
>     <origin>..HEAD" not ignore <origin> when <prev> is a single
>     revision.

Sure.  I didn't realize we can be more specific without spending too
many more bytes.  Let me steal that description.

>     "git worktree add" learns "-d" as short for "--detach".

Thanks.
