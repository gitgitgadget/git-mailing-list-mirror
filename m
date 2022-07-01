Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE5CAC433EF
	for <git@archiver.kernel.org>; Fri,  1 Jul 2022 17:03:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230439AbiGARDX (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Jul 2022 13:03:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiGARDW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Jul 2022 13:03:22 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5CB013DF9
        for <git@vger.kernel.org>; Fri,  1 Jul 2022 10:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1656694999;
        bh=c9RKcFssLmLTpn1CNZLf/kSoV737GgdyR8iQh84Kfhg=;
        h=X-UI-Sender-Class:Date:To:From:Subject;
        b=amPU0PZ2pfZlKupEeff2oeH534kPiL8Ylv3yZThddsSfw73cwbO88CeJTrfJr7BDl
         ORu7veqzT3kdcYg7DQutFBcUT6PXfRBGDQVvfD1gdUO7J3MbTHA1A7Czsb531dSwWI
         ck3Wl1lib/0EaZTZ+9eTwPzLTmkdjoaKMw4ey1HY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.178.20] ([149.233.230.9]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M89L1-1o27Nc0Hv1-005Kmc for
 <git@vger.kernel.org>; Fri, 01 Jul 2022 19:03:19 +0200
Message-ID: <130c3636-b978-1600-df53-6a38c3414a88@gmx.de>
Date:   Fri, 1 Jul 2022 19:03:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
To:     git@vger.kernel.org
From:   Roland Illig <roland.illig@gmx.de>
Subject: undefined behavior in builtin/am.c
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:zsPKLc0/A5lhYfxtHpGUpfpMvXFCdQb97zdEhQjJLc5xg50zr4C
 8i7+ovciBVohR5bFplerRIt6WGwMVQ0k8ucaFR17W7j3kpWkV420wOOhvLsfyo2pffcC8j8
 SXMgD5edwrx7y79fNnUH0lu0Ry8TWZJ8SvHbq0V3ivJKYP9hAfCGKA5/2typ4ToxYnfWH8X
 dDJ8DvuL2/532myVkZNZw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:EO+52EsgeS8=:KaQ+CgL5Y01qSjTCONGfdD
 OziU5UWB8AKIVh6I3S4j8q08NKE5kAiqwa+Pa0x8NvCmUnWJSGTfkWL0L9KD5egaTvdRmoh/0
 sPtKsXL+CR233D4uE2TSMYw+F9vm6GDtw+r2qL5he1XPDC6FrKRoDJcwXYPh0CBnqZlu9klcc
 aJXWH43A9u4aalEZmtausXLxOkBD9Wj53So3+E8Ld7fU4YfrR5ND1SiVmxL4oChiSJd0HNaFK
 XQ/BljyS+beKoAlPb4FLU56zxt6p+tPO2sT6K9Z1ij+rrqitPqiEMohL7yBz4b6eLMhnOKHv0
 NWoV4h+TdLlPw50SKY7YV3DmtKSaHjNyXzmJ44pNRyUSTurkVALF2At/D6xDTVG5EPPl71ZeP
 d76j3gHfi1ZsshjY2rghqGr/dTY7GNeOiBY/sOyHczUPNEuHcfQAf4Y2DPXK1b8QZmFRfIueC
 ekHKxpZcn+1QwCYhZbaOPFU/P1taX5HpBMhjRTx8xyyasgRgnpLWYVJQIVK6UYf8nCMWNMqfc
 YxvIlhfA7VbAdSJph3krwLW+p2JwWvcJaw7B+XkMjklH/3hMPVqiiVpal0E8rxFevTuXK58JM
 3HzkCjOmaLyKc/ugWxxQMpHbKj7rqc1USdXWR62re6X08T3uMhRRmLAk5RUyt0qKbpQ6S/YZ9
 G71JJb54gdFdq9fiFfXSZLjUNiOT4d89viyfjfbEpC9WHJDQtTw5sCmlkpySRI5c3je48hiur
 8CU/ArbXEYZxCRjFWSA8o+JLtHmG0rwmyNEjm68Dq24CqJZCBtbCDxSNre5QHNbiys7q/DhwC
 WujrBdIngQbezNHv/8V8h6x9C423Yt55d+A+8Pl2Vt+f6/Or0EZgj70yy1zIDUiNkgZUglllO
 qj7z3IViN8WZLPuh+nSU4dX7TQVgnXHrOL4r+CaMwUoO/piotz5SFvmq9bs5u3u8n+J4Oq3Lk
 I1UJpnw8lUxap9PwAabog0Zmun5xqhFAvyre+YvwvPbsvhuCBxD8zXrU2+gFfiwCDJUMROZBF
 HWTzV1LJTSjku6UFedh3CaSJxMfM83inTO/PIhPYKXctOzZ2p65//3YI0gV99RwLv9m4qs5S9
 50fqqZ4s5g+YIfgd6Ha4bY9e5zMwOrAznFvVWW2dBdfOAqxdiNOCYIODA==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

builtin/am.c says:
 > static int str_isspace(const char *str)
 > {
 > 	for (; *str; str++)
 > 		if (!isspace(*str))
 > 			return 0;
 >
 > 	return 1;
 > }

The macro 'isspace' must only be called with an integer representable as
an 'unsigned char', or with the value of the macro EOF.

On platforms where plain 'char' is a signed integer type, any character
whose value is negative invokes undefined behavior (except for the one
character that by coincidence has the same value as the macro EOF).

To fix this, write '!isspace((unsigned char)*str)' instead.

I have no idea how to trigger this part of the code but for someone who
knows this part of Git, it should be easy. Depending on the platform,
this kind of error may be silently ignored or crash the program, as
always with undefined behavior.

Roland
