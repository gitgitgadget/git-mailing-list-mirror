Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 249FD207EC
	for <e@80x24.org>; Mon, 26 Sep 2016 22:23:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753952AbcIZWXg (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Sep 2016 18:23:36 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64494 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753228AbcIZWXd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Sep 2016 18:23:33 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 192F542DEA;
        Mon, 26 Sep 2016 18:23:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=7N85ns5pUhj4Nfef2JJrpe39qlU=; b=HlCndE
        oZz63f2WV55m/YBJMk+oFjXhv69X+rfcWg8qBSWtLFpJsQ5WCh/H/tQEsY2bSEZz
        lYXHeWdYpWt2DY2lhtYVk8vlAhODpuFz56kPobiJb18yFVMaUVrh4mtHw9M9UPqd
        XClFxHVp2vpz5HmITsSMRxoEomGUeH611hqjs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=SMbUSL9CaTjx0utQhjtou9B4SZFlFuFH
        xq+3g5pm1XKeclAxbzP9/MZMSbWDW72mQPylpdy0oXQOfe01DcVXiB9x72RaV+Qt
        259BTGQ/P2alrD6ywXSNVKbbNLAeiHEju/9dVLJa6WWTdAFe+R724R67g6oQokrU
        ETaFkggiPIA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id F23DE42DE9;
        Mon, 26 Sep 2016 18:23:30 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8098742DE8;
        Mon, 26 Sep 2016 18:23:29 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kevin Daudt <me@ikke.info>
Cc:     git@vger.kernel.org, Swift Geek <swiftgeek@gmail.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 2/2] mailinfo: unescape quoted-pair in header fields
References: <20160919185440.18234-1-me@ikke.info>
        <20160925210808.26424-1-me@ikke.info>
        <20160925210808.26424-2-me@ikke.info>
        <xmqq4m52scg7.fsf@gitster.mtv.corp.google.com>
        <xmqqzimuqx7u.fsf@gitster.mtv.corp.google.com>
        <20160926194455.GB19089@ikke.info>
Date:   Mon, 26 Sep 2016 15:23:23 -0700
In-Reply-To: <20160926194455.GB19089@ikke.info> (Kevin Daudt's message of
        "Mon, 26 Sep 2016 21:44:55 +0200")
Message-ID: <xmqq7f9ypag4.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D9E9DAEA-8437-11E6-B635-C26412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kevin Daudt <me@ikke.info> writes:

> On Mon, Sep 26, 2016 at 12:26:13PM -0700, Junio C Hamano wrote:
>> Junio C Hamano <gitster@pobox.com> writes:
>> 
>> > Don't these also need to be downcased if you prefer $data over
>> > $DATA, though?
>> 
>> For now, I'll queue a SQUASH??? that reverts s/DATA/data/ you did to
>> 1/2 between your 1/2 and 2/2.
>
> Ugh, thanks. I'd replaced it in the first patch, but forgot it in the
> second.

Heh, I already guessed that much that these were sent without even
be in the tree, after editing only the patch files.  Don't do that
;-)

I am not sure I agree that $data is better over $DATA, though.
Unlike the lowercase $mail and others used in the script that are
clearly "variables", this thing is used as a constant during the
lifetime of the test script.


