Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AF3DC00140
	for <git@archiver.kernel.org>; Tue,  2 Aug 2022 22:36:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234593AbiHBWgL (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Aug 2022 18:36:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233140AbiHBWgK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Aug 2022 18:36:10 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EFB12DC4
        for <git@vger.kernel.org>; Tue,  2 Aug 2022 15:36:09 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8851812E88C;
        Tue,  2 Aug 2022 18:36:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=BDLyUV4Hfekz
        7mLpjZUxLMVXOJsZTxKjG0l5bB0Ax1E=; b=dsAZ7XHjQhbpeqo8be7WoVKc7Zk7
        Ie7KJVy1DGQ6FxTEpy58dxlmzu+LPFanVpMfqYRSktoUCy/+x1Ox1Jg4rr1yNuIe
        vQ9nDyyx/jH5OwiNNVhIE2EFZFTbUiK2FN7n9zg5YYhk9RyeFSTzdEHqZ0cA9+Kc
        I4We3tQGBnrUA/w=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7FAEE12E88B;
        Tue,  2 Aug 2022 18:36:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.145.39.32])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C2DBF12E88A;
        Tue,  2 Aug 2022 18:36:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Th=C3=A9o?= Maillart <tmaillart@gmail.com>
Cc:     =?utf-8?Q?Th=C3=A9o?= MAILLART via GitGitGadget 
        <gitgitgadget@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] rebase: introduce allow-inline-reword option
References: <pull.1228.git.git.1659422389830.gitgitgadget@gmail.com>
        <xmqqles6is9s.fsf@gitster.g>
        <2a7040a4-20ce-495d-4182-089c6c08fbd6@gmail.com>
Date:   Tue, 02 Aug 2022 15:36:06 -0700
In-Reply-To: <2a7040a4-20ce-495d-4182-089c6c08fbd6@gmail.com>
 (=?utf-8?Q?=22Th=C3=A9o?=
        Maillart"'s message of "Wed, 3 Aug 2022 00:22:56 +0200")
Message-ID: <xmqqy1w6e0ix.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 803D4214-12B3-11ED-9A67-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Th=C3=A9o Maillart <tmaillart@gmail.com> writes:

> So, if I understand your suggestion correctly, we can say that,
> most of the logic is implemented in this patch, but I should move
> the "inline" logic from the "reword" to a new action "retitle".

Yeah, I was hoping that most of the logic has already been written,
except that it is likely you just ignored the original log message
and overwrote it with the single line you got, but now you need to
read the original and replace only the title (the "paragraph" before
the first blank line), which you may not have yet.
