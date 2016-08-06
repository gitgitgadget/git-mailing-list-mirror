Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6FDE11F859
	for <e@80x24.org>; Sat,  6 Aug 2016 20:09:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751321AbcHFUJw (ORCPT <rfc822;e@80x24.org>);
	Sat, 6 Aug 2016 16:09:52 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64399 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750912AbcHFUJv (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Aug 2016 16:09:51 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 695123113F;
	Sat,  6 Aug 2016 14:33:24 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=kd9Hw2lnyYb/QBm19OurLBDgP1A=; b=iLVszY
	Dd0U3dw6drNzGPodjJzStWvcbl9H6LG5u5adr89vp7X37MMSF0OYY+3FqleEqJn8
	FT3yaZl68wmgqs13AsHJWSBvWcbCEXJ5TzL2N6oSl1HUgeT9HCdKOadW8mROXmpK
	BukfuGTbjpfE4QZkcvPeKsGgWoo4bnQ78HdT0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vfCFO+Cd2a8G0pz9He5WrrKH/e/45BwP
	cktCx35hkXcuXF/hKb5OWO91wy7zMCxTvrjlguJSrW6+psTMz4IQf3u6Ixab3F3u
	eOBSBqaZnRq6JFiJFLKjAt2l3tKbhOtfCEILiWqi8NtEZMZ81XnCS/vgx4i0dNr1
	/CgYgr1B5z0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4F8133113E;
	Sat,  6 Aug 2016 14:33:24 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C61593113C;
	Sat,  6 Aug 2016 14:33:23 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:	Stefan Beller <sbeller@google.com>,
	Git Mailing List <git@vger.kernel.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
	Duy Nguyen <pclouds@gmail.com>,
	Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>,
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
	<CAGZ79ka5OknKYo_CgBpB16EQjwU5B35yNFWx569K-LPmHuSqWA@mail.gmail.com>
	<alpine.DEB.2.20.1608061045240.5786@virtualbox>
Date:	Sat, 06 Aug 2016 11:33:21 -0700
In-Reply-To: <alpine.DEB.2.20.1608061045240.5786@virtualbox> (Johannes
	Schindelin's message of "Sat, 6 Aug 2016 10:58:52 +0200 (CEST)")
Message-ID: <xmqq8tw9iw7i.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 42091D90-5C04-11E6-B3D4-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> The problem is not Perl, but how fiddly it is to set up. And that you lose
> all the niceties of an email client (e.g. when you want to add a comment
> before the diff stat that is not intended to become a part of the commit
> message).

Just this part.  I do not think that is fair to send-email.  You are
blaming its "feature" that allows it to drive format-patch, which I
do not consider is the proper part of the command and to which I
kept saying from the early days of its introduction that I'd never
use it and I think we should discourage its use exactly because it
encourages a bad workflow (i.e. you skip the final proof-reading
before sending out, and you cannot add footnote comments).

Treat it like an MSA just like Thunderbird, just designed to be more
suited to send out patches without corruption, and you will be OK.
You work, commit and write your message with your favourite editor,
do format-patch, reword or add footnote with your favourite editor,
and then send it out.  You can avoid letting other MSAs that may
corrupt whitespaces touch what you will send out if you used
send-email, but that is not mandatory.  As long as your favourite
MSA does not corrupt your message, you can use it.

Somebody mentioned "configuring it is hard--why does the user have
to know SMTP subtleties", and that may be a valid complaint against
the primary part of send-email.  The solution for that is not to
discard it with bathwater, but make it just as easy as other MSAs,
say, Thunderbird, to configure for an average user who can configure
these other MUAs.
