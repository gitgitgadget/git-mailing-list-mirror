Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96639C433EF
	for <git@archiver.kernel.org>; Thu, 10 Mar 2022 20:13:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237071AbiCJUOv (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Mar 2022 15:14:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233319AbiCJUOt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Mar 2022 15:14:49 -0500
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0420CB45B6
        for <git@vger.kernel.org>; Thu, 10 Mar 2022 12:13:47 -0800 (PST)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8E6D2182AE8;
        Thu, 10 Mar 2022 15:13:47 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=7VYIiy7dFlOOx07C+duKE+LGAmZMYIhQPHBpun
        Me6R0=; b=tUIPynE4F4OULA277EhcGAkJLRdfMg6izYcnf4nbOfJj55yoBvL3Bo
        rjzrQ3Skx/iDEpNHd3Qr8AK++RRxWjRey5UK5+FeOhcdX8puUcOwgVdLShwF7KyW
        JEpZ4UtdsQRgOctOd6VeUd/iahTMpDjQBQ9MYYnJr8obgIsWrCF7o=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 86E3A182AE7;
        Thu, 10 Mar 2022 15:13:47 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.247.14.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 13DD7182AE5;
        Thu, 10 Mar 2022 15:13:45 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Git List Mailing <git@vger.kernel.org>
Subject: Re: RFC: Using '--no-output-indicator-old' to only show new state
References: <CAHk-=wgh8emJn-+FtxN=m_SCPiP6cGKHU-5ozzV9tWBMxn+xcA@mail.gmail.com>
Date:   Thu, 10 Mar 2022 12:13:44 -0800
In-Reply-To: <CAHk-=wgh8emJn-+FtxN=m_SCPiP6cGKHU-5ozzV9tWBMxn+xcA@mail.gmail.com>
        (Linus Torvalds's message of "Thu, 10 Mar 2022 11:40:50 -0800")
Message-ID: <xmqqo82dd0qv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 967A1F60-A0AE-11EC-B5F8-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> writes:

> So after another round of doing
>
>      git diff | grep -v '^-'
>
> to just show what the end result of a patch is, I decided that there
> has to be a better way.
>
> Of course, to normal people, that "better way" is probably some GUI
> tool that shows diffs as "before/after" in two different frames next
> to each other, but I'm a grumpy old man ("Get off my lawn") and I do
> everything but read my email in a standard text-only terminal.

Sounds like the "apply --no-add" in the opposite direction ;-) I
would find it handy myself, too, though I tend to read my patches
after applying to my tree so the postimage is usually an invocation
of "less" away for me.

I do not think it is a bad idea to have an option to give only the
postimage and another option to give only the preimage.  It would
also trivially allow people to show the side-by-side diff in GUI.
