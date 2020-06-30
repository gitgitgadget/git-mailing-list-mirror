Return-Path: <SRS0=HTZL=AL=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07C72C433DF
	for <git@archiver.kernel.org>; Tue, 30 Jun 2020 15:55:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA9D520675
	for <git@archiver.kernel.org>; Tue, 30 Jun 2020 15:55:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="OW9Awal3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389813AbgF3Pzd (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Jun 2020 11:55:33 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:51067 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730478AbgF3Pzc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Jun 2020 11:55:32 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2DF07E4581;
        Tue, 30 Jun 2020 11:55:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=975tJ7jrs4JEmt7Mygl0rmdBo5o=; b=OW9Awa
        l3W3bqkoWm1xO7jQ6/vpqMeZ5hr+d6kAuTuo5wuSRU0dd1W1v6/w7O79VXIeiROk
        8u9cbO6dh38ZFbbQgC9cDm0l2Wa46mQolpcELj2K3uO9uXJJf2sDl59aR4KUg0Ae
        RpS5kwZVNFVh8IVQU/O4P82vgsnku+Ja+qDTg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=uR1HpPSnv06+jE/SWK3unLrK/7RxCG5T
        0YeiJbCEsWl+TmbWh/MB8cQYJQlT6XXZYqzKeMkkZkTHSrRKUDFm9tZWRb6OqYHg
        8uUQsOuyCqPja+N/t9spYSP3+iM9pu+HqKiVfj9jfFSSjOTVVHD7SDaBC4ZQonaW
        nsQIxs1tgNE=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2522CE4580;
        Tue, 30 Jun 2020 11:55:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 65FC4E457F;
        Tue, 30 Jun 2020 11:55:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     David Aguilar <davvid@gmail.com>
Cc:     lin.sun@zoom.us,
        =?utf-8?B?J8SQb8OgbiBUcuG6p24gQ8O0bmc=?= Danh' 
        <congdanhqx@gmail.com>, 'Pratyush Yadav' <me@yadavpratyush.com>,
        'sunlin via GitGitGadget' <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v2] Enable auto-merge for meld to follow the vim-diff beharior
References: <311401d63e0e$b1ffe490$15ffadb0$@zoom.us>
        <0c2401d64d14$aeafa680$0c0ef380$@zoom.us>
        <20200628103755.GB26319@danh.dev>
        <bfc401d64df4$cd189e70$6749db50$@zoom.us>
        <20200630064800.GB1962986@gmail.com>
Date:   Tue, 30 Jun 2020 08:55:25 -0700
In-Reply-To: <20200630064800.GB1962986@gmail.com> (David Aguilar's message of
        "Mon, 29 Jun 2020 23:48:00 -0700")
Message-ID: <xmqqwo3oeefm.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1DDCC842-BAEA-11EA-B44E-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

David Aguilar <davvid@gmail.com> writes:

> Can you please submit the patch to the list here?
> Once you do, please feel free to add my sign-off:
>
> Signed-off-by: David Aguilar <davvid@gmail.com>

Thanks, but you didn't write a single line of new code in the patch,
and you are not relaying Sun Lin's patch on the author's behalf, so
Sob is probably not what you meant---it would either be Reviewed-by
(I've gone through the patch with fine toothed comb, I can answer
any questions about the change as well as the author could, and I
can stand behind it with confidence) or Acked-by (I've seen the
patch, didn't see anything outrageously wrong in it, and agree with
its general direction---I appreciate the author tacking the issue).
