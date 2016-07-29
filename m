Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 827A01F955
	for <e@80x24.org>; Fri, 29 Jul 2016 20:22:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752680AbcG2UW2 (ORCPT <rfc822;e@80x24.org>);
	Fri, 29 Jul 2016 16:22:28 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57179 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752045AbcG2UW0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jul 2016 16:22:26 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 2B24030440;
	Fri, 29 Jul 2016 16:22:25 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=pmMoIgXk9G7KcW+PMZgIy8Eby+k=; b=vaMCVh
	AR0t2pnOm1dZsYCP755QxAAaZuXvl9Q9cuIw4A8/dwUB35wnxN/7lNZjqexMIL4R
	EzfRJyXaAOhpRTrvgsmtQnYTXbmKu4hNHyqGeczvvt6JHxe2fmMcAxb26fzjZ94y
	DnIdSZazE6dXK2VWDmN1Q3M+bvznZiXt6x3Gk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DHn+i2Y3gabyNelimhxF7tE/r3kHgAhZ
	/sfIPd4Ay+ywbrzIWONQmMZFeRILwWaWhZ+7l73tilNtW0c94NNGyUDkO6YSVf0x
	sXXiSN6pgiestNIJNXmcByYn0Y2L2VVCz4btbb+c2BYMA5EG3r5QlscNRkZkANP8
	NuRPBwXvjGs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 23B4A3043F;
	Fri, 29 Jul 2016 16:22:25 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A12063043E;
	Fri, 29 Jul 2016 16:22:24 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Kevin Willford <kcwillford@gmail.com>
Cc:	git@vger.kernel.org
Subject: Re: [[PATCH v2] 0/4] Use header data patch ids for rebase to avoid loading file content
References: <20160729161920.3792-1-kcwillford@gmail.com>
Date:	Fri, 29 Jul 2016 13:22:22 -0700
In-Reply-To: <20160729161920.3792-1-kcwillford@gmail.com> (Kevin Willford's
	message of "Fri, 29 Jul 2016 12:19:16 -0400")
Message-ID: <xmqqshusmby9.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 295727F0-55CA-11E6-8981-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Kevin Willford <kcwillford@gmail.com> writes:

> This patch series is to remove the hand rolled hashmap in the patch_ids
> and use the hashmap.h implementation.  It also introduces the idea of having
> a header only patch id so that the contents of the files do not have to be
> loaded in order to determine if two commits are different.

> Subject: Re: [[PATCH v2] 0/4] Use header data patch ids for rebase to avoid loading file content

Did you do "format-patch --subject-prefix='[PATCH v2]'" or something
like that?  When applied, that would result in a commit title like
this:

	1/4] patch-ids: stop using a ...

because we stop at the first ']', and we do not bother to count up
to "matching bracket".

    git format-patch --subject-prefix='PATCH v2'

or even better

    git format-patch -v2

would have been more appropriate.
