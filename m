Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 52B9D202BB
	for <e@80x24.org>; Wed, 20 Mar 2019 18:03:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727196AbfCTSDl (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Mar 2019 14:03:41 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:56581 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726438AbfCTSDk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Mar 2019 14:03:40 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E061355F15;
        Wed, 20 Mar 2019 14:03:35 -0400 (EDT)
        (envelope-from tmz@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=eiy6s/d2BZEt
        pqyXtGGX4/jZ0xA=; b=Bm2489qyXPXr3e/f7OGCofLT1H4dFF/BMJfKPMjT8QTF
        9PHPp5LeXqHmh6UgGnKZ2XkvzAuO141nAayw40pvVBPHcqA5K9tNQhWIIbUdN0mp
        9dR6Ak3JbQyGTaV2ExEvbRSpZxOGOnGjK9uKz0bi8kMKltslScluvFG+UbZiuOU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=uWZ3+Y
        aP3PeooJmezqPJtUKeVru3uIrOMVG6ZsyaKmfZcEpKQK3eYT9z/bhFK8+yUvbCTj
        RppTAuB7fih7HxS0h1eFUdxYGxwkHFrRM6X+AfrOEg9VqgOe/wHQZeNsGk0awDqU
        LNCR+Vseiz6Px5O3QqSnQTL4tXysAFb/if2VY=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C488F55F14;
        Wed, 20 Mar 2019 14:03:35 -0400 (EDT)
        (envelope-from tmz@pobox.com)
Received: from morphine.paradise.teonanacatl.net (unknown [47.202.93.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 2F43555F11;
        Wed, 20 Mar 2019 14:03:32 -0400 (EDT)
        (envelope-from tmz@pobox.com)
From:   Todd Zullinger <tmz@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v3 0/4] completion.commands: fix multiple command removals
Date:   Wed, 20 Mar 2019 14:03:25 -0400
Message-Id: <20190320180329.22280-1-tmz@pobox.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <CACsJy8DiQwmAKMruOAO4roPbiRTvt5TESBTd682hTwkZjcoj2Q@mail.gmail.com>
References: <CACsJy8DiQwmAKMruOAO4roPbiRTvt5TESBTd682hTwkZjcoj2Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Pobox-Relay-ID: 7959C326-4B3A-11E9-AF17-EE24A11ADF13-09356542!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Duy Nguyen wrote:
> You probably want to drop the comment block about repository setup
> inside list_cmds_by_config() too.

You're right, of course.  Thanks Duy. :)

That's the only change since v2.

Other than a follow-up to update the commit reference in 4/4
after 1/4 is in the final form on pu, I think this might be good.
If it's easier, we can skip 4/4 and I'll resend it after the
others are on pu.

Jeff King (2):
  git: read local config in --list-cmds
  completion: fix multiple command removals

Todd Zullinger (2):
  t9902: test multiple removals via completion.commands
  completion: use __git when calling --list-cmds

 contrib/completion/git-completion.bash |  8 ++++----
 git.c                                  |  7 +++++++
 help.c                                 | 11 ++---------
 t/t9902-completion.sh                  |  6 ++++++
 4 files changed, 19 insertions(+), 13 deletions(-)

Range-diff against v2:
1:  e51bdea6d3 ! 1:  6e9872b0e3 git: read local config in --list-cmds
    @@ -33,3 +33,21 @@
     =20
      	while (*spec) {
      		const char *sep =3D strchrnul(spec, ',');
    +
    + diff --git a/help.c b/help.c
    + --- a/help.c
    + +++ b/help.c
    +@@
    + {
    + 	const char *cmd_list;
    +=20
    +-	/*
    +-	 * There's no actual repository setup at this point (and even
    +-	 * if there is, we don't really care; only global config
    +-	 * matters). If we accidentally set up a repository, it's ok
    +-	 * too since the caller (git --list-cmds=3D) should exit shortly
    +-	 * anyway.
    +-	 */
    + 	if (git_config_get_string_const("completion.commands", &cmd_list))
    + 		return;
    +=20
2:  2f5e9da9de =3D 2:  6873ae3868 t9902: test multiple removals via compl=
etion.commands
3:  7548dcc23f =3D 3:  f66bbc0b55 completion: fix multiple command remova=
ls
4:  26bef0b2af =3D 4:  197b176483 completion: use __git when calling --li=
st-cmds
