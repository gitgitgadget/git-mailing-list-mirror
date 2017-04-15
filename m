Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0A01920D09
	for <e@80x24.org>; Sat, 15 Apr 2017 08:11:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752028AbdDOILO (ORCPT <rfc822;e@80x24.org>);
        Sat, 15 Apr 2017 04:11:14 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61588 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751894AbdDOILK (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Apr 2017 04:11:10 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E61C878635;
        Sat, 15 Apr 2017 04:11:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=rI6x39qvxwjw
        ZkEcZ3rBgs81mTA=; b=eEvJhcXbovN8AR3UcE6wt5WZabW2JXmb42VjyUF53sat
        VjTIjXHrS5p7SNTCRzjKhAQN5a6dEHEZlXD7tXyg3LpgxomI/MJNYeXzuGXSDXlN
        IfdHAbi3hQsUAZoSL7odYqIrLPo+3VO1KUcASgsS//iBcaLElbOh37MGLw0He2I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=EsgBjv
        oo0oXOsrIccH16s0vx1ZrLBq2yXuRQxQ1coa3ZPqmeU313gdcQRAOhTl1Fikk2SJ
        iKl2J/O80Pm/bKEFSGYu0IYMQcXcHR/PERqTfvYjC/muhDd49aeJ4esATJEXWsqB
        EPZ9HyN8GW2Q75y1vZBlPNMBZ97jjDYm1jvo8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DDABB78634;
        Sat, 15 Apr 2017 04:11:08 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3EBB478632;
        Sat, 15 Apr 2017 04:11:08 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Jeffrey Walton <noloader@gmail.com>,
        =?utf-8?Q?Mi?= =?utf-8?Q?cha=C5=82?= Kiedrowicz 
        <michal.kiedrowicz@gmail.com>, J Smith <dark.panda@gmail.com>,
        Victor Leschuk <vleschuk@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH 00/12] PCREv2 & more
References: <20170408132506.5415-1-avarab@gmail.com>
        <20170411104739.xzhxggpufvwgr3fu@sigill.intra.peff.net>
Date:   Sat, 15 Apr 2017 01:11:07 -0700
In-Reply-To: <20170411104739.xzhxggpufvwgr3fu@sigill.intra.peff.net> (Jeff
        King's message of "Tue, 11 Apr 2017 06:47:39 -0400")
Message-ID: <xmqqinm6m6p0.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 14688CC0-21B3-11E7-A73F-E680B56B9B0B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Sat, Apr 08, 2017 at 01:24:54PM +0000, =C3=86var Arnfj=C3=B6r=C3=B0 =
Bjarmason wrote:
>
>> This adds PCRE v2 support, but as I was adding that I kept noticing
>> other related problems to fix. It's all bundled up into the same
>> series because much of it conflicts because it modifies the same test
>> or other code. Notes on each patch below.
>
> Overall, the series looks OK to me.
>
> I'm not sure if it is worth all the complexity to carry pcre1/pcre2 as
> run-time options. That does make it easier to do back-to-back
> comparisons, but it makes the code a lot more complicated. In particula=
r
> I'm worried about subtle cases where we pcre1 turns into pcre2 (or vice
> versa) by use of the aliases. That shouldn't matter to a user for
> correctness, but it would throw off the benchmarking.
>
> If we literally just added USE_LIBPCRE2 and built against one or the
> other, then all the complexity would be limited to a few #ifdefs. The
> big drawback AFAICT is that anybody doing timing tests would have to
> recompile in between.

Yeah, having to dl two libs at runtime, even when you would ever use
just one in a single run, is less than ideal.  A small downside
inflicted on everybody will add up to million times more than a
larger downside only suffered by developers, so I tend to agree with
you that we probably should simplify to choose just one (or zero) at
compile time.

> So I dunno. I had hoped libpcre2 would be a hands-down win on timing,
> but it sounds like there's a little back-and-forth depending on the
> context. Is there a ticking clock on pcre1 going away? I suspect it wil=
l
> be around for many years to come, but if they'll continue optimizing
> pcre2 but not pcre1, then it may make sense to hitch our wagon to the
> one that upstream is actually working on.
