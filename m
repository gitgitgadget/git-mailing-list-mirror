Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 85F9C20281
	for <e@80x24.org>; Tue,  3 Oct 2017 06:05:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750837AbdJCGFq (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Oct 2017 02:05:46 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56310 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750767AbdJCGFp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Oct 2017 02:05:45 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D500EA8ED9;
        Tue,  3 Oct 2017 02:05:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=HAfl5ak4TZF18Vxd8K8nD3qIyjU=; b=B3+miA
        rcOUplSXH2tIr+d7sMp8FtspYMRWIywva2y2RPM/RCAknseEicNITaOM9hAPXfEJ
        FIz3zRqpfwmOY0WYHrIIup04fM5rjt8RdPjcRW6vPNN8wtX9YaSnPCr3hKQZ7xin
        c152VGikzynrIVbqBxIPSzHk9YuY6vjFJPl70=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=cY6GPjEdO62JBTP/5LpugsdLmoWQBNZP
        cWB4EsGVBtHx2vGvZlMF9fJHBFSJzbJJ3mAhpKB8NAxLKDuYuOYmtTjkSqVZ+NWz
        jAUDrDnoONVBDVK0wJ14wF83EeQnHquBBCPXbMmSE5ZnWCsgMNL/+W7VIJrkOlK9
        VV5PjCdE0uM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CCE4AA8ED8;
        Tue,  3 Oct 2017 02:05:44 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4AF40A8ED7;
        Tue,  3 Oct 2017 02:05:44 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Michael J Gruber <git@grubix.eu>
Cc:     git@vger.kernel.org, Ekelhart Jakob <jakob.ekelhart@fsw.at>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 2/3] merge-base: return fork-point outside reflog
References: <68633b20-9e2b-ae23-2ede-8728283250f0@grubix.eu>
        <cover.1505394278.git.git@grubix.eu>
        <5513a1415d11517c28158d9b4212d383a233182f.1505394278.git.git@grubix.eu>
        <xmqq60ckzng7.fsf@gitster.mtv.corp.google.com>
        <cd97bb1b-13f3-0856-a250-8f4921b9f6d8@grubix.eu>
        <xmqqshfnx1kl.fsf@gitster.mtv.corp.google.com>
        <xmqqshfgk1mr.fsf@gitster.mtv.corp.google.com>
        <5a2fca1d-4edf-965f-4840-58c924c91051@grubix.eu>
        <xmqqzi9nlcyw.fsf@gitster.mtv.corp.google.com>
        <4a14c35c-88b0-7bc3-0a6e-c69ed9ec7ee7@grubix.eu>
        <xmqqa81njds0.fsf@gitster.mtv.corp.google.com>
Date:   Tue, 03 Oct 2017 15:05:43 +0900
In-Reply-To: <xmqqa81njds0.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Fri, 22 Sep 2017 18:14:39 +0900")
Message-ID: <xmqq7ewckbpk.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E46260A8-A800-11E7-A44B-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Michael J Gruber <git@grubix.eu> writes:
>
>> I'm still trying to understand what the original intent was: If we
>> abstract from the implementation (as we should, as you rightly
>> emphasize) and talk about historical tips then we have to ask ourselves:
>> - What is "historical"?
>> - What is tip?
>> - Tip of what, i.e. what is a "branch"?
>
> The feature was meant to be a solution for "upstream rebased the
> branch I based my work on."
> ...

So, what is the status of this thing?

While I think 1/3 and 3/3 of these three definitely make sense, I do
not think "fork-point outside reflog" does as-is If it is not even
part of the commits that were known to be at the tip some time in
the past (including "right now"---which is the fix you made with 3/3
is about), then the patch may make the command return something in
more situations, and these extra things that it returns might even
be improvements, but they are definitely not "fork-points".

To be quite honest, I am not convinced that the extra output you
would get out of the command by removing the latter half of "which
are the ancestors that were known to be at the tip?" would always
give better commit to use as the beginning of the topic to be
rebased, as I do not see any reasoning behind why, unlike the
filtered case where there _is_ a strong reasoning (with explained
limitation) behind it.

As long as the code misidentifies and picks a commits deeper than
necessary, which will force the user to say "rebase --skip", I think
we are OK.  What we want to absolutely avoid is the opposite;
somehow the code misidentifies a commit that is part of the work you
want to rebase as a recommended fork-point, which would cause the
rebase to silently lose changes.  I do not think I saw why it won't
happen explained in the log message of 2/3 at all.
