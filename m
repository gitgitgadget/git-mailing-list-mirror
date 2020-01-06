Return-Path: <SRS0=yIgW=23=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C451DC33C8C
	for <git@archiver.kernel.org>; Mon,  6 Jan 2020 20:45:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D869207FD
	for <git@archiver.kernel.org>; Mon,  6 Jan 2020 20:45:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="o2U/j5cj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726739AbgAFUpc (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Jan 2020 15:45:32 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63587 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726695AbgAFUpb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Jan 2020 15:45:31 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C3BA729F5E;
        Mon,  6 Jan 2020 15:45:29 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=iJZy48sMDYkBUgiiKS+heYjfFZ8=; b=o2U/j5
        cjnDWCMwLGZHyZlQGQkQ7/2fr7RsvI3m8x0kekalmGZNyLPo9CGAlhvfbopdTerr
        5iafhApzIg9ScGGQTnFAzcwASrXkIpJfnhrk67is4Kn3pU8lLcJVwuehlpsAXhS/
        oDWTPcGPFBg9wAZsrLy6xUfe1adnTRjo/PXpw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=bNKFLSQ2aCsXs6DzVy6A7QV+iLpPxO9X
        ke16gkXuDruu6x/8RgCKCLPM2jaG+VbSlK4Qj2eTn9H0gPcUcIoUER7KDCZTvuYs
        hxZrEGFT+2KEMgCu2D/5Enl1vS5xvJaGIvxHoYPrH8gvkssh477rF87AkQeJUojB
        Fs5kbfyITvY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BB11329F5C;
        Mon,  6 Jan 2020 15:45:29 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 160E629F5B;
        Mon,  6 Jan 2020 15:45:29 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Hans Jerry Illikainen <hji@dyntopia.com>, git@vger.kernel.org
Subject: Re: [PATCH 1/1] commit: make the sign-off trailer configurable
References: <20200105174127.9278-1-hji@dyntopia.com>
        <20200105174127.9278-2-hji@dyntopia.com>
        <71a718a7-2be7-391c-dc8f-0626a0a21aac@gmail.com>
        <xmqqtv58a5m2.fsf@gitster-ct.c.googlers.com>
        <cfa40ca5-98a1-fc9c-9ccc-f14b81119e60@gmail.com>
        <xmqqpnfw8gyn.fsf@gitster-ct.c.googlers.com>
Date:   Mon, 06 Jan 2020 12:45:27 -0800
In-Reply-To: <xmqqpnfw8gyn.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Mon, 06 Jan 2020 12:31:28 -0800")
Message-ID: <xmqqeewc8gbc.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 795D380A-30C5-11EA-9D16-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> ++
> +As it makes it harder to argue against one who tells the court "that
> +log message ends with a SoB by person X but it is very plausible
> +that it was done by inertia without person X really intending to
> +certify what DCO says, and the SoB is meaningless." to more

s/to more/to have more/; otherwise the sentence does not make any
sense.  Sorry about the noise.

> +publicized ways to add SoB automatically, Git does not (and will not)
> +have a configuration variable to enable it by default.
>  
>  -n::
>  --no-verify::
