Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B97E4203E2
	for <e@80x24.org>; Mon, 25 Jul 2016 22:20:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756426AbcGYWUJ (ORCPT <rfc822;e@80x24.org>);
	Mon, 25 Jul 2016 18:20:09 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61463 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755279AbcGYWUG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jul 2016 18:20:06 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 59F2630449;
	Mon, 25 Jul 2016 18:20:04 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=QiFVKdNAF7Xyg2xCsyA5nu/K/MY=; b=vaBfZ1
	jpGfRtdGk2xsBAX6dF0SOgxTHK7tKpt6BEq2+1tFbqJ7sd66iPruuyIQ4VBSo/bx
	YfBQWV8dH6VZ2VAbhllmLApYeKPki9QDPErMt15wxSEUdnwCpR/8wIyESChZMd2m
	0lWZTy9h5rQYUY5sMlNx1iEqBFbCf+1NHgGrE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kCL3OI7DnZNye+tB8rehzgHkjoJXRZZN
	N8eYYYG7f6t9y6e4faTwaIP6eW9VNfFng6xfaWGVU7jbVXlkhMU3v7GhSQ0xCv7r
	+qKxr2mzk8oKu2rrTkXisBpyaVgT6Zh+ZTPq6Njv1EETj0gkOFtPaQgNJVgvXFCv
	TnfP2A+Bx2o=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2E81D30445;
	Mon, 25 Jul 2016 18:20:04 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6E31230443;
	Mon, 25 Jul 2016 18:20:03 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:	git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
	Duy Nguyen <pclouds@gmail.com>,
	Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>
Subject: Re: [PATCH v4 11/16] am -3: use merge_recursive() directly again
References: <cover.1467902082.git.johannes.schindelin@gmx.de>
	<cover.1469187652.git.johannes.schindelin@gmx.de>
	<667d2f991f1423b138a746f4c685b13c5b572a83.1469187653.git.johannes.schindelin@gmx.de>
Date:	Mon, 25 Jul 2016 15:19:59 -0700
In-Reply-To: <667d2f991f1423b138a746f4c685b13c5b572a83.1469187653.git.johannes.schindelin@gmx.de>
	(Johannes Schindelin's message of "Fri, 22 Jul 2016 14:25:40 +0200
	(CEST)")
Message-ID: <xmqqy44p2wds.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EF13B8AE-52B5-11E6-97C7-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> Note: the code now calls merge_recursive_generic() again. Unlike
> merge_trees() and merge_recursive(), this function returns 0 upon success,
> as most of Git's functions. Therefore, the error value -1 naturally is
> handled correctly, and we do not have to take care of it specifically.

I've finished reading through up to this point and I'd stop for
now.

Some of the patches I didn't look beyond the context presented in
the patches, so it is very possible that I missed leaks caused by
early returns and things like that, but I didn't see anything
glaringly wrong.  Looks very promising.

Thanks.
