Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEB5AC0015E
	for <git@archiver.kernel.org>; Mon,  7 Aug 2023 01:13:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230287AbjHGBNv (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 6 Aug 2023 21:13:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjHGBNu (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 Aug 2023 21:13:50 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C37B170E
        for <git@vger.kernel.org>; Sun,  6 Aug 2023 18:13:49 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D812819F02E;
        Sun,  6 Aug 2023 21:13:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=sYNp8T2He+OED3SQwDaciXZm13AzbL5b7GDdk/eMv1g=; b=o8mp
        pW3X+Vu5ZBwfCJh5kdN0xJIayFNXNAehrBxYWvMq6UO551LoBEk47XKkpXvlnZHY
        XBxro8/U2Vxo4VvFZJWiYD9xSXC6UzkFHK1b6NENlGIUP3Hqm4Wf84Ilh3Mx0ieZ
        B68nd4jUp8zk5dUutiFxP3XVdrNcUKEcfFPs0Is=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D084119F02D;
        Sun,  6 Aug 2023 21:13:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.168.215.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4C1FD19F02C;
        Sun,  6 Aug 2023 21:13:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Linus Arver <linusa@google.com>
Subject: Re: [PATCH 3/5] trailer: add tests to check defaulting behavior
 with --no-* flags
References: <pull.1564.git.1691210737.gitgitgadget@gmail.com>
        <6b427b4b1e82b1f01640f1f49fe8d1c2fd02111e.1691210737.git.gitgitgadget@gmail.com>
Date:   Sun, 06 Aug 2023 18:13:47 -0700
Message-ID: <xmqqjzu7irhw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A99022B0-34BF-11EE-A228-C65BE52EC81B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Linus Arver via GitGitGadget" <gitgitgadget@gmail.com> writes:

> @@ -114,8 +114,10 @@ OPTIONS
>  	Specify where all new trailers will be added.  A setting
>  	provided with '--where' overrides all configuration variables

Obviously this is not a new issue, but "all configuration variables"
is misleading (the same comment applies to the description of the
"--[no-]if-exists" and the "--[no-]if-missing" options).

If I am reading the code correctly, --where=value overrides the
trailer.where variable and nothing else, and --no-where stops the
overriding of the trailer.where variable.  Ditto for the other two
with their relevant configuration variables.

