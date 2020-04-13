Return-Path: <SRS0=K77S=55=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 456BDC2BA2B
	for <git@archiver.kernel.org>; Mon, 13 Apr 2020 23:34:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 013152072A
	for <git@archiver.kernel.org>; Mon, 13 Apr 2020 23:34:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="n7F/B0Vm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390003AbgDMXeJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Apr 2020 19:34:09 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:55489 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727839AbgDMXeG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Apr 2020 19:34:06 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C29A0C421E;
        Mon, 13 Apr 2020 19:34:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=9kIUt3vsfnLED6PY4ua8I/RD3rk=; b=n7F/B0
        VmtSBZ4/OTKRLQLLFWkBUGVumIwIxgLOPswfDDsXixwwUng76XPz7dSU1EzeOuKY
        6ngd3X2B7iiL18YywvVbhXWzAGIx7uqiPP76G4tTUw6Lu6vB5RlkiiOitcUaqZxs
        x9N8QWMKDx5u2Je23ndV4/ki1lZez9N8xKiUc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Tb9FSLIGUpfraHNL3RonKPYHIkUumj5s
        74NpUSxqM4c25fxhPKmBs2pAAx4CJCmA0ZgWUFJz8U2okJPuIrYtXKUojzTlt5u1
        6gR2LY7zTIlQFVrDOYddfs212RKx0QKp2atc1oc+aGMJGXtH26zjnNonlIjmc8W2
        odXO0r9zj6I=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id BBD32C421D;
        Mon, 13 Apr 2020 19:34:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 15697C421B;
        Mon, 13 Apr 2020 19:34:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Greg Hurrell <greg@hurrell.net>
Cc:     git@vger.kernel.org
Subject: Re: git-grep's "-z" option misbehaves in subdirectory
References: <CAOyLvt9=wRfpvGGJqLMi7=wLWu881pOur8c9qNEg+Xqhf8W2ww@mail.gmail.com>
Date:   Mon, 13 Apr 2020 16:33:59 -0700
In-Reply-To: <CAOyLvt9=wRfpvGGJqLMi7=wLWu881pOur8c9qNEg+Xqhf8W2ww@mail.gmail.com>
        (Greg Hurrell's message of "Mon, 13 Apr 2020 23:55:48 +0200")
Message-ID: <xmqq8sizarko.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4110D3DC-7DDF-11EA-983E-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Greg Hurrell <greg@hurrell.net> writes:

> $ git grep -lz --full-name content
> nested/other "example".txt^@
>
> Seeing this on Git v2.25.0 on macOS (10.13.6).
>
> Does this seem like a bug, or expected behavior?

Sounds like a very ancient bug, possibly as old as the -z option
itself.



