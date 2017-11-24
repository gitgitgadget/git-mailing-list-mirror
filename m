Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6E11420954
	for <e@80x24.org>; Fri, 24 Nov 2017 07:00:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751555AbdKXHAD (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Nov 2017 02:00:03 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52507 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751136AbdKXHAC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Nov 2017 02:00:02 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B7C94AD08F;
        Fri, 24 Nov 2017 02:00:00 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=meXo0COdV7Yhe5yds0MpiaFMUAQ=; b=AReH1Z
        4lRLgGL+kMShqLsa62dqeCiNsqX+oSESZaimrDAfliHPPK46gYwc5+uwSRdktF6t
        a2v11vy0R8rmqoU83XcTQyjvYfhvCE6ijgE6pgca12p3FLlQKZw1SmPyznKgionQ
        ndz4HtCRaJnpKFvUt4xqGzAguPjbsom9H5Kps=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=AEnN5g4M2UPS4Q0nSDWd6ujz2MnU+07R
        owjdiG2b+XQIyRkSadOvKL8RMmEeFxoLIAIkhiL4CxRYTgGLjZkkSMAqUhyUEn+9
        FrV90tXv9WQQG15DkOVs2QPxw420AHkvewq8CT5LGePaLVTQi9Q/SEk99L7WtQBE
        Ksjcv8vzK8E=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 62D1AAD08D;
        Fri, 24 Nov 2017 02:00:00 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A1503AD082;
        Fri, 24 Nov 2017 01:59:59 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v4 3/4] worktree: make add <path> <branch> dwim
References: <mailto:20171118224706.13810-1-t.gummerer@gmail.com>
        <20171122223020.2780-1-t.gummerer@gmail.com>
        <20171122223020.2780-4-t.gummerer@gmail.com>
Date:   Fri, 24 Nov 2017 15:59:58 +0900
In-Reply-To: <20171122223020.2780-4-t.gummerer@gmail.com> (Thomas Gummerer's
        message of "Wed, 22 Nov 2017 22:30:19 +0000")
Message-ID: <xmqq60a0noup.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1635317A-D0E5-11E7-B1A9-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thomas Gummerer <t.gummerer@gmail.com> writes:

> Currently 'git worktree add <path> <branch>', errors out when 'branch'
> is not a local branch.   It has no additional dwim'ing features that one
> might expect.
>
> Make it behave more like 'git checkout <branch>' when the branch doesn't
> exist locally, but a remote tracking branch uniquely matches the desired
> branch name, i.e. create a new branch from the remote tracking branch
> and set the upstream to the remote tracking branch.
>
> As 'git worktree add' currently just dies in this situation, there are
> no backwards compatibility worries when introducing this feature.
>
> Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
> ---

This step makes sense and I did not spot anything controversial.
