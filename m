Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 23D14203E2
	for <e@80x24.org>; Mon, 25 Jul 2016 20:42:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752909AbcGYUmZ (ORCPT <rfc822;e@80x24.org>);
	Mon, 25 Jul 2016 16:42:25 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51686 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752835AbcGYUmX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Jul 2016 16:42:23 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 4E1E12EE1B;
	Mon, 25 Jul 2016 16:42:22 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=T1Ylj23T1c/F
	bpT3/JQpEyxHVZI=; b=dfe6sk1oavPI7x+fIPwvuAWDaK3oyWS7BkvrPkQh4oyC
	3esdqlOWA61+MVDHbF4B+lbrfpzNlmFf69N2bgjoUhDP49VOZfMPx8nVl5lbok9a
	cGBMnY76ntJxXgCU4DLpPt+nMrK8oM+8u4oMhe1esXc4k958a938ps9LqWXB6bE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=MSYPAz
	J/xUGZJ567KcmRSdy81wabbSt/K1U9VZjmnzBlPIBEywxbj9L9A0R5jjb11+cq7P
	WNUMIAHdM+6nKJqeZTaktk+4EKU97L0iTrIriGas2zMdhH75a4siNGn1LMkQb2mL
	HukHgTJiXHrjLCFBeTe2j4NWGKkdGUiscW/sM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 4703F2EE1A;
	Mon, 25 Jul 2016 16:42:22 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C50232EE19;
	Mon, 25 Jul 2016 16:42:21 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Eric Wong <e@80x24.org>
Cc:	Duy Nguyen <pclouds@gmail.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] config.mak.uname: correct perl path on FreeBSD
References: <20160725162125.15734-1-pclouds@gmail.com>
	<CAPc5daWNAWjtfR7CYN3RTeT7VyvgiNX5HED0=f3F=GT8h4yKPA@mail.gmail.com>
	<CACsJy8Df2cBAf0bWe1FLTb9cOqTX3vgNgC=ko82rG2in81R-FQ@mail.gmail.com>
	<xmqqinvt610x.fsf@gitster.mtv.corp.google.com>
	<20160725203316.GA32053@starla>
Date:	Mon, 25 Jul 2016 13:42:19 -0700
In-Reply-To: <20160725203316.GA32053@starla> (Eric Wong's message of "Mon, 25
	Jul 2016 20:33:16 +0000")
Message-ID: <xmqqoa5l4fh0.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 493E24EE-52A8-11E6-ADAC-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: 8BIT
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Eric Wong <e@80x24.org> writes:

> Junio C Hamano <gitster@pobox.com> wrote:
>> Duy Nguyen <pclouds@gmail.com> writes:
>> 
>> > On Mon, Jul 25, 2016 at 6:56 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> >> On Mon, Jul 25, 2016 at 9:21 AM, Nguyễn Thái Ngọc Duy <pclouds@gmail.com> wrote:
>> >>> It looks the the symlink /usr/bin/perl (to /usr/local/bin/perl) has
>> >>> been removed at least on FreeBSD 10.3. See [1] for more information.
>> >>>
>> >>> [1] https://svnweb.freebsd.org/ports/head/UPDATING?r1=386270&r2=386269&pathrev=386270&diff_format=c
>
> Ah, I missed that.  I guess that explains why nobody complained
> about the problem sooner.
>
>> >>> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
>> >>> ---
>> >>>  Tested with fbsd 10.3, kvm image. But I suppose it's the same as real
>> >>>  fbsd.
>> >>
>> >> Thanks; and we know that older (but not too old that we no longer care about)
>> >> FreeBSD all have /usr/local/bin/perl?
>> >
>> > I'm no fbsd expert but from the first sentence in [1] "Perl has been
>> > removed from base more than ten years ago..." I would assume it meant
>> > "... removed from base, _to_ ports system" which means /usr/local for
>> > all package installation (for ten years for perl). So I think we are
>> > good.
>> 
>> I guess we didn't follow through
>> 
>>     http://public-inbox.org/git/%3C20160720025630.GA71874%40plume%3E/
>> 
>> and allowed the thread to drift into a tangent?
>
> +Cc Dscho
>
> I've been meaning to followup on that, but had connectivity
> problems to my VM last week.  I still prefer we use numeric
> comparisons for version numbers since numbers are... numeric.
> IOW, I prefer we go with my original patch.

I tend to agree with you if we have to do "systems older than this
should use /usr/bin, others should use /usr/local/bin", but this
different incarnation of the same topic seems to claim that older
ones had /usr/local/bin forever anyway, and that was what made the
patch interesting.

