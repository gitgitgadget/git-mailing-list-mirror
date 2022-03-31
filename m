Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E42D7C433FE
	for <git@archiver.kernel.org>; Thu, 31 Mar 2022 19:33:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234739AbiCaTfo (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 31 Mar 2022 15:35:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234713AbiCaTfn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Mar 2022 15:35:43 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C76305FF2D
        for <git@vger.kernel.org>; Thu, 31 Mar 2022 12:33:55 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 66C58186174;
        Thu, 31 Mar 2022 15:33:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=8nYjiSIBzMQRGrsDw0Ce3om+5aaK0WvcZGiBOA
        Do3dI=; b=Fm13C576Q6lRGSbM2UlrH1ZfL0tCh++3LMT7gOkyK7uL5wemhoUL6f
        JqnURchupy8TfyFbil449TFcWJTNkLLSU4CDdVt7apmUHOfYdSJuwWKB2GmAOzwJ
        SakgqZG3kNZTqivw87MaXQlnKTmVgpynGnMXnUcgWWqFheivuZD+4=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5EECC186173;
        Thu, 31 Mar 2022 15:33:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.227.145.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id AF046186172;
        Thu, 31 Mar 2022 15:33:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Tao Klerks via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Tao Klerks <tao@klerks.biz>, Glen Choo <chooglen@google.com>
Subject: Re: [PATCH v6] tracking branches: add advice to ambiguous refspec
 error
References: <pull.1183.v5.git.1648624810866.gitgitgadget@gmail.com>
        <pull.1183.v6.git.1648742485887.gitgitgadget@gmail.com>
Date:   Thu, 31 Mar 2022 12:33:51 -0700
In-Reply-To: <pull.1183.v6.git.1648742485887.gitgitgadget@gmail.com> (Tao
        Klerks via GitGitGadget's message of "Thu, 31 Mar 2022 16:01:25
        +0000")
Message-ID: <xmqqlewp3oio.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7F30F1AE-B129-11EC-BAE8-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Tao Klerks via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Tao Klerks <tao@klerks.biz>
>
> The error "not tracking: ambiguous information for ref" is raised
> when we are evaluating what tracking information to set on a branch,
> and find that the ref to be added as tracking branch is mapped
> under multiple remotes' fetch refspecs.
>
> This can easily happen when a user copy-pastes a remote definition
> in their git config, and forgets to change the tracking path.
>
> Add advice in this situation, explicitly highlighting which remotes
> are involved and suggesting how to correct the situation.
> ...
>  Documentation/config/advice.txt |  4 +++
>  advice.c                        |  1 +
>  advice.h                        |  1 +
>  branch.c                        | 63 +++++++++++++++++++++++++++++----
>  4 files changed, 62 insertions(+), 7 deletions(-)

Can we add a test case for the new "advice" output?

Thanks.
