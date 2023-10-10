Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FA95CD68E3
	for <git@archiver.kernel.org>; Tue, 10 Oct 2023 02:44:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441927AbjJJCo0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Oct 2023 22:44:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1441879AbjJJCoZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Oct 2023 22:44:25 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5EBE9C
        for <git@vger.kernel.org>; Mon,  9 Oct 2023 19:44:23 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 206D621FDA;
        Mon,  9 Oct 2023 22:44:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=17n/6VpdI9Rh5ZE+0cec7hR5C1Y37tzIP6hAt3
        Hw+tQ=; b=aDN49U6N4nHp1oxxlni3q2DKGDp7e4JyFrZy03NSqhUMeWrGIWgBBY
        QAphpqz0WS3puyjUrDKDlX4LpmTYbj2QtcRtYmsvDz0gfb2dD5ZnHjpzYW2jXpEa
        MO665ar9cdJvOIxvn4tHW72f/sOu9mZbVTyNQv7w+tOBka83/YWIs=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 194BA21FD9;
        Mon,  9 Oct 2023 22:44:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id A904B21FD4;
        Mon,  9 Oct 2023 22:44:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     git@vger.kernel.org
Subject: [silly] worldview documents?
In-Reply-To: <CABPp-BFsrt0zS3NHsVAyOSW6vGioe8Z-iN2M3_JNBpP2fWVq9g@mail.gmail.com>
        (Elijah Newren's message of "Fri, 6 Oct 2023 07:41:51 -0700")
References: <20230909125446.142715-1-sorganov@gmail.com>
        <20231004214558.210339-1-sorganov@gmail.com>
        <20231004214558.210339-2-sorganov@gmail.com>
        <xmqq34yog3ux.fsf@gitster.g>
        <CABPp-BFsrt0zS3NHsVAyOSW6vGioe8Z-iN2M3_JNBpP2fWVq9g@mail.gmail.com>
Date:   Mon, 09 Oct 2023 19:44:18 -0700
Message-ID: <xmqqo7h7urgd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E95B0F48-6716-11EE-97B2-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

>> [Footnote]
>> ...
>
> Thanks for writing this up.  In the past, I didn't know how to put
> into words why I didn't particularly care for this mode.  You explain
> it rather well.

I am glad it helped non-zero number of people.

It probably owes big to my failing, but because we strongly view it
a virtue not to be opinionated, we have many discrete tools and
features that can be used in combination to support a workflow well,
even when some of these tools and features are not useful for a
different workflow.  It indeed is a good thing to be flexible and to
support different workflows well, and we tend not to single out a
workflow among many and advocate it, but because our documentation
lacks description of major possible workflows, what their underlying
philosophies and their strengths are, how some of our tools and
features support them, and why some others are not good fit.  Being
given a toolbox with too many tools without being taught how they
are to be used together and for what purpose may be a fun puzzle to
figure out for tinkerers, but when you have a problem to solve and
tinkering is not your main focus, which is true for most people, it
is not fun.  

In short, in pursuit of not to be opinionated, we fail to give the
readers best current practices.  The first place to start rectifying
it might be to have some write-ups for various major workflows and
the worldview behind them.  The importance given to first-parenthood
offers two quite different worldviews that affects the choice of
tools (e.g. "merge --no-ff", "checkout origin/master && merge mine
&& branch -f mine" aka "reverse merge").

I suspect that this also relates to your "would --cc be totally
unnecessary now we have --remerge-diff?" as well.  What kind of
conflicts are interesting highly depends on what you are looking
for, which in turn is influenced by the workflow employed by the
project and what role you are playing in it.
