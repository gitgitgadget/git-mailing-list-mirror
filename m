Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 13D9F1F97E
	for <e@80x24.org>; Sun, 25 Nov 2018 01:00:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbeKYLue (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Nov 2018 06:50:34 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64425 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726400AbeKYLue (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Nov 2018 06:50:34 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7399412C9D3;
        Sat, 24 Nov 2018 20:00:46 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=Qr+wZNx5IWx2
        Se+B2+9ulKPILJk=; b=xxvz0nSyjjLcfTuTh0VG7+uYtN4sgVLPZrxhORNQOgva
        8VHT//ik8Vq//KLGmDRxsLIyqxSDaJV3rrEAsQ+X25owxzaZzkToJ1USB/A2Qb5Y
        maMtlHtMIzVt7ypkIjHvZTiMaxUSBZt+DMGN0AxGfocjdYggLSFWU47A7oSMvOs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=DTKhKZ
        SfFHVaDkCJaxzqXHHniMnFcIyVyp6KeBI9QlhKelcH+gJ7UY/gbhrmoOUd8MwWqP
        wvx8Wv4a03lm2dW3+KFM3UbLrYHqU+dReTdnEhRBirn14+EwkxF6asjQe+whmCO6
        WYx45n4BFyA6BdZetNMDCppKJEsMqzHcvSNfE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6BEF212C9D2;
        Sat, 24 Nov 2018 20:00:46 -0500 (EST)
Received: from pobox.com (unknown [35.187.50.168])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D937012C9D1;
        Sat, 24 Nov 2018 20:00:44 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [ANNOUNCE] Git v2.20.0-rc1
References: <xmqqmuq25ufc.fsf@gitster-ct.c.googlers.com>
        <87y39w1wc2.fsf@evledraar.gmail.com>
        <877eh219ih.fsf@evledraar.gmail.com>
Date:   Sun, 25 Nov 2018 10:00:43 +0900
In-Reply-To: <877eh219ih.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Sat, 24 Nov 2018 21:54:46 +0100")
Message-ID: <xmqq36rq2cp0.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 89BFFFF2-F04D-11E8-BB36-BFB3E64BB12D-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

>>  * "git rebase" and "git rebase -i" have been reimplemented in C.
>
> Here's another regression in the C version (and rc1),...
> I wasn't trying to stress test rebase. I was just wanting to rebase a
> history I was about to force-push after cleaning it up, hardly an
> obscure use-case. So [repeat last transmission in
> https://public-inbox.org/git/87y39w1wc2.fsf@evledraar.gmail.com/ ]

which, to those who are reading from sidelines:

    Given that we're still finding regressions bugs in the rebase-in-C
    version should we be considering reverting 5541bd5b8f ("rebase: defau=
lt
    to using the builtin rebase", 2018-08-08)?

    I love the feature, but fear that the current list of known regressio=
ns
    serve as a canary for a larger list which we'd discover if we held of=
f
    for another major release (and would re-enable rebase.useBuiltin=3Dtr=
ue in
    master right after 2.20 is out the door).

I am fine with the proposed flip, but I'll have to see the extent of
damage this late in the game so that I won't miss anything.  In
addition to the one-liner below, we'd need to update the quoted
release notes entry, and possibly adjust some tests (even though the
"reimplementation" ought to be bug-to-bug compatible, it may not be).

diff --git b/builtin/rebase.c a/builtin/rebase.c
index 9dc8475cd3..60e357c735 100644
--- b/builtin/rebase.c
+++ a/builtin/rebase.c
@@ -54,7 +54,7 @@ static int use_builtin_rebase(void)
 	cp.git_cmd =3D 1;
 	if (capture_command(&cp, &out, 6)) {
 		strbuf_release(&out);
-		return 1;
+		return 0;
 	}
=20
 	strbuf_trim(&out);
