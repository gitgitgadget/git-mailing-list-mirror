Return-Path: <SRS0=P8cE=5O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5E86C2D0E9
	for <git@archiver.kernel.org>; Sun, 29 Mar 2020 05:49:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFEBB2074A
	for <git@archiver.kernel.org>; Sun, 29 Mar 2020 05:49:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="EiI67UpH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726198AbgC2Ft1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 29 Mar 2020 01:49:27 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63673 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725834AbgC2Ft1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Mar 2020 01:49:27 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1D103605B6;
        Sun, 29 Mar 2020 01:49:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=tCc9YnCPZPh8
        +Ic49yz6GQKSvRU=; b=EiI67UpHn2HoANKt2lvRKsizFbbJoxiGF4Ts4spFJ6JE
        ln9BNrf8qWqwvG0KwZaTZsSq1PNSUfmwYRErsrkYEPQ77u8f+KordWA76L1RsCW5
        xQVyrF9XONlmT2VgFw35lungMAukgmPXzFZvwPP9k3oqyLQHtA8tDv9D9jn4C5c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=jks9PV
        48xCTbtBHpj/z4zP4bDF0uldpRKhbNHFF3dTmfYXMJonkKXX0SZUpAayf8j4ct71
        Y6QgYYUcANt/idq6ZxLnn1P3PatdzJ0wRGZCDbDa96/P2+2X54X6UYoxgnee45OF
        cgFaR+Qdsbt3547QIo48k7yRb6XyifbIBUg34=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 058EC605B5;
        Sun, 29 Mar 2020 01:49:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 706C7605B4;
        Sun, 29 Mar 2020 01:49:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/3] add travis job for linux with musl libc
References: <cover.1585203294.git.congdanhqx@gmail.com>
Date:   Sat, 28 Mar 2020 22:49:23 -0700
In-Reply-To: <cover.1585203294.git.congdanhqx@gmail.com> (=?utf-8?B?IsSQ?=
 =?utf-8?B?b8OgbiBUcuG6p24gQ8O0bmc=?=
        Danh"'s message of "Thu, 26 Mar 2020 14:35:16 +0700")
Message-ID: <xmqq4ku7d82k.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 0B6F3346-7181-11EA-9D65-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh  <congdanhqx@gmail.com> writes=
:

> Recently, we've un-broken git for Linux with musl libc,
> and we have a serie to fix false negative with busybox shell utils.
>
> There is a sample travis build for this serie applied on top of master:
> https://travis-ci.org/github/sgn/git/builds/667111988
>
> And, after merging with my v4 to fix busybox false negative:
> https://travis-ci.org/github/sgn/git/builds/667112197

I have this topic near the tip of 'pu' and it seems to be finding
issues not in your build with 'master'.  I'd expect that we'll be
seeing patches to various parts of the system from you or others
with musl libc to correct them, after which we can merge the topic
down.

Thanks.
