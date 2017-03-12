Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6B47A201C2
	for <e@80x24.org>; Sun, 12 Mar 2017 02:52:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755618AbdCLCwF (ORCPT <rfc822;e@80x24.org>);
        Sat, 11 Mar 2017 21:52:05 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62577 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1755500AbdCLCwE (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Mar 2017 21:52:04 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2B1447B841;
        Sat, 11 Mar 2017 21:52:02 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=D/pp52IuxNKN
        wyCJ3B9hF03pMB4=; b=goNSlgm1pBu+yuN4HhE6a6bOZqnBYuXP/cEq7jAViY4L
        y3dczJbW1GRDIPZrIg8Ge50fI5nW6eMMmLkTRUgfpXxTtmZBzqtEdK2fcl6kegNv
        RXLxORcfuHZdFfg5iordWxoFRdBUA947RcFfZ+NwAjEMVmqDpnqh/yRvx/deDbY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=Texekm
        J+ppjR1g/GTCi/mIeEM8nUuf1QcBKJzUBPXbr1Ems9upbWh6zk2MViSOfsoP+7ty
        U0wSsgal574bf3PL7mvqAMBvh6DMkWb/CFH3PC5HluIH4zhbSiTmBPYtbYlPpVoc
        VAEt/7bIogTSt5T/GjSIXpBenG/ftqqyCyf1I=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 225E27B840;
        Sat, 11 Mar 2017 21:52:02 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4BF677B83E;
        Sat, 11 Mar 2017 21:52:01 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Jake Goulding <goulding@vivisimo.com>,
        Jeff King <peff@peff.net>, Tom Grennan <tmgrennan@gmail.com>,
        Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH] tag: Implicitly supply --list given another list-like option
References: <20170310124247.jvrmmcz2pbv4qf3o@sigill.intra.peff.net>
        <20170311120855.16756-1-avarab@gmail.com>
        <CACBZZX4AJqvtZQdZZFU8+1So5G9F11_SN4=za+8p=KYim9SFSQ@mail.gmail.com>
Date:   Sat, 11 Mar 2017 18:51:59 -0800
In-Reply-To: <CACBZZX4AJqvtZQdZZFU8+1So5G9F11_SN4=za+8p=KYim9SFSQ@mail.gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Sat, 11 Mar
 2017 13:14:48
        +0100")
Message-ID: <xmqqefy3w6k0.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: DDEF6F96-06CE-11E7-81AC-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

>> Junio: This will merge conflict with my in-flight --no-contains
>> patch. I can re-send either one depending on which you want to accept
>> first, this patch will need an additional test for --no-contains. I
>> just wanted to get this on the ML for review before the --no-contains
>> patch hit "master".

I haven't looked at the patch text of this one closely yet, but I
think the goals of both make sense, so we would eventually want to
have them both.

I also think that "if you said --contains, --merged, etc. you are
already asking to give you a list and cannot be creating a new one",
which is the topic of this patch, makes sense even if nobody were
interested in asking "--no-contains".

So perhaps you would want this applied first, so that existing three
can already benefit from "implicit --list" before waiting for the
other one?

