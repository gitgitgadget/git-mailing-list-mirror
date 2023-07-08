Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D021EB64DA
	for <git@archiver.kernel.org>; Sat,  8 Jul 2023 10:56:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbjGHK4Y (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 8 Jul 2023 06:56:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjGHK4W (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Jul 2023 06:56:22 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB18B12C
        for <git@vger.kernel.org>; Sat,  8 Jul 2023 03:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=s31663417; t=1688813778; x=1689418578; i=georgmueller@gmx.net;
 bh=hIwDE2olxhhy9bDpYNuP1Rj32Bg0loiJKaXpNlAUDIQ=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
 b=JLgKDn5QAjQSn/pHHh2IFgGqhGIvBjJD4UdYnBEVSyD+SrDlD/E5fCGcu7hR/fVuztgkKBS
 dos8PUNeuCB3dU/2WppMImDQ8y3XPDYvGFjGABskWGxPNQg17jZLKD/NgQJ6YG3lc4BkS63uK
 l5OVav5RSl0rIyUj0QCjs2/MSBmqk48l564lFD0H3m4ExMoDQoBdsr8NwFkBA5OmgHVNyDsDP
 5hqmm2+O00UsRbnqDSXc6eSVPhKMUXECqEPNOFvIPkkx6wmF8sEYjB6SH68469nlF+DkZ0/nW
 rCEsGi2jYW8SQb8q2N6He31/PXALRt+M5luKgHH5GSE9ACikT4gw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from nb-georg.home ([109.104.37.175]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N49lD-1prWHj2p0b-0104Z1; Sat, 08
 Jul 2023 12:56:18 +0200
From:   =?UTF-8?q?Georg=20M=C3=BCller?= <georgmueller@gmx.net>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Georg=20M=C3=BCller?= <georgmueller@gmx.net>
Subject: [PATCH 0/2] fix resize issues on large screens
Date:   Sat,  8 Jul 2023 12:55:42 +0200
Message-ID: <20230708105546.2945446-2-georgmueller@gmx.net>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:NVCn00D2+6+x5a/XReux0UFlS4rRnNfKTNnZzEVeosXabr2150O
 D8mVh524V98Di3EBML6/7vUHRptyWX1WwZWucFjphELZteDGVDixH/CN0c3kYvlRDcESv5Q
 FJkUynU7e44OdiUEl3R79kxZ1g6vE7Q4z52Sp2Zku6LszNNtVEbhUsIqJxOFI/2lAadGjom
 RXm+0iYMrXmc0WUOnWeVA==
UI-OutboundReport: notjunk:1;M01:P0:5Y1Qo8pthfk=;Sfiwlsznh+7xyS3fXD7KfwrZqJ4
 bvimsCVbg7wQcDpXZy1pE1LRMPDkCdIS5mDCROIkYNmC/wStne7n5egIF2xI6/xk4N6/lx66Q
 mvuxb/KRywFDz3ntx8ime09Ge2yO0qiFOneufuYOU08ihMQihp28JwEqDSawzPL0MAfK6Jhz4
 ujlqr/DhvV4W4QHGDJQ1PH7NQvuFVbfnCmf6TUf01clxHSlshIBiQqfDMcp1stnAPkuMlEz5B
 qrzpU8zqJ8QqQ7D/Fp/zhu3g7KjV0UlslKoEK+i+jax97GxcrHN2XyuFe04o760bQ/sDnQzWe
 V4n8ft0a9+clUZrSK75UjKX7/KQr+2qG6EJg/nm9IE4UGVvgX+n7ytatQMQu3s5AjDqhxY2A1
 tPLKrs7/v6oiRSJXmc6VDv1CAO30oWUMVzi1suebha4uc0vzMxSOHmnOpsiywCZWhaMRcVl9s
 F5rta+oQsKDMfdXQHTw8RdGfLK/KunnKkXzrrfsLV5A1/ki9LuXxq/hMStwR5DfFGFIlWhIr1
 W2Pm0YBIuc2/r2lAH53I7g4ldA2pt6T3TF4vRdZoYEqlEJdyquzOZ3XPvHZEV4dBX01PPF78M
 /brFWWH7p9MjT9yPV9ZQ+4qYDKIKMNtFUhYI0rAKtfnpttcJXQN0pr9riU9Qg9f0FjQn9E/Jn
 OPd0UW0nh2wltFo+q9UKtvrW1dyRKFm4dPjiSnw+zcGgmXYyD+SUTTZIZgYP0I/lhJPnoLz1z
 Pig5d0uHzT4RePmuRKC5pv8kHIJY10NzdbpSmzF0MvmvewBUR0/LWBEMtSt5xB6fuUCAjommi
 qJAp4C2Jsem1Oa70CElw7ZT5S4i+yqM7t93jdSSYoEq5pO7LjQM7ZNJNgsk2Ytqnc6S5KY+se
 4RjYX/C17Th1CnTxeTc87WwsxcSAfrUVho3fwVx/sFvhIZJABP/2+V55lNs/0dE9Q8jCRbduf
 o0vatg==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When opening gitk in a multi-monitor setup with different resolutions,
the resize factor causes the first columns of the layout get bigger and
bigger while the other columns (author, date in upper pane, file list in
lower pane) shrink to a minimum size.

The following setup triggers the problem on Fedora 38/Gnome 44:
* primary screen 1 has a FHD resolution (1920x1080)
* secondary screen 2 has a QHD resolution (2560x1440)

Every time gitk opens at screen 2, the resize is triggered and the columns
are shifted 1.33x to the right (2560/1920 =3D 1.33).
After multiple rounds of closing/opening gitk, the columns are at their
minimum size and the contents are not visible or only a minimum is
visible.

The following patches are two approaches to fix the problem. Maybe the
hard-coded values could be variables, this is a first shot to solve the
problem.

Georg M=C3=BCller (2):
  gitk: limit factor scaling on resize to widths below 1900px
  gitk: keep author and date colums to a minimal width on resize

 gitk-git/gitk | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

=2D-
2.41.0

