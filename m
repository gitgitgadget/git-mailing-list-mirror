Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B16C520193
	for <e@80x24.org>; Thu,  4 Aug 2016 18:20:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934029AbcHDSUv (ORCPT <rfc822;e@80x24.org>);
	Thu, 4 Aug 2016 14:20:51 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59943 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S933852AbcHDSUu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Aug 2016 14:20:50 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B7B5B3256D;
	Thu,  4 Aug 2016 14:20:49 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=dyAg6szYcogq9l0JgjbXfX7OkuQ=; b=H1+vfd
	96hYhJolEHcqitJ7TcqIcrm/Lguze92S5IBqFGz0w5hk1p5rPikBn7yDN3eebgVB
	ZdMp5r6DIcRixyRq0FXKRgggtgI7JxJXbVdZ+Mk9zMu6++Jjho/7ipjbZrBFWJPA
	qeIViQqRWJTm0V8+asKdURFPOxoLbJlJ5lprI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=m55FJ0XVmefGZB4YS4wLMDs3QHEec/kE
	mqQXLuA1Fpr7gG7LY/lB/uOt5Vcw7TmYNLR3uocWbCS2dOU89Il7sGEmrBV0qkXm
	OC7b6dBThIPBf5GYgGjQDXLJBA976aJaBsFxo8CLNuc3WFOCYkdDDh44cK5CAMlg
	hRy/pF4dcOs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id AD8433256C;
	Thu,  4 Aug 2016 14:20:49 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 18F183256B;
	Thu,  4 Aug 2016 14:20:49 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:	git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
	Duy Nguyen <pclouds@gmail.com>,
	Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>
Subject: Re: [PATCH v6 16/16] merge-recursive: flush output buffer even when erroring out
References: <cover.1469547160.git.johannes.schindelin@gmx.de>
	<cover.1470051326.git.johannes.schindelin@gmx.de>
	<3b4494c586574b59d80d0f1b88bd4c3d56b678cf.1470051326.git.johannes.schindelin@gmx.de>
Date:	Thu, 04 Aug 2016 11:20:47 -0700
In-Reply-To: <3b4494c586574b59d80d0f1b88bd4c3d56b678cf.1470051326.git.johannes.schindelin@gmx.de>
	(Johannes Schindelin's message of "Mon, 1 Aug 2016 13:44:57 +0200
	(CEST)")
Message-ID: <xmqq7fbw4cqo.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2B5DEF66-5A70-11E6-AA26-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> Ever since 66a155b (Enable output buffering in merge-recursive.,
> 2007-01-14), we had a problem: When the merge failed in a fatal way, all
> regular output was swallowed because we called die() and did not get a
> chance to drain the output buffers.

OK.  Even though I really wanted to see somebody else review this
series as well, I finished reading it through one more time before
that happened, which is unfortunate because I think this is ready to
start cooking in 'next' even though I no longer have much faith in
my eyes alone after staring at this series so many times---you start
missing details.

Thanks.
