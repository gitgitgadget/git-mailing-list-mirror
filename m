Return-Path: <SRS0=H/u6=4H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E287C34056
	for <git@archiver.kernel.org>; Wed, 19 Feb 2020 17:40:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 669552465D
	for <git@archiver.kernel.org>; Wed, 19 Feb 2020 17:40:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="xjJAVLUc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726700AbgBSRkm (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Feb 2020 12:40:42 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:62575 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726609AbgBSRkm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Feb 2020 12:40:42 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 596CFC0AE8;
        Wed, 19 Feb 2020 12:40:40 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=3aTfq+CpqneZ
        k63D4emNBaZTkGY=; b=xjJAVLUcpkm7TgBqlSt11MW0ShRoJNRbzJXIhPc+zViL
        3/3bjpt+bglOTwxgAYhr5I/3p1j0fOzBVYr5UWgeagZwGQ1fZ1uRLREHktgy4RSG
        eXTUqjKF5RxrWpnPCeLi626C/WSzcBvp79LICv7ZNphBVM2DilSQoulmTvWUXPs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=Ev4l+p
        YqFl8ODaEo7/QLb4Lh2Et7/6FDWEEOR5n4vFEV7kP89+8vu+demYw/vND+QN9CI2
        2FPudFdkaGBS3xAjuCili8aYSANe8JyB1TReAQJKFGpcXkzAf0+Aq3NN4y3fs1u4
        mq7Vvenvz67ljtioqiN1D0z6rBYXBrLLFbp34=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 53537C0AE7;
        Wed, 19 Feb 2020 12:40:40 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 72D5BC0AE5;
        Wed, 19 Feb 2020 12:40:37 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Miriam Rubio <mirucam@gmail.com>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        =?utf-8?Q?Ren?= =?utf-8?Q?=C3=A9?= Scharfe <l.s.r@web.de>,
        Christian Couder <christian.couder@gmail.com>
Subject: Re: [Outreachy] [PATCH v4 00/12] Finish converting git bisect to C part 1
References: <20200217084039.78215-1-mirucam@gmail.com>
Date:   Wed, 19 Feb 2020 09:40:35 -0800
In-Reply-To: <20200217084039.78215-1-mirucam@gmail.com> (Miriam Rubio's
        message of "Mon, 17 Feb 2020 09:40:27 +0100")
Message-ID: <xmqqd0aafpbg.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: F06B40C2-533E-11EA-9121-B0405B776F7B-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Miriam Rubio <mirucam@gmail.com> writes:

> These patches correspond to a first part of patch series=20
> of Outreachy project "Finish converting `git bisect` from shell to C"=20
> started by Pranit Bauva and Tanushree Tumane
> (https://public-inbox.org/git/pull.117.git.gitgitgadget@gmail.com) and
> continued by me.
>
> This first part is formed of preparatory/clean-up patches and all=20
> `bisect.c` libification work.=20
>
> I would like to thank Ren=C3=A9 Scharfe and Taylor Blau for their
> suggestions.

Thanks all.

Will queue.  I guess this "part 1" is pretty much done and ready for
'next'.
