Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A177C433F5
	for <git@archiver.kernel.org>; Sun, 20 Feb 2022 20:16:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244496AbiBTUQo (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Feb 2022 15:16:44 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238792AbiBTUQn (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Feb 2022 15:16:43 -0500
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A8E34C43F
        for <git@vger.kernel.org>; Sun, 20 Feb 2022 12:16:22 -0800 (PST)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id AF0431799CA;
        Sun, 20 Feb 2022 15:16:21 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=8wymC2HFSWLs4eDiAztwVKX6Au9vM+v28i0EYU
        4o/so=; b=MRWn3hOfWG9cMRoZJ6+8MyMDnh/ZgoSbkrqfQhItVXtx31ZxSm6n2U
        xoMFLa1Mxf2B6pqq6dDvksAnKhmXe+f/4Ii8ioN0dCYuI5zDf07Pss/Vz6AYDJfY
        frVKnEg9jdU0n9Y2kkqx8VYJz6ydeVWwGsLEyI0u0C3CnifcyVwHU=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A62D81799C9;
        Sun, 20 Feb 2022 15:16:21 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 0749D1799C8;
        Sun, 20 Feb 2022 15:16:19 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>, jabolopes@google.com,
        Jeff Hostetler <jeffhostetler@github.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH] Provide config option to expect files outside sparse
 patterns
References: <pull.1153.git.1645333542011.gitgitgadget@gmail.com>
        <54a0aa74-57c2-ee65-ae07-cb1b0daf947f@github.com>
Date:   Sun, 20 Feb 2022 12:16:18 -0800
In-Reply-To: <54a0aa74-57c2-ee65-ae07-cb1b0daf947f@github.com> (Derrick
        Stolee's message of "Sun, 20 Feb 2022 14:41:55 -0500")
Message-ID: <xmqqsfsduwdp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F6CD0B44-9289-11EC-A781-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <derrickstolee@github.com> writes:

> This patch looks like a good solution to the concerns brought up by
> Jonathan N. around vfsd. VFS for Git uses the microsoft/git fork with
> its own custom config to protect things like this. I imagine that we
> will start setting your core_expect_files_outside_sparse_patterns
> variable when reading the virtual filesystem info. We might even modify
> some of our custom checks to use this variable instead. That would make
> them appropriate to send upstream.
>
> Should we update Documentation/config/core.txt describing this config
> key? Or is this intended to be an internal detail only for something
> like vfsd?
>
> The only concern here really is if we want to be picky about the "VFS
> for Git" references instead of "vfsd" references in the commit message.

Thanks for a quick response to make sure what our left hand is
trying to do will not interfere with what our right hand has already
been doing ;-)

