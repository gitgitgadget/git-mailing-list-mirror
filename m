Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4CD7C433F5
	for <git@archiver.kernel.org>; Thu, 20 Jan 2022 22:33:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243835AbiATWds (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Jan 2022 17:33:48 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:56850 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234313AbiATWdn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jan 2022 17:33:43 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D774817C58D;
        Thu, 20 Jan 2022 17:33:42 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+ONVSsa2OBGYJknvYSuIs1PhsWHEShHQ9VB9C0
        fjYKA=; b=PL4iOZuGi0I0ZxIl8SNh0LgFEHnRvK4iemqMbVvJfVIFwfIq6uMDNj
        R5tp2w3RwEmd+6J50ycC45Thab0EXsbduyg21yqvga9ryXOQc7FZ4yQcN4hxpilx
        5LTHX9XlPj2vh0JC4PUpTMHxGeZvj0j1FhziQ645uM6BXCgvN2D+g=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id CFC1D17C58C;
        Thu, 20 Jan 2022 17:33:42 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 45D0E17C58A;
        Thu, 20 Jan 2022 17:33:40 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Todd Zullinger <tmz@pobox.com>,
        Petr =?utf-8?B?xaBwbMOtY2hhbA==?= <psplicha@redhat.com>
Subject: Re: [PATCH] checkout: fix BUG() case in 9081a421a6
References: <YemTGQZ97vAPUPY0@pobox.com>
        <patch-1.1-21ddf7c628d-20220120T212233Z-avarab@gmail.com>
        <xmqqee52ghwg.fsf@gitster.g>
Date:   Thu, 20 Jan 2022 14:33:39 -0800
In-Reply-To: <xmqqee52ghwg.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
        20 Jan 2022 14:29:51 -0800")
Message-ID: <xmqqa6fqghq4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 042AE772-7A41-11EC-AAA8-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> So from my point of view, BUG() is indeed inappropriate because what
> the conditional statement noticed was a broken repository, and not a
> programming bug.

Forgot to say: "; it should have been at least a warning(), if not a die()".
