Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31088C433DB
	for <git@archiver.kernel.org>; Tue, 23 Feb 2021 08:22:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E1A1564E4B
	for <git@archiver.kernel.org>; Tue, 23 Feb 2021 08:22:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231995AbhBWIWK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Feb 2021 03:22:10 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:65385 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231827AbhBWIWH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Feb 2021 03:22:07 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2B98190409;
        Tue, 23 Feb 2021 03:21:26 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=U4D367vBnB4QUZat7Fe/hxWE0ys=; b=gd8Kg+
        qmIXS39xRwbbV0nAhrG7CrA/id5ycj8PLmvLIDzcMzoEpRYwpUpqYjzAVxHdIYFf
        QvYDYYOahXIR2Ja8IlBbp00XmbV6l5EtEPb24/BrNJMO9AzX5/PweKU0sBjmzJBK
        xMPPC6yZ6jk8MfFLdk4nttxLsX8knOb5fyEZU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=lrweaGi9yREcLTqezyLG9YE1XyvV0eb+
        8sV30XZv50ufGqKEdF0/cES8yhPMm72Le1/OyccJl9DSCRFnmuNTyo/7zvhPsbxH
        EEVlyWIh7nWxcF4M9qNmAS/bHO3eayajwW2kzJbZ+Q49yWd4e5/ZfaIVhhP0NxuQ
        tCKejKxjJ98=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 233AA90408;
        Tue, 23 Feb 2021 03:21:26 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A59AE90407;
        Tue, 23 Feb 2021 03:21:25 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Alex Henrie <alexhenrie24@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH v3] rebase: add a config option for --no-fork-point
References: <20210223071840.44267-1-alexhenrie24@gmail.com>
        <YDSvhEBh8YeCblpa@generichostname>
Date:   Tue, 23 Feb 2021 00:21:24 -0800
In-Reply-To: <YDSvhEBh8YeCblpa@generichostname> (Denton Liu's message of "Mon,
        22 Feb 2021 23:32:20 -0800")
Message-ID: <xmqqo8gb42kb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1ED5B1C4-75B0-11EB-B481-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> I don't think this test is quite necessary. In other parts of the
> code, we've already tested that local configs have priority over
> global configs. We can assume that config machinery works so we
> don't need to test it here.

I am not so sure if we should place so much trust in the code of
"rebase", or any other subsystem for that matter, that it uses the
configuration API and parse-options API correctly.

The do_test_rebase helper introduced here would be useful clean-up
on its own, so I'd rather take it as-is.
