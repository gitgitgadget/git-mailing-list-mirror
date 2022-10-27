Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B700ECAAA1
	for <git@archiver.kernel.org>; Thu, 27 Oct 2022 16:30:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236087AbiJ0Qa5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Oct 2022 12:30:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235531AbiJ0Qay (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Oct 2022 12:30:54 -0400
Received: from mout.web.de (mout.web.de [212.227.15.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B36855FACF
        for <git@vger.kernel.org>; Thu, 27 Oct 2022 09:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1666888237; bh=kuqtjl1KrvCHGy7Dw5u08LE93KqWuDIYSYtIju/2Rns=;
        h=X-UI-Sender-Class:Date:To:Cc:From:Subject;
        b=nQhiS/jZE+sjS/rgDgS90Drng+L3GjfYfPH9MHjPqlW9v+HBg6sgZ8lMoSn9bF2/B
         B3aiRoDlrTGxwEwzG9doO4fcUI7aYFGXvALbUVM2Pn9G4X2BBR1rL58lkk4DJQ5Viq
         UjMupBhUuSuwsBaqjpzkvvPnP0S6tS9Fgxip22hwXt04onHbFZ0LPsYGcZXsHinmVz
         0QyotyJ4XJHp/K8B4WUPjTBsPdWdXFdb9s0uhJRwgetEpfDpxWYxF+To/WRFu8cAko
         u5JXp4dSISktwbfx3Bb5SDfvuZMDO9uZKhdsGQegvNbd6l8Y7RoAhfltfTr0zI69bA
         W/w7AHZ4zXz4w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.23.191]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mkmzr-1pUYSJ3V5L-00mL24; Thu, 27
 Oct 2022 18:30:36 +0200
Message-ID: <7407e074-4bd8-b351-7fa4-baf59b41880c@web.de>
Date:   Thu, 27 Oct 2022 18:30:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.1
Content-Language: en-US
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH 0/8] run-command: remove run_command_v_*()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:XIuCk8h4nUlWIzLPvIu0632nYg/8D+aHcZmpbYfDvYYFKrZi/m5
 lZCkt+RdZRUek8aZyxk7SybZGPEWyy+ldvIov6BDHYyXHi7tBGVLbgIaDwZl4OyZ72zLYxA
 18FyA0nE7JwFkURC4d3NayN4stwUAratUjzDSIgwjIH1qvktIppJFZIFr1hhPlvxhNe+nwi
 SowErNQbog3zQ++AQCaug==
UI-OutboundReport: notjunk:1;M01:P0:X3i96CHFjSg=;iqxSjbE7qsSlBe1mDCSXz9mBt5p
 hJqbvizw++zVYOYqOilW9nmOkAcQDVHJGLWdafiShZb9MS5quPzaF7vTZfub+rkKX4/P6XjcG
 rbjWeVwibSrjDbemH11Rk8ch5WIKu/X4RMyJXJLdL3qQy7zbZ3+Ov1qGpKk1gMrV2/Lsoyj9Z
 k+a12z0gtx/N7qfrmSXe2CTkkkVUNJSgXI9nKZAlEW4rgH++3LN+dr5K6k7EdyPMeTl4ZeOuj
 yz4Jcyl4xf5A5l6PrUz/rzDK8qlXnnKk5Ff2CGA32k5KOyj04NimIY15mABgvLaLyUnOBIAnc
 lCysuRYXZBC3oCUyzsjiHlbADei1K0D0fc8VpAjhQGnGzD1UY8yo0JCVHW9WNFZY9MlxIOI5D
 C4bIgOs4SLdUGQMveaO1x24IPka4GcJWW/DxlK0hN/qn+rlDSjZtMXJ725R7eXafrBKqlFPhS
 iQ+udBxmpHwdlP30ioQ31U0nWJeZHjwF7I7auW19Hu1FayvyhRhCSE1rMUesJ8doccMH9eIoo
 vN659U6v0rwSRqRlYI+19aN0dCqX4jWwwrkDEpSNjpP3n3BU8YogBjL/xr+hRUOcfpGYKkCfD
 W1nKDXdBBusiCBpFxvL8ka1LKuw2tUeeyScqWQqM9QlsPM8W4Kyb5KdpFlRW5IOj3HwoxBvP0
 n39VYjJxG36NMK4bfV2meeJiO1jbRCCtZSDw/tqEBe5J8HxgAg7cx/y+Ecd/m5wP6MzxL7/UY
 7N6Ezy8LK8RGad3R6M/OA6CK7GuMOwd4ZMSGrbxIPOAluB0UfbMqqOgdtwu16XiIYtj5o3KkL
 Dee3tsS13S36+PQPEpFvg27W7uwnjFrrUjXawImszUEdYxXFU1spwjg6dbAj2egCqsmumEjmH
 +0uqhsKqV+R2oIYCjpnixwU8p+yFOnQdT/RSzb2+JcwqG9g5jBT5FTyTbTiqDYrpzoLM4lSPx
 u11OUytCYHfOHDozfV3ugXi9twU=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Replace the convenience functions run_command_v_opt() et. al. and use
struct child_process and run_command() directly instead, for an overall
code reduction and a simpler and more flexible API that allows creating
argument lists without magic numbers and reduced risk of memory leaks.

This is a broken-out and polished version of the original scratch at
https://lore.kernel.org/git/9d924a5d-5c72-fbe6-270c-a8f6c5fc5850@web.de/

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason (1):
  merge: remove always-the-same "verbose" arguments

Ren=C3=A9 Scharfe (7):
  bisect--helper: factor out do_bisect_run()
  use child_process members "args" and "env" directly
  use child_process member "args" instead of string array variable
  replace and remove run_command_v_opt_cd_env()
  replace and remove run_command_v_opt_tr2()
  replace and remove run_command_v_opt_cd_env_tr2()
  replace and remove run_command_v_opt()

 add-interactive.c        |   9 ++-
 bisect.c                 |  12 ++--
 builtin/add.c            |  19 +++--
 builtin/am.c             |  12 ++--
 builtin/bisect--helper.c |  68 +++++++++---------
 builtin/clone.c          |  41 ++++++-----
 builtin/difftool.c       |  24 ++++---
 builtin/fetch.c          |   9 ++-
 builtin/gc.c             |  55 ++++++++++-----
 builtin/merge-index.c    |   4 +-
 builtin/merge.c          |  53 ++++++--------
 builtin/pull.c           | 147 +++++++++++++++++++--------------------
 builtin/remote.c         |  40 +++++------
 compat/mingw.c           |  11 +--
 diff.c                   |  27 ++++---
 fsmonitor-ipc.c          |  10 ++-
 git.c                    |  15 ++--
 ll-merge.c               |   7 +-
 merge.c                  |  18 ++---
 run-command.c            |  35 ----------
 run-command.h            |  33 +--------
 scalar.c                 |  13 ++--
 sequencer.c              |  32 ++++-----
 shell.c                  |  17 +++--
 t/helper/test-fake-ssh.c |   7 +-
 t/helper/test-trace2.c   |   4 +-
 tmp-objdir.h             |   4 +-
 27 files changed, 344 insertions(+), 382 deletions(-)

=2D-
2.38.1
