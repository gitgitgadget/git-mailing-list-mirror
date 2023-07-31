Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3B8BC41513
	for <git@archiver.kernel.org>; Mon, 31 Jul 2023 15:58:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233002AbjGaP6m (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 Jul 2023 11:58:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233000AbjGaP6c (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Jul 2023 11:58:32 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B0A01708
        for <git@vger.kernel.org>; Mon, 31 Jul 2023 08:58:31 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7A66C1A47A6;
        Mon, 31 Jul 2023 11:58:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=kx9o9C4uB5SSigJGLyOe/8V7Y0LFJpQOjot59w
        8sgoE=; b=piT7lZknQTmvV/hcc3fF6AipzeXq6YbD7TwljjzneM73rWloND2Uo1
        5WYf4vgwF1xgiq6EPbEiKeEoBA9w1I+QBe/YTQ37g+Y3A2cEa4HGh5BapSAerQsb
        rfC5jiTFrlh+r66hfdvh3DCbHSkEfpCHjO+BcsIit/IvRObWcLuTo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 677291A47A5;
        Mon, 31 Jul 2023 11:58:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.168.215.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id CEF0D1A47A4;
        Mon, 31 Jul 2023 11:58:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Wong <e@80x24.org>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/3] sha256/gcrypt fixes
References: <20230731120808.1230210-1-e@80x24.org>
Date:   Mon, 31 Jul 2023 08:58:28 -0700
In-Reply-To: <20230731120808.1230210-1-e@80x24.org> (Eric Wong's message of
        "Mon, 31 Jul 2023 12:08:05 +0000")
Message-ID: <xmqqy1iwyswr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 17BBA1CE-2FBB-11EE-8B36-307A8E0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Wong <e@80x24.org> writes:

> I noticed problems requiring patches 2 and 3 while eyeballing
> the code, but had to come up with the first one to fix
> SANITIZE=leak, first.

Thanks.

>
> Eric Wong (3):
>   sha256/gcrypt: fix build with SANITIZE=leak
>   sha256/gcrypt: fix memory leak with SHA-256 repos
>   sha256/gcrypt: die on gcry_md_open failures
>
>  sha256/gcrypt.h | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
