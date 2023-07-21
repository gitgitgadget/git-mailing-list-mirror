Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 652E3EB64DD
	for <git@archiver.kernel.org>; Fri, 21 Jul 2023 17:04:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbjGUREE (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Jul 2023 13:04:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230107AbjGURED (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Jul 2023 13:04:03 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D98610CB
        for <git@vger.kernel.org>; Fri, 21 Jul 2023 10:04:02 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 148D22EBAA;
        Fri, 21 Jul 2023 13:04:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=MQbdlVNXOJ1W
        ZFnA3K0txQrVaEGmstY7aYzg7sBMajE=; b=UeqWz0KLHfVg1/l5htDzdog4REvF
        AGy08lObar/7DNrvJkiQpgTiFEZkqhhiNCXgfInMM46qPgsJFjanICah8d42v+nL
        BGdub8ikwLHN2s2zjjWwD71zHVW7tRNC+zRAhP+GZLIPYwsZ32AzPj7tkJ5Ch4m3
        fVHoOcbJtfcTulI=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 0E6532EBA9;
        Fri, 21 Jul 2023 13:04:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.168.215.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 4F1062EBA6;
        Fri, 21 Jul 2023 13:03:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: [PATCH] pack-objects: fix --no-keep-true-parents
References: <d392a005-4eba-7cc7-9554-cdb8dc53975e@web.de>
        <xmqqo7k9fa5x.fsf@gitster.g>
        <fe7e43a0-5f08-73a7-fd04-b9127592b45c@web.de>
Date:   Fri, 21 Jul 2023 10:03:57 -0700
In-Reply-To: <fe7e43a0-5f08-73a7-fd04-b9127592b45c@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Fri, 21 Jul 2023 14:41:56 +0200")
Message-ID: <xmqqtttxurgi.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 9527FBF6-27E8-11EE-947A-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> Since 99fb6e04cb (pack-objects: convert to use parse_options(),
> 2012-02-01) git pack-objects has accepted --no-keep-true-parents, but
> this option does the same as --keep-true-parents.  That's because it's
> defined using OPT_SET_INT with a value of 0, which sets 0 when negated
> as well.
>
> Turn --no-keep-true-parents into the opposite of --keep-true-parents by
> using OPT_BOOL and storing the option's status directly in a variable
> named "grants_keep_true_parents" instead of in negative form in

"grant" -> "graft" (locally fixed, no need to resend).

> "grafts_replace_parents".
>
> Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
> ---

Thanks.
