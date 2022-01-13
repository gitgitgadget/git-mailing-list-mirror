Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFBD9C433F5
	for <git@archiver.kernel.org>; Thu, 13 Jan 2022 19:15:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237900AbiAMTPP (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Jan 2022 14:15:15 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64496 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237868AbiAMTPK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jan 2022 14:15:10 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 656D6FFAC3;
        Thu, 13 Jan 2022 14:15:08 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=dv5JIBHpnlWP
        0qzIbTaFJuHUGVNbj2/JeGuxHEUITNQ=; b=d+JYO62BlSKbkToN9fFAU6nR6Heh
        yQyrEADDrmbAuFZzKyPsFoCgQ4AidXoBU0CTxD3zaIf6s0eCbiXhXc7d5XRb1lL4
        PCeW9II0usWSIfSfkSI2jtJJFska7CRmv6hdqXD2/DqBgYuza+yN2f3iXBCglGxK
        iRGj0csFJRRorVk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1FFCBFFABE;
        Thu, 13 Jan 2022 14:15:08 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 644C6FFABC;
        Thu, 13 Jan 2022 14:15:06 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH] reftable: avoid initializing structs from structs
References: <pull.1188.git.git.1642092934523.gitgitgadget@gmail.com>
        <220113.86r19btv5a.gmgdl@evledraar.gmail.com>
Date:   Thu, 13 Jan 2022 11:15:04 -0800
In-Reply-To: <220113.86r19btv5a.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Thu, 13 Jan 2022 18:13:14 +0100")
Message-ID: <xmqqy23jh2h3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 1E0EB4E4-74A5-11EC-898A-CB998F0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> Would make sense to steal the compiler version etc. details from my
> <patch-1.1-7425b64c0a0-20220113T113821Z-avarab@gmail.com>. I.e. eventua=
lly
> we'll be able to change this & other code back, as nobody will care
> about that older compiler version. It worked before in the pre-image on
> a more recent xlc.

If so, wouldn't it be a better option not to worry about such an old
compiler at all from the get-go?  Even with an unnecessary "turn an
array of structs into an array of pointers to structs", the
resulting code becomes less natural to follow.  And after all, this
may be part of our tree but is not yet integrated with our system,
no?

Thanks.
