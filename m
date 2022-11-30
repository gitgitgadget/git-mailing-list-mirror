Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27682C4321E
	for <git@archiver.kernel.org>; Wed, 30 Nov 2022 18:01:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230023AbiK3SBk (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Nov 2022 13:01:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229813AbiK3SBj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Nov 2022 13:01:39 -0500
Received: from mout.web.de (mout.web.de [212.227.17.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66C442EF68
        for <git@vger.kernel.org>; Wed, 30 Nov 2022 10:01:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1669831283; bh=5Ieh1zDMWRck7yXmV4+ThLMVu3takPtApObc9iNzrMc=;
        h=X-UI-Sender-Class:Date:To:Cc:From:Subject;
        b=Wo051ryqbpyoDBZC8rLSu+3oQGfQfWLjOTbAMiwkbIKyANqiKjznwYa1TDK6eoFLi
         qh8O04NMMvvqMOrmq/qFEJUHkCvLf9mjHv1fzDlPyrFUQlgFW37rCPq0saJY9q3pvb
         OnfPEpE/jAnehC7Ti6lJJYiVYhmip+Ciuer0vf0wMxuQfIsoeeEiUylKxjXO0JmbFC
         caJ3Zd1w/llXiye3nmC3MDTQWQs9o/KsHm4C032r7l4aZYZVxldEFxEqI0jYSvxVta
         tK+BT75MZJgG5yfycN0uQFVSLIsFEuYO3VaTXKQlYVMxGkyknmSdxpRN2cCoSRLYRF
         T4fo8/bpe4WTw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.154.159]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M59nK-1ozLT4434W-001GDU; Wed, 30
 Nov 2022 19:01:23 +0100
Message-ID: <0620b4a6-b80a-d8a0-5a35-857b9fe0c986@web.de>
Date:   Wed, 30 Nov 2022 19:01:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.0
Content-Language: en-US
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jeff King <peff@peff.net>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH 0/3] diff: build parseopts array on demand
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:1JgRBCeQyksukWIBqDINYQVw4vzK+bPTDM7g/yUMCVOakeppCIS
 QUiq9UPWDI28Qa/JMggGJy6yrnrwlaDrkx/a+SpfQl747kwon/v/EmG6NkuOXkyPu7rYA6f
 okkLG/0xzwkWNNsJJgl3yGu+OF9kHwZuFVOMrIreNaw6BR1UEdx7fwMajLZLc3vhIJK5fP0
 v1Ug9IzyWXAFnbbAPTXfQ==
UI-OutboundReport: notjunk:1;M01:P0:sm6TT9YGHIo=;XFTRPF6VI3FRHeDuyiaGAZbubjN
 v10MftVEzfnZxsoh8mlpLAc2pPyyYQ23WGLwrN8w++VPHyIIhL5SNXT4HfbHyVExv6Y5+PgEL
 x13tzohZFHv9pdysfYVMy4t5Oko1/zWOi8o7bj1dKNUXjR1lCzUrR3rVZ4Ut46usZAs4qf0jO
 rzk/I3AUnddea0wum9zVhrKHn1eHKsqESQVEXstlRFHLt9Xv95Lhp01YLfF+8y+rwx/RFDD1r
 RlHVl6Rsf386jT7Gqf+k4VHRdt+pPwmXNjYjY0MosqjPWV1wDfmzsNOKE3r3d9f6tvDwXG16k
 A0aaH+iXwCXzz33s+TCbJjsn6SkLDQer639UqGvV4ZgMU0QMsyM3hvNtdno+NSzmtB5/Cym2j
 3NreyJcTvBVXwcsMONgP4PgcWppGxC9jZQ6Q9NozYBEMX8i8sG9lySf5+kgVIgCVWdn1mP0gN
 bXce2LV/UlgtxIUxpJk2G2P6IENMsBUAufVaCB+9RNeWmFFESKOInYwPbnIwYnGUfPcZogMsf
 53NIddyaw/gTNw6EJUKdvIYbEo02+I9q1W7aca1RudYxXQ7BpZByxKtIjuYhIzCAfPrCLnpSY
 neXBtyh7vaeFNpZ+SGPIDLWKoY2n4b1sVeLMA10sM0qY3HP2zGsJ3Xhl30lM4qgEhTtfXIo+e
 qlNmodGATkYbRYCmAbGi2HUqzndmXhCvQpf0rVAdUA2DVMWmcRQqOZatJKyuoBRFPsKtv3ufr
 dHHyegcNE9JJW/819Er3lm7MdUQ1bI/TFIH3ABfoy8xbOAvth8tF/McWoPbOwvSS99OcnGV3O
 zLYM/nZsrd+OGssQgDaBl6VlpUU7veLMDY30fwv/PIjbsFiiQSuqSGoXoYOCeDQ7WI7Kfnd7+
 0wjo2+Nh4ZNXuUiY8jZcPHlpdTpErk/4tdR/o6DoVqdC5hGqgPhln6soUR/Mpjfcx02+jN055
 Pgq1YYp+pLUKftdNuc1WxuebCpw=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Calling repo_init_revisions() and release_revisions() in that order
leaks the memory allocated for the parseopts array in the embedded
struct diff_options member.  Get rid of that leak by reducing the
lifetime of that array.

Original patch:
https://lore.kernel.org/git/4fd82dc6-e0f8-0638-5b10-16bfef39a171@web.de/

Submitted separately from that thread because it's independent enough.

  diff: factor out add_diff_options()
  diff: let prep_parse_options() return parseopt array
  diff: remove parseopts member of struct diff_options

 builtin/range-diff.c |  2 +-
 diff-no-index.c      |  3 +--
 diff.c               | 26 +++++++++++++++-----------
 diff.h               |  1 +
 4 files changed, 18 insertions(+), 14 deletions(-)

=2D-
2.38.1
