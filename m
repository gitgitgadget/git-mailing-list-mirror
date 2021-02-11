Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AC1DC433E9
	for <git@archiver.kernel.org>; Thu, 11 Feb 2021 19:23:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE7A664E00
	for <git@archiver.kernel.org>; Thu, 11 Feb 2021 19:23:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232014AbhBKRfE (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Feb 2021 12:35:04 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:51342 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232256AbhBKRcx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Feb 2021 12:32:53 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 244DB10E5D5;
        Thu, 11 Feb 2021 12:32:08 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=ssUK0IfJz+ay
        g+6ZVVUWmnaB9H8=; b=Qa/+QelSbEmN8xWIesZmMq4b1LkY4nzSOOhwNozU3odv
        8XT/eV8VRAq6RoKTEQ2nnmk83OIkGvGSpoMfq6mgvIUFYUU9YYA9Uj4pFTN4glCJ
        DfI357yJHFHEcT+JCDLUYIQR1RWZCNGaGv4NoCb7EWWmN5mKVTGhbzwgNgC4wf8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=uvc5fb
        cqVnD2ZmsbXTcsbcyI9KMSSdVyH1qJswNfmvpprYGgGl9S+wZPVrmxrprpjzp3r2
        xlIfhx8d5qyCzTabw4CPmyaUZbt5pzG9DQMJfAgsbnNc5a4wE7m8KDkOsaZzsKIU
        Gx5joY6y/SA3WOwLerheNP9St0Kma104RNHkY=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 1D98510E5D3;
        Thu, 11 Feb 2021 12:32:08 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 6508110E5D1;
        Thu, 11 Feb 2021 12:32:05 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: Re: [PATCH 4/4] tests: remove most uses of test_i18ncmp
References: <20210120182759.31102-1-avarab@gmail.com>
        <20210211015353.28680-5-avarab@gmail.com>
Date:   Thu, 11 Feb 2021 09:32:03 -0800
In-Reply-To: <20210211015353.28680-5-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Thu, 11 Feb 2021 02:53:53 +0100")
Message-ID: <xmqqa6say0h8.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 0F180DE2-6C8F-11EB-84F1-E43E2BB96649-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> As a follow-up to d162b25f956 (tests: remove support for
> GIT_TEST_GETTEXT_POISON, 2021-01-20) remove most uses of test_i18ncmp
> via a simple s/test_i18ncmp/test_cmp/g search-replacement.

I am a bit hesitant to take this step, primarily because the
distinction between test_cmp and test_i18ncmp is serving as a sign
for tests to identify if they are dealing with translatable messages
or plumbing/machine-readable messages.

If a totally different approach to test i18n messging part
(e.g. Dscho's rot13) appears any time soon, it would be helpful to
leave these distinction in, rather than ripping them out, with two
caveats.

 - If such a change does happen soon enough, then the codebase this
   huge patch touches would not be all that different by the time
   when it happens, so reverting this patch should not be too
   involved, which means my hesitation is not all that warranted.

 - If such a change does not happen for some time, then it would
   become impractical to revert this patch when it does happen due
   to changes in the codebase, if we apply it with the intention of
   "we can easily revert if we need to".  But even if we drop this
   step, until such a change appears, we surely will gain more calls
   to test_cmp (and possibly test_i18ncmp) in the codebase, and at
   that point, we can trust the distinction between test_cmp and
   test_i18ncmp even less, which means it does not help all that
   much if we tried to keep test_i18ncmp.

So, perhaps we should bite the bullet and just take this step.


