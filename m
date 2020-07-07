Return-Path: <SRS0=WOg5=AS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA046C433DF
	for <git@archiver.kernel.org>; Tue,  7 Jul 2020 22:37:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75C5320675
	for <git@archiver.kernel.org>; Tue,  7 Jul 2020 22:37:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Kw2Nnpez"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729341AbgGGWhp (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jul 2020 18:37:45 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62557 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728299AbgGGWhp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jul 2020 18:37:45 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 39FE4631DB;
        Tue,  7 Jul 2020 18:37:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=KeYKcu4Jq7p/0++UMma1t81P+Wk=; b=Kw2Nnp
        ezYTxJYaCkgp7mM0dcxCTIgxWlHIy9mTPx6EjXEi+Azy/GR6UX0fFu7vDFT9Beg9
        bfjvff/AM9HNd1D1QFVMI8lYl3FaOUybEo+aZYvEj61ReSB65Kg8mN/UdCCbb0R9
        AECQeXhn26KGPQ4SoIpH8EWSuuNxV3OYG0w2w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=h+T5KUvEZHGrun0IYAuU8CCXZSgfp5xL
        cxU0ZlIjypkh5xvxXflTJUDDmUFWk/4l6nxTsQrL/RIMBh5O25gNEPd4Qt2vDmVU
        zVJoiHg8QR2KV7+eDbOfSOVg+YYwxCfU16yU1YmSyc4H7Pd+lVsFeTIXamT2sETA
        0joSJerywY8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 329D0631D9;
        Tue,  7 Jul 2020 18:37:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.231.104.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B4F2F631D8;
        Tue,  7 Jul 2020 18:37:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH] Make some commit hashes in tests reproducible
References: <pull.816.git.git.1594149804313.gitgitgadget@gmail.com>
        <xmqqfta33y0m.fsf@gitster.c.googlers.com>
        <20200707205418.GB1396940@coredump.intra.peff.net>
        <xmqq1rln3t4y.fsf@gitster.c.googlers.com>
        <20200707215206.GA2300296@coredump.intra.peff.net>
Date:   Tue, 07 Jul 2020 15:37:42 -0700
In-Reply-To: <20200707215206.GA2300296@coredump.intra.peff.net> (Jeff King's
        message of "Tue, 7 Jul 2020 17:52:06 -0400")
Message-ID: <xmqqk0zf2bpl.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7887090C-C0A2-11EA-B775-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I'm also skeptical how often we use system times anyway, because _any_
> use of test_commit or test_tick in a script is enough to make all of the
> subsequent commands deterministic. I'd be more inclined to let a
> particular script say "I'm interested in random times". But then, I'd
> think such a script would be better written to trigger its interesting
> cases with a well-crafted set of deterministic times.

Yeah, the DEVELOPER=YesPlease was a tongue-in-cheek comment.  

Reproducibility would mean we see less test breakages due to
raciness, but I do not recall a case where digging into test
breakage due to raciness led to discovery of and fix to a real
breakage in Git itself, so it is probably a good thing.

Thanks.
