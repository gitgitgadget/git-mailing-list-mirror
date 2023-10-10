Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E1ECCD68E2
	for <git@archiver.kernel.org>; Tue, 10 Oct 2023 00:59:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379370AbjJJA7z (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Oct 2023 20:59:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379367AbjJJA7y (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Oct 2023 20:59:54 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4348A6
        for <git@vger.kernel.org>; Mon,  9 Oct 2023 17:59:52 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1AE731BDA61;
        Mon,  9 Oct 2023 20:59:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=dWIR2kSFInkbREzF2rSkiVvtIumkhrRW2NcJtw
        GwqVk=; b=OR4nVAfHzMCOtDrcO69EdLCKPKhAv2Wmb2JFdbSJ2bal7vgzpwRlMb
        5LQbDx2m65uTDBJYdHRvhSS8OJ9ACZcxUOfIQgfKsO7Q6x0Xgw9qyR61T/jbpgTm
        PgM9L3E3AGvcSqAHIsHgLiQPbjHD4tHEF59YZcEuTQZpjscvIQ9eo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 130AA1BDA60;
        Mon,  9 Oct 2023 20:59:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 76B401BDA5F;
        Mon,  9 Oct 2023 20:59:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Hugo Sales <hugo@hsal.es>
Cc:     git@vger.kernel.org, Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
Subject: Re: [PATCH 0/3] Add `-p' option to `git-mv', inspired by `mkdir'
In-Reply-To: <xmqq1qe3wbt1.fsf@gitster.g> (Junio C. Hamano's message of "Mon,
        09 Oct 2023 17:39:22 -0700")
References: <20231009233458.1371351-1-hugo@hsal.es>
        <xmqq1qe3wbt1.fsf@gitster.g>
Date:   Mon, 09 Oct 2023 17:59:50 -0700
Message-ID: <xmqqttqzuwah.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5137BDBE-6708-11EE-A077-78DCEB2EC81B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Regardless of the "do we require, or is it sifficient to imply, the
> '-p' option when we lack leading directories?" question, once we
> start "auto-creating" the leading directory hierarchy, one worrysome
> thing such a new feature introduces is an ambiguity and unexpected
> behaviour. ...
> Both are plausible, and "mkdir -p" does not have such a nasty
> ambiguity.  That is what makes me unsure about the new feature
> (again, either with required "-p" or with implied "-p").

I checked what POSIX, who does give "-p" to mkdir(1), has with
mv(1), and they do not have "-p".  Neither GNU, which tends to add
such "usability" enhancements on top of what everybody else has.

And I think they are being very sensible.  By not adding such an
option to "mv", they can sidestep the unnecessary ambiguity, and it
isn't too bad to do a "mkdir -p" separately before doing such a "mv"
into a (potential) new directory.

So, let's not do this patch.

Thanks.

