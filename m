Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AA7141F404
	for <e@80x24.org>; Fri, 26 Jan 2018 22:04:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751698AbeAZWEw (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Jan 2018 17:04:52 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52008 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751394AbeAZWEv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Jan 2018 17:04:51 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 225ABCF732;
        Fri, 26 Jan 2018 17:04:51 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=9yl7xSQalWWW4GdwjRuoBPmcRnA=; b=mB/mmY
        7KidFTs/JYAZolet0F7sBlmNb6FKab61W3Yw2yGVkAggUhp1vdK7iZhC3BcxcMSP
        HQheBgwsZgb0r16vtaLVx5KJzPGGufLZn16WLV32Vm4hgvekbZ5zIozVO0Tec3v0
        eyzxqDAbZ3mU9jtsk2xOOnrqEgdlHaxZXsXUg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; q=dns; s=sasl; b=wgO/b+YfR4qFkST1aGSUS0b3OVAv9yCV
        2crXIHjsXj9ecLXrt9gByLi1+/rVtqLymr7IHj1A4emTHdBifFOAGE5jnJKPmheC
        JZe3udBJvyXcqamikqM5RWWQG2ouJvVCK5Ha94utOUH2W647rCGhGh5jWF6/fflT
        3eDz+ZUe/zU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 19EF3CF731;
        Fri, 26 Jan 2018 17:04:51 -0500 (EST)
Received: from pobox.com (unknown [104.155.68.112])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 84920CF730;
        Fri, 26 Jan 2018 17:04:50 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Andreas Schwab <schwab@linux-m68k.org>
Cc:     Derrick Stolee <stolee@gmail.com>, git@vger.kernel.org,
        peff@peff.net, git@jeffhostetler.com, sbeller@google.com,
        dstolee@microsoft.com
Subject: Re: [PATCH 05/14] packed-graph: implement construct_graph()
In-Reply-To: <87vafowce2.fsf@linux-m68k.org> (Andreas Schwab's message of
        "Fri, 26 Jan 2018 22:14:45 +0100")
References: <20180125140231.65604-1-dstolee@microsoft.com>
        <20180125140231.65604-6-dstolee@microsoft.com>
        <xmqq607o732t.fsf@gitster.mtv.corp.google.com>
        <87vafowce2.fsf@linux-m68k.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
Date:   Fri, 26 Jan 2018 17:04:49 -0500
Message-ID: <xmqq1sicuvi6.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EE1EC318-02E4-11E8-8BF6-D3940C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Andreas Schwab <schwab@linux-m68k.org> writes:

> On Jan 26 2018, Junio C Hamano <gitster@pobox.com> wrote:
>
>> Also, would >>32 be a problem if commit.date is an uint32 (and
>> shifting all its bits out to the right)?
>
> It would be undefined.

Yup, exactly.  Thanks.
