Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B7D7C433DB
	for <git@archiver.kernel.org>; Tue,  9 Feb 2021 23:12:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5338764DA5
	for <git@archiver.kernel.org>; Tue,  9 Feb 2021 23:12:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbhBIXKq (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Feb 2021 18:10:46 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58815 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234139AbhBIWOz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Feb 2021 17:14:55 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C87EEB11A5;
        Tue,  9 Feb 2021 16:50:17 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=duk7SMxFbEINbaPzibqsMjA+7IM=; b=vbi4VU
        vxMkixL1trMPbC1045fNhpdAYgHh2m7oC/VtNWJnJYRtllIAldap+EVOhN3tOCZ+
        KbsauFQL+g5U6iPlWTs28UxEJj8wwfVNelx9nMCmYtiG2auxJuDUBzp/WBeBlQsi
        k+unsKxAC7Kbfeqf7jvWluP0zD9kifJ5j3ZAc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=P0QTZjZyVZPa/SeELZ7FzTT15JWXsoDy
        KKRyUBbUkojZYv3FM2Y3kMU8MO0kY6mC6xMldiHlq4YMEpTbwj9jS6LaLfaa2DSe
        NbFlVmKzrEQcC0K6UCVnTThpG8Pqwrm0eG5kuz+65/neIw27WzyYf7aTtbbQWK7K
        XiTqqgHe+dM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C0E7AB11A4;
        Tue,  9 Feb 2021 16:50:17 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4972AB11A3;
        Tue,  9 Feb 2021 16:50:17 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Christian Walther via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Christian Walther <cwalther@gmx.ch>
Subject: Re: [PATCH] doc: mention bigFileThreshold for packing
References: <pull.872.git.1612897624121.gitgitgadget@gmail.com>
Date:   Tue, 09 Feb 2021 13:50:16 -0800
In-Reply-To: <pull.872.git.1612897624121.gitgitgadget@gmail.com> (Christian
        Walther via GitGitGadget's message of "Tue, 09 Feb 2021 19:07:03
        +0000")
Message-ID: <xmqqim70zzaf.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CC27904E-6B20-11EB-8AF9-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Christian Walther via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Christian Walther <cwalther@gmx.ch>
>
> Knowing about the core.bigFileThreshold configuration variable is
> helpful when examining pack file size differences between repositories.
> Add a reference to it to the manpages a user is likely to read in this
> situation.

Thanks.

I doubt that the description of --window/--depth command line
options, for both repack and pack-objects, is the best place to add
this "Note".  Even if we were to add it as an appendix to these
places, please do not break the flow of explanation by inserting it
before the description of the default values of these options.

>     I recently spent a lot of time trying to figure out why git repack would
>     create huge packs on some clones of my repository and small ones on
>     others, until I found out about the existence of the
>     core.bigFileThreshold configuration variable, which happened to be set
>     on some and not on others. It would have saved me a lot of time if that
>     variable had been mentioned in the relevant manpages that I was reading,
>     git-repack and git-pack-objects. So this patch adds that.

Not related to the contents of the patch, but I am somewhat curious
to know what configuration resulted in the "huge" ones and "small"
ones.  Documentation/config/core.txt::core.bigFileThreashold may be
helped by addition of a success story, and the configuration for the
"small" ones may be a good place to start.

Thanks
