Return-Path: <SRS0=ys1m=5K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 639D0C43331
	for <git@archiver.kernel.org>; Wed, 25 Mar 2020 21:24:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1037D20719
	for <git@archiver.kernel.org>; Wed, 25 Mar 2020 21:24:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="QfD0sHeU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727376AbgCYVYk (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Mar 2020 17:24:40 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50007 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727351AbgCYVYj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Mar 2020 17:24:39 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6B78A42D11;
        Wed, 25 Mar 2020 17:24:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=981gvDO6T7blbqmVPa9rjIm7ogU=; b=QfD0sH
        eU+N+K16KNlwlX7B6O3Za55/8fOX0oI4kI/WCo6Jv3nMuur4VaBs6Mb3NE7nJyj0
        cXsjfxniZuiYSqDCAFciPbAhOagR59OYHA2/15WCOnPNpVjkpAWrAkIAaQFRfJRp
        wTbdfyR+qzVkjhnb7rZU1eIV6PoS0mtgzsEFo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=t9Wbh6WwT03TO0czo7KKZpLSiwaN5Gx4
        8HnMf6LJ5N1ur/ze4W7sUUljG/CtAt0iuY5pajabGd/gnfIrJHtsE53qah7DfKUG
        6C6bNANiF75dnHiNc24JQuI6jq4DBq1z5BuK3e8vg/pL8g7PrmwlgYJg3hHSJbGL
        bv0/UPq7rOM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6304C42D10;
        Wed, 25 Mar 2020 17:24:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id DB4EF42D0F;
        Wed, 25 Mar 2020 17:24:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Wong <e@80x24.org>
Cc:     Lukas Pupka-Lipinski <lukas.pupkalipinski@lpl-mind.de>,
        git@vger.kernel.org, pjwhams@gmail.com
Subject: Re: [PATCH] added: Multi line support for ignore-paths configuration
References: <e5c78a24-e17f-c1bb-4ea7-3ddaa45abcf0@lpl-mind.de>
        <20200325203823.GA21913@dcvr>
Date:   Wed, 25 Mar 2020 14:24:37 -0700
In-Reply-To: <20200325203823.GA21913@dcvr> (Eric Wong's message of "Wed, 25
        Mar 2020 20:38:23 +0000")
Message-ID: <xmqqd090w2ju.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 07FEEC5A-6EDF-11EA-8AB5-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Wong <e@80x24.org> writes:

> Lukas Pupka-Lipinski <lukas.pupkalipinski@lpl-mind.de> wrote:
>> From 01d4e4dbc4e524db6188f41904a7274d1582d066 Mon Sep 17 00:00:00 2001
>
> Hello Lukas and welcome to git hacker community!  It looks like
> your first patch, so some details to point out, most of which
> should be covered in `Documentation/SubmittingPatches'

Thanks, Lukas and Eric for an excellent review.

 Thanks, though S-o-b generally includes the full name, so:
>
>   Signed-off-by: Lukas Pupka-Lipinski <lukas.pupkalipinski@lpl-mind.de>
>
> is more appropriate

Yes.  The author identity and the "name <addr>" on Signed-off-by
line should match.

