Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FF6CCD54BF
	for <git@archiver.kernel.org>; Mon, 25 Sep 2023 19:14:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233045AbjIYTON (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Sep 2023 15:14:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231730AbjIYTOL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Sep 2023 15:14:11 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69A48B8
        for <git@vger.kernel.org>; Mon, 25 Sep 2023 12:14:05 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 14287220FF;
        Mon, 25 Sep 2023 15:14:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=vJHRNKr+eMOdeYasrd/aEldkBuOOJH6t59xoAo
        bAhm0=; b=NLNJNtGAVoNl452uvdre9nVb8IHzuKeprvCXyEV+ZhX3KUeuZ+L+2n
        jO5mQKn87Zg4SK+ITVElRSKhNUkQ16AzGQkQj0VMRf6FV6wzZMeIlpGVy+UyPCm6
        exONHC/5tFbVDkwMpHf4yVglQFfCCBRLvEa4SjlGk04aJhi/VZ1Jw=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0C0DC220FE;
        Mon, 25 Sep 2023 15:14:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id B422B220FC;
        Mon, 25 Sep 2023 15:14:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, John Cai <johncai86@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <stolee@gmail.com>,
        Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v7 0/9] Repack objects into separate packfiles based on
 a filter
In-Reply-To: <20230925152517.803579-1-christian.couder@gmail.com> (Christian
        Couder's message of "Mon, 25 Sep 2023 17:25:08 +0200")
References: <20230911150618.129737-1-christian.couder@gmail.com>
        <20230925152517.803579-1-christian.couder@gmail.com>
Date:   Mon, 25 Sep 2023 12:14:00 -0700
Message-ID: <xmqqy1gurrpj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AF9E4EFE-5BD7-11EE-AFB9-A19503B9AAD1-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

> # Changes since version 6
>
> Thanks to Junio who reviewed or commented on versions 1, 2, 3, 4 and
> 5, and to Taylor who reviewed or commented on version 1, 3, 4, 5 and
> 6!  Thanks also to Robert Coup who participated in the discussions
> related to version 2 and Peff who participated in the discussions
> related to version 4. There are only the following changes since
> version 6:
>
> - This series has been rebased on top of bcb6cae296 (The twelfth
>   batch, 2023-09-22) to fix conflicts with a `builtin/repack.c`
>   refactoring patch series called tb/repack-existing-packs-cleanup by
>   Taylor Blau that recently graduated to 'master':
>
> 	https://lore.kernel.org/git/cover.1694632644.git.me@ttaylorr.com/
> 	https://lore.kernel.org/git/xmqqil81wqkx.fsf@gitster.g/
>
> - Patch 6/9 (repack: add `--filter=<filter-spec>` option) has been
>   reworked to apply on top of the above mentioned patch series.
>   Taylor even posted the fixup patch to apply to this series so that
>   it works well on top of his series:
>   
>     https://lore.kernel.org/git/ZQNKkn0YYLUyN5Ih@nand.local/

Thanks, both, for working well together.

Will replace and merge to 'seen'.  Let's see others supporting the
change to chime in, and get it merged to 'next' soonish.  I gave a
quick cursory look and changes to rebuild on the "existing packs
cleanup" topic all looked sensible.


