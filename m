Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4557FEB64D7
	for <git@archiver.kernel.org>; Fri, 23 Jun 2023 17:26:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232449AbjFWR0d (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Jun 2023 13:26:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230506AbjFWR0b (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jun 2023 13:26:31 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05CAE184
        for <git@vger.kernel.org>; Fri, 23 Jun 2023 10:26:30 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5E4F118FA83;
        Fri, 23 Jun 2023 13:26:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=0LlksXPQ9sZV2i9ytwYl2isGZw2uwMdBN+sKz8
        7hR7s=; b=PzFYgZSY6Vilke7umjYIQAJDK7OIixq+BlU8w9CurX3ki0YRk43jvD
        0SnuD3WmaqPhQYKps90ofgy8FQEJZE5mLqXNAZU0A4l5wGpIQM1/WxYDhIdn17zr
        MGofwmYyP54wt017LrP1ni+5Jitfmu1mBCljkw7hQpXX/SsGJYsAs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 56D5F18FA81;
        Fri, 23 Jun 2023 13:26:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.62.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id AD42118FA7D;
        Fri, 23 Jun 2023 13:26:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Sebastian Schuberth <sschuberth@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: Clean up stale .gitignore and .gitattribute patterns
References: <CAHGBnuOR+MU50jhNBHw8buWS_Yr9D92mErvgoi=cK16a=4_YUA@mail.gmail.com>
Date:   Fri, 23 Jun 2023 10:26:23 -0700
In-Reply-To: <CAHGBnuOR+MU50jhNBHw8buWS_Yr9D92mErvgoi=cK16a=4_YUA@mail.gmail.com>
        (Sebastian Schuberth's message of "Fri, 23 Jun 2023 17:29:42 +0200")
Message-ID: <xmqqcz1may4g.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1418E3C6-11EB-11EE-ADCE-C65BE52EC81B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sebastian Schuberth <sschuberth@gmail.com> writes:

> is there a command to easily check patterns in .gitignore and
> .gitattributes to still match something? I'd like to remove / correct
> patterns that don't match anything anymore due to (re)moved files.

I guess "git check-attr --stdin" and "git check-ignore --stdin" will
be part of the solution to your problem, but I do not know what the
other parts would be.

Feeding "ls-files" output to "check-ignore --stdin" feels sort-of
oxymoron because by definition the output from "ls-files" cannot
contain any ignored paths.
