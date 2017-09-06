Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6DA151F4DD
	for <e@80x24.org>; Wed,  6 Sep 2017 19:51:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752753AbdIFTvj (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Sep 2017 15:51:39 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60761 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752395AbdIFTvi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Sep 2017 15:51:38 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 51B34989EF;
        Wed,  6 Sep 2017 15:51:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=Q1Ixs7VHFfpC3ftHPtGzPbRWKho=; b=OsGnxFQH2NVFMR8QwNnA
        TkgSj/JBeQgBh6SjIXmRQIr3sWH2O2ag9lmClRUfrOaSmNd00c2PjFq/7zE+H5yl
        4TzthXJU4eGj6WFye51usX9iYRo3XXNSxxE8yZBupWUAZlbR0Glq6Z7oDQGCIASh
        oyffECVjgHhhPmxiL6/C0sc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         q=dns; s=sasl; b=R2J5HozOW2dikRZHn5PuYHBnUIupJ+waTAHPRIbIs989dX
        zqNQGbbhhO3bB/63nxVQG9w8QJTrSynEIloV93X9KKUmxKm4Hmu2y8leVcerZH0f
        Yoc30yd5JDZkSmcnxuSXMkcQDicT4Vgfkdo30agZx8cTLdG3tOqtbi686b+wk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4AA44989EE;
        Wed,  6 Sep 2017 15:51:38 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B0023989ED;
        Wed,  6 Sep 2017 15:51:37 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Rene Scharfe <l.s.r@web.de>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 00/34] plug strbuf memory leaks
References: <20170830175005.20756-1-l.s.r@web.de>
Date:   Thu, 07 Sep 2017 04:51:36 +0900
Message-ID: <xmqq8thr61x3.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CB5DBD74-933C-11E7-B444-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rene Scharfe <l.s.r@web.de> writes:

> Release allocated strbufs in functions that are at least potentionally
> library-like; cmd_*() functions are out of scope because the process
> ends with them and the OS cleans up for us anyway.  The patches are
> split by function and were generated with --function-context for easier
> reviewing.

I read through all of them and they looked sensible.  I had a few
comments on individual patches, though.

