Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2B00C433F5
	for <git@archiver.kernel.org>; Thu, 13 Jan 2022 18:40:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237575AbiAMSkS (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Jan 2022 13:40:18 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:55873 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231186AbiAMSkR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jan 2022 13:40:17 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 79701175AE6;
        Thu, 13 Jan 2022 13:40:17 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=VWUNxAow+7/U
        0tTv6igT+85M/KIDIXh0Ey4RHf4nCQo=; b=c54Tqa8jHlS/2pS2cs+Go7sckfUE
        y43eTgWKLyhmF8MTLCUYpsWV+Mkw88rcB/lKLsWurP1K2zYvgYsJzklrWbRMjjCb
        L5tfs2gcbgZFVxouV5ynmFL4QrPosPqkBoDzqsHvDebBnlGHNBUDN+QalCEXALAk
        91XUyDrbz/kmfTI=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5F48D175AE5;
        Thu, 13 Jan 2022 13:40:17 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 8F823175AE4;
        Thu, 13 Jan 2022 13:40:14 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Christian Couder <christian.couder@gmail.com>,
        Ramkumar Ramachandra <r@artagnon.com>,
        Git List <git@vger.kernel.org>, "Miriam R." <mirucam@gmail.com>
Subject: Re: git bisect bad @
References: <1edfc6ff-4db8-447f-9eb7-85843258a286@www.fastmail.com>
        <xmqqilus3ctf.fsf@gitster.g>
        <fead25d6-6f5f-487a-ad4c-0657fe9785fd@www.fastmail.com>
        <xmqq4k6b34h8.fsf@gitster.g>
        <bafa9564-fa48-413d-bbef-3f068c03dd31@www.fastmail.com>
        <3dade45b-494f-663b-264b-06a51ea1cf56@web.de>
        <xmqq35lsyhbf.fsf@gitster.g>
        <13e323e9-eb0c-71c3-215f-b77c91fcc4c8@web.de>
        <5be4cdad-6769-68e8-0984-5fe89668d007@web.de>
        <421215c1-f6ae-4ec2-b666-2a481056ef79@www.fastmail.com>
        <CAP8UFD3tyBhrOQzg9j4qDAT0Tb8TCTK0=J6ORsiLVuMWn+W9wg@mail.gmail.com>
        <8bc73981-589e-20e5-247b-2f74e166ae1a@web.de>
Date:   Thu, 13 Jan 2022 10:40:13 -0800
In-Reply-To: <8bc73981-589e-20e5-247b-2f74e166ae1a@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Thu, 13 Jan 2022 14:55:53 +0100")
Message-ID: <xmqqr19biinm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 3F3A282E-74A0-11EC-A1CE-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> The implementation language of git bisect is not immediately relevant
> here, but that the shell is used to call the user-supplied bisect run
> script is.  If we'd run it directly (without RUN_USING_SHELL) we could
> distinguish error code 126/127 from execution errors.

Yes, but it means that we'd need to reimplement command line
splitting, environment and variable substitutions, etc. in a
way that people expect from executing their run "script" with
a shell.

I'd rather not to see us go there.

Thanks.
