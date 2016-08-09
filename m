Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A62611F859
	for <e@80x24.org>; Tue,  9 Aug 2016 17:25:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932403AbcHIRZW (ORCPT <rfc822;e@80x24.org>);
	Tue, 9 Aug 2016 13:25:22 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58808 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932257AbcHIRZU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Aug 2016 13:25:20 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9C08A31CFF;
	Tue,  9 Aug 2016 13:25:18 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=kedJbiDd5rChryh1bpLUUnzpb0g=; b=C0PkAd
	/GoeiQKHxX+4tN97GrZp+NJwEQMuk32crX86DYDX4RfALQmJknszT+M1JxAlv2wS
	99UMYIKo7lfgB3SwJJFKL8bK65UhLURnujSvh+xewYt9tEdQqo2AJ7pdWW69cT9D
	PbbixON/kfg6UETue5ZNgSMymCYBdY4RmUtcU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=f6Y5AtKrVqO91aUP0LP1DDcRPFtt69Sv
	VZ++QjXMxhl/qhutODF4ik1D2I3O5Uj/rhCkviQo+06KMMq5qzY9VgI2/lmpQ0SI
	mRrEWuMBX6w8nVJ0Z/r7xdwY+zuEBcVpT3DF7nx83JPAfVnlFxO4csGqZ6/vSCgi
	FfqhlmN3mMM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9400731CFD;
	Tue,  9 Aug 2016 13:25:18 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1976A31CF9;
	Tue,  9 Aug 2016 13:25:18 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:	Lars Schneider <larsxschneider@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Git Mailing List <git@vger.kernel.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
	Duy Nguyen <pclouds@gmail.com>,
	Jakub =?utf-8?Q?Na?= =?utf-8?Q?r=C4=99bski?= <jnareb@gmail.com>,
	Eric Wong <e@80x24.org>
Subject: Re: patch submission process, was Re: [PATCH v6 06/16] merge_recursive: abort properly upon errors
References: <cover.1469547160.git.johannes.schindelin@gmx.de>
	<cover.1470051326.git.johannes.schindelin@gmx.de>
	<8ff71aba37be979f05abf88f467ec932aa522bdd.1470051326.git.johannes.schindelin@gmx.de>
	<xmqqlh0gjpr6.fsf@gitster.mtv.corp.google.com>
	<alpine.DEB.2.20.1608021004080.79248@virtualbox>
	<xmqqy44ec15p.fsf@gitster.mtv.corp.google.com>
	<alpine.DEB.2.20.1608031021050.79248@virtualbox>
	<CAPc5daXJzMsJf5K84XBFuQ5=q_OwtYUW2FikZ2QsZWk8fa9jgg@mail.gmail.com>
	<alpine.DEB.2.20.1608031753431.107993@virtualbox>
	<CAGZ79kYWdZCNW_eBi5aLAacyBZJXQ9xyOWMBmjNsYT5NWjr-Og@mail.gmail.com>
	<alpine.DEB.2.20.1608041730130.5786@virtualbox>
	<CAGZ79kaTT3NgKj8akB8t9b1BF3i6sXe7Un9oq5KP8077Wz-E+g@mail.gmail.com>
	<alpine.DEB.2.20.1608050925240.5786@virtualbox>
	<alpine.DEB.2.20.1608061045240.5786@virtualbox>
	<CFDF5DDE-C5D9-489E-B099-6D0D2479B331@gmail.com>
	<xmqqr39zf9tt.fsf@gitster.mtv.corp.google.com>
	<alpine.DEB.2.20.1608091339590.5786@virtualbox>
Date:	Tue, 09 Aug 2016 10:25:16 -0700
In-Reply-To: <alpine.DEB.2.20.1608091339590.5786@virtualbox> (Johannes
	Schindelin's message of "Tue, 9 Aug 2016 13:41:18 +0200 (CEST)")
Message-ID: <xmqqlh05c0sj.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3E00A926-5E56-11E6-B193-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Mon, 8 Aug 2016, Junio C Hamano wrote:
>
>> Unless a patch is about an area you are super familiar with so that you
>> know what is beyond the context of the patch to be able to judge if the
>> change is good in the context of the file being touched, it is always
>> hard to review from inside a mail reader.
>> 
>> Running "git am" is a good first step to review such a patch, as that
>> lets you view the resulting code with the full power of Git.  As you
>> gain experience on the codebase, you'll be able to spot more problems
>> while in your mail reader.
>
> I am glad that you agree that the requirement to manually transform the
> patches back into Git (where they had been originally to begin with) is
> cumbersome. This is the first time that I see you admit it ;-)

I was about to apologize for writing a statement that can be
misread, but I do not think what I wrote can be misinterpreted, even
if a reader deliberately tries to twist the words s/he reads, to
lead to such a conclusion, so I won't.

I merely said that reviewing a change in an unfamiliar area is
harder (not "cumbersome", but "needs understanding first") with a
patch, and it is easier to see changes in context by applying (which
is an easy, not "cumbersome", process).

