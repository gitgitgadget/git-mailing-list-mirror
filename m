Return-Path: <SRS0=GnTn=7I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 415DAC433E0
	for <git@archiver.kernel.org>; Tue, 26 May 2020 18:33:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F31DC206F1
	for <git@archiver.kernel.org>; Tue, 26 May 2020 18:33:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="pDBR8Kjl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730210AbgEZSdU (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 May 2020 14:33:20 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63827 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728113AbgEZSdU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 May 2020 14:33:20 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B435675577;
        Tue, 26 May 2020 14:33:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=WEnkJxKJoImhaSL+EJtzZMztduo=; b=pDBR8K
        jl5BIaUr9C2rtDEKjFlwyUyTlIiU11p6uAcHN11W6xkxegc8G3QrAG4fl2jvEcfc
        7UReAfEzYgWOxwNYAjbFfW75pyMbReQ8zCLS31bBFYy+ebodyg90J9SPLqG/sFtv
        pKjq5pQaxCF3Aa/wTfF48wbn/D73LCeH7uptw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=dilqdhC653uzpBT+owfS7nEK3F8SsXSJ
        X6J1d5oFKLHpKsPV4YQ5U/BK9lXt1JBx6zOL736TcD2XWPapTMo52RgUQhQWWi0b
        tJIhUdNpInkgq8QLPXW4/fdyi8GC0oxMB5Tq75BIVTNyNxqUOtL6ddZnZ5q6nTWA
        pMt8+twuHQY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A5F3A75576;
        Tue, 26 May 2020 14:33:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.231.104.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1DD0C75575;
        Tue, 26 May 2020 14:33:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     ydirson@free.fr
Cc:     git <git@vger.kernel.org>
Subject: Re: [BUG] diff algorithm selection issue
References: <505382066.1036329918.1590513687177.JavaMail.root@zimbra39-e7>
Date:   Tue, 26 May 2020 11:33:18 -0700
In-Reply-To: <505382066.1036329918.1590513687177.JavaMail.root@zimbra39-e7>
        (ydirson@free.fr's message of "Tue, 26 May 2020 19:21:27 +0200
        (CEST)")
Message-ID: <xmqq5zcio8b5.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5EFA99D4-9F7F-11EA-A65C-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

ydirson@free.fr writes:

>> Or is it rather intended to be `--diff-algorithm=default --minimal`,
>> whatever the default may be in the future ?
>
> Now that I think about it, do we really want "minimal" as a valid choice
> for --diff-algorithm, if it's not a choice of algorithm ?

I asked the same question to myself before writing my first response
but it is way too late to ask it now.  I do support the spirit of
"--minimal", but not "--diff-algorithm=minimal" which may be an
ill-thought-out shorthand for "--diff-algorithm=default --minimal".

If you dig the list archive, I would imagine that you would find
that not an insignificant part of list participant back then thought
it was a good idea ;-)


