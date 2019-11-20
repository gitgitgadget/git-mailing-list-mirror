Return-Path: <SRS0=iiTG=ZM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73294C432C0
	for <git@archiver.kernel.org>; Wed, 20 Nov 2019 03:50:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CE872240D
	for <git@archiver.kernel.org>; Wed, 20 Nov 2019 03:50:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="lbX19cQy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727608AbfKTDua (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Nov 2019 22:50:30 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:63766 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727415AbfKTDua (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Nov 2019 22:50:30 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id DF6059749A;
        Tue, 19 Nov 2019 22:50:29 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+KEvOKPrsGe8Qco3Jr48fl35EyQ=; b=lbX19c
        QyBNCcEsT9WVjfvXvdKVbJQXYQjhhq72dRwb9nRydXiPwkNlTl+LoLVhYQF+qi27
        CQTpH6NXobBQQiDPzb9iWnU+GpxuBrlDDiKqj6pp3kW/hRazsDD+NCw5MHaCYQM1
        L3UpmH/GKiLkb3FoHUViCQdXx7atShBX7kGso=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=jh2kWHZov1fuiSufiBmWTNMv0LdyX6Qv
        zxJG6tTP+Ekf0+HLFXThpnnTBh8awsHua14fmNvdlpTfBb4mZOnKKxP+dhgqgpOe
        XXBxE//IVh7TxjQEMtC0Pg0ACYSTHNyKSglG6jAMMgcc7vNauA7Ffa4kS+alZ51t
        nSj8EViZSq0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D7E7597499;
        Tue, 19 Nov 2019 22:50:29 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id F2AF797498;
        Tue, 19 Nov 2019 22:50:26 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christoph Berg <myon@debian.org>
Cc:     git@vger.kernel.org
Subject: Re: git clone git clone some://url
References: <20191119141537.GD18924@msg.df7cb.de>
Date:   Wed, 20 Nov 2019 12:50:24 +0900
In-Reply-To: <20191119141537.GD18924@msg.df7cb.de> (Christoph Berg's message
        of "Tue, 19 Nov 2019 15:15:37 +0100")
Message-ID: <xmqqimnfcikf.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E3781B30-0B48-11EA-8656-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christoph Berg <myon@debian.org> writes:

> On some git hosting sites [*], if you copy the repository URL, you'll
> actually get "git clone some://url" in the cut buffer. When you then
> proceed to do "git clone <paste>" in the next terminal window, the
> command executed is actually this:
>
> $ git clone git clone some://url
> fatal: Too many arguments.

Or

    $ git git clone some://usr
    $ git git git diff

;-)

I seriously doubt "git" should do anything funky when fed such
command lines.

