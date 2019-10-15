Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 561CB1F4C1
	for <e@80x24.org>; Tue, 15 Oct 2019 07:11:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726251AbfJOHL1 (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Oct 2019 03:11:27 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:50238 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725842AbfJOHL0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Oct 2019 03:11:26 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 57AE51F4C0;
        Tue, 15 Oct 2019 07:11:26 +0000 (UTC)
Date:   Tue, 15 Oct 2019 07:11:26 +0000
From:   Eric Wong <e@80x24.org>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee <stolee@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: ds/sparse-cone, was Re: What's cooking in git.git (Oct 2019,
 #03; Fri, 11)
Message-ID: <20191015071126.GA908@dcvr>
References: <xmqq8sprhgzc.fsf@gitster-ct.c.googlers.com>
 <nycvar.QRO.7.76.6.1910122327250.3272@tvgsbejvaqbjf.bet>
 <20191015015052.GA19636@dcvr>
 <xmqqzhi2bsp8.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqzhi2bsp8.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> wrote:
> Eric Wong <e@80x24.org> writes:
> 
> > I just took a brief look, but that appears to leak memory.
> >
> > "hashmap_free(var, 1)" should be replaced with
> > "hashmap_free_entries(var, struct foo, member)"
> >
> > Only "hashmap_free(var, 0)" can become "hashmap_free(var)"
> 
> I deliberately avoided merge-time band-aid fixups on this topic and
> ew/hashmap exactly because I was sure that I'd introduce a similar
> bugs by doing so myself.  Using evil merges can be a great way to
> help multiple topics polished independently at the same time, but
> when overused, can hide this kind of gotchas quite easily.
> 
> A reroll on top of ew/hashmap would be desirable, now that topic is
> ready for 'master'.

Just to be clear, that reroll should come from Stolee (+Cc-ed), right?
I'll be around to help answer questions, but also pretty busy
with other stuff and I think Stolee knows this API pretty well :>
