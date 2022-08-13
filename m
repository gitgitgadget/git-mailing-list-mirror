Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 460B1C19F2D
	for <git@archiver.kernel.org>; Sat, 13 Aug 2022 22:29:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239747AbiHMW3Q (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 13 Aug 2022 18:29:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237907AbiHMW2r (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 Aug 2022 18:28:47 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F264D61B37
        for <git@vger.kernel.org>; Sat, 13 Aug 2022 15:28:45 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 80CA9146663;
        Sat, 13 Aug 2022 18:28:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=GXmCdqyZPNUV
        ATLRGF3MyrcxSuhhTgPJXu/tDGGvIoA=; b=uOSlLE0Hfp8PBp5E8p1zLhMr69Ga
        QVck8fhEkuA7+xP3dUdCqhb4ZbZRGMpbO6q3Ou1SPoeZFGnCF4/JI71Fuwv/DUrI
        rFMzfHW4F/s+DggRxSSn9dixb296jTz5SS9xz0AasG0Q2fSaeZg0lAoU9K5csZoZ
        9JpcZe0nGAlfChU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 78A4B146661;
        Sat, 13 Aug 2022 18:28:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id DEA11146660;
        Sat, 13 Aug 2022 18:28:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?utf-8?Q?Rub=C3=A9?= =?utf-8?Q?n?= Justo via GitGitGadget 
        <gitgitgadget@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] branch: allow "-" as a short-hand for "previous branch"
References: <pull.1315.git.1659910949556.gitgitgadget@gmail.com>
        <s7862q69-05o8-s5s8-n635-823s34q358q4@tzk.qr>
        <xmqqk07iu3c3.fsf@gitster.g>
        <be21e2ba-1c57-a5aa-a986-64413f3983c3@gmail.com>
Date:   Sat, 13 Aug 2022 15:28:40 -0700
In-Reply-To: <be21e2ba-1c57-a5aa-a986-64413f3983c3@gmail.com>
 (=?utf-8?Q?=22Rub=C3=A9n?= Justo"'s
        message of "Sat, 13 Aug 2022 11:19:40 +0200")
Message-ID: <xmqqczd393s7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 490250D0-1B57-11ED-AF29-CB998F0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rub=C3=A9n Justo <rjusto@gmail.com> writes:

> Previous to this, I thought about making also a "git diff -",
> ...
> Also discarded the "git diff -" change, because of so many flags and
> conditions "diff" has. So I only sent the "branch -" patch.

Yeah, that is why the approach Johannes showed, i.e. instead of
making "in this context but not in that context, '-' means
'previous'" changes to random commands, teaching anybody that takes
@{-1} to understand that '-' means 'previous' everywhere, appears
very tempting.

