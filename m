Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-7.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 832C92018A
	for <e@80x24.org>; Fri,  1 Jul 2016 16:08:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752025AbcGAQIy (ORCPT <rfc822;e@80x24.org>);
	Fri, 1 Jul 2016 12:08:54 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50856 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751218AbcGAQIy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jul 2016 12:08:54 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6FE0F2786D;
	Fri,  1 Jul 2016 12:08:47 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6cxLeZN22WNEPsdcHJSBmIPsQFU=; b=Yw1n+7
	etLTEhrkRNAozaALodrUrLe8EUxiBZee9d/Tlvfmv2RR68EwDvzY1YbGrB7z7wUK
	xO7tjzfdNUZnTH//o0O3EgNvtQjY3oDDWTodu18kz/QyL2mAzuNdMXvJfMWbei6o
	J0qXcCO7pSCIsi/zF2G16yFVhgREpjeTI5H5A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Bv5LyZW7oTIynW3fqlTFSy3sATwjc2NM
	J/ih8sDUhRTx8txs9nn9JJJK5jqk4gRzOOPrE61cYqg7DsPuAp9WmEFnUfjoTpiC
	Ieiv56Ffluzi4P2Vv53rZJ3Pci3oM4WMW3eZTwTswVY0c6hbf1Qg8uzVzc8GZ3TM
	k1vwewWuoNo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 67FE72786C;
	Fri,  1 Jul 2016 12:08:47 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E7C022786B;
	Fri,  1 Jul 2016 12:08:46 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Jeff King <peff@peff.net>
Cc:	Linus Torvalds <torvalds@linux-foundation.org>,
	Jakub =?utf-8?Q?Nar?= =?utf-8?Q?=C4=99bski?= <jnareb@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Marc Strapetz <marc.strapetz@syntevo.com>,
	Git Mailing List <git@vger.kernel.org>
Subject: Re: topological index field for commit objects
References: <f15a14a5-f39d-9c41-16b9-fe0a48d7450b@syntevo.com>
	<CAPc5daVC-+0Vr30L_pbcL0GN2OmnGm-+V4tE2WTos_vPRb_S1g@mail.gmail.com>
	<CAGZ79kY6Ry+DfO90wza_RrVbCRAgNB4N=0W6svuJgvGNxeFh5Q@mail.gmail.com>
	<xmqqk2h73f2i.fsf@gitster.mtv.corp.google.com>
	<20160629205647.GA25987@sigill.intra.peff.net>
	<5774426F.3090000@gmail.com>
	<20160629220049.GA4416@sigill.intra.peff.net> <5774F4C7.805@gmail.com>
	<CA+55aFy2AEe7ew5Px=2Uit6hraGV9zFr=JZ57rSYXWMQ4nMjeg@mail.gmail.com>
	<20160701031711.GA4832@sigill.intra.peff.net>
Date:	Fri, 01 Jul 2016 09:08:44 -0700
In-Reply-To: <20160701031711.GA4832@sigill.intra.peff.net> (Jeff King's
	message of "Thu, 30 Jun 2016 23:17:12 -0400")
Message-ID: <xmqqlh1lz6gj.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 17594770-3FA6-11E6-8D35-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> So I think it would be more productive to put a check like this in "git
> commit" rather than (or perhaps in addition to) fsck. That prevents
> us creating the broken relationship, but it does still mean the user may
> have to to go back and tell the original committer that their clock was
> broken.
>
> You could also have the fsck check look not only for out-of-order
> commits, but also commits in the future (from the perspective of the
> receiver). That would reject such broken commits before they even hit
> your repository (though again, it is unclear in such a case if the
> commit is broken or the clock of the checker).

I agree 100% with the above two paragraphs.
