Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A79F0C433EF
	for <git@archiver.kernel.org>; Fri, 13 May 2022 15:35:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381353AbiEMPfI (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 May 2022 11:35:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348935AbiEMPfF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 May 2022 11:35:05 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84D4C2DC6
        for <git@vger.kernel.org>; Fri, 13 May 2022 08:35:03 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 23B0113BF5D;
        Fri, 13 May 2022 11:35:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=GEC9cA8ZpEdE
        9ptRkZX6hXCB48K4b0545EGq3mIZLL4=; b=Vi6oItiG5Zf3R4GgUzghPZlZBsNq
        zQdx81a4HgrDKvIyR0HYe2a0+yujcVlJLc1qX6U1DlPF+JLDjsMvBdW0meZZ3DmW
        2coUXay9mh5UZFq8sXj9acGAiqAS/N09cKvOcm8GRCfx0PXDdeEscEUrDHrVE0mh
        z8z9r7WZM0OA3YA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id EF6B513BF5B;
        Fri, 13 May 2022 11:35:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.65.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3451613BF5A;
        Fri, 13 May 2022 11:35:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: js/scalar-diagnose, was Re: What's cooking in git.git (May
 2022, #04; Thu, 12)
References: <xmqqilqacmmd.fsf@gitster.g>
        <nycvar.QRO.7.76.6.2205131404280.352@tvgsbejvaqbjf.bet>
Date:   Fri, 13 May 2022 08:34:59 -0700
In-Reply-To: <nycvar.QRO.7.76.6.2205131404280.352@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Fri, 13 May 2022 14:06:56 +0200 (CEST)")
Message-ID: <xmqqmtflbg4c.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 40B9DDA8-D2D2-11EC-9040-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> My first reaction was: but wait, what about the file mode? Then I
> remembered that Ren=C3=A9 offered the opinion that we could easily intr=
oduce
> `--add-executable-file-with-contents` _iff_ we need that at some stage,
> and when I considered symbolic links, I noticed that the `--add-file`
> option does not accept those in the first place, so it would be funny i=
f
> `--add-file-with-contents` supported symbolic links.

Knowing how we present symbolic links in the patch output, I would
actually think it is quite natural to say

    --add-virtual-file=3DRelNotes:120000:Documentation/RelNotes/2.37.0.tx=
t

and be able to create a symlink.  But if we are to go in the route
to later add "--add-executable-file-with-contents", it is plausibly
a workable solution to add "--add-virtual-symbolic-link", too.  And
when it happens, we may say "why didn't we use the word 'virtual' in
the existing option names?"

By the way, should it be "--add-file-with-contents", just like you
wrote above?  The version in 'seen' says "--add-file-with-content".

Thanks.
