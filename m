Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0DCCC433EF
	for <git@archiver.kernel.org>; Wed,  3 Nov 2021 23:17:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D839861058
	for <git@archiver.kernel.org>; Wed,  3 Nov 2021 23:17:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbhKCXUd (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Nov 2021 19:20:33 -0400
Received: from mout.gmx.net ([212.227.17.20]:43729 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229652AbhKCXU1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Nov 2021 19:20:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1635981468;
        bh=421a5rSJ771OySYpJJ+wRyLz6jrieg8UwA1bUFjw6BA=;
        h=X-UI-Sender-Class:Date:From:To:Subject;
        b=EtP9Xpyo7340FyEVxPqMjAX4TvmwPIFB+iyuRQU9D1kGyZr7OM/ftnUBO10JkKqZr
         k9Az/1Qsb3McXwPH8ftmVDmCa9EWHnDSDUG78DMm3UKr7qS60dUL5aUpxvb0nXcbbz
         mXzMNQucMpDQTfpmCAegFwZPY0IUrGlHFCfgERWY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.20.119.151] ([89.1.212.10]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MbivG-1mC66604lS-00dGGZ for
 <git@vger.kernel.org>; Thu, 04 Nov 2021 00:17:48 +0100
Date:   Thu, 4 Nov 2021 00:17:46 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     git@vger.kernel.org
Subject: Breakage in dockerized(pedantic, fedora); Fix in the works
Message-ID: <nycvar.QRO.7.76.6.2111040007170.56@tvgsbejvaqbjf.bet>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:aAybSH0y4yemSqWqQuONTCZHyu6cCEH9u2RORssruVSxIRR3um5
 WwigCLMV0+bTaf4/GK4xzjYIpqLCN8tVgxLzvFkVZW4aGRFzA3XXSf8aozGPkpu2u35vpef
 ctAnFwv5xx9OLncAP/yjtwmUp4Ze9KmU/YBUXdbZRvKlTl8pOCTBONzPrLBtGZfR6fmiMsv
 pjgRMxabAKKVcj0tPF8/Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:bN6IO/4LPa8=:F+pIVL/ybAGeBWBVzfYVC0
 3g70N7+Fba6sphM2LfpO59EWblGd/D8bIdWmdC/i/bsihhyayy1Fe2GkjD+KjixDbSdGWYYpX
 L/LzGNmpcDX0wQ6xuUScdl55ipSi4Ik/C4T4GYhL2zpilr7qGmliLB6xoctUM216Gx4Be46bt
 RMWGVi8LUCnPC1TG6/zNkJWArCUQntQOSmzp37j2arAO3yEm5VE+xS7OqLRaR85JVeU7DXbAZ
 QKzpXlLvTZvZy2Lt87pZrnmdnW+iCkZaYh8yxYcDNlo2zFo4yjkv04gfWO+nW3e4ZOWjyk0i0
 BwBdmrfCyiHz3fWPhTirE8gez6ctGURTehGbKalfz9KP9LfhdWMqfDC3jPkJJKGhffsuAkX2s
 G+9mCZqYdtr39YsHN5RewkDNJkg5jBnzoOr0VMB44YiBB9YH5PD3ilqdwFTkSg6w2prevTrZs
 jsbW6UK+/MysMc/zIUMj3TpsZI0eCsX9k8LKi0FAdtGINOdfxzjeLbODaJtoDJ6scL7kcELfm
 hqkCpGQ7QtMAXOzu0vFxRzbHxzCJVS288ITTt4i0cunhlT8AH+vg5InZWYz/L0oCNx4J0q4BY
 TjfmJZksPeH2aw+SEBgCG87dT2PZnGssg1qRQkQlb3jjMmvPNFl3EWv8+2VmlPEPMO0mxm2nJ
 WxxtbYYKRqBfJx4tSTHtd+BA9JKILdX2SUaCrhAC5FNvYvc3Cko+/emTxqahaSv9qYnCS54uZ
 qxqHL1uyqOPRvYTrkCGy3D683zdnZv9gS7DTubIYc4noKG1X/Do1xf+Wz0+kLjJcg6NY3ixX/
 7uSXjonBQAiDI921qGD5RYJ/qPqgQtRQgiCgm56GhwkJ7Amfp/nJzKCunpU6wu+7mDQ177cVT
 sgey77lG4fx1J0RZtMiEoiqmVu/IvQV80N8zwoy5n04uPsqwXTqyxENaYmcSk2rA70r3E//26
 PMMaYHu48dKfQx0apPgoe/nfXvSRP0w6fzHpnpAl+PYtEpnyt8T59dod359dB/ejGccLbQH0D
 IJPm0plwtQDcTr46PLNdEX2G1/OrK3ZQ62zyns7lRkD2aWIrd0r4UglAzilR3AIu9tY32muuX
 7Qclx+rDloMYI4=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Team,

some of you might have noticed that the `dockerized(pedantic, fedora)` job
started to fail, see e.g.
https://github.com/git/git/runs/4098188917?check_suite_focus=true#step:5:232

This also happened during the Git for Windows rebase onto -rc1 that
Victoria Dye prepared, and together we investigated the problem. Victoria
will send a fix later. (I'm saying this just in case anybody wondered
whether they should investigate this breakage.)

Thanks,
Dscho

