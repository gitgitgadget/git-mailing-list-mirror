Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 928D21F858
	for <e@80x24.org>; Thu, 28 Jul 2016 20:30:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757563AbcG1Ua0 (ORCPT <rfc822;e@80x24.org>);
	Thu, 28 Jul 2016 16:30:26 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61435 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757542AbcG1UaX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Jul 2016 16:30:23 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 6E38C2F67A;
	Thu, 28 Jul 2016 16:30:16 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=v2JRIqIWjfSd
	BnoBRXlXVQ3gfxw=; b=NzsaxcSp1ESUHF2czFKESCrwsdpcxd+csV1AJxAkOneV
	Jvj9jF+UM8xmDwn9Bllsi8UbzKIj+vJ+sz0OceTYx2Rn49uEb5YKADoinGDr75BG
	it1OqF1Jp1FXRuU180AmpLMHrf9N3nuABykGGB+vz2yu4RDnfKb81y7zvBUKWDs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=OVP3od
	BbTUk9cXGHriYFTY1joi1r/5L4dLEkj4bv5Bo1GfZTx9P3SlGOyRmowq3m//kteK
	UElqj/7dc/RnQDN9IY+xqHOPs18c1FIK024Uzna/ppytODoQ2IhERQT3jfATONIG
	yncYky1VgaGbGrgWxmbPozgNFb2Q9esP6Z1bw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 65BAF2F679;
	Thu, 28 Jul 2016 16:30:16 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D4A092F678;
	Thu, 28 Jul 2016 16:30:15 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>
Cc:	Eric Sunshine <sunshine@sunshineco.com>,
	Johannes Sixt <j6t@kdbg.org>,
	Vasco Almeida <vascomalmeida@sapo.pt>,
	Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH va/i18n-even-more] rebase-interactive: trim leading whitespace from progress count
References: <fa512576-487e-9b9c-3ada-7f0d9b135e4b@kdbg.org>
	<CAPig+cSBZ_Vey2BW8S4D+7ufG1U3a-N402s4zZZJ2OE=xH1+tQ@mail.gmail.com>
	<579A52BD.8050009@gmail.com>
Date:	Thu, 28 Jul 2016 13:30:13 -0700
In-Reply-To: <579A52BD.8050009@gmail.com> ("Jakub =?utf-8?Q?Nar=C4=99bski?=
 =?utf-8?Q?=22's?= message of "Thu,
	28 Jul 2016 20:45:17 +0200")
Message-ID: <xmqqpopxqze2.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 17D4A99E-5502-11E6-8479-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: 8BIT
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Jakub Narębski <jnareb@gmail.com> writes:

> On the gripping hand, the number of currently processed commits
> (instructions) in an interactive rebase is a number, and arithmetic
> expansion can be understood as shell equivalent of casting to integer.

I get that argument; it is a bit too cute a justification for my
taste, but the resulting code is consistent with how $total loses
the potential leading whitespace, so I'll queue it as-is.

Thanks.

>
>>> Signed-off-by: Johannes Sixt <j6t@kdbg.org>
>>> ---
>>> diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
>>> @@ -121,7 +121,7 @@ mark_action_done () {
>>>         sed -e 1q < "$todo" >> "$done"
>>>         sed -e 1d < "$todo" >> "$todo".new
>>>         mv -f "$todo".new "$todo"
>>> -       new_count=$(git stripspace --strip-comments <"$done" | wc -l)
>>> +       new_count=$(( $(git stripspace --strip-comments <"$done" | wc -l) ))
>>>         echo $new_count >"$msgnum"
>>>         total=$(($new_count + $(git stripspace --strip-comments <"$todo" | wc -l)))
>>>         echo $total >"$end"
