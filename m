Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2E6B02021F
	for <e@80x24.org>; Tue,  2 Aug 2016 21:00:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757107AbcHBVA2 (ORCPT <rfc822;e@80x24.org>);
	Tue, 2 Aug 2016 17:00:28 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63626 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757145AbcHBVAT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Aug 2016 17:00:19 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id B992A317AE;
	Tue,  2 Aug 2016 17:00:17 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/FMOdOsGW1xHRIxRYpeEf2akrCY=; b=ISrY1G
	t+442NXSopKXQ+S+Yygb0OP0H7eG8tjT30IjME56N6t3VpDGuUTwRfP1zDNm6zXJ
	SHPplGeW1e4IPO75GHW8bD5ik+GCHoqUnLNPrcVJPyPsRD5MS4DM/cQJcUSIgCBn
	UcD5E9TIMbm3XpuWu2Cjcg4rJnRazWx7k+piw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=SmBMcePqqzpC3BRPy4AvVh06s2lo9D+m
	e1aMO+snu0R+u7Ay3X6HDIuZtvdSHr3Lbizvw6+oueCvt53POLgxOGtVUSYwqsAl
	Rwbaqm0JaOB2doY6BtsFpYeZlQSEprVbUxcMUomp5nP6mFyQqiR/+rajYLZccf1i
	NxDsLu6RCZU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id B04E9317AD;
	Tue,  2 Aug 2016 17:00:17 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 34161317AC;
	Tue,  2 Aug 2016 17:00:17 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Oleg Taranenko <olegtaranenko@gmail.com>
Cc:	git <git@vger.kernel.org>
Subject: Re: git bisect for reachable commits only
References: <CABEd3j8VLbpeWbA6BfHYp5aLPEy0PesqYoHM9u4OM=b7Qm=LDg@mail.gmail.com>
	<xmqqinvonwxc.fsf@gitster.mtv.corp.google.com>
	<CABEd3j-MW--YSC9=nwcgHzxd6cqmUY+ky3-wLxMiMmbBGsvS7Q@mail.gmail.com>
	<CABEd3j--sxCwv6fWmNxTtdpgwU0_YKbfiFONX6TsQFZGn79yuQ@mail.gmail.com>
	<CAP8UFD118RdB5dX2-wEm5VnKud7sirHhdC9kvWmXV0eAQHvfsA@mail.gmail.com>
	<xmqq7fc0jmhx.fsf@gitster.mtv.corp.google.com>
	<CAP8UFD315CgntwYiC9g-R7KN0XiL9635Vwv_y8yi4n-uj8o90A@mail.gmail.com>
	<xmqqwpk0f5jr.fsf@gitster.mtv.corp.google.com>
	<CABEd3j_6DNgs1u5AdkkzWt7U=J2fZ4a-2jewVjkfExt0KPvWiQ@mail.gmail.com>
Date:	Tue, 02 Aug 2016 14:00:15 -0700
In-Reply-To: <CABEd3j_6DNgs1u5AdkkzWt7U=J2fZ4a-2jewVjkfExt0KPvWiQ@mail.gmail.com>
	(Oleg Taranenko's message of "Tue, 2 Aug 2016 12:15:06 +0200")
Message-ID: <xmqqinvidgyo.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1D8A48F8-58F4-11E6-8F59-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Oleg Taranenko <olegtaranenko@gmail.com> writes:

> First, assuming the common ancestor is GOOD based on the fact that
> some descendant given as GOOD is pretty bad idea.

What you claim is fundamentally incompatible with the way "bisect"
works as a O(log(n)) operation.  It is likely that your definition
of Good for the purpose of your bug-hunting needs to be rethought if
you want to take advantage of "bisect".

> I have another request to get git bisect more user-friendly, regarding
> rolling back last step or steps, if accidentally 'git bisect bad' or
> 'good' was wrong entered, but I think it worth for another thread.

Are you aware that you can check $GIT_DIR/BISECT_LOG and replay it
to recreate any previous state of the bisection?  That would
probably help.
