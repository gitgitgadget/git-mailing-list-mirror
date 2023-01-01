Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E830DC46467
	for <git@archiver.kernel.org>; Sun,  1 Jan 2023 21:09:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbjAAVFo (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 1 Jan 2023 16:05:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjAAVFn (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Jan 2023 16:05:43 -0500
Received: from mout.web.de (mout.web.de [212.227.15.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE5C2D6C
        for <git@vger.kernel.org>; Sun,  1 Jan 2023 13:05:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1672607134; bh=uCoUpLgr3SzQFB8stC9HmdsQ3Isxg+qdtg+ej7T2Bz8=;
        h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
        b=C7mtNe08/clHmefwCcD4RALCZtlj+PmKu8s7Ud4XSiT+unqXwwYNFUM3Hni/ecvn7
         PyN/oDcNukWraX4gXU0KykGxMuUmJzQI7uT2T8kyzmKcBZPxaR1yKB8znhEw+iQUUY
         fUZ3rOWDs2G+ZytsMTRQC3V1V+kJzvuZ3paqnKNM7HmDiySO5ICP8COjh5z2DayOs8
         MsK/DJXmwMgShi9sQuFR5/XEuFEkJ7Xv5lRMXwSSnyL96vUqsut98dmmx9IIyPvl2J
         wpcbcRUXpVZ4UBAJo+bdhIXBwS/pgUMQZoeHmPMuMXiKlFnI9UtwxYmUXn2+fLBuIV
         IV7G18r/Nqlkg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.151.35]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M8C07-1p7wmj1fMZ-005HTv; Sun, 01
 Jan 2023 22:05:34 +0100
Message-ID: <9bc1bd74-f72c-1b43-df7c-950815babb03@web.de>
Date:   Sun, 1 Jan 2023 22:05:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: [PATCH v2 0/4] COPY_ARRAY, MOVE_ARRAY, DUP_ARRAY
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
References: <efe7ec20-201e-a1c1-8e16-2f714a0aee8e@web.de>
Content-Language: en-US
In-Reply-To: <efe7ec20-201e-a1c1-8e16-2f714a0aee8e@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:tHxMyl0uVJWFEPv13Cq4dWR+zK0LkFjiqXgsrAMr+6EXKhGvHIN
 jv5Qr24tcnxN/CtOfB98PGQC2zNr2OT9YiBJb+tPvzPe+H2a/6LPPelCU/8lz3BQFbmP6hL
 4Dqr00mhEv/oAWI7h9DeSeQ7ma0a1zQl+Cvx/LiPM1KIgEZOKlAwce2IYrbCYg2FCmd9ego
 +0Raq7UHdUA7U0nemQZQg==
UI-OutboundReport: notjunk:1;M01:P0:0ur2QNrjQns=;1aUiIl3vYLVCysP+7s45FWfhKoB
 wAnn0MXiM7BqhujHjOndPKEl1dh20eC43bIy3zogsvQeIrk04EMOkl7Lmti0rAeO9yZFt0eMj
 MYC+I4fDnBXT8PeA7oTgnO+cZgAZRL5V7BVerD9+qUJ3npvKBQQVl6alRdiTwXy2D7r14l4OW
 BTEZcMADR06iDTn/bwVX/0Z3cUymVflhEX9DZIux/LRXk2+JpfSXBSre3PbST46TZjg6d8Yhm
 HSOpZ5qUOH7bqwWg3ApvPFMoYCtC4QkTzNmPHvdiC1G51lGXAAUJtwsbUDL6daNUXXNquaVez
 TzI/lJQQtQOw/SPoiqtCYcTgeiO8kkFGxos5X4R3P7NNqGV+6+elpKc3/Ww/IOsdbpLziR9xT
 E5ugc8Hg1ds91Rx6GcQ2sZdD4TQRNd1i0glAz7ukRCskme/nU9ZXzaLZra+WL1Lx4KUYbr4/O
 EkQyaVAPRRfEEOSVLNLcS/p/ocY8yO8ShTg9qouJj4K7lB3CLvvktpxNKZGW2k/msRKx8FWAY
 5lwjouy+b2TYkZSbpLG2poUnUMpGr5v/CW0MUtfnCWQsCfVhDTXdFxkSVdAsiEu+ugBPmYIVU
 SI+XzPcOiSagyMm9CwkvxeALqe2azRTKkRcI2W+4iA+R3Puxkg2jmimaNJRBGUqrA87/LYJJC
 27PGOmvq90UozlrJdwqeqnbpB1VScAESnqQ1NfLNDrgWe4gU4A7/+b4ko28Zp8kqQAjLG+jyk
 LtLv2erd5siWSmbospY3iECyf9p33v3pHgwQFb8mLliEitX/v1r2y85SCqWKfM0xWAR9tr+Nw
 mkF9yF1bU5oX1fd/VbgtTQUYa6mET7bmSMBLUIavWLWPVzzPASQY0C8r7ufo9aD1J4dmwKC+r
 g1otdCwV/u4ACTFpi557HdmK+S7EPptOY8Dnd0gNRCjKjbLV8chQmjdLVNMG0lN6p8j2Rzc0t
 6ymwedn1sSm5qWxkT481CuFdrKE=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Changes since v1:
- add macro BARF_UNLESS_COPYABLE
- use __builtin_types_compatible_p if available

  factor out BARF_UNLESS_COPYABLE
  do full type check in BARF_UNLESS_COPYABLE
  add DUP_ARRAY
  use DUP_ARRAY

 attr.c                         |  3 +--
 builtin/am.c                   |  3 +--
 commit-graph.c                 |  3 +--
 commit-reach.c                 |  3 +--
 compat/mingw.c                 |  3 +--
 contrib/coccinelle/array.cocci |  7 +++++++
 git-compat-util.h              | 15 +++++++++++++--
 parse-options.c                |  3 +--
 pathspec.c                     |  6 ++----
 9 files changed, 28 insertions(+), 18 deletions(-)

Range-Diff gegen v1:
1:  052b9c103d < -:  ---------- do full type check in COPY_ARRAY and MOVE_=
ARRAY
-:  ---------- > 1:  f50df9208f factor out BARF_UNLESS_COPYABLE
-:  ---------- > 2:  6a98a8f2a2 do full type check in BARF_UNLESS_COPYABLE
2:  fb5544fc51 ! 3:  757baca245 add DUP_ARRAY
    @@ Commit message
            dst =3D ARRAY_DUP(src, n);

         That would be more versatile, as it could be used in declarations=
 as
    -    well.  Making it type-safe would require the use of typeof from C=
23,
    -    though.
    +    well.  Making it type-safe would require the use of typeof_unqual=
 from
    +    C23, though.

         So use the safe and compatible variant for now.

3:  bfbf085ac3 =3D 4:  435fbd8e92 use DUP_ARRAY
=2D-
2.39.0
