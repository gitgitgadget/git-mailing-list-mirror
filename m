Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC6C2C4361B
	for <git@archiver.kernel.org>; Thu, 10 Dec 2020 00:13:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F79A23609
	for <git@archiver.kernel.org>; Thu, 10 Dec 2020 00:13:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728499AbgLJANv (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Dec 2020 19:13:51 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56315 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726777AbgLJANv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Dec 2020 19:13:51 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4BC0989AA4;
        Wed,  9 Dec 2020 19:13:09 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=p67s7MnqqvBxejwBPRlCzA610BQ=; b=Gzf2tK
        0jS4jm1RaRnzM7YSu3QcsElrnsySgEYtaJ6YQ9pJQv0Of9tMbKwsZcR+pXaTjuAb
        yYIZyKnLrsyBcEB6QEkm5o/oxHnQHIRXfC+uDWgjaMzCF2CZEKKHTR/5CnlSsL0u
        BLQhC7UqblSgraICeKOYCii84vc4Cmh+w6HUU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=hjbwMeU4nIn9ryBW3luVeCXGeGW4XeWU
        Gkr+P9wkDI/uVwyRxLjtvgUWkOaOdZAse6TOXsD0piZwlWcMPIQu2R+ba1/zkl6A
        xP5MT3oAAfqMNzEP6Ppheh6uZpMnr9PKXHHkoAg6Bkj2hlXpW6/YWmQqOXzISEze
        xYqHUgOZIfc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4324389AA3;
        Wed,  9 Dec 2020 19:13:09 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id BDA8589AA2;
        Wed,  9 Dec 2020 19:13:08 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Josh Steadmon <steadmon@google.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, jrnieder@gmail.com, jonathantanmy@google.com,
        sluongng@gmail.com, congdanhqx@gmail.com,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v4 5/8] maintenance: add start/stop subcommands
References: <pull.724.v3.git.1601902635.gitgitgadget@gmail.com>
        <pull.724.v4.git.1602782524.gitgitgadget@gmail.com>
        <5194f6b1facbd14cc17eea0337c0cc397a2a51fc.1602782524.git.gitgitgadget@gmail.com>
        <20201209185114.GN36751@google.com>
        <20201209191616.GO36751@google.com>
Date:   Wed, 09 Dec 2020 16:13:08 -0800
In-Reply-To: <20201209191616.GO36751@google.com> (Josh Steadmon's message of
        "Wed, 9 Dec 2020 11:16:16 -0800")
Message-ID: <xmqqtusuzffv.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7B8ADF12-3A7C-11EB-B911-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Josh Steadmon <steadmon@google.com> writes:

>  	# start registers the repo
> -	git config --get --global maintenance.repo "$(pwd)" &&
> +	git config --get --global --fixed-value maintenance.repo "$(pwd)" &&

The rewrite makes it better than the original, but I wonder why the
original did not do a more obvious

	git config --get maintenance.repo >actual &&
	pwd >expect &&
	test_cmp expect actual

>  	# stop does not unregister the repo
> -	git config --get --global maintenance.repo "$(pwd)" &&
> +	git config --get --global --fixed-value maintenance.repo "$(pwd)" &&

Ditto.
