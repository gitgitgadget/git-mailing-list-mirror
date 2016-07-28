Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3287C1F858
	for <e@80x24.org>; Thu, 28 Jul 2016 20:33:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755794AbcG1UdW (ORCPT <rfc822;e@80x24.org>);
	Thu, 28 Jul 2016 16:33:22 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64749 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753273AbcG1UdV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jul 2016 16:33:21 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0E6762F9D2;
	Thu, 28 Jul 2016 16:33:20 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Hgwk1d28EEj/lPTVX5T1Jskwuxc=; b=K3ZaOm
	H/FkRPPIonP+7582t5GI9lJ2MDplC0qE+ILegR/HSWrX1mGlKdReIIIADubhvbWP
	H8EL0lS2MWIuWVnLal8eclfgMKZj7J7bzuUTaSVnoQPZEFsWQwnBg7cPjfQG8mf6
	uygq3RhBLw4+v/EIt2uIwExeohZwGIsWJCTuE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kMhzTloIreTB3jJe1rsPuzEoo25O9X+o
	r25h+sAgYudgdmLPeG0IzpBYqzYx7kuxhJJk3nG8Ep6/Eyg2UV0xkqrf5BZpHdJV
	O3YT7M8birF+u2oUJBUe9sQHa8V1SDhivu3fjcu+q2YOqm2qlU/KzL9oK86PL523
	GB/3cu1VA/s=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 04FC72F9CE;
	Thu, 28 Jul 2016 16:33:20 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 782E02F9CD;
	Thu, 28 Jul 2016 16:33:19 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Duy Nguyen <pclouds@gmail.com>
Cc:	Robin Ruede <r.ruede@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH/RFC 0/7] Add possibility to clone specific subdirectories
References: <20160728160226.24018-1-r.ruede@gmail.com>
	<CACsJy8AW3Z+C81F6w7WiZXXvcLRv9PB4=Wjbze6eE_MPgikU8A@mail.gmail.com>
Date:	Thu, 28 Jul 2016 13:33:17 -0700
In-Reply-To: <CACsJy8AW3Z+C81F6w7WiZXXvcLRv9PB4=Wjbze6eE_MPgikU8A@mail.gmail.com>
	(Duy Nguyen's message of "Thu, 28 Jul 2016 18:59:16 +0200")
Message-ID: <xmqqlh0lqz8y.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 853CF14E-5502-11E6-9301-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

>> 4. Fsck complains about missing blobs. Should be fairly easy to fix.
>
> Not really. You'll have to associate path information with blobs
> before you decide that a blob should exist or not.

Also the same blob or the tree can exist both inside and outside the
narrowed area, as people reorganize their trees all the time.  I am
not quite convinced a path-based approach (either yours or Robin's)
is workable in the longer term.
