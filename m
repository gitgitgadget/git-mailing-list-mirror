Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AD019202DD
	for <e@80x24.org>; Mon,  2 Oct 2017 04:07:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750792AbdJBEH3 (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Oct 2017 00:07:29 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63733 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750740AbdJBEH2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Oct 2017 00:07:28 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 62747A3543;
        Mon,  2 Oct 2017 00:07:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=wbE8xH1XZdJw
        iYVerMBkYoK7pdc=; b=MV+xSBpkP6TshRF1sDjklYvsBmpqSJLuKxfmVvdHL46h
        ysjqa3E5hveFbyT3VA20DkZInHukZsj9qbrQOL78vpkdMOfzryh56fMupHWuIuzS
        /vQ3xF0HCnZZCwIeKGvccWNcO4Cr7Xej3LRjwhbOlA0NnuNmCMdw5zILa9mEB74=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=vjQMge
        YVSRgelQ4a/pu3sYlr+zAnImQZfa/rTCuYqyu9SICY245qnNpNAM82gW7e7nTvu0
        olBlaKgCh7VdzjQd2ER4m+n5uubymFCkeqYMNK2dkDzjiGc4KQRvrs302ibesF2h
        TJWLkCLsZV0S0Ad439QomaXw9+t9m8i4vJy8o=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 598A9A3542;
        Mon,  2 Oct 2017 00:07:28 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C5397A3541;
        Mon,  2 Oct 2017 00:07:27 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] builtin/: add UNLEAKs
References: <20171001174208.1693753-1-martin.agren@gmail.com>
Date:   Mon, 02 Oct 2017 13:07:26 +0900
In-Reply-To: <20171001174208.1693753-1-martin.agren@gmail.com> ("Martin
        =?utf-8?Q?=C3=85gren=22's?= message of "Sun, 1 Oct 2017 19:42:08 +0200")
Message-ID: <xmqq1smmqjk1.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 3420D12C-A727-11E7-B319-575F0C78B957-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin =C3=85gren <martin.agren@gmail.com> writes:

> ... While addressing `msg` in builtin/tag.c, convert the existing
> `strbuf_release()` calls as well.

That part of this patch made me raise eyebrows a bit but only
slightly.  We are about to leave the function to exit anyway, and
all the other that got new UNLEAK(var) at the end are doing the same
thing.

So overall I think this patch makes sense.  Thanks.
