Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A89142018E
	for <e@80x24.org>; Mon,  8 Aug 2016 17:29:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752449AbcHHR3k (ORCPT <rfc822;e@80x24.org>);
	Mon, 8 Aug 2016 13:29:40 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59418 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752422AbcHHR3h (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Aug 2016 13:29:37 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 85AD833655;
	Mon,  8 Aug 2016 13:29:36 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=fEyMjhILVh3OdTtmdg0smLSjEBI=; b=UB2dWS
	3bQTOq87WPhTj744VK/ajJN+9TI37i0RnR9ek244OpFrjwwPXKXh/om5heQuwTMW
	DMO2ehEdAHsQ6/VMaTgknKO3oXyViKsRZ/dJAruK8cZpqZLFAxMGozbH8/4rDZH8
	IrB1OihSrbTkhnCwdc+zoa72t1mPaF/kr7LnU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BO77TBmHsJYeK9hateQB6QL9Z3SRAkYI
	+8HIENI2YiDVR+k7yulL8SumESyGbPRc1ijzmPdAfdPgXS7oJo4NImKteSi7B9Qk
	QPdckprjSZSByJaaX504LJ7pfRS5ZcsNK3IHh4z99+DswKtuogpWPIMfIjEdZORR
	uj3j9wW/0UU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7CEF633653;
	Mon,  8 Aug 2016 13:29:36 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E687233652;
	Mon,  8 Aug 2016 13:29:35 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Lars Schneider <larsxschneider@gmail.com>
Cc:	Johannes Schindelin <johannes.schindelin@gmx.de>,
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
Date:	Mon, 08 Aug 2016 10:29:34 -0700
In-Reply-To: <CFDF5DDE-C5D9-489E-B099-6D0D2479B331@gmail.com> (Lars
	Schneider's message of "Sun, 7 Aug 2016 13:09:28 +0200")
Message-ID: <xmqqr39zf9tt.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AD464A62-5D8D-11E6-B3AF-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Lars Schneider <larsxschneider@gmail.com> writes:

>     ... then I am always super
>     eager to send out a new roll just because I don't want any other reviewer
>     to waste time on obviously wrong patches. However, I have the impression
>     that frequent re-rolls are frowned upon.

Correct.  A good middle-ground is to just reply with "Yes, thanks
for your suggestion, will fix in the next round", while receiving
review comments.  Good reviewers who value their time will not to
waste their time by responding on a point that has already been
pointed out and acknowledged.

> 4.) Reviewing patches is super hard for me because my email client does not
>     support patch color highlighting and I can't easily expand context or look at
>     the history of code touched by the patch (e.g via git blame). I tried to setup
>     Alpine but I wasn't happy with the interface either. I like patches with a GitHub
>     URL for review but then I need to find the right line in the original email to
>     write a comment.

Unless a patch is about an area you are super familiar with so that
you know what is beyond the context of the patch to be able to judge
if the change is good in the context of the file being touched, it
is always hard to review from inside a mail reader.

Running "git am" is a good first step to review such a patch, as
that lets you view the resulting code with the full power of Git.
As you gain experience on the codebase, you'll be able to spot more
problems while in your mail reader.
