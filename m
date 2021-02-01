Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8291BC433E0
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 22:09:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4478C64D92
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 22:09:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbhBAWJh (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Feb 2021 17:09:37 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:65193 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbhBAWJg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Feb 2021 17:09:36 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E64DF93B4E;
        Mon,  1 Feb 2021 17:08:51 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=BwCJT80KGI7rw4+YJEVDyYTS0Qs=; b=ODZQIwnyYf1Ii+G2H4+B
        YCu7Pjzzd97egeOa1/17hflTVPPat7i79U1tUC0vH6Lm95hEadspYRyW27h5Ahl0
        0nR9mjzgGJddxsPp5Y1SSQDGb0AokybLPZx0Prm9/tjP8HbO1TtegLzzwX7+KRxd
        nMxRKf2sm9WZ+lM5oJI/TDg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         q=dns; s=sasl; b=JHW15lnBs8tVgRcNODAT/MLFZq9Leu0OPdv2/YkFhD848l
        Yn2SCN5Q3r39iOmIo0pziBX7590tWBFIGvhJ8gzdkF1jBrVn502mINufN7duHOp7
        OW3C3v4gxmIBGsw4up3Y7BaQGKoebnysMo5xieRuxpM1sqfwe3bouU0ImrgjM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DDF6693B4D;
        Mon,  1 Feb 2021 17:08:51 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.243.138.161])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5672993B4C;
        Mon,  1 Feb 2021 17:08:51 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3 01/17] commit: use config-based hooks
References: <20201222000435.1529768-1-emilyshaffer@google.com>
        <20201222000435.1529768-2-emilyshaffer@google.com>
Date:   Mon, 01 Feb 2021 14:08:50 -0800
Message-ID: <xmqqlfc7jv9p.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 10DFDE0A-64DA-11EB-A56D-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> writes:

> Because all but 'post-commit' hooks are expected to make some state
> change, force all but 'post-commit' hook to run in series.

OK.  And a sequence of hooks that run in series are expected to use
the output from the previous one as its input?

> 'post-commit'
> "is meant primarily for notification, and cannot affect the outcome of
> `git commit`," so it is fine to run in parallel.

Makes sense.

