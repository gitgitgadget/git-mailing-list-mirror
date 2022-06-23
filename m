Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70E71C433EF
	for <git@archiver.kernel.org>; Thu, 23 Jun 2022 16:28:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232234AbiFWQ2b (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Jun 2022 12:28:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232239AbiFWQ2X (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Jun 2022 12:28:23 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28AF6CC0
        for <git@vger.kernel.org>; Thu, 23 Jun 2022 09:28:03 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 6FF821B70C9;
        Thu, 23 Jun 2022 12:28:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=JhRwHZjoOtaK
        nHtdWuunb0ywAHSe1g6CZA+NO4hHFhg=; b=Urn9CNNUe+W3a0Ox+D/5Tqn+OzAL
        5OQPmgt+Oiez3PpTCHQeu9H/lLa+WUl3LTD3uc3CXrd9Vjs+Wgv8N2GXMhedNzP3
        w6SIbpdwZguSAZjgdU1SpL3Sh7r/jevbfYWIwF8tV1zTWLJmuNqWa/OZJ3hdpJcD
        Wtcd8XO1PCQzUyg=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 689361B70C8;
        Thu, 23 Jun 2022 12:28:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id C8CE21B70C2;
        Thu, 23 Jun 2022 12:27:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     rsbecker@nexbridge.com, git@vger.kernel.org,
        git-packagers@googlegroups.com
Subject: Re: v2.37.0-rc2 - Additional Breakages on NonStop x86 (was RE:
 [ANNOUNCE] Git v2.37.0-rc2)
References: <002401d88700$7908f6d0$6b1ae470$@nexbridge.com>
        <664fcc55-1cd3-eb01-9be6-80bc4492e849@web.de>
Date:   Thu, 23 Jun 2022 09:27:58 -0700
In-Reply-To: <664fcc55-1cd3-eb01-9be6-80bc4492e849@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Thu, 23 Jun 2022 17:21:46 +0200")
Message-ID: <xmqqmte31h0x.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 723F7220-F311-11EC-B370-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> Am 23.06.22 um 14:55 schrieb rsbecker@nexbridge.com:
>> RC2 had numerous new test failures on NonStop that were not
>> present in RC1, RC0, or prior git releases, ignoring the @2
>> problem previously reported.

I am wondering if "@2 problem" is the only thing that were present
in -rc1 but was only noticed in -rc2, which presumably is because
some other changes in the reporter's build and test environment.

> rc2 changed the following files:
>
>    $ git diff --stat v2.37.0-rc1 v2.37.0-rc2
>     Documentation/git-gc.txt         |  3 +--
>     GIT-VERSION-GEN                  |  2 +-
>     builtin/name-rev.c               |  2 +-
>     contrib/completion/git-prompt.sh | 32 +++++++++++++++++------------=
---
>     t/t9903-bash-prompt.sh           |  2 +-
>     5 files changed, 21 insertions(+), 20 deletions(-)
>
> The name-rev change only modifies a help message.  At first glance ther=
e
> doesn't seem to be a way that these changes may influence the outcome o=
f
> those tests.

Thanks for a thought.
