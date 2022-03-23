Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 360FEC433F5
	for <git@archiver.kernel.org>; Wed, 23 Mar 2022 20:54:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344843AbiCWU4W (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Mar 2022 16:56:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344842AbiCWU4T (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Mar 2022 16:56:19 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 807B28BF15
        for <git@vger.kernel.org>; Wed, 23 Mar 2022 13:54:49 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E425617AFD7;
        Wed, 23 Mar 2022 16:54:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=A7x9kVHeKAibAPtnz/+dVqDdydvwQSuJvXJPK8
        Emt00=; b=jwg+wb/famP7XucaMxqY48W8mHhgwbBynNGH/VEY7IIPVKhPlWLRbS
        3K3vfNkF20bIntjxrKZ84UhcvaC+9ubmCPHgJ/aYRiEJSs9MaKWXPLVevTQ+rMt0
        +XsHunx+WN454PbKLAQ1K7NEJqFuTINkwErdOqJgJX/9/g63UGOCc=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id DD10117AFD6;
        Wed, 23 Mar 2022 16:54:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.227.145.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 4F29517AFCF;
        Wed, 23 Mar 2022 16:54:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Victoria Dye <vdye@github.com>
Cc:     Josh Steadmon <steadmon@google.com>, git@vger.kernel.org,
        lessleydennington@gmail.com
Subject: Re: [RFC PATCH] repo-settings: set defaults even when not in a repo
References: <1b27e0b115f858a422e0a2891688227be8f3db01.1648055915.git.steadmon@google.com>
        <fcfdcbb9-761a-0d34-7d36-61e0ef279922@github.com>
Date:   Wed, 23 Mar 2022 13:54:45 -0700
In-Reply-To: <fcfdcbb9-761a-0d34-7d36-61e0ef279922@github.com> (Victoria Dye's
        message of "Wed, 23 Mar 2022 13:11:10 -0700")
Message-ID: <xmqqpmmcqtii.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 78DCAD96-AAEB-11EC-9594-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Victoria Dye <vdye@github.com> writes:

> I think the decision of whether to go with this approach or the alternative
> listed below depends on the validity of a 'repository' without a gitdir. 
>
> As far as I can tell, there is an implicit conflict between the changes in:
>
> 1. b66d84756f (commit-graph: respect 'commitGraph.readChangedPaths',
>    2020-09-09)
> 2. 44c7e62e51 (repo-settings: prepare_repo_settings only in git repos,
>    2021-12-06) (as you pointed out in your message)
>
> The former says that commit-graph should use a repository setting (implying
> it needs a valid repository), and the latter says that you need a valid
> gitdir to get repository settings.
>
> So to me, how to proceed depends on whether a repository can be "valid"
> without a gitdir or not:

Sorry, I do not get it.  What does "a repository without a git dir"
look like?  It does not make any sense to me.  A repository without
working tree, I can understand.
