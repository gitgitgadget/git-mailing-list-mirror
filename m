Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D50DC433ED
	for <git@archiver.kernel.org>; Tue, 27 Apr 2021 06:49:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F031261078
	for <git@archiver.kernel.org>; Tue, 27 Apr 2021 06:49:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230050AbhD0GuZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Apr 2021 02:50:25 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56353 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbhD0GuZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Apr 2021 02:50:25 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3FF82C0487;
        Tue, 27 Apr 2021 02:49:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Wod2lUKOzLgxMIMU/h4vUBhUWwU19+2dgk+jpz
        qTF7I=; b=AWvv1q3C1Hbq0ivOj5ZKrQQPRzO/PvCEK7Tu620H2uE7F7iIglnBbH
        9n6pqtVk5aE/nupUC2LrjBSxgwYJN1MgOtRekPwAAgi/4Zv6JaFQhbxSoRc2mLL8
        rpG/jA/Qm56uvlNhLaYeHnt8aHRlRgg8dgDjuNlN7Cysyhc3Ec/zA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2635EC0486;
        Tue, 27 Apr 2021 02:49:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 93347C0485;
        Tue, 27 Apr 2021 02:49:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     ZheNing Hu <adlternative@gmail.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v11 0/2] [GSOC] trailer: add new .cmd config option
References: <pull.913.v10.git.1618562875.gitgitgadget@gmail.com>
        <pull.913.v11.git.1618672417.gitgitgadget@gmail.com>
        <xmqq5z0kbl8x.fsf@gitster.g>
        <CAOLTT8RKCV+Kpya-_AVjuVGWzs1WtGS8n_+sD0FVzwEpeXGwCw@mail.gmail.com>
        <xmqqfszk1ot6.fsf@gitster.g>
        <CAOLTT8QUA+m1W6-v=ZA205SZo8G5GBKMzJHBzU8DuQSTKiPUBw@mail.gmail.com>
        <xmqq1rb3xl3t.fsf@gitster.g>
        <CAOLTT8TciU7rvmEgXGMuVCMDN6HjMadL-L=Q9kej6=j6ktJHwA@mail.gmail.com>
Date:   Tue, 27 Apr 2021 15:49:40 +0900
In-Reply-To: <CAOLTT8TciU7rvmEgXGMuVCMDN6HjMadL-L=Q9kej6=j6ktJHwA@mail.gmail.com>
        (ZheNing Hu's message of "Thu, 22 Apr 2021 17:20:54 +0800")
Message-ID: <xmqq35vcfchn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BE2CC87A-A724-11EB-AF7C-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

ZheNing Hu <adlternative@gmail.com> writes:

> Now I think that we should keep those trailers which ask for a
> "name <email>" pair, like "Helped-by", "Signed-off-by", when we
> provide a "help:","sign:" in command line, This allows the user to
> dynamically fill in the "name <email>" pair of other people in the
> commit message later. It is worthwhile for users to exit with exit(0).
>
> But those dispensable things like "Commit-Count", It must depend
> on a person's statistics in the git repository. So "cnt:" is meaningless,
> users' script can let it exit(1).

Perhaps, but at this point what you think (or what I think) does not
matter.  That was the whole point of letting .cmd script signal Git
if the result from the invocation should be kept or discarded with
its exit status.  What would be sufficient here for us to do is to
agree that it would be good to have a minimal set (perhaps a pair)
of examples to demonstrate that the script can choose to keep or
discard a meaningless trailer entry with its exit status.
