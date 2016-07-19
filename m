Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3DB1B1FEAA
	for <e@80x24.org>; Tue, 19 Jul 2016 18:46:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750998AbcGSSq4 (ORCPT <rfc822;e@80x24.org>);
	Tue, 19 Jul 2016 14:46:56 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52318 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750722AbcGSSqz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jul 2016 14:46:55 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 0BB3B2BEC6;
	Tue, 19 Jul 2016 14:46:54 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=JD3dp6mzJ1zmcSp2EO0rn3BEdT8=; b=Udrej4
	0pYPPOznhd6UuO/5oak1Xa2NluHXGXfAYHeh7/FIdCsbn2eZepVwjXMzQyPO9WPF
	m0GXP/OhskCEuBsjlHT1epv2d7gBYXa1mdhRy8iDdolCkwln+Onko1I2TPLJbFFH
	7Z5fVzqXN7gpaDJpq1hoOp04bleVTVe506/uk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XDLsXp7O9eqMdO3H10/aeq9WYuwMB+ze
	h7UlGXyHpYU9Sh8WWqNmmv9HDTdz0SCbuDE23vdmoBzusAbPLucWefCf/67b/jFj
	wU2sCE7Dig6DEl0O9LQQN3mvEyZlKljLNUu4RhdKQjDjLCAbkLWChVpUXKJ78RLh
	/7Fi41QqaQY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 0305A2BEC2;
	Tue, 19 Jul 2016 14:46:54 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 7BB242BEC1;
	Tue, 19 Jul 2016 14:46:53 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Duy Nguyen <pclouds@gmail.com>
Cc:	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Herczeg Zsolt <zsolt94@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
Subject: Re: Git and SHA-1 security (again)
References: <CAPp-Vrb_n6z39RLHZ4AeUaBFiJfL3_xX8Utfq7+bTgzZrza58Q@mail.gmail.com>
	<20160716201313.GA298717@vauxhall.crustytoothpaste.net>
	<alpine.DEB.2.20.1607170949360.28832@virtualbox>
	<20160717142157.GA6644@vauxhall.crustytoothpaste.net>
	<CACsJy8AH9Q6rOgvcWGsLGPaP96koGA=k0PYgXP6F3RZ=XAwaSw@mail.gmail.com>
	<CACsJy8CR_fkYL5UYbV1MqiTSe3gTqWfOrA1NOHTw09vZn7Y-Aw@mail.gmail.com>
	<xmqqk2ghh80x.fsf@gitster.mtv.corp.google.com>
	<CACsJy8DyybW5kTWZ2nJ4GN=S46M9rU0EapOrR6PjSV=b1ZFrBw@mail.gmail.com>
Date:	Tue, 19 Jul 2016 11:46:51 -0700
In-Reply-To: <CACsJy8DyybW5kTWZ2nJ4GN=S46M9rU0EapOrR6PjSV=b1ZFrBw@mail.gmail.com>
	(Duy Nguyen's message of "Tue, 19 Jul 2016 19:27:02 +0200")
Message-ID: <xmqqpoq9fotg.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 292CF804-4DE1-11E6-B1D6-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

>> Even though that single operation might be possible, do not go
>> there.  A "pathname" identifies a "path", not its contents, and
>> "appending crap after path" breaks the data model badly.
>
> I thought about that but I thought all those operations required
> special treatment for submodules anyway.

Operatins requiring special treatment does not make it right to
break the data model anyway, so...
