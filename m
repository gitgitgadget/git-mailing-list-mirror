Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34831C433F5
	for <git@archiver.kernel.org>; Mon, 10 Oct 2022 20:56:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231156AbiJJU4R (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Oct 2022 16:56:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230474AbiJJU4E (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Oct 2022 16:56:04 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E26055BC29
        for <git@vger.kernel.org>; Mon, 10 Oct 2022 13:55:55 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7B4CA1BF6E8;
        Mon, 10 Oct 2022 16:55:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=WRYr1Yj32ycELcgtx1zemzLcxFKtyQKIdqNDi5
        9b7xA=; b=oUHK2XrF6/8CKjqNmzATC2btO4mw2dIKiV2AY23KGt7TRwS5MhHVz6
        pho9dfmBHHhy7rdj7k/eIiSWtsI4l8sE0ztFwhQVAJsHEN0RY9XtkrOON8vZlYhY
        6QX2M44/wjdSmH4xX8tjjWDpdZSwHdcRUt9x57izFLitiOHGASe4I=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 746F81BF6E7;
        Mon, 10 Oct 2022 16:55:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id AEA6D1BF6E6;
        Mon, 10 Oct 2022 16:55:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Oscar Dominguez via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Oscar Dominguez <dominguez.celada@gmail.com>
Subject: Re: [PATCH 1/2] ci(main): upgrade actions/checkout to v3
References: <pull.1354.git.git.1665388136.gitgitgadget@gmail.com>
        <2dbb779f7fde175a8acd8e9de7c81db32fdf3e81.1665388136.git.gitgitgadget@gmail.com>
Date:   Mon, 10 Oct 2022 13:55:51 -0700
In-Reply-To: <2dbb779f7fde175a8acd8e9de7c81db32fdf3e81.1665388136.git.gitgitgadget@gmail.com>
        (Oscar Dominguez via GitGitGadget's message of "Mon, 10 Oct 2022
        07:48:55 +0000")
Message-ID: <xmqqtu4b1jqg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: ED76E17C-48DD-11ED-A847-B31D44D1D7AA-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Oscar Dominguez via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Oscar Dominguez <dominguez.celada@gmail.com>
>
> to be up to date with actions/checkout opens the door to use the latest
> features if necessary and get the latest security patches.
>
> Signed-off-by: Oscar Dominguez Celada <dominguez.celada@gmail.com>
> ---
>  .github/workflows/main.yml | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)

Hmph.  When 0dc787a9 (ci: accelerate the checkout, 2021-07-04)
updated us from actions/checkout@v1 to actions/checkout@v2 it listed
a lot more concrete "what we gain by doing this change", than the
hand-wavy "opens the door" argument.

And it left container jobs at @v1 with an explanation that @v2
seemed to be incompatible.  If the issue has that been resolved in
@v3, it would be necessary to say that the issue has been resolved
and it is safe to use @v3 there in the proposed log message.

> diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
> index 831f4df56c5..8dc9d938159 100644
> --- a/.github/workflows/main.yml
> +++ b/.github/workflows/main.yml
> ...
> @@ -291,7 +291,7 @@ jobs:
>      runs-on: ubuntu-latest
>      container: ${{matrix.vector.image}}
>      steps:
> -    - uses: actions/checkout@v1
> +    - uses: actions/checkout@v3
>      - run: ci/install-docker-dependencies.sh
>      - run: ci/run-build-and-tests.sh
>      - name: print test failures
