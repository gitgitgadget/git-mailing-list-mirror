Return-Path: <SRS0=Hc2o=CM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB7F6C43461
	for <git@archiver.kernel.org>; Thu,  3 Sep 2020 21:49:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5301320639
	for <git@archiver.kernel.org>; Thu,  3 Sep 2020 21:49:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="oHyrwx8u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729212AbgICVtA (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Sep 2020 17:49:00 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58588 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728134AbgICVtA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Sep 2020 17:49:00 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id EC74C758F2;
        Thu,  3 Sep 2020 17:48:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=0E2FnUc1lSwazwvxVpF7ndi7TVk=; b=oHyrwx
        8u7QL3mR6DbC4obLK554QG9Q2JHWUJskBNeB80AQjKoi1sKDbAPDuSfjhVYjXWu7
        Z5oj16eqSlLmTvqXpFbL/twNAIeTkz5lvEAvLyqvGbZWpCPD10xowx+AT87jg6zd
        MTWJzpHDg6wlCZhIoc4/gjShGt7keKsh6ok2M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=X5eA4z9Nn8qpnkPMTgjYVr99v0RoVdve
        8831Q8KijtoPBZ0i5EYGztzG9fiH2K3KOwnvlPjHBv/EwBKyyieRrNIeyhhGk7qg
        FuZkpYfrKU5qZLO5trfMbQIgaZ4Nb0ne/6sOjD5EXR3+nZMxG985yxqkzUUPsZZv
        CGJ5KDYTLd4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E4B6F758F1;
        Thu,  3 Sep 2020 17:48:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7AD26758EF;
        Thu,  3 Sep 2020 17:48:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "sunlin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, sunlin <sunlin7@yahoo.com>,
        Lin Sun <lin.sun@zoom.us>
Subject: Re: [PATCH v17] Support auto-merge for meld to follow the vim-diff behavior
References: <pull.781.v16.git.git.1594544903477.gitgitgadget@gmail.com>
        <pull.781.v17.git.git.1594596738929.gitgitgadget@gmail.com>
        <xmqqv9idn2yr.fsf@gitster.c.googlers.com>
Date:   Thu, 03 Sep 2020 14:48:56 -0700
In-Reply-To: <xmqqv9idn2yr.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Thu, 23 Jul 2020 17:58:36 -0700")
Message-ID: <xmqq4koe8rav.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 44E86CB6-EE2F-11EA-A589-01D9BED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> I have queued v16 (the one with the beginning of bool-or-str) with
> minimum fixups for issues I pointed out in the review of that
> revision queued on top of it as SQUASH??? commit.  Please find it in
> the 'seen' branch.
>
> Also,
>
>     Subject: Support auto-merge for meld to follow the vim-diff behavior
>
> needs fixing.
> ...

Anything new on this topic?  No rush, but I'd hate to see a
basically good topic to be left in the stalled state too long.

Thanks.
