Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F93FC2D0E4
	for <git@archiver.kernel.org>; Tue, 24 Nov 2020 21:16:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24E6E20715
	for <git@archiver.kernel.org>; Tue, 24 Nov 2020 21:16:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="h3OqsIlC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730545AbgKXVQt (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Nov 2020 16:16:49 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:53845 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730537AbgKXVQs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Nov 2020 16:16:48 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C3E8FF283E;
        Tue, 24 Nov 2020 16:16:46 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=S5sEnX39yQNTiS5MxsMIRg8DfMA=; b=h3OqsI
        lCMkd0mgUohAm1BDdnga1Z0FtAwNA0Bh0KkJ8FBMLm0CsH5Mppxir7DfB7lxhCaZ
        3QNanJ3/nXX38TU7OoRychJTzudiC0tSCvC8UyAOyvUdg8IbX8hCax41RWhunrdz
        YSCMA6AYVhMZX5q9fUKqoJ0+ocwmdK+/o6fYQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=FdnjV7ZTPhGyaCgb092uqbZLAaeV2g+x
        E0PjP8nx/d5DCeJIJX3p5cKBuzYTHaS7nVxuoeWRkxInJ0PIa+BUAaoh0azN/qP5
        o4qtE/1UpYbHIhQnyEq4Eg5nbEyOyJ5/fnOutCLt6cW6ZKefh3WiQvYhGK4SmaLF
        6c9iJhBSwRw=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id BE9CDF283D;
        Tue, 24 Nov 2020 16:16:46 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 0D90CF283C;
        Tue, 24 Nov 2020 16:16:43 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] t3404: do not depend on any specific default branch name
References: <pull.798.git.1606212950283.gitgitgadget@gmail.com>
Date:   Tue, 24 Nov 2020 13:16:42 -0800
In-Reply-To: <pull.798.git.1606212950283.gitgitgadget@gmail.com> (Johannes
        Schindelin via GitGitGadget's message of "Tue, 24 Nov 2020 10:15:49
        +0000")
Message-ID: <xmqqv9duihfp.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5A5BC7E0-2E9A-11EB-9752-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> Now that we can override the default branch name in the tests via
> `GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME`, we should avoid expecting a
> particular hard-coded name.
>
> So let's rename the initial branch immediately to `primary` and work
> with that.

Yes, that is probably the approach that gives us the most stable
environment to work in.   I like it.

>     Applying this patch would obsolete the change in 
>     js/default-branch-name-tests-final-stretch to force the default branch
>     name to master in t3404.

Yup, after taking these individual replacement patches, I expect
that the big topic will see shrinkage, which is good.

Will queue.  Thanks.
