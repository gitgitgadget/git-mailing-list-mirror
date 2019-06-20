Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3CDB01F4B6
	for <e@80x24.org>; Thu, 20 Jun 2019 18:20:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728469AbfFTSNQ (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Jun 2019 14:13:16 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59942 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729205AbfFTSNP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jun 2019 14:13:15 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 149E516701A;
        Thu, 20 Jun 2019 14:13:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=xEogMMPvUiqO
        U2s29mDtRG48llM=; b=B1XOuLL2E8Ui4zhMjOlvPXTZf3mrmiRLreAuTGlmiCHa
        YEpb0svvNBqymQnoul7DWo+Iq9P9Q8Tfo/oGjHirBEuvevPPK0jsnxc3PtqF+L5Y
        jFjNCJWKsDJAd13zLXfR3pl/apYecxl0ofUaZmAqpEHJrxSkWVFj5sb6V4d/V18=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=QMrme3
        lYZ57TrQHVCiehVJXA8xjTw1btwYwdyiWaByyEuNGry37nPMe40/YnubmtACHvn6
        UCBhaut3e+XcJ7/AGVYyhCUm3k9cFeMaDIMx3NlneWDWa/IHLtoVS3sAeu2yfxK8
        Umx1V9cISdc0PhRvRVj5qqN3v3G7huf33dJqE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0D7B0167019;
        Thu, 20 Jun 2019 14:13:13 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 707A3167018;
        Thu, 20 Jun 2019 14:13:12 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/6] Change <non-empty?> GIT_TEST_* variables to <boolean>
References: <87imt18a2r.fsf@evledraar.gmail.com>
        <20190619233046.27503-1-avarab@gmail.com>
Date:   Thu, 20 Jun 2019 11:13:11 -0700
In-Reply-To: <20190619233046.27503-1-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Thu, 20 Jun 2019 01:30:40 +0200")
Message-ID: <xmqqo92snn0o.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 10E44A56-9387-11E9-9062-72EEE64BB12D-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> This changes the remaining <non-empty?> special snowflake test modes
> to <boolean> and gets rid of test_tristate() in favor of the now
> standard "boolea" test.
>
> I'm replying to my "gc: run more pre-detach operations under lock"
> thread because one of the things my WIP patches to make gc locking
> less sucky depends on is new GIT_TEST_GC_* test modes to test its
> racyness, which in turn depends on these cleanups.

That sounds like the "gc: run more ..." depends on these (iow, that
should be the reply to these, not the other way around)?

I am asking because I see obvious value in these "uniformly require
<boolean>" consistency change (which could be backward incompatible,
but as long as these are GIT_TEST_*, we do not mind too much forcing
developers to adjust), but not yet in the "gc: run more ..." one,
and do not want these to be taken hostage.

Thanks.

>
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason (6):
>   env--helper: new undocumented builtin wrapping git_env_*()
>   t6040 test: stop using global "script" variable
>   tests: make GIT_TEST_GETTEXT_POISON a boolean
>   tests README: re-flow a previously changed paragraph
>   tests: replace test_tristate with "git env--helper"
>   tests: make GIT_TEST_FAIL_PREREQS a boolean
>
>  .gitignore                |  1 +
>  Makefile                  |  1 +
>  builtin.h                 |  1 +
>  builtin/env--helper.c     | 74 +++++++++++++++++++++++++++++++++++++++
>  ci/lib.sh                 |  2 +-
>  gettext.c                 |  6 ++--
>  git-sh-i18n.sh            |  4 ++-
>  git.c                     |  1 +
>  po/README                 |  2 +-
>  t/README                  | 12 +++----
>  t/lib-git-daemon.sh       |  7 ++--
>  t/lib-git-svn.sh          | 11 +++---
>  t/lib-httpd.sh            | 15 ++++----
>  t/t0000-basic.sh          | 10 +++---
>  t/t0016-env-helper.sh     | 70 ++++++++++++++++++++++++++++++++++++
>  t/t0205-gettext-poison.sh |  2 +-
>  t/t5512-ls-remote.sh      |  3 +-
>  t/t6040-tracking-info.sh  |  6 ++--
>  t/t7201-co.sh             |  2 +-
>  t/t9902-completion.sh     |  2 +-
>  t/test-lib-functions.sh   | 58 +++++-------------------------
>  t/test-lib.sh             | 29 ++++++++++++---
>  22 files changed, 220 insertions(+), 99 deletions(-)
>  create mode 100644 builtin/env--helper.c
>  create mode 100755 t/t0016-env-helper.sh
