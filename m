Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 971F51F855
	for <e@80x24.org>; Mon,  1 Aug 2016 20:41:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754230AbcHAUlH (ORCPT <rfc822;e@80x24.org>);
	Mon, 1 Aug 2016 16:41:07 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60294 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753319AbcHAUlE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 1 Aug 2016 16:41:04 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id F24B0319EA;
	Mon,  1 Aug 2016 16:41:02 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=TH8rX08Ohxws
	4DFIkjRihrI9ht8=; b=P19rs0lxUp7imVnrrt5yqvHlid82d981AlzAnyqB+NWf
	ECgnZeS10QkBZHizyGNetLCUYOIRD/r3MHo/7gyFK94dQB+BiBtTWnulb1Cn8gHV
	+nU+O/uUJKq9Y4Lb+dCDvFXc23tFpINGxapGXyPwb4JnPrSvLhDuHqgSQSZWEFg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=xhR88R
	u9r9XzKEoZgIArSp2WMuSA84pdDHgkw8mIqEYOcO1yYaLNCjcoOaQif/3uIQO7Kr
	hm8+0s1UA8YZV3LzA7iW5oJo/Zb5bHR/HKFScUQc49URuVfQI7jFIAsDlNNruuSg
	CmK1RHP/ncuasLuiUv8Q04S9ngvHHUZY530KU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id EB43F319E9;
	Mon,  1 Aug 2016 16:41:02 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 7DA88319E7;
	Mon,  1 Aug 2016 16:41:02 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Jeff King <peff@peff.net>
Cc:	=?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
	Git List <git@vger.kernel.org>
Subject: Re: [PATCH] use strbuf_addstr() for adding constant strings to a strbuf
References: <579CE597.4060009@web.de>
	<20160801164929.ezalmutcrc3erc22@sigill.intra.peff.net>
Date:	Mon, 01 Aug 2016 13:41:00 -0700
In-Reply-To: <20160801164929.ezalmutcrc3erc22@sigill.intra.peff.net> (Jeff
	King's message of "Mon, 1 Aug 2016 12:49:29 -0400")
Message-ID: <xmqqd1lsi5nn.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 42DF4B5C-5828-11E6-B498-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: 8BIT
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Sat, Jul 30, 2016 at 07:36:23PM +0200, René Scharfe wrote:
>
>> Replace uses of strbuf_addf() for adding strings with more lightweight
>> strbuf_addstr() calls.
>> 
>> In http-push.c it becomes easier to see what's going on without having
>> to verfiy that the definition of PROPFIND_ALL_REQUEST doesn't contain
>> any format specifiers.
>
> Nice. I care a lot less about whether "addf" or "addstr" is more
> efficient. But the second point, that it makes the intent clearer, is a
> big win.

Yes!
