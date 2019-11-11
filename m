Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5F28F1F454
	for <e@80x24.org>; Mon, 11 Nov 2019 02:09:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbfKKCJ2 (ORCPT <rfc822;e@80x24.org>);
        Sun, 10 Nov 2019 21:09:28 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64509 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726734AbfKKCJ2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Nov 2019 21:09:28 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4EDB636E13;
        Sun, 10 Nov 2019 21:09:26 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=6NdvNMRC/kzZrGx9IbMXyv+98D4=; b=Zz/sNP
        BvuA/4XT0r6FIoGQA59+dwHeBxrMvJSF1eyIeyH0lAAfvL2aEnwWIbO+4veCQ366
        P0M1nEA8kBZRdFScHHJy9UEZeELPPxP/fsZrKMGcdvtrzwf/P6O6sBht0DwENZn0
        ZPWIRgp4A8CgR0XjQRXoP0CIxQzdw42sG1BIU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=tjHCWI8wp/+Su9SYcaKMiJy+QU4lod6a
        jCilJKObt3V5PwA298CtYuuGyfaru2COa1euWRF7h0I7KFeY9EVMHmMXJpwBMdBy
        M2Ou7I4MVmipmf0jDJMZpMHIitJT44cj6tCr0/kueOu+Lzt4gosShj56AFHDQ7PA
        p/hMhcUDF2U=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4656B36E12;
        Sun, 10 Nov 2019 21:09:26 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A0DB136E11;
        Sun, 10 Nov 2019 21:09:25 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Bryan Turner <bturner@atlassian.com>,
        Git Users <git@vger.kernel.org>,
        "peff\@peff.net" <peff@peff.net>
Subject: Re: Split commit graphs and commit-graph read
References: <CAGyf7-G3NDp--2nUbri_0EqvSLF21M0gsFCOKDCWMY+e68Htog@mail.gmail.com>
        <87f16645-6af4-9703-1d0d-eb64728d2849@gmail.com>
Date:   Mon, 11 Nov 2019 11:09:24 +0900
In-Reply-To: <87f16645-6af4-9703-1d0d-eb64728d2849@gmail.com> (Derrick
        Stolee's message of "Sun, 10 Nov 2019 20:19:20 -0500")
Message-ID: <xmqq1rufjh9n.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 48EAADFC-0428-11EA-A3CE-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> To fix this issue, I would probably go about it by removing the "read"
> subcommand and creating a "test-tool read-commit-graph" for the tests
> that need that output.
>
> If others on-list think that the better thing to do is to update the
> "read" subcommand to provide the same output, but iterate over each
> layer of an incremental commit-graph, then I can do that work instead.

I think moving it to test-tool is a good idea, whether the output
presents a single result that consolidates all layers together, or
allows to name just a single layer and shows its contents.  I do not
have a strong opinion between the two (both sounds usable debugging
aid).

Thanks.

