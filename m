Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6B91C433F5
	for <git@archiver.kernel.org>; Sat, 12 Mar 2022 23:50:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233039AbiCLXvy (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 12 Mar 2022 18:51:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231147AbiCLXvx (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 Mar 2022 18:51:53 -0500
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D9436FA01
        for <git@vger.kernel.org>; Sat, 12 Mar 2022 15:50:46 -0800 (PST)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8625A115B83;
        Sat, 12 Mar 2022 18:50:43 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=6pdoKoA6aHQAfVSvALr3w2RX1Bpa/T8uWKSxr9
        RoTWU=; b=scrD8FWLHW83wXGCDxljTYnqJSHLCL+lGf1sEtS59sDT/yHLkBo30H
        uKcstexTBPRYCQzfvjw2nGknvVODnZE4VBDBOzRhgUBjg3DLFfNXVw/liD/YwQy2
        ytqxMsoFxR8Sd87Ggy3Qc5OSl46rVefc2MvwNy3AQsISpPFjWi3uQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7EFE7115B82;
        Sat, 12 Mar 2022 18:50:43 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.195.168.105])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id DF028115B80;
        Sat, 12 Mar 2022 18:50:42 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     <rsbecker@nexbridge.com>
Cc:     "'Sean MacLennan'" <seanm@seanm.ca>, <git@vger.kernel.org>
Subject: Re: Request: a way to ignore .gitattributes
References: <20220312130712.6d9d2d00@zonker.seanm.ca>
        <01ab01d83656$071d7cd0$15587670$@nexbridge.com>
Date:   Sat, 12 Mar 2022 15:50:40 -0800
In-Reply-To: <01ab01d83656$071d7cd0$15587670$@nexbridge.com>
        (rsbecker@nexbridge.com's message of "Sat, 12 Mar 2022 16:13:26
        -0500")
Message-ID: <xmqq8rten31r.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3A893BD4-A25F-11EC-B5FA-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

<rsbecker@nexbridge.com> writes:

> These may seem a little off the wall, but:
> 1. Could you use a clean/smudge approach to mess with your bad
> .gitattributes file before it gets put down on disk? I realize that
> registering the filter might not be possible given that you need to muck
> with .gitattributes to do it, but if you have any control at all and can get
> the filter in, perhaps that might be a way to clean up the bad
> .gitattributes file.
> 2. What about a post-checkout hook that fixes .gitattributes and then does
> an update-index --assume-unchanged on it. This is under the assumption that
> you will never change .gitattributes in your clone.

Ahh, that's cleverer than what I had initially as a knee-jerk
reaction, which was "fix the tool that emits '$path -text' for each
and every path in the repository and instead use '* -text' perhaps?".



