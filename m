Return-Path: <SRS0=nsHh=4C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD68AC2BA83
	for <git@archiver.kernel.org>; Fri, 14 Feb 2020 17:04:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A225320656
	for <git@archiver.kernel.org>; Fri, 14 Feb 2020 17:04:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="R+PmXb5B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392699AbgBNREQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Feb 2020 12:04:16 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:60732 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392487AbgBNREL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Feb 2020 12:04:11 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4E9C4C38CC;
        Fri, 14 Feb 2020 12:04:10 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Vhwn3u3uSN7q2hEfitISrJe7+HM=; b=R+PmXb
        5BBoIgWZphYFXwxlqcsbEzZIwDXgYPJzPAHDC+P/vXD/BsI41XOjQaHapPAVjXk5
        KjUZu586L3kmy4AKjzmtBjhJa/bnudLbdEx8JFYGpvnZMitl5R/R/fRm8YW6I9xZ
        KH4tYLj4JkN+xAFTxFyB31mSdaNtojDSGVQiA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=m0SP59ahwwksMQfV1qNGHRlPiKlVIdRG
        kPfrziRTOvl8Quf8tktdX3OYZxoBPixZv5asZ9f8AKYbLoXO5m7xUdN9gPcW+92R
        3jxPsRfDdeQ+EiZoFRcN5CJLyGwMXdLJgKSatQJ4yqHjXelkY7nlBr+jXwZexZ6W
        79+NNg0Jc0c=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 479C2C38CB;
        Fri, 14 Feb 2020 12:04:10 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 69704C38CA;
        Fri, 14 Feb 2020 12:04:07 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v7 14/15] bugreport: list contents of $OBJDIR/info
References: <20200214015343.201946-1-emilyshaffer@google.com>
        <20200214015343.201946-15-emilyshaffer@google.com>
Date:   Fri, 14 Feb 2020 09:04:05 -0800
In-Reply-To: <20200214015343.201946-15-emilyshaffer@google.com> (Emily
        Shaffer's message of "Thu, 13 Feb 2020 17:53:42 -0800")
Message-ID: <xmqq4kvtp0ca.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 02FCEB24-4F4C-11EA-9D43-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> writes:

> Miscellaneous information used about the object store can end up in
> .git/objects/info; this can help us understand what may be going on with
> the object store when the user is reporting a bug. Otherwise, it could
> be difficult to track down what is going wrong with an object which
> isn't kept locally to .git/objects/ or .git/objects/pack. Having some
> understanding of where the user's objects may be kept can save us some
> hops during the bug reporting process.

This step seems to have a new whitespace breakage that did not exist
in the previous round.
