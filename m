Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE002C3E8C5
	for <git@archiver.kernel.org>; Wed, 18 Nov 2020 17:47:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 49688248EB
	for <git@archiver.kernel.org>; Wed, 18 Nov 2020 17:47:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="flbvdPGc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728135AbgKRRqP (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Nov 2020 12:46:15 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:57656 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727754AbgKRRqO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Nov 2020 12:46:14 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A0B2A10CBC2;
        Wed, 18 Nov 2020 12:46:14 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=2pPyRDICFm6yPKxLIihHSB68a5g=; b=flbvdP
        GcljDlZgwNyqfAPbRPKQsU6k7ljpRYZIey6JHIXELOj0NO/lKyiloLNHMAltwIMs
        D9hUUqu+X8gkee0z9gizQjMPjzR2jDl+2ODUYFf1mhhDdZmXSaozLYEPR0ViElKJ
        nP4rEshVAsA7O1Cak+zqG5BjCefkbdjUGzsPE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=wTPFmRypm6vxVWIQy+GBzGlr6oGgcGR9
        lvdySNCP0vI+Tj2epm9j0lvajwi1WfUtawrV8VPFMwfRN/nZbOTHZqVvFZNgzyZX
        7UojKrPPLvz0fURSCTyb/ILjOIno5UrfwCf0lTG38pS241dag0AGsBDl94S0PC63
        C+iVsD4pkv8=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 9946D10CBC1;
        Wed, 18 Nov 2020 12:46:14 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id E07FF10CBBE;
        Wed, 18 Nov 2020 12:46:11 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Drew DeVault" <sir@cmpwn.com>
Cc:     <git@vger.kernel.org>, "lanodan" <contact+git@hacktivis.me>
Subject: Re: [PATCH v3] help.c: configurable suggestions
References: <C76K6Q09ATLR.1OI5KW390LKFX@taiga>
Date:   Wed, 18 Nov 2020 09:46:10 -0800
In-Reply-To: <C76K6Q09ATLR.1OI5KW390LKFX@taiga> (Drew DeVault's message of
        "Wed, 18 Nov 2020 12:17:43 -0500")
Message-ID: <xmqq8say36e5.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F289FF34-29C5-11EB-AD2D-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Drew DeVault" <sir@cmpwn.com> writes:

> On Wed Nov 18, 2020 at 12:16 PM EST, Junio C Hamano wrote:
>> It is unclear from this description alone why this is needed. The
>> seller of this change needs to emphasize how this is better than
>> setting the variable to "0" (do not autocorrect). My guess is that
>> some users do not even need the suggestion of correct spelling when
>> they made a typo?
>
> This is one reason. Another is that spell checking can be
> computationally expensive, and take an annoyingly long time on low-end
> devices.

Both are good reasons to describe in the log message, so that the
next reader of "git log" won't have to ask "why?"


