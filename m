Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B12DC433DB
	for <git@archiver.kernel.org>; Fri, 12 Feb 2021 17:55:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B29864E9A
	for <git@archiver.kernel.org>; Fri, 12 Feb 2021 17:55:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230521AbhBLRz0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Feb 2021 12:55:26 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:57145 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbhBLRzZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Feb 2021 12:55:25 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A59B3117B90;
        Fri, 12 Feb 2021 12:54:45 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=zyeLEZgm45OWZ0iE1ESK+d75vuM=; b=MgAKTz
        X94bv1GxzwVZ5xIar7olYKrx+xzjgEOE0LUtEIq/vCZ0f03D2ry/3UWKToZtKkxp
        YbuKp7a1z99PGd1yEt1xMZ4WHBfQPMvc15h9JLM4Hy7YOhM8nu1CI0vVmlNIr31r
        JWVQJXg/wku/U33Xb6kkYMRsXKH/pEiqMnrqk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=RgaRuuq1bTwIBaGsPgCl8fT/RABMGsmE
        ivdJMVeJNCv7wmICv64wBiusY0jfwElWTJwbDLos5OjsCB2iE5u69ub/31iNxWxl
        PjOfuFyNVoWBWhO1ZjhyCGAcyHLrbnSLCbKQUfCHSgfJTGGy1kcW7mGPbUUcACK1
        IkUJ3GoZBRs=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 9E68C117B8F;
        Fri, 12 Feb 2021 12:54:45 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.243.138.161])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id E9C9D117B8E;
        Fri, 12 Feb 2021 12:54:42 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, ZheNing Hu <adlternative@gmail.com>
Subject: Re: [PATCH] diff: --{rotate,skip}-to=<path>
References: <xmqqo8gqwasu.fsf@gitster.c.googlers.com>
        <nycvar.QRO.7.76.6.2102121713390.29765@tvgsbejvaqbjf.bet>
Date:   Fri, 12 Feb 2021 09:54:40 -0800
In-Reply-To: <nycvar.QRO.7.76.6.2102121713390.29765@tvgsbejvaqbjf.bet>
        (Johannes Schindelin's message of "Fri, 12 Feb 2021 17:15:09 +0100
        (CET)")
Message-ID: <xmqq35y1w4rj.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 62AA97F0-6D5B-11EB-8785-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> This is more a drive-by comment, as I have no stake in this, but don't we
> already have a more generic solution via `-O<orderfile>`? See
> https://git-scm.com/docs/git-diff#Documentation/git-diff.txt--Oltorderfilegt
> for details.

The use cases are quite different.  This one is meant for a
single-shot use, while orderfile is a more permanent thing.

See https://lore.kernel.org/git/xmqqeehp2jis.fsf@gitster.c.googlers.com/
and start reading from "I suspect that" for background story.
