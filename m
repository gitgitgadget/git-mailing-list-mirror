Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F37A1C433EF
	for <git@archiver.kernel.org>; Fri, 18 Feb 2022 20:50:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239546AbiBRUuy (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Feb 2022 15:50:54 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233019AbiBRUuy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Feb 2022 15:50:54 -0500
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11CEF98F49
        for <git@vger.kernel.org>; Fri, 18 Feb 2022 12:50:36 -0800 (PST)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0EAF010DF9D;
        Fri, 18 Feb 2022 15:50:36 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=fiHiNAS/Kudy
        8J8pmVgJrfJ68QbhZwxY+9q7Gees238=; b=pIdjiExv18D7hqKFt9Lk3uL99v4H
        uB57cRlDvk3u48yFi2PwVWSalisZRRE4cNY1kyXIiULJRoWWlgJN6Pw80RLIOTY6
        d0gujPJZns1bOYC3UGwPwsyKH1QMPmyMZqf8cVN8MsJAUoQU2Bpt1r5btpSr4HDl
        ISV3fqCVDBPR0QE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 040A510DF9C;
        Fri, 18 Feb 2022 15:50:36 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5BF0E10DF98;
        Fri, 18 Feb 2022 15:50:35 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Han-Wen Nienhuys <hanwen@google.com>,
        Elijah Newren <newren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH] glossary: describe "worktree"
References: <xmqqczjvxy3o.fsf@gitster.g>
        <CABPp-BHrFb_AA2OAiR7Bmq7vQuyG2Wme_PdjPdY8j-tp3VJfJg@mail.gmail.com>
        <xmqqiltmwufw.fsf@gitster.g>
        <CAFQ2z_OgVcaty1wMX0O0mj-PYSAphKAkXgTCW+uJKDAuCwLn4w@mail.gmail.com>
        <xmqqh796tw34.fsf@gitster.g>
        <CAFQ2z_Pvje9LM0iyiP87S-L754zepEE_9k=_4Oa0w1Lo_pb=TQ@mail.gmail.com>
        <xmqqczjuttyw.fsf@gitster.g>
        <CAFQ2z_O=WguSAJDD4DRpwtX54A5dWQZQPCuQDR81idknQgchaA@mail.gmail.com>
        <xmqqtucx8g34.fsf@gitster.g>
        <220218.867d9rhqab.gmgdl@evledraar.gmail.com>
Date:   Fri, 18 Feb 2022 12:50:34 -0800
In-Reply-To: <220218.867d9rhqab.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Fri, 18 Feb 2022 21:25:15 +0100")
Message-ID: <xmqq1qzzzyp1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 6BA7C6DC-90FC-11EC-9CCB-CB998F0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> But I may be entirely missing the point here...

Not only FETCH_HEAD is a multi-line file, but each entry in it carry
extra information that do not belong to a 'ref', like where it came
from and whether its intended use is to merge into the current
branch.

The file is much closer to what "rebase -i" uses its "todo list"
for, than being a "ref-like" thing.  The only similarity with a
loose ref is that it begins with 40-hex and get_sha1_hex() will
happily return success.  The file format was designed to take
advantage of the loose-ness of get_sha1_hex(), historically, so
that the reading side can reuse the logic to read loose refs.

You can blame all of that to my laziness ;-).

After you fetch a single ref, get_oid("FETCH_HEAD") should keep
returning the object name of what you fetched, but that does not
mean the full multi-line trash needs to be stored in any ref
backend.  If you fetch multiple refs, get_oid("FETCH_HEAD") can only
return one of them anyway, so as long as we keep the only useful use
case working, we do not have to use the machinery the ref backend of
choice uses to store it.  It can remain an on-disk file, just like
the "todo" list "rebase -i" uses is an on-disk file.


