Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9687AEB64DA
	for <git@archiver.kernel.org>; Mon, 26 Jun 2023 15:55:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbjFZPzg (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Jun 2023 11:55:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbjFZPze (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Jun 2023 11:55:34 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 219FE94
        for <git@vger.kernel.org>; Mon, 26 Jun 2023 08:55:34 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6B6D01932BF;
        Mon, 26 Jun 2023 11:55:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=/1JIaDXZNslhpO5evPb+ys2hlK0Ap26BEXDI8e
        cK0JA=; b=Ickdc+GFWHT6vJYQ5LBCL/N5j7ndf9OgHSjLF4dtuCB5efJ3zNXvko
        VvEWVVgYljql3ILO5/RQtlBh6URx/RodgSRFLXoA3YR3l4eqTSk3exo+q5Z+xF0e
        mGrq7AUnbCtG/IP0Xx89EfcvEaQ9DXWuGmm75fU/y+P44r5QAMJVE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 620011932BB;
        Mon, 26 Jun 2023 11:55:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.62.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D1FFC1932B9;
        Mon, 26 Jun 2023 11:55:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Sebastian Schuberth <sschuberth@gmail.com>
Cc:     Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>
Subject: Re: Clean up stale .gitignore and .gitattribute patterns
References: <CAHGBnuOR+MU50jhNBHw8buWS_Yr9D92mErvgoi=cK16a=4_YUA@mail.gmail.com>
        <20230624011234.GA95358@coredump.intra.peff.net>
        <CAHGBnuPO63Hi8mfA+MkAGES-gs0eNCDPG2FcPZT=YsnVzKd30A@mail.gmail.com>
Date:   Mon, 26 Jun 2023 08:55:31 -0700
In-Reply-To: <CAHGBnuPO63Hi8mfA+MkAGES-gs0eNCDPG2FcPZT=YsnVzKd30A@mail.gmail.com>
        (Sebastian Schuberth's message of "Mon, 26 Jun 2023 09:51:27 +0200")
Message-ID: <xmqqo7l25ibw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E1C8207A-1439-11EE-AC13-307A8E0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sebastian Schuberth <sschuberth@gmail.com> writes:

> Thanks Peff for the suggestion. I ended up scripting something via
> JGit [1], as we're anyway using it as part of our Gradle build system.
>
> PS: As a future idea, it might be good if "git mv" gives a hint about
> updating .gitattributes if files matching .gitattributes pattern are
> moved.

Interesting.  "git mv hello.jpg hello.jpeg" would suggest updating
a "*.jpg <list of attribute definitions>" line in the .gitattributes
to begin with "*.jpeg"?

