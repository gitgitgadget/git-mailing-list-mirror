Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 506FA1F406
	for <e@80x24.org>; Tue,  9 Jan 2018 20:12:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751931AbeAIUMg (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Jan 2018 15:12:36 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55342 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751294AbeAIUMf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Jan 2018 15:12:35 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CA6BDBF733;
        Tue,  9 Jan 2018 15:12:34 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=k+wBwewfcMe+5xkwk20tciyWmEY=; b=YAwxx2
        P+nOxtjHuYhRaKTsPZ7U4Nag1rYaFavUAMZyC5GL5DgZmR9fwrOzXaywOpR/N4Wo
        zAr7KuezSDw9qQaoC+t82BdVIc404RIRgr1OCF+qIq0mYPUyg3q7LgEU4ukDR6++
        DiJ1foeHLvbVrvKbxkr6bMczFZlT4MIMcKAAg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=I3BqPVSmyhHy0Pb6v4r2IUaL1gHK13Vn
        mw/ww0KKHmcqyFay2dwJR9LfiyRoufwGwV41CVR/fRMRuyvFpyqxbAkov8luumG0
        L9P1t2os8vbC2k74PrMw1iXYm8tn6p0enBye/YAimDNVByJlcM4OcVGRgHtiucZV
        Xxmq54pjYqw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C1C67BF732;
        Tue,  9 Jan 2018 15:12:34 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 33328BF731;
        Tue,  9 Jan 2018 15:12:34 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>, Derrick Stolee <stolee@gmail.com>,
        =?utf-8?B?w4Z2YXIg?= =?utf-8?B?QXJuZmrDtnLDsA==?= Bjarmason 
        <avarab@gmail.com>, git <git@vger.kernel.org>,
        Derrick Stolee <dstolee@microsoft.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC PATCH 00/18] Multi-pack index (MIDX)
References: <20180107181459.222909-1-dstolee@microsoft.com>
        <87k1wtb8a4.fsf@evledraar.gmail.com>
        <c08416f1-bbec-2037-34a6-f454d85de439@gmail.com>
        <20180108102029.GA21232@sigill.intra.peff.net>
        <nycvar.QRO.7.76.6.1801081438470.31@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
        <20180109065018.GA32257@sigill.intra.peff.net>
        <nycvar.QRO.7.76.6.1801091357560.37@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
        <CAGZ79kYdgD2h7QjjJe0aA4eMATCGkH62XYvziUNvAPsBJDXOCA@mail.gmail.com>
Date:   Tue, 09 Jan 2018 12:12:33 -0800
In-Reply-To: <CAGZ79kYdgD2h7QjjJe0aA4eMATCGkH62XYvziUNvAPsBJDXOCA@mail.gmail.com>
        (Stefan Beller's message of "Tue, 9 Jan 2018 11:51:06 -0800")
Message-ID: <xmqqtvvu4wr2.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6DF7F43E-F579-11E7-BFF8-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> And in that light, I'd like to propose a new naming scheme:
>
> (a) assume that we "tag" HEAD at the start of the rebase
> (b) any abbreviation must be given as committish anchored to said ref:
>
> pick REBASE_HEAD~1 commit subject
> pick REBASE_HEAD~2 distak the gostim
> pick REBASE_HEAD~3 Document foo
> pick REBASE_HEAD~4 Testing the star-gazer
>
> And as we have the full descriptiveness of the committishs there,
> each commit can be described in a unique way using the graph relationship.
> I am just throwing the name REBASE_HEAD out there to trigger some associations
> ("similar to FETCH_HEAD"), but I dislike the name.
>
> (c) this would not solve the problem of mergy history, yet. For that we'd need
>     to introduce more keywords, that allow us to move around in the DAG,
>     such that we can reset to a specific revision or name revisions on the fly.
>     So maybe all we need is "reset", "name" (== short lived tag),
>     "merge" (rewrite parents of HEAD) to be expressive enough, but still keep
>     the line oriented interface?

It is correct to say that (c) is an issue that is not solved by (b),
but with the current scheme, the commits are internally referenced
by full object names, and just before it is presented to the end
users, these names are abbreviated down to unique prefix.  The
machinery expands these abbreviated names back to the full names
before going forward, so it is not an issue that we are creating new
commits during the rebase.

Does it make it easier to read if we used ~$n notation based on a
fixed point, instead of shortened unique object names?  What
improvement is (b) trying to achieve?



