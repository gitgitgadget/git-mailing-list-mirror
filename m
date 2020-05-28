Return-Path: <SRS0=eul5=7K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F390C433DF
	for <git@archiver.kernel.org>; Thu, 28 May 2020 15:54:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41AE120814
	for <git@archiver.kernel.org>; Thu, 28 May 2020 15:54:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="De/U7F5N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404807AbgE1Py6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 May 2020 11:54:58 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:57826 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404629AbgE1Py4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 May 2020 11:54:56 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E1D39CBF16;
        Thu, 28 May 2020 11:54:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=UtkOmT1wR8iR
        cUl5JMIiN6pltEk=; b=De/U7F5NVE83jq88cD0HhPXF2J/NPemf9VqgmeFMjjhy
        cwwIrMrb/UocuLRN2f08h7vNBLLD/pwIx7FsiKeOD2SzauNXXzk9Df7NgYjsl3HT
        NG0jTib/owIySPCKmbOo4uTZBCrUoDrRx5hdmRZ29VdC7Fen+ayknfV0XPF3YYo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=k9vZBx
        6xEA5u7B8ImH3kQRx1nKQk5OdTiZgsn4060q8t6mC1B97YLTkFQFKDgRBZHPfABn
        JVe9asYgZ3eOOnGcq5IcstVLP/MpDOi2onkHim3V0s6aar63Uba8SV48TSvTnlWX
        4wmzyWYiM3h1cA2RZXscA/IsNr50DptxRAhN4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id DB6D6CBF15;
        Thu, 28 May 2020 11:54:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 0EB70CBF13;
        Thu, 28 May 2020 11:54:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>,
        Marco Trevisan via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Marco Trevisan <mail@3v1n0.net>
Subject: Re: [PATCH] completion: use native ZSH array pattern matching
References: <pull.645.git.1590520398132.gitgitgadget@gmail.com>
        <20200526235834.GG1915090@camp.crustytoothpaste.net>
        <20200527061359.GB40564@Carlos-MBP>
        <20200528021727.GH1915090@camp.crustytoothpaste.net>
Date:   Thu, 28 May 2020 08:54:49 -0700
In-Reply-To: <20200528021727.GH1915090@camp.crustytoothpaste.net> (brian
        m. carlson's message of "Thu, 28 May 2020 02:17:27 +0000")
Message-ID: <xmqqd06o3vhy.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 908F5480-A0FB-11EA-8E2C-B0405B776F7B-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> On 2020-05-27 at 06:13:59, Carlo Marcelo Arenas Bel=C3=B3n wrote:
>> On Tue, May 26, 2020 at 11:58:34PM +0000, brian m. carlson wrote:
>> >=20
>> > This file is necessarily used by both bash and zsh.  Does bash
>> > (including the bash 3 used on macOS) happen to continue to work with
>> > this syntax?
>>=20
>> if by that you meant t9902.[150-152] to succeed with macOS bash?:
>>=20
>> $ bash --version
>> GNU bash, version 3.2.57(1)-release (x86_64-apple-darwin17)
>> Copyright (C) 2007 Free Software Foundation, Inc.
>>=20
>> then I think we can add (on top of master):
>>=20
>> Tested-by: Carlo Marcelo Arenas Bel=C3=B3n <carenas@gmail.com>
>
> Yes, that is what I meant.  I'm glad to know my question has been
> answered and things work.  I'm okay with the patch as it is in that
> case, although I'd give bonus points for mentioning that this syntax
> doesn't regress bash.

True.  And we would want to also have tested-by on more recent
versions of bash, no?
