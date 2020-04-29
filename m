Return-Path: <SRS0=05is=6N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 664B9C8300A
	for <git@archiver.kernel.org>; Wed, 29 Apr 2020 20:37:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 427C120B1F
	for <git@archiver.kernel.org>; Wed, 29 Apr 2020 20:37:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="xycrZ/nq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727991AbgD2Uhl (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Apr 2020 16:37:41 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:64640 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726858AbgD2Uhk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Apr 2020 16:37:40 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0D4BEB0274;
        Wed, 29 Apr 2020 16:37:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=GalcPFXo7NWjl6Ndx1FmVs6xcws=; b=xycrZ/
        nq26XeHdpI7zzCmoJ6vPXUjHZVVupZqD3L2woPPEu2u9DXo5KAfZ4pM3IBAxTUR2
        oE4JV3VXzxCv4bFsJ2dms4jDKHxpyyJTnpFRECge27tJXtG4dqdGw0EpqvVvP7DV
        dAtOx/HvElYMMauhiwBUfc7C+Pbb4KKAw6eBQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=PNWUIJnEPCzdwNeD37IxHODdmZRc1dXn
        14VHX0bWb/3SyWpEKu+ZX5YrzEhOBwEiMF9fy83IsA+gNqtdalLbZFcVYxw92DgJ
        Fw4GJwqE7y994JNy+uJT3AvnkYtF7joAuvyx/H6zEJmXaPd3RrvjQnMe7opcrG4O
        Tfb5SqR8Fzg=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 04801B0271;
        Wed, 29 Apr 2020 16:37:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 25D8DB0270;
        Wed, 29 Apr 2020 16:37:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Sergey Organov <sorganov@gmail.com>,
        Ivan Tham <pickfire@riseup.net>, git@vger.kernel.org,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH] branch: add '-' to delete previous branch
References: <20200429130133.520981-1-pickfire@riseup.net>
        <877dxyo1k8.fsf@osv.gnss.ru> <20200429190013.GG83442@syl.local>
        <87v9likr5a.fsf@osv.gnss.ru> <20200429195745.GC3920@syl.local>
        <xmqqa72uvy7n.fsf@gitster.c.googlers.com>
Date:   Wed, 29 Apr 2020 13:37:33 -0700
In-Reply-To: <xmqqa72uvy7n.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Wed, 29 Apr 2020 13:22:36 -0700")
Message-ID: <xmqq5zdivxiq.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 41F7EE3A-8A59-11EA-AA26-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Taylor Blau <me@ttaylorr.com> writes:
>
>> Again, not sure that this is always the case. This *is* how 'git
>> checkout' works.
>
> To be honest, I am somewhat sympathetic to those who find "-" ==
> "@{-1}" unless it is used as an argument to "git checkout/switch".

Insert "confusing" before "unless".  Sorry about the typo.


> The use of "-" in "checkout" is the exception, not the norm, and it
> was sort of justifiable due to similarity to "cd -".  Both are
> commands to the computer you give to "go to the previous place".
>
> "git merge -", "git branch -d -" etc. are not about *going* to the
> previous place, and declaring the "-" is "previous place" is taking
> it a bit too far, at least to my taste.
>
> Oh, I do not like those who advocate "@" as a synonym for "HEAD",
> either.  If there is one simple thing I want to get rid of from the
> system, that's it ;-).
>
> Anyway...
