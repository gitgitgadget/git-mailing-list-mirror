Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C95AF202DD
	for <e@80x24.org>; Fri, 14 Jul 2017 08:39:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751402AbdGNIjd (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Jul 2017 04:39:33 -0400
Received: from mout.gmx.net ([212.227.17.20]:55990 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751362AbdGNIjb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Jul 2017 04:39:31 -0400
Received: from virtualbox ([37.201.192.198]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LzGV3-1djOQu304H-014Q2B; Fri, 14
 Jul 2017 10:39:25 +0200
Date:   Fri, 14 Jul 2017 10:39:24 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 0/2] Fix regression: CamelCased aliases
Message-ID: <cover.1500021526.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:hZEOm/eZ7BJlBQlp9yHMGrLFlZ7uBx74l568rTR1d82RTR2fKiP
 30yZKWiykwSoPBxHLQJ9e6i/octBxXDk+CqQRx5hJh0KIKlem06zFFihPHxK2B448unyXpH
 tZdK5GP4qCHYgqEaMaJYIlTZVUzxV51K5W3SvtvfJpYfdAvA/u82QSemCR7DYL7nvuWKEOh
 PBkmrPBpDat38cqOt6LvQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:tWf7ibml/hM=:+e5euHbnQ0aw+vVhN8Miz3
 3IAZ9biPCxvhR9PdrvxnKiHuaoM8wMNf4FYnkmqy7RFIi3kApcUgCsXzeDcVTPt8q/6iaE9Mz
 lDz3BzLyd3fXE3nME0mabnc3m11jzhiCyIpiE3b7+UORgQ1IauAejeNvgUJS/qkvWaK3zMVWM
 9xP9JN1EHIAdKsTWpYsZDVpxwMNUh2ah94yH2ZzjK/f3IXvk08eEerHvPAOMUmHHxDNEuuxtN
 cVrDmEOft4+QZFHz7mjlqqQwEcnFQa+JuwolHrmzggFyvTdSEpp67o3mwJpHohTXIj1ISah9x
 //QhifJoD5sRSVDJ/3hdBzswus01n9rZDG08S9xQtNOPlZmwpUSrDYT2VL85FmRmlcGmYTln1
 Y3dEF8bMGpm7lvzEGWWADohA7B+A15k1YmBi1JZ9igUpqpiVq2lkKKTWZkiH5kx4vvtmOjMm5
 ztq6mY27QtDJGFd871bYGDPJZjhfWnfshdDvORDNnhGkulDxL33h3DkMcE+uoZoJtdcgjkFdQ
 hy+9VXleNxm+NWDjzG0gHLBcowfSfZKI65Fp6L1q8+6zRtUvz5quuK9ZaI6ebGcgCcGS/YKTs
 s3Qz55U8ibxmHUy6GFpT+1tRi94iWs9MLD21Ot6toY5Otf0MZ0A+w98+lSEApl37XZIUl0nfl
 aG8U0HoM0eW1nxjU9yBCe6u9H7m/3mYXPjELZFzwzgs4dQxH1dTHzhbFf0cYum0ZLF84EVpSX
 BCp8dlzMuFKWESSf0kF+kIof03dWO5EV3nXHGYMKDvz8/BWcDkW6VP/ByzYBevnrL61v6XbGy
 6PPEYkr2cP54zZchctXS0waQ35zwOsRbJJ0hmz1BvTDhvSDgQ8=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It was possible before v2.13.3 to invoke:

	git config alias.CamelCased <something>
	git CamelCased

This regressed (due to a stupid mistake of mine that was not caught in
patch review, sadly) in v2.13.3.

And this patch series fixes it again, introducing a regression test to
ensure that it does not get broken again.


Johannes Schindelin (2):
  t1300: demonstrate that CamelCased aliases regressed
  alias: compare alias name *case-insensitively*

 alias.c                | 2 +-
 t/t1300-repo-config.sh | 7 +++++++
 2 files changed, 8 insertions(+), 1 deletion(-)


base-commit: f3da2b79be9565779e4f76dc5812c68e156afdf0
Published-As: https://github.com/dscho/git/releases/tag/CamelCased-aliases-v1
Fetch-It-Via: git fetch https://github.com/dscho/git CamelCased-aliases-v1
-- 
2.13.3.windows.1.13.gaf0c2223da0

