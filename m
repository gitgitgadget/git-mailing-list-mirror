Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0AFAC433F5
	for <git@archiver.kernel.org>; Thu, 13 Jan 2022 09:33:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231844AbiAMJdC (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Jan 2022 04:33:02 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:57189 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231216AbiAMJc6 (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 13 Jan 2022 04:32:58 -0500
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 1E8535C0242;
        Thu, 13 Jan 2022 04:32:56 -0500 (EST)
Received: from imap46 ([10.202.2.96])
  by compute2.internal (MEProxy); Thu, 13 Jan 2022 04:32:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=artagnon.com; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type:content-transfer-encoding; s=fm1; bh=EU7VY
        /oIbTOt48HCEnGIyleLc0Br5p8k17xWGeP6tzQ=; b=ov2WwSLVwWExfjtCg/1H+
        9Wjej9IVEqyPotaDIS1do9LY8b52x7b/RFn9ICFo98QzxSSxcVskk6T2uLWOsfeO
        lT+nQPn9nZXt8WDfABQNNqOWOIZwNZS/6iz/udDcP3OpdL+vFVWwMVqE+BCE4sHs
        6ngoZxz4LjatrVeTXEE68/yrqbxuIbPAF4uvYPhCgl1l5jEuOuJJwOC+SnzMGciW
        0sBaaeqesD+fXLFxkASOJF6su5nx1PyTn55g2iEWCsnk08eW8EzJlitpDQARXjmi
        ivLcXK3MgatzSjQaatYXrrAKApVQYiVZtxtGZH+GhfLQRrSCqul5Cs/19tLO1mZF
        g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=EU7VY/oIbTOt48HCEnGIyleLc0Br5p8k17xWGeP6t
        zQ=; b=FYGTykYqaT0VYJeFdZT62exzy+cxGuLW8CI6ZYHvdvJuBwrK3RCWoX0KC
        R70n8YxVz2hP9YqCdAOI/cyuomY86IAAtv7Ql6LVc/6wZJ5JUvGNlqRPHRXHrJ45
        dZ1w1WsXMSbexZWxI+4fDbkw50lLNbdMgxCr4KpdFs7dzUFeO6OxDMo0xZ90fEmN
        1rIuhC6HPh7bAWjZh1vRhyomE27PDTqIi4Evf/Rh3FGKQN5UtGsG58ZvVK6iHbba
        u5QBAoZOCdDu3G0z9WK2vRGeTPTEEzTKM3T8wzd4FmPtW32W6zYIoFZaPd5Gz9QQ
        y6z2K4m1GIThA1QX1ClE6FaJJs/8A==
X-ME-Sender: <xms:x_HfYbepf611HSDABELmBysMlbOFnOobaDDnIHPYDlPnJD0f_4L3wg>
    <xme:x_HfYRPJfwBr9Mz3XcKANMO5vEUU0uruKmrudA_igAM_Htnsafsm4dIEYGY6A-IFI
    KJ9UwDJhckl_t20Db8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrtdefgddtfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvufgtgfesthhqredtreerjeenucfhrhhomhepfdftrghm
    khhumhgrrhcutfgrmhgrtghhrghnughrrgdfuceorhesrghrthgrghhnohhnrdgtohhmqe
    enucggtffrrghtthgvrhhnpeekveeukeeiudelkefgleetudehffekgeevffehleejgeek
    veetieetkeevvddvheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehrsegrrhhtrghgnhhonhdrtghomh
X-ME-Proxy: <xmx:x_HfYUgH9NOMpp7gYuRmEDKbZbKEgSksyLBDMWQIVzxapPTJMBvMDw>
    <xmx:x_HfYc81tegIQ8Yi2HZOkLzWQD1eACuRe6BP4Lojp18ALCKdJGveMw>
    <xmx:x_HfYXunlzyq6Cs1_SisIVGZLmyNuVFLEjydOpyDoJlsXCcRH9q8zQ>
    <xmx:yPHfYQWMCf9WKR6fNJVkHXskqaPSYvDfemfia9dIE3NeBk8yNhCoCA>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id D78E71EE007D; Thu, 13 Jan 2022 04:32:55 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-4569-g891f756243-fm-20220111.001-g891f7562
Mime-Version: 1.0
Message-Id: <421215c1-f6ae-4ec2-b666-2a481056ef79@www.fastmail.com>
In-Reply-To: <5be4cdad-6769-68e8-0984-5fe89668d007@web.de>
References: <1edfc6ff-4db8-447f-9eb7-85843258a286@www.fastmail.com>
 <xmqqilus3ctf.fsf@gitster.g>
 <fead25d6-6f5f-487a-ad4c-0657fe9785fd@www.fastmail.com>
 <xmqq4k6b34h8.fsf@gitster.g>
 <bafa9564-fa48-413d-bbef-3f068c03dd31@www.fastmail.com>
 <3dade45b-494f-663b-264b-06a51ea1cf56@web.de> <xmqq35lsyhbf.fsf@gitster.g>
 <13e323e9-eb0c-71c3-215f-b77c91fcc4c8@web.de>
 <5be4cdad-6769-68e8-0984-5fe89668d007@web.de>
Date:   Thu, 13 Jan 2022 10:32:35 +0100
From:   "Ramkumar Ramachandra" <r@artagnon.com>
To:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        "Junio C Hamano" <gitster@pobox.com>
Cc:     "Git List" <git@vger.kernel.org>,
        "Christian Couder" <christian.couder@gmail.com>
Subject: Re: git bisect bad @
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe wrote:
> > Am 12.01.22 um 18:50 schrieb Junio C Hamano:
> > So exit code values are only very vaguely standardized.  It's very
> > possible that there are programs that use 126 or 127 to signal
> > something other than "can't execute" or "cannot find command".  Under
> > the new rules the bisect run script would have to translate them to
> > some lower value.
>=20
> Reserving 126 and 127 shouldn't cause too much trouble, but there's
> also a way to avoid it: bisect run could checkout a known-good
> revision first and abort if the script returns non-zero for any
> reason, including its non-existence.

I can't say I'm overly enthusiastic about this trade-off. I think most p=
eople would check their bisect scripts against the good revision by hand=
 before starting bisect: why introduce one redundant step for users like=
 me who tend to bump their heads, because they're a bit rusty with machi=
nes?

Again, I don't know if this is a good idea, but if exit codes from the s=
hell aren't standardized, surely fork() and exec() would have a better s=
pec? So, perhaps remove the little git-bisect.sh and rewrite it in C? I'=
d be up for this task, if we decide that this is a better way to go.

Warm regards,
Ram
