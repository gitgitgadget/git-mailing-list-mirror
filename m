Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88E87C4332F
	for <git@archiver.kernel.org>; Fri, 14 Oct 2022 15:37:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230480AbiJNPh5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Oct 2022 11:37:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230504AbiJNPhx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Oct 2022 11:37:53 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96BD71793BA
        for <git@vger.kernel.org>; Fri, 14 Oct 2022 08:37:51 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D7F961C0EC6;
        Fri, 14 Oct 2022 11:37:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=hqzD9CeBB2n1eB/5UT51EfKnnRJaLlIVk4J/LM
        E352k=; b=c8eHxgS3+Ao0JtTZ186vEfgjieW0OFztEAttunIxktO0uqwmr6+PmY
        t++eeSKOoGFIoyjxJv3FB5UN74Zj9/ntsLnQsa6w32pOQh8Yf2ZxmStZJldXexUf
        pe/0iXJU3A+LAW/n9n8eNUYcU4IvbfkZCHGcZ46h5ECfS9tor2RlU=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id CF58D1C0EC5;
        Fri, 14 Oct 2022 11:37:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 8A6821C0EC4;
        Fri, 14 Oct 2022 11:37:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Tao Klerks <tao@klerks.biz>
Cc:     Tao Klerks via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] mergetool: new config guiDefault supports auto-toggling
 gui by DISPLAY
References: <pull.1381.git.1665590389045.gitgitgadget@gmail.com>
        <xmqqedvbcrnn.fsf@gitster.g>
        <CAPMMpoigKVzhXu1WqSrx13MP1jR0J+ajkwRVVtY_LwHYAoWeTg@mail.gmail.com>
        <xmqqsfjqbwil.fsf@gitster.g>
        <CAPMMpoiwnLyqzBBubkgSpjyJQqSeEVdoZy72FAwGDbMgg9UXxg@mail.gmail.com>
Date:   Fri, 14 Oct 2022 08:37:46 -0700
In-Reply-To: <CAPMMpoiwnLyqzBBubkgSpjyJQqSeEVdoZy72FAwGDbMgg9UXxg@mail.gmail.com>
        (Tao Klerks's message of "Fri, 14 Oct 2022 14:32:47 +0200")
Message-ID: <xmqqilkmbelx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 277AF7B4-4BD6-11ED-BCB1-B31D44D1D7AA-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Tao Klerks <tao@klerks.biz> writes:

> My understanding, from ad-hoc testing, is that using OPT_BOOL causes
> the target variable ("use_gui_tool" in this case) to *always* be set
> to either "1" or "0", regardless of whether the user sets the main
> flag, the --no form of the flag, or sets nothing at all.

You are saying "git gc --keep-largest-pack" is broken ;-)

OPT_BOOL() and OPT_BOOL_F() are OPT_SET_INT() in disguise and there
is no "set to this default value if no command line option is given"
involved.  At least I do not recall allowing such a code in.

Thanks.
