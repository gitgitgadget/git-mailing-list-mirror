Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B6D3C43331
	for <git@archiver.kernel.org>; Tue,  9 Feb 2021 20:54:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45EEF64EB4
	for <git@archiver.kernel.org>; Tue,  9 Feb 2021 20:54:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234127AbhBIUxi (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Feb 2021 15:53:38 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:56095 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233925AbhBIUnQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Feb 2021 15:43:16 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4B32310C46A;
        Tue,  9 Feb 2021 15:42:34 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=A0AkypZY3I7+
        i6zPvCRShll427g=; b=Lv/C3zmeXwgNKuPscipCrXo1Xvz/K3DiXw/SG9MRP9EG
        8x4pBRjmAbUNsZk6MuCkS98SygmclDQp6SFt1NTy72l2uCn6EYRppdxoZYzce08R
        WO0XGygbqgM7rLXp7v2GTku8yV3gk6vxV7kDDSWn5yCd/ufLhXfkoK+FUYi8mno=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=a1QT6q
        usqH/gjhHqVelnvd5tbmT4gbvb5FA8KNbIn3akzgZtyFcXIUc2L4ZH8A5XHM28a9
        RLZfNFqzPXYJXXRWgNpSXf5QOPYbd4wEWrXxHRRcDQJ5xLDUDYbbx+asWeIZFGwN
        3WV3C1muAhwNvY8PoP6O95yk9lB0zUi+uH6HM=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4415F10C469;
        Tue,  9 Feb 2021 15:42:34 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 8793F10C468;
        Tue,  9 Feb 2021 15:42:31 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eli Schwartz <eschwartz@archlinux.org>
Cc:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>, git@vger.kernel.org
Subject: Re: gitattributes export-subst and software versioning
References: <7418f1d8-78c2-61a7-4f03-62360b986a41@archlinux.org>
        <ac1288b8-5cdf-8e1e-702a-815c5fbc2da3@web.de>
        <4f65f02c-1d16-aa2c-3e7b-28d807b9ebe9@archlinux.org>
Date:   Tue, 09 Feb 2021 12:42:29 -0800
In-Reply-To: <4f65f02c-1d16-aa2c-3e7b-28d807b9ebe9@archlinux.org> (Eli
        Schwartz's message of "Mon, 8 Feb 2021 19:19:59 -0500")
Message-ID: <xmqqpn190y8a.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 54C7ADBC-6B17-11EB-91A0-D609E328BF65-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eli Schwartz <eschwartz@archlinux.org> writes:

>> And replacing the flags with a commit slab doesn't seem to be enough,
>> either -- I get good results lots of commits, but for some git log wit=
h
>> the new placeholder would just show some nonsensical output, as it
>> seems to get the depth calculation wrong for them somehow.
>
> You mean git describe <commit> produces wrong results for those?

Running "describe" as an external command, like the patch you are
responding to does, would not produce any wrong result, but R=C3=A9ne's
point is that it would be very involved to turn "describe" into a
function that can be called as if it is a library function without
disrupting the operation of "log" that is running in the same
address space, and the change he tried had some weird bugs to get
the computation wrong.

