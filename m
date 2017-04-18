Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CA9381FA26
	for <e@80x24.org>; Tue, 18 Apr 2017 01:56:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932306AbdDRB4N (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Apr 2017 21:56:13 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50460 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754378AbdDRB4K (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Apr 2017 21:56:10 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DBCB674CF7;
        Mon, 17 Apr 2017 21:56:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=/SJBsZ+E+/wc
        IuSDCZ+LpypMQ7I=; b=PXitl1xmOayOOqDhRyXS7HZnN0a8oGhc9pX9IL0cgAdE
        oY58JgGu28oxOo6WifYFG3IAGLFyWjx3VpNU4Vq6gHHnk6GCb1mXJKsYpzWCyt1D
        CNQ+HCO4k43vEXsIQTQCbEI+q5R6uNSZsWxhFRed8+W8QV2yHUCJUQF8Kmv9yQE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=ULRswm
        f5mDZoaXoBZcRZROMbHz8npPe9vWiNdZlOqAzwLwVl93CJeSKkk6mvhC3rFS7833
        9FOQpLZBT1uy20PC1eJhJ2yuEIzlAZ+k4Ajxxy0chloaLSETDM+HWZMzB6JknG+g
        YAqiCAzeX8PQrUv4A0f5++BlE4AD/e+pl5PNs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D413E74CF6;
        Mon, 17 Apr 2017 21:56:09 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 310B174CF5;
        Mon, 17 Apr 2017 21:56:09 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     David Turner <dturner@twopensource.com>, git@vger.kernel.org,
        Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: What's cooking in git.git (Apr 2017, #02; Sun, 16)
References: <xmqqmvbfij92.fsf@gitster.mtv.corp.google.com>
        <e6f869b1-09c2-88eb-d79d-b0dc2090a632@web.de>
Date:   Mon, 17 Apr 2017 18:56:07 -0700
In-Reply-To: <e6f869b1-09c2-88eb-d79d-b0dc2090a632@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Mon, 17 Apr 2017 11:56:52 +0200")
Message-ID: <xmqqo9vuh420.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 3120B580-23DA-11E7-AD03-C260AE2156B6-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> Am 17.04.2017 um 09:30 schrieb Junio C Hamano:
>> * dt/xgethostname-nul-termination (2017-04-13) 1 commit
>>   - xgethostname: handle long hostnames
>>=20
>>   gethostname(2) may not NUL terminate the buffer if hostname does
>>   not fit; unfortunately there is no easy way to see if our buffer
>>   was too small, but at least this will make sure we will not end up
>>   using garbage past the end of the buffer.
>>=20
>>   Will merge to 'next'.
>
> [Sorry for repeating, but I didn't see a direct reply.]
>
> If a host name doesn't fit then the buffer is too small.  Let's make it
> big enough, reducing the number of magic constants and avoiding silent
> truncation all at the same time.  Patch for that:
>
> -- >8 --
> Subject: [PATCH] use HOST_NAME_MAX to size buffers for gethostname(2)
>
> POSIX limits the length of host names to HOST_NAME_MAX.  Export the
> fallback definition from daemon.c and use this constant to make all
> buffers used with gethostname(2) big enough for any possible result
> and a terminating NUL.
>
> Inspired-by: David Turner <dturner@twopensource.com>=20
> Signed-off-by: Rene Scharfe <l.s.r@web.de>
> ---

Thanks.  Let's have this one immediately before David's
xgethostname() patch on the same topic branch.

The fact that the length of my_host[] vs locking_host[] being
different still remains, though.  I do not know if it matters.
