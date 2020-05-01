Return-Path: <SRS0=YBbL=6P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FCC0C47254
	for <git@archiver.kernel.org>; Fri,  1 May 2020 20:56:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4BA62208DB
	for <git@archiver.kernel.org>; Fri,  1 May 2020 20:56:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="BVKEwiyQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726635AbgEAU4F (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 May 2020 16:56:05 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:55902 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726045AbgEAU4D (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 May 2020 16:56:03 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 34E7CC4888;
        Fri,  1 May 2020 16:56:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=PLQWQfBBUDG0z1op0YYww+BSN8k=; b=BVKEwi
        yQz8AQ778bzFSfTy8PHZiP8J1XbXk2pvyGyo1oBUVh34yv68H0PLUHkPlZSjd2N4
        0Qy3mLBwym4d//J4akFxu3xnaVpAXsryheMMyUKx3FhPQ7mtnMm+qgPBCLI32YpQ
        QAzPsQcavGDGpPAfcHDOSSqYq/EsuqRh3tkXs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=UvZIAGIhMRcR4CERuJkwj3Ga1Vn+mj4k
        PtthU8nf9vUlm2vE+vtp+Z4hFVX4y9pCAFjJNmSmtxUW6D/ucFOTCogNOdeLMV53
        vSPfRo1TA9GETlbihAAhkO0TJevBi0eUQkFzJsXVi+KIKofgyED/EEglrbyinylz
        02J6yPhrMdE=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2D165C4887;
        Fri,  1 May 2020 16:56:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 6C6FDC4885;
        Fri,  1 May 2020 16:55:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Apr 2020, #04; Thu, 30)
References: <xmqqmu6spocm.fsf@gitster.c.googlers.com>
        <20200501202411.GA41612@syl.local>
Date:   Fri, 01 May 2020 13:55:56 -0700
In-Reply-To: <20200501202411.GA41612@syl.local> (Taylor Blau's message of
        "Fri, 1 May 2020 14:24:11 -0600")
Message-ID: <xmqqh7wzl6hv.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 28678C00-8BEE-11EA-8970-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> Thanks for an update. Here are some new topics that I have been tracking
> as well:

Thanks.  I think we are more or less on the same page.

> The only topics that I've been tracking that aren't here are still going
> through some review. Those are:
>
>   * Sibi's patches to start building with CMake [1].

I trust this one is in good hands, targetting somewhere in contrib/
and with a clarified objective of helping VS builds.

>   * The fifth part of Denton's patches to replace 'test_must_fail'
>     usage with another approach [2].

Yes, the earlier parts of it is clear but the last step needs a bit
clear explanation.

>   * Dogulas Fuller's patches to update a quoting issue in documentation
>     [3].

I think we are moving to "This is how these look in .git/config
file" approach.
