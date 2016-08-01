Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 453A51F855
	for <e@80x24.org>; Mon,  1 Aug 2016 17:40:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754462AbcHARk2 (ORCPT <rfc822;e@80x24.org>);
	Mon, 1 Aug 2016 13:40:28 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50222 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754320AbcHARkZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Aug 2016 13:40:25 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 812E730B65;
	Mon,  1 Aug 2016 13:35:25 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Zi6l+i8enDNtZVnPoP97gAQmTfM=; b=DwqMqr
	5XWE/E7InLIPZbRbSK5I8HQLteuyrdPeh16gr5MzEqfijNn7cXYTAMMvUXGyxEQF
	j6yKpILlpmRmmdEZHhqWvbP2XejmeST5r0Z0b35NMKubqa4y2fFP7j4PDq96urXc
	okvxVdN/SCn1Obn8LKGBkhinxPSJFCoZbe/gQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DlzPKGdET4H4gvj3KhxaaXWT7XGktIf7
	oGxSCE4TLj/1lMgnSEKGwA99l/na9RtjVKeRtloHnoKNJuPorcpYAMcgSi+1nQKK
	r36+9g2sOdlyVwUC1bd1Bsu4eTGPRDc2QuWluZGH6a/gGkBSOShp3+H23m/Hg4KY
	O8kWdVIYcs0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 7850B30B64;
	Mon,  1 Aug 2016 13:35:25 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id ECEE230B63;
	Mon,  1 Aug 2016 13:35:24 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Jeff King <peff@peff.net>
Cc:	Josh Triplett <josh@joshtriplett.org>, git@vger.kernel.org
Subject: Re: [RFC] git-format-patch: default to --from to avoid spoofed mails?
References: <20160728211149.GA371@x>
	<xmqq8twlqwan.fsf@gitster.mtv.corp.google.com>
	<20160728215603.GA22865@sigill.intra.peff.net>
	<xmqq4m79qujr.fsf@gitster.mtv.corp.google.com>
	<20160729001618.GA9646@sigill.intra.peff.net>
	<20160729020801.GA14892@x>
	<20160729225800.GA23268@sigill.intra.peff.net>
	<20160730045055.e3t6tpgi6zch4epo@x>
	<20160730054742.iwmr4pavdy5z73rw@sigill.intra.peff.net>
Date:	Mon, 01 Aug 2016 10:35:22 -0700
In-Reply-To: <20160730054742.iwmr4pavdy5z73rw@sigill.intra.peff.net> (Jeff
	King's message of "Sat, 30 Jul 2016 01:47:42 -0400")
Message-ID: <xmqqfuqol7dx.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5461162C-580E-11E6-869B-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Fri, Jul 29, 2016 at 09:50:55PM -0700, Josh Triplett wrote:
>
>> I would propose the following then:
>> 
>> - I'll write a patch adding a config option format.from, along with
>>   documentation, without changing the default.
>> - The release notes for the version of git introducing that config
>>   option should mention, prominently, the plan to change the default in
>>   a future version of git.
>> - A subsequent release can change the default.  No major rush to do
>>   this.
>> 
>> Does that sound reasonable?
>
> That sounds fine to me.

To me, too.

> I do have to admit that after reading through the "format.*" section of
> git-config(1), there is quite a bit that is configurable in it. So
> perhaps we do not need to be as careful about behavior changes as I
> thought.

I am not sure how the first sentence (which I agree with; a random
user can have quite a different behaviour configured when the
command is run without any option) leads to the conclusion in the
second sentence.  The user can break assumptions made by a tool that
reads format-patch output by tweaking his config but at least he
knows that he changed the configuration, i.e. the breakage can be
explained and attributed to his own action.  The change in the
default is somewhat different.

When we _know_ we are going to be changing the default, we should
forewarn in previous releases (in release notes, and perhaps we
would want to have a runtime warning when the user formats others'
changes without having format.from explicitly set to either true or
false).

So the second step can be delayed and does not have to be done for
the release that includes the first change.  But I am not sure how
"there are many format.* configuration" leads to "we just announce
that we changed the default and tell peole there is a new knob to
retain the original behaviour".

> So if you wanted to squish steps 2 and 3 together, that would also be OK
> by me.
