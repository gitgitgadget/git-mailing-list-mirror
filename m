Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B6B46203E2
	for <e@80x24.org>; Mon, 25 Jul 2016 14:58:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752802AbcGYO61 (ORCPT <rfc822;e@80x24.org>);
	Mon, 25 Jul 2016 10:58:27 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53812 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752400AbcGYO6Z (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jul 2016 10:58:25 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4982F2F593;
	Mon, 25 Jul 2016 10:58:24 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=pNUe8pHG/QjJGhFd4DNUjFH68JE=; b=CD1n8i
	3JIFHNZfGdmF86GYA3M9uvz9quQSG26UZbw7LBBtyXn+fXvxjmG+L4auipEf92oR
	wLeCM0N+CgIqcG7lr5UrjFINnKoWj+JfbE4zlzVnR92rezsyLl9e2mYYYtcj0Onv
	vmkgDJwQoKPn2i5Hyp4EUo41AyAUG8djjCjxU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WyO6sTkhEL1qJboHqtb8yZFHike6J5KR
	935VfzA0HmYv5ANtk2fRCnEBDyAEqS7+2f1lINgBhDz0yjhsMLFiVIZ/gCVJn8Sy
	HG9TpoVU/fo8+2GDl0CF3uTlJ0vLSnQCVfzd5SZgs/SmFa3UTUlVV1KevCGNrT5p
	Z/SEdWqjwUM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 40CC62F591;
	Mon, 25 Jul 2016 10:58:24 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B4ACA2F590;
	Mon, 25 Jul 2016 10:58:23 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Heiko Voigt <hvoigt@hvoigt.net>
Cc:	Git List <git@vger.kernel.org>, Stefan Beller <sbeller@google.com>,
	Lars Schneider <larsxschneider@gmail.com>,
	=?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH] submodule-config: use explicit empty string instead of strbuf in config_from()
References: <578E7A07.8080006@web.de> <20160720082515.GA823@book.hvoigt.net>
	<57911AFF.7030107@web.de> <20160725143706.GA4872@sandbox>
Date:	Mon, 25 Jul 2016 07:58:21 -0700
In-Reply-To: <20160725143706.GA4872@sandbox> (Heiko Voigt's message of "Mon,
	25 Jul 2016 16:37:07 +0200")
Message-ID: <xmqq60rt933m.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3C08D524-5278-11E6-83C8-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Heiko Voigt <hvoigt@hvoigt.net> writes:

> Thats a good idea. Can send a patch, but I noticed that your change is
> already in next and my change has not been picked up. So I am unsure if
> I should base my patches on next or if Junio wants to keep your change?

When you noticed something you want to touch up in 'next' but not in
'master', please try to find which topic the target of your
touching-up comes from.

	git log --first-parent <other options> master..next

I often use --oneline for <other options>, because I am reasonably
familiar with the topics in 'next', but people may start from "git
blame" output, finding the commit that left the text you are
touching up, then where it was merged to 'next'.  That would give
you

commit 59dbd5834007c1e4dff25770da095babcb69a009
Merge: 679f992 508a285
Author: Junio C Hamano <gitster@pobox.com>
Date:   Tue Jul 19 13:43:44 2016 -0700

    Merge branch 'rs/submodule-config-code-cleanup' into next
    
    Code cleanup.
    
    * rs/submodule-config-code-cleanup:
      submodule-config: use explicit empty string instead of strbuf in config_from()

The second parent 508a285c (submodule-config: use explicit empty
string instead of strbuf in config_from(), 2016-07-19) is a good
place to base your patch.

Thanks.



