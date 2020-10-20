Return-Path: <SRS0=RnkD=D3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 611FEC433DF
	for <git@archiver.kernel.org>; Tue, 20 Oct 2020 03:11:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE8C2222E9
	for <git@archiver.kernel.org>; Tue, 20 Oct 2020 03:11:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="uOuNNm8S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390992AbgJTDLD (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Oct 2020 23:11:03 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:62437 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390989AbgJTDLD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Oct 2020 23:11:03 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4D957F3941;
        Mon, 19 Oct 2020 23:11:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ZBGPM4q9Fcq6qjF+JEaCq5ZQjPY=; b=uOuNNm
        8SJcG2W4S2QFlNwR7P1Wo4bSeFdlue9O6Vb7AGzfp1Q/0gZiJg8Isbxj+0PDbp5e
        IppdufACO4ZshWS45eM1GdOLZMRK9eLoTPd+MRZBjG/4KH2FLFD8ZceOIbBEZR/Z
        uu0Ge7TO2SA5bY5R7SmI+pN6loQgnfGY+9qOU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=REcPHw1UX0dlo9j2sjXRu1m7S/52UKfi
        bkpuhPhClYwnwTeQej29PtgkDDbfpWt6eTf2rPmcddtQ/X/g9xx4dzjaSRqzlf5B
        qPJwD3WesECUF125X1I5BELZdCJhtObkzAlnxb62I9+19SifNO0TYUjHsz8an6NQ
        Oh8LsPCcMU8=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 465FDF3940;
        Mon, 19 Oct 2020 23:11:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 8B3C3F393E;
        Mon, 19 Oct 2020 23:10:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Nipunn Koorapati via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        Utsav Shah <utsav@dropbox.com>,
        Nipunn Koorapati <nipunn1313@gmail.com>,
        Nipunn Koorapati <nipunn@dropbox.com>
Subject: Re: [PATCH v3 5/7] perf lint: check test-lint-shell-syntax in perf
 tests
References: <pull.756.v2.git.1603143316.gitgitgadget@gmail.com>
        <pull.756.v3.git.1603147657.gitgitgadget@gmail.com>
        <28c1e488bf644786af071e66b73450baa47ccc44.1603147657.git.gitgitgadget@gmail.com>
        <20201020023857.GC54484@nand.local>
Date:   Mon, 19 Oct 2020 20:10:56 -0700
In-Reply-To: <20201020023857.GC54484@nand.local> (Taylor Blau's message of
        "Mon, 19 Oct 2020 22:38:57 -0400")
Message-ID: <xmqqlfg1d22n.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E02A3E5E-1281-11EB-AA80-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

>>  		echo change$i >unrelated-file$i &&
>> -		seq 1000 | tac >>unrelated-file$i &&
>> +		test_seq 1000 | tac >>unrelated-file$i &&
>
> Makes sense. I wouldn't be opposed to breaking this out into an earlier
> change (e.g., "it's about to become not OK to use seq in t/perf, so
> prepare for that by replacing any invocations with test_seq()"), but I
> think it's probably not worth it, since this patch is small as it is.

test_seq is fine, but I do not think tac is portable (only saved by
the fact that not many people, especially on exotic platforms, run
perf scripts).
