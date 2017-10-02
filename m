Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A724E20281
	for <e@80x24.org>; Mon,  2 Oct 2017 13:56:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751160AbdJBN4j (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Oct 2017 09:56:39 -0400
Received: from mout.gmx.net ([212.227.17.22]:53292 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751101AbdJBN4i (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Oct 2017 09:56:38 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MUpI8-1dp6fl0yZI-00Y7Ml; Mon, 02
 Oct 2017 15:56:33 +0200
Date:   Mon, 2 Oct 2017 15:56:32 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 0/3] for-each-ref: add :remote-ref and :remote-name
 specifiers
Message-ID: <cover.1506952571.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:1BeF95rcWXfyLmBbRkJJyx1LcRPPQ+eGQMHhsbKGmt9aUfkBU8W
 p1jk/dh7XKtEBIbVYxC1xDUqlbfsGu2tVepNGgPV54F0SpCJ1Jg/GvvBBBbijzR4LnnUXuU
 k/lHzc/B22RdjNzFpl8HISVt3eBuUQikuQZlwcRUZHAYP/0XBIE/NZk8amUVAkwmt+QjD9r
 e3Ti4ny4SkH6NtKSjYI2Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:CM8qmlFjWFo=:KxryqjJRbzmAJE8rVrLJy/
 IAxkVFNScHd3A4snRVCGk1q4NzfexsXN6GMaWj4GXShBX+LhApc/isxJ1vFyJjCPySnDtqG1f
 KgC2sZ6wtov5q3Rh83Mw8FYDDJF3j0GHSTJ1S9g/i3ks8ckINun3lBv9keiuxYY21XM5mT7jC
 bPBeGqdaXnLD4ii/n878CUcNjOU1ynnI57c2U70KtDetrmT+as58Wh22E4bTsz7n1m4RNFbTy
 dAsangiooki+LVg4QIimC7zjKQ2xDln0mr6CJnXhzViKML3ZPgp+HfPgqOD9lgR5ZwTXhakrf
 yhGegHmGCUJMW9P2eJuNskkzu2gW/pjgTkY2dk+juFPSbtNEBdQC1ZEYa+BSY+N2XviMhUIuF
 kF8FXqsKK3urfD6rJl19gXy/nMx4cmsvr5V34Z4rxwYtBxe7kjg28lBlk1ZxdNRtdIg6xDl2R
 +87Knenq8wtTXZONuDH/cE5Ilu/0Iz2Ce6tpAytA4Zpna1nC4llNQaL6vR6jFlHEse7I/cyeu
 3kZiZ9KmHBmWux8tCOEDuoC7W6Y9c7wVrr00G4aOk+SB+OHdd85mddSnQGpjgyhYcFx7zHvOs
 WYEzkD0vwx+09G6NCy8Bo5ftIFy0jg+5LDljkJyr5NGFUHyPnKGZPzb/eHC+iTfmOT7ravyh8
 9HN24O/mfSTtlWHwCnDy2rxpSm7B1MzyL1FBXMnnWvFsDFpibVLH1OoWee5IyTnb17Dci2si8
 9YeMGGox9a1cO/PRr8noFjS0V9f/bYTSePPaiTbZtdpPBgnHTRF4hhb3jGw+8eyc7HHR3VA9F
 QSzgjmmziZeoCyhTzqzKg6hpfofGHaguFU0K70njmxZDFO7hVk=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This introduces support for

	git for-each-ref \
		--format="%(merge:remote-name),%(merge:remote-ref)"
	git for-each-ref \
		--format="%(push:remote-name),%(push:remote-ref)"

to figure out the remote nickname as well as the name of the corresponding
branch on the remote.

Note: the `%(push:remote-name)` placeholder is only interpolated by the value
of `branch.<name>.pushRemote`; unlike `git push`, it does not fall back to
`branch.<name>.remote`. Likewise, `%(push:remote-ref)` interpolates to the
empty string unless `remote.<nick>.pushRefs` is configured.

This is useful for third-party tools that need to know this type of information
for tons of branches.


J Wyman (1):
  for-each-ref: let upstream/push optionally report merge name.

Johannes Schindelin (2):
  for-each-ref: let upstream/push optionally report the remote name
  for-each-ref: test :remote-name and :remote-ref

 Documentation/git-for-each-ref.txt | 19 +++++++++++--------
 ref-filter.c                       | 35 +++++++++++++++++++++++++++++++----
 remote.c                           | 30 ++++++++++++++++++++++++++++++
 remote.h                           |  2 ++
 t/t6300-for-each-ref.sh            | 32 ++++++++++++++++++++++++++++++++
 5 files changed, 106 insertions(+), 12 deletions(-)


base-commit: ea220ee40cbb03a63ebad2be902057bf742492fd
Published-As: https://github.com/dscho/git/releases/tag/ref-filter-remote-name-v1
Fetch-It-Via: git fetch https://github.com/dscho/git ref-filter-remote-name-v1
-- 
2.14.2.windows.1

