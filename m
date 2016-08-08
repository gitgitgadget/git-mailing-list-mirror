Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C37A51FD99
	for <e@80x24.org>; Mon,  8 Aug 2016 01:58:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751955AbcHHB5t (ORCPT <rfc822;e@80x24.org>);
	Sun, 7 Aug 2016 21:57:49 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50099 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751671AbcHHB5s (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Aug 2016 21:57:48 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 11B8533310;
	Sun,  7 Aug 2016 21:57:47 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9OHEhcUq+1DT2vUgzGwwzsT/h58=; b=Er9R2A
	RlToM9+EnrbN7ShcWIZWVymrPMJZVFzPhcVrr5CG28dRs0LgLkR5vjDMd5NBwO51
	CLTbTEloFr6wx2IUZC1Ub//gJ6pM0zZOyPpkublAWRsO+mN7FCADi7oO/9FO2S55
	cEdpYsRj4gle8UHbtCkDrHLcw5bAaOrIqlhW8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MibZZDK3ROnlQ5LupJllZQdX5c9sHPBU
	6Bxuzlbr2ka4jrdDUc3d4qwXyPdXrfGoO3ApgjO3I6pVC/bK0AtIa8Hf9QYzdMyA
	8Fs5Q3YeiJ6RcaDRrZ+TMijDdVYd58RfZ4zWhj7B+IS3nzkftnegnu5HV/gOMOk6
	jupWhj69vsQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 08E4D3330F;
	Sun,  7 Aug 2016 21:57:47 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8D9FE3330E;
	Sun,  7 Aug 2016 21:57:46 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Eric Wong <e@80x24.org>
Cc:	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff Hostetler <git@jeffhostetler.com>, git@vger.kernel.org,
	Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v5 4/9] status: collect per-file data for --porcelain=v2
References: <1470434434-64283-1-git-send-email-git@jeffhostetler.com>
	<1470434434-64283-5-git-send-email-git@jeffhostetler.com>
	<xmqqbn16vnlf.fsf@gitster.mtv.corp.google.com>
	<alpine.DEB.2.20.1608071026120.5786@virtualbox>
	<20160807222903.GA462@starla>
Date:	Sun, 07 Aug 2016 18:57:44 -0700
In-Reply-To: <20160807222903.GA462@starla> (Eric Wong's message of "Sun, 7 Aug
	2016 22:29:03 +0000")
Message-ID: <xmqqy448ggyv.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 80A8842A-5D0B-11E6-87C9-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Eric Wong <e@80x24.org> writes:

>> > Not a big deal (no need to resend for this one alone), but let's
>> > make the above properly formatted, i.e.
>> > 
>> > 		if (ce_stage(ce)) {
>> >                 	...
>> > 		} else {
>> >                 	...
>> > 		}                        
>> 
>> Do I understand correctly that your objections is against having the curly
>> brace before the "else" on its own line?
>> 
>> If so, when did our coding style change? I vividly remember that we
>> strongly favored putting the "else" on a new line after a closing brace,
>> to make diffs nicer in case the braces were removed or added.
>
> AFAIK, Linux kernel CodingStyle has always been what Junio
> suggested (just w/o the trailing spaces :),
> and we inherit from that.

What Eric said.

While I admit that I sometimes break line between "}" and "else {"
by inertia when I am being careless and get caught by checkpatch.pl
myself, I do not recall trying to justify it; you probably may
remember somebody else saying that, but I don't recall anybody
making that argument on the list, and more importantly I don't
recall us making that our style based on that argument.

The only two and half kinds of warnings we knowingly ignore from
scripts/checkpatch.pl in the Linux kernel source tree are:

 * "Avoid typedefs."  We do avoid making graduitous use of typedef to
   hide a structure behind a type and pretty much limit ourselves to
   use it for (callback) function types, though.

 * "We've never heard of Helped-by/Mentored-by footers"; well,
   kernel folks may not, but we have ;-)

 * "No spaces for bitfield width".  This may not be justifyable, but
   the majority of our bitfield widths are defined in the way not
   blessed by checkpatch.pl checker.
