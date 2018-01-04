Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 34C8E1F404
	for <e@80x24.org>; Thu,  4 Jan 2018 18:22:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751770AbeADSWu (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 Jan 2018 13:22:50 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50098 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751563AbeADSWt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Jan 2018 13:22:49 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A1B3EC9977;
        Thu,  4 Jan 2018 13:22:48 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=ergYFGNxCiPJ
        +fMEsPoRP7PR5JY=; b=wYriQ4auNn2JQFCOpHkm0IlP6mvsFYYXOY/4kEs7AZ5I
        FPxJ2OSTN2kTKoCeRzbKG8HZL7+CwVFBv4tkhZFw1VC+2dYI6HsU+stzAxqgLkAX
        /Bi/9pQ1S4ckugyKNTb9dzJt3Z9ZrXBAAEQ/xPF1WDpIjD1fYMkHh2tJmtocFlk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=FzZwBf
        D53KI1CHqk0EgY6h0uo7yuGConGzddxjxK/gUiRoa0d4nXUIvr6ZnrAMqwEmbcNk
        o5xakNvV8DwtLouDxermoOZXEQtkEIOvW4yXQ+04ey2fbQv6mo903KE1Wc2g1vLC
        cOlvh3VmM0cC2wk1T2LK832bz/5p+r+iN/M/M=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 99863C9976;
        Thu,  4 Jan 2018 13:22:48 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 19A12C9975;
        Thu,  4 Jan 2018 13:22:48 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     suzuki toshiya <mpsuzuki@hiroshima-u.ac.jp>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH] git-archive: accept --owner and --group like GNU tar
References: <20171229140535.10746-1-mpsuzuki@hiroshima-u.ac.jp>
        <df39f62558314cf6a9d9df3e23f31dd8@OS2PR01MB1147.jpnprd01.prod.outlook.com>
        <5A4B2DA5.907@hiroshima-u.ac.jp>
        <59a1fc058278463996ed68c970a5e08a@OS2PR01MB1147.jpnprd01.prod.outlook.com>
        <955dae095d504b00b3e1c8a956ba852a@OS2PR01MB1147.jpnprd01.prod.outlook.com>
        <5A4D9089.3050209@hiroshima-u.ac.jp>
        <f7654cd9-2cd0-0775-3b10-8e3dc1a66dae@web.de>
Date:   Thu, 04 Jan 2018 10:22:46 -0800
In-Reply-To: <f7654cd9-2cd0-0775-3b10-8e3dc1a66dae@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Thu, 4 Jan 2018 17:59:50 +0100")
Message-ID: <xmqqmv1tfpqh.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 443D2E30-F17C-11E7-9525-8EF31968708C-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> I don't know if it's a good idea, but perhaps we don't even need a new
> option.  We could change how pathspecs of untracked files are handled:
> Instead of aborting we could include them in the archive.  (Sounds like
> the simplest possible interface, but may have practical problems.)

One practical problem is that users who do this

    $ git archive HEAD Documentation/ | tar tf -

would be expecting (at least) two different things, depending on the
situation they are in.

So at least you'd need an "--include-untracked" option, I guess.
