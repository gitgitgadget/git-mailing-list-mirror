Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4980A1FE4E
	for <e@80x24.org>; Sat, 25 Jun 2016 00:29:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751862AbcFYA3X (ORCPT <rfc822;e@80x24.org>);
	Fri, 24 Jun 2016 20:29:23 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62299 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751443AbcFYA3W (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jun 2016 20:29:22 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 3592C27748;
	Fri, 24 Jun 2016 20:29:21 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=7x3lgFXHx7cG5vMqaU35aahv1U0=; b=H6pfPM
	X8DXUSfjr4RGYzfIYBLWASoVCaoXtz9x/hpB6O5/s5QzOop5HHBTZBj1s4zlYkgJ
	+kaQ3OcqePu1J5O8bju4/cIsVtaNdpDRs0mV0EiDGxao9ZAYyspoeGoDI8aLtsex
	nVXG31mtz2tawypUKgiAJvHong0yTL99OmiXs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JqcgfprOaNVL9yBvgJMUovRN48gCyZFA
	zSBxnXq06kaNjll0/ynuR0HgVdaqvKVROVtlFyg2iNkTMsBfDWi5TmsVR+AJr1bJ
	6fL5vCXSfg7TrVhPPKatgRPjZs7vxsuF6dpap6DYoFfhtmquIFBT07JINi1CKa34
	2652Ire+70s=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 2DE3927747;
	Fri, 24 Jun 2016 20:29:21 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A34EA27745;
	Fri, 24 Jun 2016 20:29:20 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	"brian m. carlson" <sandals@crustytoothpaste.net>
Cc:	git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
	Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v3 06/11] diff: rename struct diff_filespec's sha1_valid member
References: <20160624230929.82222-1-sandals@crustytoothpaste.net>
	<20160624230929.82222-7-sandals@crustytoothpaste.net>
Date:	Fri, 24 Jun 2016 17:29:18 -0700
In-Reply-To: <20160624230929.82222-7-sandals@crustytoothpaste.net> (brian
	m. carlson's message of "Fri, 24 Jun 2016 23:09:24 +0000")
Message-ID: <xmqqfus2dsbl.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DBE95746-3A6B-11E6-AD85-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:


> @@
> struct diff_filespec o;
> @@
> - o.sha1_valid
> + o.oid_valid
>
> @@
> struct diff_filespec *p;
> @@
> - p->sha1_valid
> + p->oid_valid

Totally offtopic (from Git's point of view), but why does Coccinelle
need both of these?  I recall that between v1 and v2 there were some
confusing discussions about the order of these equivalent conversions
mattering and the tool producing an incorrect conversion in v1.

