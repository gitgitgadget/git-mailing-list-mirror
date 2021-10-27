Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7494BC433FE
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 20:16:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B8A3610A0
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 20:16:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239127AbhJ0UTE (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Oct 2021 16:19:04 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:65160 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239063AbhJ0UTD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Oct 2021 16:19:03 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 599F4EAC65;
        Wed, 27 Oct 2021 16:16:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=y8CZFFRWwxvQhRkounsTtHjI5CbmBCiS5gW1wR
        gd55w=; b=XhnOmcAmT3AZLarmfVRrsP9/SE9ahnJYVuiLXsrDmn9tTCzwggMohA
        xy+x9PEqkzVyknpg9S5sgMlR7v7iX+Kj5l+JRWnyOoA19fvcfAC5lqGBjjm3dipE
        q0OblTd1RJPQS3CEReFm+6D/WmjpFQ/5MKmVbL1zuIZZ+bt2AIJk4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 50CF1EAC64;
        Wed, 27 Oct 2021 16:16:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B0157EAC63;
        Wed, 27 Oct 2021 16:16:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Alex Riesen <alexander.riesen@cetitec.com>
Cc:     Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>
Subject: Re: [PATCH] Remove negation from the merge option "--no-verify"
References: <YXfwanz3MynCLDmn@pflmari>
        <YXhwGQOTfD+ypbo8@coredump.intra.peff.net> <YXlBhmfXl3wFQ5Bj@pflmari>
        <YXlD5ecNSdeBSMoS@coredump.intra.peff.net> <YXlTpzrY7KFqRlno@pflmari>
Date:   Wed, 27 Oct 2021 13:16:35 -0700
In-Reply-To: <YXlTpzrY7KFqRlno@pflmari> (Alex Riesen's message of "Wed, 27 Oct
        2021 15:27:03 +0200")
Message-ID: <xmqq4k92w7do.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C96E3A10-3762-11EC-B211-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alex Riesen <alexander.riesen@cetitec.com> writes:

> From: Alex Riesen <raa.lkml@gmail.com>
>
> This allows re-enabling hooks disabled by an earlier "--no-verify"
> in command-line and makes the interface more consistent.
>
> Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
>
> ---
>
> This one is on top of "[PATCH] Fix "commit-msg" hook unexpectedly called for
> "git pull --no-verify" (http://public-inbox.org/git/YXfwanz3MynCLDmn@pflmari/).
> Which is a bit awkward. Should I resend as series?

Don't we need to do this at the root cause command "git commit"?  It
is documented to take "--no-verify" but not "--verify" to countermand
an earlier "--no-verify" on the command line.

And yes, I agree that we shouldn't introduce an awkwardness in one
step of the series and fix it in another step of the same series.
