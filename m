Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE436C433DB
	for <git@archiver.kernel.org>; Sun, 24 Jan 2021 16:50:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C540522D50
	for <git@archiver.kernel.org>; Sun, 24 Jan 2021 16:50:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726435AbhAXQt7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 24 Jan 2021 11:49:59 -0500
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:52749 "EHLO
        wout3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725948AbhAXQtx (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 24 Jan 2021 11:49:53 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 2C9B2EBC
        for <git@vger.kernel.org>; Sun, 24 Jan 2021 11:49:04 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Sun, 24 Jan 2021 11:49:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alchemists.io;
         h=from:content-type:content-transfer-encoding:mime-version
        :subject:message-id:date:to; s=fm3; bh=xCKLJngxA2rBK7MaXLC8ksrxH
        HZBkXIMntFsoqNrzDs=; b=eodl3kolMctt9omUHeTDXacy4GZS9duX5cujZUdVV
        iOJNU2PCAy/xW7fZvFozOgNulwLQwvdS4mqJWCMADlloYgC5RY6zvSzeZ2efCme2
        z8Qrf12YpmHrusTnGpzsXWUWjP/GrsvCC0Ra2xyhHcaYEpcjUp/lahKzUMczMA0k
        cZyeAjH6ndTbjK6SFnkEmzEK8NGLH/i98JOt2l0dpYByI+5VBezmX4eUDUuItnt7
        +zdDSExUzKk599FgrKwDehtSoFvXMsdFtXLdFjFiV3HAy6P7uF6BBVdSggGL3D/O
        Uw9ujp+7vtldcGQRG409lfNe9cx2BOE3XaMjOfQ0g0z4w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-transfer-encoding:content-type
        :date:from:message-id:mime-version:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=xCKLJn
        gxA2rBK7MaXLC8ksrxHHZBkXIMntFsoqNrzDs=; b=nY3wFKhXflGRDV+Hyw348u
        YbewkYj9Jm/YAgw3yJHfdL+v+9BhAq3y6nck9iA7nBWc5R7n6ekM+itZ31asEGlK
        eL8Md1nkEF0miOTNRRwRM1p39Vb38Ugl06jk8Qp3Rrw3QleQZ4DemTr/bDiTpfXC
        L5iMBAc7FxJJKNBd+Stee6hVBMXhYsK5B+aFJAoAHLrMyuwzgb2zANAzwXYBizga
        bXYLwdp3D+8LYIXwWZy6VcRbdRoryjvrbTLQRYhFZg6xDtMxs1Qky1WY4WhW7n4Z
        aX/X3QNMJn2jv92wCHOyySd0n5LPiabFJnQ8nCeu+to4z+F6hv+xAPvlERD/D9zw
        ==
X-ME-Sender: <xms:_6QNYMqT2S8fIfw6fowIPefxxfa-Xg-5j2vqaDKh2HrnkVmdHhPCsQ>
    <xme:_6QNYCqFmYw-LIqQj_pCqsMS0oKxg7QWG1qv1ssBg2E7kjtCcH5HuMDQK5nN_e1B6
    v-Oiy5n7c7tfA2->
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvddugdelgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephfgtgfgguffkfffvofesthhqmhdthh
    dtvdenucfhrhhomhepuehrohhokhgvucfmuhhhlhhmrghnnhcuoegsrhhoohhkvgesrghl
    tghhvghmihhsthhsrdhioheqnecuggftrfgrthhtvghrnhepleekgedtleffteffleeule
    efhfeuudfggfdugedvueduhfetleehgeeiheefleeunecuffhomhgrihhnpehgihhthhhu
    sgdrtghomhenucfkphepleeirdeggedrudekledrudelheenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsrhhoohhkvgesrghltghhvghmihhs
    thhsrdhioh
X-ME-Proxy: <xmx:_6QNYBPHGfFSzByM_203-R55fqah2Mj4MO4iwri46jT8VIilcQL92w>
    <xmx:_6QNYD5BPBWWC6-wjz6s9ftMiSRZ9rJJOjyo0EUD7OZI4jbBZIVNWg>
    <xmx:_6QNYL4_sVKA0hH49t6-GCQMLhf5Gp23QBfR8Vp0KZ-JxXp6cjXiLQ>
    <xmx:_6QNYNHtWKwzk7L9yttnSu8N-JsA8d-h8jMC76URUvyA5meysd4s7w>
Received: from [10.10.44.24] (96.44.189.195.adsl.inet-telecom.org [96.44.189.195])
        by mail.messagingengine.com (Postfix) with ESMTPA id 7FDC9240057
        for <git@vger.kernel.org>; Sun, 24 Jan 2021 11:49:03 -0500 (EST)
From:   Brooke Kuhlmann <brooke@alchemists.io>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.40.0.2.32\))
Subject: How to Verify Git GPG Signed Downloads?
Message-Id: <B6DFB74D-A722-4DBD-A4B2-562604B21CCB@alchemists.io>
Date:   Sun, 24 Jan 2021 09:49:02 -0700
To:     git@vger.kernel.org
X-Mailer: Apple Mail (2.3654.40.0.2.32)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello, I'm trying to figure out how to obtain the public key used to =
encrypt the Git file downloads. I put together a gist that explains the =
problem and question in detail here:

https://gist.github.com/bkuhlmann/684b74d25d83d52df8d0caeb6219aa15

If anyone has any advice on how to make this possible, it would be =
greatly appreciated.

Thanks,
Brooke

