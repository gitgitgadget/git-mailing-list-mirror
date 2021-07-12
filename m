Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCBE3C07E99
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 20:41:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCC03611C1
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 20:41:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232890AbhGLUoE (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Jul 2021 16:44:04 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51761 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231795AbhGLUoE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jul 2021 16:44:04 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E1E32CCE05;
        Mon, 12 Jul 2021 16:41:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=n3NbBQdBvfyj
        FNo3l/LhoMXvM74dUgrEdXfjyRUT4xA=; b=srXPKHZqd6tHt0U+JoljzqSM3iUn
        obiHfbHqtIh4nLjjgEULuBHb07Kq8D22rursLtsqZvAJORsOpz7A0ynt51X5YxgB
        UfswIS7L2PdUXRcO5OOJDLno5RHTZfvEnBpPgvkSRsQQvxS856fyD9LVtM04mWJx
        tyqWQspegjG5hQQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D876DCCE04;
        Mon, 12 Jul 2021 16:41:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 56982CCE02;
        Mon, 12 Jul 2021 16:41:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 0/5] tests: migrate to "test-tool pkt-line"
References: <cover-0.5-00000000000-20210707T101549Z-avarab@gmail.com>
        <cover-0.5-00000000000-20210712T164208Z-avarab@gmail.com>
Date:   Mon, 12 Jul 2021 13:41:13 -0700
In-Reply-To: <cover-0.5-00000000000-20210712T164208Z-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Mon, 12 Jul
 2021 18:44:15 +0200")
Message-ID: <xmqqpmvn2rkm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 7FF80420-E351-11EB-98C5-8B3BC6D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> This series is marked for "will merge to next" already, but not there
> yet. A trivial v2 whitespace fix in case Junio's in time to pick it
> up.
>
> See v1 at https://lore.kernel.org/git/cover-0.5-00000000000-20210707T10=
1549Z-avarab@gmail.com/
>
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason (5):
>   serve tests: add missing "extra delim" test
>   serve tests: use test_cmp in "protocol violations" test
>   tests: replace [de]packetize() shell+perl test-tool pkt-line
>   tests: replace remaining packetize() with "test-tool pkt-line"
>   test-lib-functions.sh: remove unused [de]packetize() functions
>
>  t/helper/test-pkt-line.c               | 12 +++++
>  t/t5410-receive-pack-alternates.sh     | 42 +++++++++++++-----
>  t/t5411/once-0010-report-status-v1.sh  | 12 ++---
>  t/t5500-fetch-pack.sh                  | 15 ++++---
>  t/t5530-upload-pack-error.sh           | 24 +++++-----
>  t/t5562-http-backend-content-length.sh | 16 ++++---
>  t/t5570-git-daemon.sh                  | 22 ++++++----
>  t/t5704-protocol-violations.sh         | 61 ++++++++++++++++++--------
>  t/test-lib-functions.sh                | 42 ------------------
>  9 files changed, 135 insertions(+), 111 deletions(-)
>
> Range-diff against v1:
> 1:  fcb53980597 =3D 1:  67aa8141153 serve tests: add missing "extra del=
im" test
> 2:  c3544fb53cd =3D 2:  64dfd14865c serve tests: use test_cmp in "proto=
col violations" test
> 3:  c1015fa6ab0 =3D 3:  c33f344ab20 tests: replace [de]packetize() shel=
l+perl test-tool pkt-line
> 4:  ab23513b48b ! 4:  a44e1790f2a tests: replace remaining packetize() =
with "test-tool pkt-line"
>     @@ t/helper/test-pkt-line.c: static void pack(int argc, const char =
**argv)
>      =20
>      +static void pack_raw_stdin(void)
>      +{
>     -+
>      +	struct strbuf sb =3D STRBUF_INIT;
>      +	strbuf_read(&sb, 0, 0);
>      +	if (strbuf_read(&sb, 0, 0) < 0)
> 5:  2d22b83971a =3D 5:  cc91d15ef70 test-lib-functions.sh: remove unuse=
d [de]packetize() functions

Well, if you care that much, I'd prefer to also see an blank line
between the end of decl and the first statement.

;-)
