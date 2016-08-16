Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B17142018E
	for <e@80x24.org>; Tue, 16 Aug 2016 19:07:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751936AbcHPTG4 (ORCPT <rfc822;e@80x24.org>);
	Tue, 16 Aug 2016 15:06:56 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61062 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751584AbcHPTG4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Aug 2016 15:06:56 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 463B73595D;
	Tue, 16 Aug 2016 15:06:55 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4qIH8VvEwcGvSW35QaBAWQjLw0I=; b=Poxh9c
	ROYGpOiqjN12padHpOdl4yuuQVR3UkicDhV10/7yBMYSSJjbhWxP55Pt1sm6s1wP
	vO4SCNu/EUY5kMsEK4xyJyik23ln4oP0V95WOFqxdwMde0MpHrCmdpEBLFEzqAkC
	PSPu+DQ0+hMFybtXCgYezR0VMXFFIqL8NRNUQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=C3cYHX3biMJB2abJpxmuxQGrnK0zLr+E
	ChpsZ8+bfeO6tWlsARuI3Oujsz/kAFmUmBm+3q4ey91GP54o4F/JRqVF3U76fGqE
	FpNvdf0HWyeMgR8+nUcRFR6IvvPPUuOJe59UTYi16FKA4wF8q2hW5syjLg3szjTM
	y/bmuGAIlYs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 3B9393595C;
	Tue, 16 Aug 2016 15:06:55 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 695973595B;
	Tue, 16 Aug 2016 15:06:54 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Ralf Thielow <ralf.thielow@gmail.com>
Cc:	git <git@vger.kernel.org>,
	Lars Schneider <larsxschneider@gmail.com>,
	Joseph Musser <me@jnm2.com>,
	Philip Oakley <philipoakley@iee.org>,
	John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH v3] help: make option --help open man pages only for Git commands
References: <20160815053628.3793-1-ralf.thielow@gmail.com>
	<20160816162030.27754-1-ralf.thielow@gmail.com>
	<xmqq60r0ei9k.fsf@gitster.mtv.corp.google.com>
	<CAN0XMOL2WZkh17v-7OtA8AMbzs4NUuj8xPVwJBD-PnK4fBaUFw@mail.gmail.com>
Date:	Tue, 16 Aug 2016 12:06:52 -0700
In-Reply-To: <CAN0XMOL2WZkh17v-7OtA8AMbzs4NUuj8xPVwJBD-PnK4fBaUFw@mail.gmail.com>
	(Ralf Thielow's message of "Tue, 16 Aug 2016 19:57:00 +0200")
Message-ID: <xmqqd1l8cz3n.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9896B478-63E4-11E6-8B6B-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Ralf Thielow <ralf.thielow@gmail.com> writes:

> 2016-08-16 19:27 GMT+02:00 Junio C Hamano <gitster@pobox.com>:
>> Ralf Thielow <ralf.thielow@gmail.com> writes:
>>> +
>>> +     if (swapped)
>>> +             return help_unknown_cmd(cmd);
>>
>> I am guilty of suggesting "swapped"; even if we are going to mark
>> this as OPT_HIDDEN, I think we should be able to think of a better
>> name.  I think the meaning of this boolean is "we know that this is
>> not a guide and is meant to be a command.", and I hope we can come
>> up with a name that concisely expresses that (e.g. "--not-a-guide",
>> "--must-be-a-command").
>>
>
> I think "--cmd-only" is a good name.  With a good name I think it's worth
> to make this option visible to the user.

Sure.  I'd prefer "cmd" to be spelled out in anything that is
end-user facing, though.
