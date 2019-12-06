Return-Path: <SRS0=yMBz=Z4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 326B2C43603
	for <git@archiver.kernel.org>; Fri,  6 Dec 2019 21:31:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB47120659
	for <git@archiver.kernel.org>; Fri,  6 Dec 2019 21:31:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="rXd9ERTO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726397AbfLFVbm (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Dec 2019 16:31:42 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:62942 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726330AbfLFVbm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Dec 2019 16:31:42 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 994C2ADC13;
        Fri,  6 Dec 2019 16:31:40 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=xi09KCsmH6hQ/UILVf7+cVyhKLU=; b=rXd9ER
        TOhJIl9srXi5XEDlWOEv8av5aQWZKKcDHsJc/E0rzdn9sebdYmY43UFlJL/97sQm
        pTPQf1d1l2Emi2OZaFAbSrEBuLWG8mELhbkQZAVTk9nFhvaBJxoULu5WKqVbNKA2
        WNIPHSjHT4eAEYl9ovpHPsjQgQ+FFTEpVkQvY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=jTLfcAu2nn0xmLSsnzJd/mVmLCKv+dMD
        GXyloSBiiQMZQdx/sCkpDgSJb5wPWJrWVdBmKG67gK5Y1kohMFXXL7RvIQ/O0LuY
        aZ6MWt69q2ZbIwVO3WWq/UfNNRG5jXxYuaTNGXqWIu37N2g8VOIdy2EPx6lqxKiO
        cvz/bxHMTcY=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 92299ADC12;
        Fri,  6 Dec 2019 16:31:40 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id BC019ADC0A;
        Fri,  6 Dec 2019 16:31:37 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>
Subject: Re: What's cooking in git.git (Dec 2019, #01; Mon, 2)
References: <xmqqpnh6yfrl.fsf@gitster-ct.c.googlers.com>
        <bea26b66-ac52-8f0e-9557-c958db7be628@gmail.com>
Date:   Fri, 06 Dec 2019 13:31:35 -0800
In-Reply-To: <bea26b66-ac52-8f0e-9557-c958db7be628@gmail.com> (Derrick
        Stolee's message of "Wed, 4 Dec 2019 13:53:10 -0500")
Message-ID: <xmqqd0d1w37s.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C8D20D70-186F-11EA-96CE-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> On 12/2/2019 9:16 AM, Junio C Hamano wrote:
>> * ds/sparse-cone (2019-11-22) 19 commits
>>  - sparse-checkout: check for dirty status
>>  - sparse-checkout: update working directory in-process for 'init'
>>  - sparse-checkout: cone mode should not interact with .gitignore
>>  - sparse-checkout: write using lockfile
>>  - sparse-checkout: use in-process update for disable subcommand
>>  - sparse-checkout: update working directory in-process
>>  - sparse-checkout: sanitize for nested folders
>>  - unpack-trees: add progress to clear_ce_flags()
>>  - unpack-trees: hash less in cone mode
>>  - sparse-checkout: init and set in cone mode
>>  - sparse-checkout: use hashmaps for cone patterns
>>  - sparse-checkout: add 'cone' mode
>>  - trace2: add region in clear_ce_flags
>>  - sparse-checkout: create 'disable' subcommand
>>  - sparse-checkout: add '--stdin' option to set subcommand
>>  - sparse-checkout: 'set' subcommand
>>  - clone: add --sparse mode
>>  - sparse-checkout: create 'init' subcommand
>>  - sparse-checkout: create builtin with 'list' subcommand
>> 
>>  Management of sparsely checked-out working tree has gained a
>>  dedicated "sparse-checkout" command.
>> 
>>  How well is this topic done at this point?
>
> Hopefully this is ready to merge and I can start on the
> follow-up topics. I think this is ready enough that any
> further comments can be done in follow-up commits.
>
> That said, I thought the topic was in that state before
> the 2.24.0 release, but then Szeder found several good
> points worthy to address here. He is CC'd to hopefully
> comment.

Ping?
