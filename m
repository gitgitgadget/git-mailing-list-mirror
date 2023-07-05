Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78877EB64DA
	for <git@archiver.kernel.org>; Wed,  5 Jul 2023 17:32:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233176AbjGERcn (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Jul 2023 13:32:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233000AbjGERcU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jul 2023 13:32:20 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80FF91BDD
        for <git@vger.kernel.org>; Wed,  5 Jul 2023 10:31:37 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id AC73E1A2E29;
        Wed,  5 Jul 2023 13:30:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=z4zHZ0leSu308wKPUdovBW9BBooRhKVl4jRH27
        GZnfE=; b=N/N91Q1E2dcUQ49ZoUKPmzJEj/DYoCNJKdO5wLtXAAfHM+gKmBJvIU
        r6FVc6cWLyQEHvIxUxWztFhgL5olW7zdiwQuM6rchNGg2zojAJU9MV5IoHi4QQCD
        yQbEsfJUBeqpAc51A6eHxWDfk3BBcWXlG1XAvDJ0teS8T/gWvWzes=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A4B541A2E28;
        Wed,  5 Jul 2023 13:30:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.233.135.164])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0E36C1A2E27;
        Wed,  5 Jul 2023 13:30:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Jeff King <peff@peff.net>, Tiago d'Almeida <tjamadeira@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>, git@vger.kernel.org
Subject: Re: index.skipHash doesn't work with split index, was Re: Bug Report
References: <CAO=RawtAvOna1xrBNY+T-fo4UQe-ipC6OvFODvOSdu4wUML3Ng@mail.gmail.com>
        <20230629083859.GA585934@coredump.intra.peff.net>
        <3b9165a7-e37e-f429-bbcb-1b95aa9731fc@gmx.de>
Date:   Wed, 05 Jul 2023 10:30:33 -0700
In-Reply-To: <3b9165a7-e37e-f429-bbcb-1b95aa9731fc@gmx.de> (Johannes
        Schindelin's message of "Wed, 5 Jul 2023 16:27:50 +0200 (CEST)")
Message-ID: <xmqqttui1d1i.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A646D2EA-1B59-11EE-A520-307A8E0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> The reason why this is needed is that the shared index _must_ have an
> identifer that the split index can use, and that's that index hash.
> Skipping it breaks that pattern.

A very good summary.

