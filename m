Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F88DC433F5
	for <git@archiver.kernel.org>; Tue,  7 Dec 2021 18:52:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236024AbhLGSzi (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Dec 2021 13:55:38 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:56286 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231669AbhLGSzg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Dec 2021 13:55:36 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 43991154AE9;
        Tue,  7 Dec 2021 13:52:06 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Cw0SFtGjgvQ2CCH38zdRoKuz6emLzx1qeUglMU
        KD6Zo=; b=o7YHOEz6VrF1446oBE0O9RfZFO8QNfXFX2IB64x68JRHgDFzM8ehRF
        ahRypK5f9LF7kdJni04oZ+/k4FZU/vbUHp7Yn1RrgjkKCN6DpJH1iEdq87ms3QLS
        wCATzH8chG8szVmet983Lg530p5Wp9N3pWSgk7oUi7x8R+zQimoHs=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 3C24D154AE8;
        Tue,  7 Dec 2021 13:52:06 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 35375154AE6;
        Tue,  7 Dec 2021 13:52:02 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Josh Steadmon <steadmon@google.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, chooglen@google.com, emilyshaffer@google.com,
        avarab@gmail.com
Subject: Re: [PATCH v5 0/2] branch: inherit tracking configs
References: <9628d145881cb875f8e284967e10f587b9f686f9.1631126999.git.steadmon@google.com>
        <cover.1638859949.git.steadmon@google.com>
Date:   Tue, 07 Dec 2021 10:52:00 -0800
In-Reply-To: <cover.1638859949.git.steadmon@google.com> (Josh Steadmon's
        message of "Mon, 6 Dec 2021 23:12:06 -0800")
Message-ID: <xmqq4k7k8cz3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C3B955C2-578E-11EC-AF29-98D80D944F46-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Josh Steadmon <steadmon@google.com> writes:

> I've addressed feedback from V4. Since 2/3 reviewers seemed to (at least
> slightly) prefer handling multiple upstream branches in the existing
> tracking setup, I've gone that direction rather than repurposing the
> branch copy code. None of the other issues were controversial.
>
> In this version, I'd appreciate feedback mainly on patch 1:
> * Is the combination of `git_config_set_gently()` +
>   `git_config_set_multivar_gently() the best way to write multiple
>   config entries for the same key?

IIRC git_config_set_*() is Dscho's brainchild.  If he is available
to comment, it may be a valuable input.

> * Does the reorganization of the BRANCH_CONFIG_VERBOSE output make
>   things more readable, or less? Should I try to simplify the output
>   here so that we don't end up with so many translatable variants of the
>   same message?

Let me find time to take a look.

> Also, a question specifically for Junio: this will conflict with
> gc/branch-recurse-submodules; should I rebase on that, or wait till it
> hits next, or just ignore it for now?

Can you two work out the preferred plan, taking relative importance,
priority, and difficulty between the topics into account, and report
to us how you want to proceed and why you chose the route once you
are done?

Unless the plan you two come up with is outrageously bad, such a
decision by stakeholders would be far more acceptable by the
community than going by my gut feeling.  In short, I'd prefer
decentralization ;-)

Having said that, I think this one is a simpler topic that is closer
to become stable enough than the other one, so it could be that the
rebases want to go the other direction.

Thanks.
