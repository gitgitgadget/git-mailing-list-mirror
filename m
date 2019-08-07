Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B249E1F731
	for <e@80x24.org>; Wed,  7 Aug 2019 17:50:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388692AbfHGRuO (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Aug 2019 13:50:14 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52862 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388428AbfHGRuO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Aug 2019 13:50:14 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3E4EB170411;
        Wed,  7 Aug 2019 13:50:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=m+Gj905pPW6Qzuw5/3PwTVKUQJY=; b=yRGBZx
        CjnkcrgwV5l1KJV15qdaR3ZA7sHMmEClx1AJo3qq4UupJvw/1f+canMKx8wk9fTV
        vcSrkY8WQp9wPZ+mRh2ZCGPqdZRTEw+NW/uhQHzdqSZejxSA5+JKg/28Y9IqE/Ok
        j1x6HADvW77yhoGLJnaGvTeW2qizPV7b+uu8c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=DdRhrNFAqXFawiSRwAjgQVIoPXC3fXm+
        Ufy2923ITgfizwkZVJVeksdyqdOgsMW3L11aQ6POQtx7DJWK8FrlN0SaJmhiqy48
        mkM7Xv7dWE/r44v8frqbE7isDqcoD1rHIHG2U/ruj7f8CuKuRJt+W5dqIniroBEs
        bcztDMNSmX0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 35737170410;
        Wed,  7 Aug 2019 13:50:12 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 980AC17040F;
        Wed,  7 Aug 2019 13:50:11 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Pratyush Yadav <me@yadavpratyush.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git-gui: Call do_quit before destroying the main window
References: <20190804143919.10732-1-me@yadavpratyush.com>
        <b7cbe50d-879f-68b9-30b2-181c3058297f@yadavpratyush.com>
        <xmqqftmejgr1.fsf@gitster-ct.c.googlers.com>
        <549ad583-5ca1-7096-f4ce-10e8a836f7f9@yadavpratyush.com>
Date:   Wed, 07 Aug 2019 10:50:10 -0700
In-Reply-To: <549ad583-5ca1-7096-f4ce-10e8a836f7f9@yadavpratyush.com>
        (Pratyush Yadav's message of "Wed, 7 Aug 2019 00:34:51 +0530")
Message-ID: <xmqq5zn8j25p.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CDAD6594-B93B-11E9-B447-46F8B7964D18-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Pratyush Yadav <me@yadavpratyush.com> writes:

> So if I fork the project, will you pull from my fork? If yes, what
> exactly would I have to do? Make a set of changes and then ask on the
> list for you to pull from my fork?
>
> I am a relatively inexperienced programmer, and it feels like a kinda
> big responsibility that I'm not sure I am ready for. But maybe you can
> look at the changes from a high level POV before pulling, so there is
> someone sanity checking my changes.

This patch as a one-off thing may not be too bad, as it already had
exposure to the list (and there probably are more people scanning it
than it would have been if you silently made a pull request on
GitHub, because they saw messages from me in this thread).

BUT.

If I make it a habit to pull git-gui stuff from random people who
are not committed to and/or feel experienced enough for working on
git-gui, the result would be even worse than taking patches on
git-gui directly from the list.  At least a patch on the list I can
see how others react (or not react).  On the other hand, I do not
know how to interpret lack of comments from others on GitHub pull
request---perhaps nobody thought it was a good change, perhaps
nobody is paying attention to it, or what other possibilities there
are.

So,... quite honestly, I'd rather not.
