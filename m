Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7858C433EF
	for <git@archiver.kernel.org>; Fri, 25 Mar 2022 00:33:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244454AbiCYAeq (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Mar 2022 20:34:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236404AbiCYAeo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Mar 2022 20:34:44 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3D66D7B
        for <git@vger.kernel.org>; Thu, 24 Mar 2022 17:33:09 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 441D81892D9;
        Thu, 24 Mar 2022 20:33:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=xUHI7bcq7gBmggoRbzLloZAL3L6X/hzhLzzQHigFbnM=; b=Q/e9
        kBaX5NCGLIouphUCEjZLgmCGtmBm9LXYbHf2HvMHrET63hQSSwmXVlSPtG8xZja9
        ZvDQH5qWH8+/ZmGR1as8AViNZsY1/yNtnU5P50iXHY+yaUukfzi6giz61n24EfIm
        ygRtLJsFOMSpvtI0+4H9ZxR6YkD37z4GWnPDcEA=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 3D4B81892D7;
        Thu, 24 Mar 2022 20:33:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.227.145.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id A3C531892D6;
        Thu, 24 Mar 2022 20:33:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH] test-lib-functions: fix test_subcommand_inexact
References: <xmqqmthgu3e6.fsf@gitster.g>
        <20220324181056.53824-1-chakrabortyabhradeep79@gmail.com>
Date:   Thu, 24 Mar 2022 17:33:05 -0700
Message-ID: <xmqqy20yeuri.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 23B09902-ABD3-11EC-B6B6-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com> writes:

> Inexact means that the line needs not to be exactly same - there may be
> some words in between the desired words (in this case, any flags that come
> between the desired sub-commands). The current behaviour (i.e. 
> `local expr=$(printf '"%s".*' "$@")`) is justifying the name of the function.

The current name may justify what it does, but so does "declare
match randomly" would.  How much fuzziness we tolerate is something
that must be made clear to help developers who may potentially want
to use it, and the phrase "inexact" alone would not help us.

