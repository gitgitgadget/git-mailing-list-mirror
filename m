Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4BD041F87F
	for <e@80x24.org>; Mon, 19 Nov 2018 03:33:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728322AbeKSNzX (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Nov 2018 08:55:23 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63051 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726995AbeKSNzX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Nov 2018 08:55:23 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id EBC6011C121;
        Sun, 18 Nov 2018 22:33:08 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=RJbiZM26X4E6
        wQEuZLECwGBJ1PQ=; b=ctrfa/mYaeRYopp97ccb1Lc+DndirV/rq68+IfzJKb4M
        D+vS8rA2mXJGyt3TMbRLYzTJ4OG4YeEBujLdDMxqj3XraEnoDdQrHCau/o8z2zCC
        40YtE/YqIWxTB1jaQOdJCVPWhJ2sFtDNyxR7GSf2ZoxCs0rzbul/Z7nBOBsf3pM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=cJDlf/
        QYyZ2XTjAztc0QO2lRzYG4CESASFc4S1/vU3q0UUstDPqzszJGcBy1PjmbnLCYtS
        M4HbGhwYLnKzO4fDB4USUyfdya/85XyyBWX3fVjcr4Y1mdA3ahOTKkRto5di9h65
        D163O+xtuAWy3SrKigfJEjJHtPwZDqM3+L8+s=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E55EE11C11F;
        Sun, 18 Nov 2018 22:33:08 -0500 (EST)
Received: from pobox.com (unknown [104.155.68.112])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 645A811C11E;
        Sun, 18 Nov 2018 22:33:08 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Randall S. Becker" <rsbecker@nexbridge.com>
Cc:     =?utf-8?Q?'Torsten_B=C3=B6gershausen'?= <tboegi@web.de>,
        "'Steven Penny'" <svnpenn@gmail.com>, <git@vger.kernel.org>
Subject: Re: Cygwin Git with Windows paths
References: <5bf18396.1c69fb81.20780.2b1d@mx.google.com>
        <20181118154124.GA21680@tor.lan>
        <CAAXzdLXSJU5bC_D1Q_gCWqKG7mcdcAvRkiYzano-VsrRRxazDQ@mail.gmail.com>
        <20181118171525.GA25854@tor.lan>
        <xmqqsgzydj6n.fsf@gitster-ct.c.googlers.com>
        <005801d47fad$345d5a70$9d180f50$@nexbridge.com>
Date:   Mon, 19 Nov 2018 12:33:07 +0900
In-Reply-To: <005801d47fad$345d5a70$9d180f50$@nexbridge.com> (Randall
        S. Becker's message of "Sun, 18 Nov 2018 21:11:32 -0500")
Message-ID: <xmqqbm6leo7g.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: D53CFAC6-EBAB-11E8-85A6-BFB3E64BB12D-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Randall S. Becker" <rsbecker@nexbridge.com> writes:

>> Torsten B=C3=B6gershausen <tboegi@web.de> writes:
>>=20
>> > And it may even be that we need a special handling for the "\" to be
>> > treated as "/".
>>=20
>> I do not do Windows, but is_dir_sep() needs to be tweaked if you want =
to do
>> that.
>
> Heavy Cygwin user here. It is used in my environment for
> cross-compilation. Everything should be done using / separators in
> Cygwin, not \. So /cygdrive/c, /cygdrive/d always prefaces the
> path rather than C:\ or D:\, which won't parse. It is,
> essentially, a bash environment, including that git completions
> work properly. Backslash ends up doing what it would in bash.

In short, in your opinion, the original message in this thread
expresses an invalid wish, as C:\path\to\dir\ is not a valid way to
spell the path to the directory, and it should be written as
/cygdrive/c/path/to/dir instead?

How well does this argument work in the real world, when another
claim in the original message

    This causes problems for any non-Cygwin tools that might call Git:

    http://github.com/golang/go/issues/23155

is taken into account, I wonder, though?
