Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F063C4361B
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 22:16:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27B76238A0
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 22:16:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388632AbgLIWQJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Dec 2020 17:16:09 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59430 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388265AbgLIWQI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Dec 2020 17:16:08 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DF6439EE6F;
        Wed,  9 Dec 2020 17:15:26 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=YuHgwuEZ2kKLI8Tkz8i6bunZd1M=; b=RGBr2H
        3Xz2Tqg2EKfRQSr/lZeX4MaWX6EzNXFzPn0rMSswEQHCh5moC2mWIMKHvEaqoTpR
        DrPMZjBx9z2gvZ18foMOJa/ruNGDIHwDvAHrhQlPEBN/gIZ4GwVAhIwf5l9W5cTJ
        lSIfzIR+FZiEiGy+Wc3h9Dp6dBf2P7jm2+5Ig=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=nbf47+Wt+E2DNS+9YM0oSpKLAOyVcRVm
        zqYqFuFgQEzbIdf9MeNcDcz4xZ5e8YGzDk/sHKcUYKiyHaa3e4Ip1hNJvzkj1Lqc
        pk3Fivvkkl4qkSVsvCoy5PQQVK4ybxfF2yiHTFwbzjV2+v/0df0evMj+HjJwKW+R
        /6S66t3nKHk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D67869EE6E;
        Wed,  9 Dec 2020 17:15:26 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5A6049EE6D;
        Wed,  9 Dec 2020 17:15:26 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v2 4/4] init: provide useful advice about
 init.defaultBranch
References: <pull.921.git.git.1606087406.gitgitgadget@gmail.com>
        <pull.921.v2.git.git.1606173607.gitgitgadget@gmail.com>
        <bccef953913da629057b3e9b211bc54081fa4475.1606173607.git.gitgitgadget@gmail.com>
        <xmqq8sarljfn.fsf@gitster.c.googlers.com>
        <nycvar.QRO.7.76.6.2011240648160.56@tvgsbejvaqbjf.bet>
        <xmqq8saqjx2n.fsf@gitster.c.googlers.com>
        <nycvar.QRO.7.76.6.2012091513540.25979@tvgsbejvaqbjf.bet>
Date:   Wed, 09 Dec 2020 14:15:25 -0800
In-Reply-To: <nycvar.QRO.7.76.6.2012091513540.25979@tvgsbejvaqbjf.bet>
        (Johannes Schindelin's message of "Wed, 9 Dec 2020 15:47:05 +0100
        (CET)")
Message-ID: <xmqqblf21v9e.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0A048650-3A6C-11EB-B2E2-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Tue, 24 Nov 2020, Junio C Hamano wrote:
>
>> I am not saying it is a legitimate need.  I just wanted to make it
>> clear that we deliberately chose not to grant that wish in the
>> message.  An advice flag in this context means that the users can
>> choose to let their distro and sysadm to flip the default silently,
>> which is much worse than having to see the message every time they
>> start a new repository with "git init".
>
> The distribution already can add patches, so this objection is a red
> herring. The sysadm can pick a different value for `init.defaultBranch`
> and dictate to the user silently what initial branch name to use, so that
> is also a red herring.

The "setting init.defaultBranch is the only way to squelch" approach
means the ~/.gitconfig will have the settings soon after the user
starts using Git and /etc/gitconfig will not allow administrators to
force their will over what the user decides to use.  Distros adding
patches to strip configurability by setting init.defaultBranch in
user's ~/.gitconfig?  Is that the kind of possibilities worth
discussing?

So, no, your counter-argument above is nothing but a red-herring.

If you want a counter-argument, please explain why "I am fine to see
the default flipped to whatever the tool picks and having no control
over when the flipping happens" can be a sensible choice for users
with what kind of workflows.  The only folks I can think of who
would be fine with that are (1) those who do not create the second
branch in the repository and will stay on the primary branch
forever, and (2) those who immediately rename the branch to what
they want after "git init".  For other folks, such a choice is a
disaster waiting to happen, and it just feels irresponsible to offer
such a choice, at least to me.

Thanks.
