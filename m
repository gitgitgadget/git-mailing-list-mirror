Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4B04E202A2
	for <e@80x24.org>; Sat, 21 Oct 2017 02:02:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753311AbdJUCCH (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Oct 2017 22:02:07 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57700 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753222AbdJUCCG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Oct 2017 22:02:06 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E4909B5E7F;
        Fri, 20 Oct 2017 22:02:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=vXEJ5Prr5IRZnRbShaPK9Mwdsh0=; b=SBwmm5
        pOTPlZNkukdqR93TeTyByVFo6m2uvqyGIW3sX9JoFhO3l7RWH0cDQDFSoWYqga01
        hNDIUD5JdIedH8An7WSdPtzNHEO+yxbT715nLonFP8vnaZBemNwELssOj3DdN9JQ
        UzLYkB75DDc3TPxMu4oaAKx+Mhk403fOjLfbA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=R4GlXOcI4iIrqSmHpow/4PN8wG8fS5+A
        MFQB/tpspd1MxB2u9Ovpf6ty+TNPFnAGdjI+a5jTQIrSu45lArHeJX0iXQqiOOdw
        FB5aELPdsE2iXqEE+0uNb1vF+QcAkzQ6o7WJZobktbTr/DXHH5GDzX4MGR6ZKiSY
        ONWPc8KPhZs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DD172B5E7E;
        Fri, 20 Oct 2017 22:02:05 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 47919B5E7D;
        Fri, 20 Oct 2017 22:02:05 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Simon Ruderich <simon@ruderich.org>
Cc:     Jeff King <peff@peff.net>, Stefan Beller <sbeller@google.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH 2/3] t5615: avoid re-using descriptor 4
References: <20171019210140.64lb52cqtgdh22ew@sigill.intra.peff.net>
        <20171019210730.sgm4g4tmor2dgjv7@sigill.intra.peff.net>
        <CAGZ79kYTmUnM+fcf222-cvwB3Fg4+J_xy28E7A3AYryx4qDf_w@mail.gmail.com>
        <20171019232337.zfd7occtjboem7f4@sigill.intra.peff.net>
        <20171020055058.s5dgxyfjnqtlxv4d@sigill.intra.peff.net>
        <CAGZ79kaSu+nHHntFPWbkXk1TC4ys9htesRg9HHXcpK+Y6MwZeg@mail.gmail.com>
        <20171020224608.3ataitvdq5r33iih@sigill.intra.peff.net>
        <20171021001916.bohcqjuxcufxvpam@ruderich.org>
Date:   Sat, 21 Oct 2017 11:02:04 +0900
In-Reply-To: <20171021001916.bohcqjuxcufxvpam@ruderich.org> (Simon Ruderich's
        message of "Sat, 21 Oct 2017 02:19:16 +0200")
Message-ID: <xmqq7evpgswz.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D63F1F50-B603-11E7-A836-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Simon Ruderich <simon@ruderich.org> writes:

> On Fri, Oct 20, 2017 at 06:46:08PM -0400, Jeff King wrote:
>>> I agree. Maybe just stick with the original patch?
>>
>> OK. Why don't we live with that for now, then. The only advantage of the
>> "999" trickery is that it's less likely to come up again. If it doesn't,
>> then we're happy. If it does, then we can always switch then.
>
> I think switching the 4 to 9 (which you already brought up in
> this thread) is a good idea. It makes accidental conflicts less
> likely (it's rare to use so many file descriptors) and is easy to
> implement.

Yeah, I like the simplicity of implementation, and I more like the
fact that it is simpler to reason about its limitation.
