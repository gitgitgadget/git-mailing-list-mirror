Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 97BBD1F4C0
	for <e@80x24.org>; Wed, 16 Oct 2019 02:15:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389722AbfJPCPT (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Oct 2019 22:15:19 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:52492 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731979AbfJPCPT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Oct 2019 22:15:19 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E79B6A35FD;
        Tue, 15 Oct 2019 22:15:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=FDhgVKUGpyXV1gPlmoJZPITjIuQ=; b=rBIHq9
        oqn2193QdgPu6W5U6ma4N4UgCQgqvjVCj8xl1hAlkdL/r1svrcRXp1Py/9+KpO+/
        h14L+n60VWKbtz/LTT0Qu7/zq9bF3ywDftZWrzB9NtmN3UiEV6oJqxhT2od2hae2
        Dpdha0Js+WO1/vpMrILEemgs1Mrl+MevN/sAQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ahgdE37ySIQBCnWMR9qBd6DUsEAafKde
        E6Rc/ezCGKsnAns8HJZBEVroymyCf4tWaIdzGBz7fFPr3SqgLr75myxrgzmymyq9
        Jvo5pO5LWKCaNg5Fc6X79sKquk+S4ChnfHm4E9QKhcOYdRp6DVihuBP9fwaxlC1r
        NkuPWLlxRQQ=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E0BFFA35FC;
        Tue, 15 Oct 2019 22:15:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 12601A35F8;
        Tue, 15 Oct 2019 22:15:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     James Coglan <jcoglan@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Denton Liu <liu.denton@gmail.com>,
        James Coglan via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 01/11] graph: automatically track visible width of `strbuf`
References: <pull.383.git.gitgitgadget@gmail.com>
        <4bc0a0596164212aa9d29d6dd0d7a0d8ab1b9dd0.1570724021.git.gitgitgadget@gmail.com>
        <nycvar.QRO.7.76.6.1910102303330.46@tvgsbejvaqbjf.bet>
        <20191010230550.GA42541@generichostname>
        <xmqq7e5cjbwj.fsf@gitster-ct.c.googlers.com>
        <20191011050111.GA94866@generichostname>
        <nycvar.QRO.7.76.6.1910111800220.46@tvgsbejvaqbjf.bet>
        <79463ee5-a171-53a8-4903-84a825c4e8d8@gmail.com>
        <xmqqo8ymg64c.fsf@gitster-ct.c.googlers.com>
        <66b8ed45-4baa-37d9-c97f-72188ece32eb@gmail.com>
Date:   Wed, 16 Oct 2019 11:15:13 +0900
In-Reply-To: <66b8ed45-4baa-37d9-c97f-72188ece32eb@gmail.com> (James Coglan's
        message of "Mon, 14 Oct 2019 13:55:39 +0100")
Message-ID: <xmqqd0exa11q.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CB0A1A3E-EFBA-11E9-A724-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

James Coglan <jcoglan@gmail.com> writes:

>> Is there a reason why you need a pointer to a strbuf that is
>> allocated separately?  E.g. would it make it harder to manage
>> if the above were
>> 
>> 	struct graphbuf {
>> 		struct strbuf buf;
>> 		int width; /* display width in columns */
>> 	};
>> 
>> which is essentially what Dscho suggested?
>
> I used a pointer here because I create the wrapper struct in
> `graph_next_line()`, which is an external interface that takes a
> `struct strbuf *`:
>
> int graph_next_line(struct git_graph *graph, struct strbuf *sb)
> {
> 	struct graph_line line = { .buf = sb, .width = 0 };
> 	// ...
> }
>
> So I'm not allocating the strbuf here, just wrapping a pointer to
> it.

OK, so existing callers allocate strbuf, and you are merely adding a
wrapper structure to keep track of the width.  The management of the
lifetime of the strbuf is not your business so there is no reason to
inline the structure in graph_line.  Makes sense.  Thanks.
