Return-Path: <SRS0=RB3M=7H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D40DFC433DF
	for <git@archiver.kernel.org>; Mon, 25 May 2020 17:27:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 668322078B
	for <git@archiver.kernel.org>; Mon, 25 May 2020 17:27:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Qf96H6Q7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391326AbgEYR1N (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 May 2020 13:27:13 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51794 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389251AbgEYR1N (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 May 2020 13:27:13 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 202F56D76A;
        Mon, 25 May 2020 13:27:11 -0400 (EDT)
        (envelope-from tmz@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
        :cc:subject:message-id:references:mime-version:content-type
        :in-reply-to:content-transfer-encoding; s=sasl; bh=6qiOUTx9s61/2
        WlMXXm9mEwc79k=; b=Qf96H6Q78p0sOj+udP+UsCOa7bdq5fKl+JFO5+N/t900j
        RUTBZrmleJdRORlMcDwHtDRnFFW3GEFaocACbIMPsc4RqMkfUb+lrlIWEUTHkjKD
        ZDQfQhGWyMjFRgSKp9X9hmII35R/orDZTh0Y6h3fe6LL+nVmODLqeomvkgrto8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=date:from:to:cc
        :subject:message-id:references:mime-version:content-type
        :in-reply-to:content-transfer-encoding; q=dns; s=sasl; b=PLle5cS
        htDkSQCE6qomtO9CfPeUq8UDyekrwS3lcAT5CcDYyPLGJZKZJxIDE3zIsLAdGFqO
        uLclxXWG8WnY6l0dMQYuolzs+gY8WLZK50zdD7aeXAUmdGF4B3NlShRFylwBozrM
        y7eTBV7BiyQna8P5j65k671fvd5LnkJIJy3M=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0F0666D769;
        Mon, 25 May 2020 13:27:11 -0400 (EDT)
        (envelope-from tmz@pobox.com)
Received: from pobox.com (unknown [71.254.198.10])
        (using TLSv1.2 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6C9226D768;
        Mon, 25 May 2020 13:27:10 -0400 (EDT)
        (envelope-from tmz@pobox.com)
Date:   Mon, 25 May 2020 13:27:08 -0400
From:   Todd Zullinger <tmz@pobox.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Son Luong Ngoc <sluongng@gmail.com>,
        Shourya Shukla <shouryashukla.oo@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Martin =?iso-8859-1?Q?=C5gren?= <martin.agren@gmail.com>,
        git@vger.kernel.org
Subject: Re: What's cooking in git.git (May 2020, #08; Sun, 24)
Message-ID: <20200525172708.GT6611@pobox.com>
References: <xmqqh7w4pulj.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <xmqqh7w4pulj.fsf@gitster.c.googlers.com>
X-Pobox-Relay-ID: F7183B46-9EAC-11EA-8C7B-C28CBED8090B-09356542!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Junio C Hamano wrote:
> Git 2.27-rc2 will be tagged soon, but most of the topics planned for
> it are already in 'master'.

There's a minor issue in the ss/faq-ignore topic which
breaks the doc build on CentOS/ RHEL 6 that was mentioned by
Son Luong Ngoc=B9.  The "." in the anchor text causes an issue
for the older doc toolchain on these systems.

I included a simple patch for that in a reply=B2.  I haven't
seen any discussion on it one way or another.  At the risk
of pestering, I thought I'd mention it in case it had just
flown under everyone's radar during this busy time.

On one hand, the doc build toolchain on CentOS / RHEL 6 is
old and those systems will be EOL at the end of November.
So we might find it acceptable to stop supporting the doc
build there.

On the other hand, the fix/workaround is quite trivial and
nearly imperceptible to readers of the documentation.  The
problematic "." in ".gitiginore" only appears in the anchor
link for HTML viewers or in the plain text for readers of
the .txt file:

    [[files-in-.gitignore-are-tracked]]

vs.

    [[files-in-gitignore-are-tracked]]

I'm not sure there's enough value in keeping the "." in this
case to justify breaking the doc build for users stuck on an
old CentOS / RHEL 6 system.

I think the risk of applying the patch is sufficiently low
that it would be worth including in 2.27.0.  That is, unless
there is a strong opinion that the "." is quite useful or
that even low effort isn't worth taking to support such an
old doc toolchain.

=B9 https://lore.kernel.org/git/CAL3xRKdwOASiGys+7Uu_OA5kBPrTdAURfEw3UQ+r=
guTXT+C6JQ@mail.gmail.com/
=B2 https://lore.kernel.org/git/20200519045301.GY24220@pobox.com/

Thanks,

--=20
Todd
