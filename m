Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 62E00203E2
	for <e@80x24.org>; Mon, 25 Jul 2016 18:11:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753613AbcGYSLf (ORCPT <rfc822;e@80x24.org>);
	Mon, 25 Jul 2016 14:11:35 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53678 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753604AbcGYSLa convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Jul 2016 14:11:30 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 7037A2D86E;
	Mon, 25 Jul 2016 14:11:29 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=KWwWSvTogjtc
	HSYSVDW5JPa7TyM=; b=eBuXfBRxBS8v7pxHGlkZky1W6iGdFobG2jrnNsV1VDqv
	oCW0vcZD0qHOyg2U+A+AvA1GQXcZ+HAjxbgfn4BsNIhGq8GWYRj7j8GRWUiioQP3
	g6A0LYHkgs8D6ogS3T6xLfzzIBd3BCI62V2x2fZPILbVwYOxZeZrJiTRZmvDPl4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=OjunUr
	c2LSE/A56Us4SkdL00Rp00M2VzIwW2UmyI+sGxkZVSVktyXSTPikCh6pYDwPd6rX
	K32SAcNXuBku9qOckUW0yzWYtmQaJHPehcLT7sRx+aakd76zMiwx5zNERVCTqRkE
	lznI4bW7O1ScF/0VynyQ0tKZMD0FGZRciSUl0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 698D52D86D;
	Mon, 25 Jul 2016 14:11:29 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id EB6762D86C;
	Mon, 25 Jul 2016 14:11:28 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Duy Nguyen <pclouds@gmail.com>
Cc:	Git Mailing List <git@vger.kernel.org>, Eric Wong <e@80x24.org>
Subject: Re: [PATCH] config.mak.uname: correct perl path on FreeBSD
References: <20160725162125.15734-1-pclouds@gmail.com>
	<CAPc5daWNAWjtfR7CYN3RTeT7VyvgiNX5HED0=f3F=GT8h4yKPA@mail.gmail.com>
	<CACsJy8Df2cBAf0bWe1FLTb9cOqTX3vgNgC=ko82rG2in81R-FQ@mail.gmail.com>
Date:	Mon, 25 Jul 2016 11:11:26 -0700
In-Reply-To: <CACsJy8Df2cBAf0bWe1FLTb9cOqTX3vgNgC=ko82rG2in81R-FQ@mail.gmail.com>
	(Duy Nguyen's message of "Mon, 25 Jul 2016 19:27:41 +0200")
Message-ID: <xmqqinvt610x.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 3554261E-5293-11E6-8D62-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: 8BIT
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

> On Mon, Jul 25, 2016 at 6:56 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> On Mon, Jul 25, 2016 at 9:21 AM, Nguyễn Thái Ngọc Duy <pclouds@gmail.com> wrote:
>>> It looks the the symlink /usr/bin/perl (to /usr/local/bin/perl) has
>>> been removed at least on FreeBSD 10.3. See [1] for more information.
>>>
>>> [1] https://svnweb.freebsd.org/ports/head/UPDATING?r1=386270&r2=386269&pathrev=386270&diff_format=c
>>>
>>> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
>>> ---
>>>  Tested with fbsd 10.3, kvm image. But I suppose it's the same as real
>>>  fbsd.
>>
>> Thanks; and we know that older (but not too old that we no longer care about)
>> FreeBSD all have /usr/local/bin/perl?
>
> I'm no fbsd expert but from the first sentence in [1] "Perl has been
> removed from base more than ten years ago..." I would assume it meant
> "... removed from base, _to_ ports system" which means /usr/local for
> all package installation (for ten years for perl). So I think we are
> good.

I guess we didn't follow through

    http://public-inbox.org/git/%3C20160720025630.GA71874%40plume%3E/

and allowed the thread to drift into a tangent?


