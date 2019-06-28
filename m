Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 20A0B1F461
	for <e@80x24.org>; Fri, 28 Jun 2019 20:50:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726631AbfF1Uuv (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Jun 2019 16:50:51 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63245 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726537AbfF1Uuu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Jun 2019 16:50:50 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7C2171560DF;
        Fri, 28 Jun 2019 16:50:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=un9h5ZxpufmVWG/4CY/1bgF4Cpg=; b=cQv2at
        6NHG76TJkK9Bie1SzR2o2Ujfb3yG6Q/D4q5Lu3sh/47sUdRRVKsoL64PhfCr0Ac/
        Q4CWKFa3iICEUAAWCY3t4mWFL4nVaoJJ+HmDFZguJOT6jnLBFqKln+WAqGWfMqad
        AwgfH5zMQ5uGbLRpWGEV7CbMBnCkXKRDV0198=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=UCuw3V8+aduLuWIkzYTh7f4GtarnpPQV
        y5vkcaD89TUZuKVuYuJc/L9T+wP43tXI23LkrHCLJqcx7/aHPgJfARbIrr7YpAlf
        UTWlgLeDybVQF253afzsyK8mRHMB7xrxCOnGf5oGrgBonvSU4bnH08VJFAo6uMDX
        iMHQhKPV5IM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 734D91560DE;
        Fri, 28 Jun 2019 16:50:48 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C43E21560DC;
        Fri, 28 Jun 2019 16:50:47 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Johannes.Schindelin@gmx.de, peff@peff.net,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v2 1/3] repo-settings: create core.featureAdoptionRate setting
References: <pull.254.git.gitgitgadget@gmail.com>
        <pull.254.v2.git.gitgitgadget@gmail.com>
        <bdaee3ea9df0533c268d6bebbd252c00cfbaccd6.1560957119.git.gitgitgadget@gmail.com>
Date:   Fri, 28 Jun 2019 13:50:46 -0700
In-Reply-To: <bdaee3ea9df0533c268d6bebbd252c00cfbaccd6.1560957119.git.gitgitgadget@gmail.com>
        (Derrick Stolee via GitGitGadget's message of "Wed, 19 Jun 2019
        08:12:00 -0700 (PDT)")
Message-ID: <xmqqd0ix8me1.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 680551EE-99E6-11E9-92FB-72EEE64BB12D-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +core.featureAdoptionRate::
> +	Set an integer value on a scale from 0 to 10 describing your
> +	desire to adopt new performance features. Defaults to 0. As
> +	the value increases, features are enabled by changing the
> +	default values of other config settings. If a config variable
> +	is specified explicitly, the explicit value will override these
> +	defaults:
> ++
> +If the value is at least 3, then the following defaults are modified.
> +These represent relatively new features that have existed for multiple
> +major releases, and present significant performance benefits. They do
> +not modify the user-facing output of porcelain commands.
> ++
> +* `core.commitGraph=true` enables reading commit-graph files.
> ++
> +* `gc.writeCommitGraph=true` eneables writing commit-graph files during
> +`git gc`.

I was re-reading the whole series, and found that the phrase
"present significant benefits" was somewhat overselling.  Wouldn't
that claim largely depend on the end-user's workflow?  The same
comment applies to the description of "at least 5" level, too.

I would not mind if we say "enabling this may present performance
benefits", with or without "significant" before "performance
benefits", and with or without ", depending how your repository is
used" at the end.

Thanks.
