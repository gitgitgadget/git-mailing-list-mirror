Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B26B02018B
	for <e@80x24.org>; Mon, 18 Jul 2016 19:17:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752050AbcGRTRt (ORCPT <rfc822;e@80x24.org>);
	Mon, 18 Jul 2016 15:17:49 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64441 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751865AbcGRTRs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jul 2016 15:17:48 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 659282CCEF;
	Mon, 18 Jul 2016 15:17:47 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=EmDYoSJ/5DIlgqWCjuKF79HEZ1c=; b=ptC3xK
	vrninUhHUyqLx+sCrdUEzRsLOOx679cH2IU0gRIOQtKVqj8SQAfskPba/rFur71I
	WzmkLoRLlm0SmLGZnws1pP7fwvWNn3cbvDPStQfvRUjSFmeTv7Dg0JNfXxDGf92t
	BL3jNwjrhqL6ePMgoW/xIPOLJ+ZuWFcxUS9N8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Pdxqo1yo+JviEhBhkqkPIsoGmRWl/Wvx
	tnjU4PUI76gPF3oMnlf5AAPZOMlikIhrOk5KFOiUnv6jgFLtYKrJWEV8+OnBFNZa
	N6bruYpUn8ODttdx1oIjF05TwWjnNcgEdupVIdrOA27CCBGOgDWTwhEhPCjbcAgZ
	NWY0zMTimP0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 5CCC02CCEE;
	Mon, 18 Jul 2016 15:17:47 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D28E02CCED;
	Mon, 18 Jul 2016 15:17:46 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Jeff King <peff@peff.net>
Cc:	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Eric Wong <e@80x24.org>,
	=?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
	git@vger.kernel.org
Subject: Re: [PATCH] test-lib: stricter unzip(1) check
References: <20160718064431.GA10819@starla>
	<20160718130405.GA19751@sigill.intra.peff.net>
	<alpine.DEB.2.20.1607181536540.3472@virtualbox>
	<xmqqtwfmkduk.fsf@gitster.mtv.corp.google.com>
	<20160718185634.GA24726@sigill.intra.peff.net>
Date:	Mon, 18 Jul 2016 12:17:44 -0700
In-Reply-To: <20160718185634.GA24726@sigill.intra.peff.net> (Jeff King's
	message of "Mon, 18 Jul 2016 12:56:35 -0600")
Message-ID: <xmqqy44yiwmf.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4F733B6A-4D1C-11E6-82AD-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Mon, Jul 18, 2016 at 11:20:19AM -0700, Junio C Hamano wrote:
>
>> Stepping back a bit, why do we even care if "unzip -a" works on
>> "../$zipfile" and converts things correctly in that check_zip() test
>> in t5003 in the first place?  It looks more like a test on "unzip"
>> than making sure we correctly generate a zip archive to me...
>
> I think it is testing that we generated an archive with the correct "I
> am text" flags so that an unzip implementation can do the
> auto-conversion.

Yes, I understand that.  I was hoping for a response along the lines
of "we want to make sure we mark text as text, and 'zip -l' has an
option to let us check the attributes without having to actually
checking things out" ;-)


