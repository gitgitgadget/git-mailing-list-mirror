Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BE74C433F5
	for <git@archiver.kernel.org>; Sun,  9 Jan 2022 19:30:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234637AbiAITaB (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 9 Jan 2022 14:30:01 -0500
Received: from wout5-smtp.messagingengine.com ([64.147.123.21]:34839 "EHLO
        wout5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232020AbiAITaB (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 9 Jan 2022 14:30:01 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id E4A23320024A
        for <git@vger.kernel.org>; Sun,  9 Jan 2022 14:30:00 -0500 (EST)
Received: from imap46 ([10.202.2.96])
  by compute3.internal (MEProxy); Sun, 09 Jan 2022 14:30:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=artagnon.com; h=
        mime-version:message-id:date:from:to:subject:content-type
        :content-transfer-encoding; s=fm1; bh=kZoSZPg/wv/75yqcyZwr4Krs6Z
        FXHGqLqix+s9C4M3U=; b=sbtyzJMGyeDEFbDmnKpByJMQimPM2zUOwm2vTjv7lV
        T2fv44vB3O60Uql8xJ8Mqq097a3KH0lqt4UchgCUvTWowezdozAXPV4Ic1Qyj4S9
        k45O0QOvRiES8nG3vqgDBEzrPzgSR72YRBR4yEdM8AvjkpxbDk5m85XSIOXtbW5D
        yA2iE8m8MIgFsys8kae3uWakdt1nPYgmGlP8ZTPOZ1gsejJBXnoOGOmE7v+PacK6
        0bXvZ1a145BY0wmK+j+IwL4apdlzhEguEqrVnMtAO7csS9I79yWgiY1DvOWKecyu
        2Fo220R56UUjePJx3F4ILhuTJ78cU1x7lNPDflt4pTMQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-transfer-encoding:content-type
        :date:from:message-id:mime-version:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=kZoSZP
        g/wv/75yqcyZwr4Krs6ZFXHGqLqix+s9C4M3U=; b=jURtvTQbyecazPeP4JelUT
        169VSABWTidUAu80IS0emi1jaMvzxgx91zqvajtxtdLeK0E6hy2QDj/vkhG87a54
        YcQG8mbVxDPgWkPbc8D4NlA0dcgwk2+B7Uj4Q/WY3M+FsXKmHwzDIgML/rS1ghGd
        biEaOskoOo094fQ/2sjiFdSBgSLDKe+Av6Bb277Ta67O7k7IoutRGnBxNxbOy6gr
        ubkkljznL+RhtXOIveqCoCtW4E0QnkIpttYDhtl0sUYrlgkX3SG/+eJajpgb86ZO
        07HI2CRxnPztvI7tjqnbHOP/j51leVEPZ+ydkbo4+7yP2RBK9NoR3KwUoqh/X06Q
        ==
X-ME-Sender: <xms:uDfbYSERzqfws1TYWze_5Jq_mGi_yM49Sr-RIKoQfrZbbGYgtCnDTQ>
    <xme:uDfbYTUNg0bTTqQT7INbxskXgktQ9eh1nJsXVScyQm1eJymU--aLaVOCgvqJZoUm9
    _shoHRG2IMpeoQAnXw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrudegkedguddvkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepofgfggfkfffhvffutgfgsehtqh
    ertderreejnecuhfhrohhmpedftfgrmhhkuhhmrghrucftrghmrggthhgrnhgurhgrfdcu
    oehrsegrrhhtrghgnhhonhdrtghomheqnecuggftrfgrthhtvghrnhepkeekhfdtgfejje
    etudeugfehgeeghefffeethfeuvedujeeifedtuedtvefhhffhnecuvehluhhsthgvrhfu
    ihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprhesrghrthgrghhnohhnrdgtoh
    hm
X-ME-Proxy: <xmx:uDfbYcKV5t2d4Mj5LlRO5-wHkS0NjRmBYsj-HAz12q9-npVdXvNgMg>
    <xmx:uDfbYcF7dTVKqMBvY1x0QjZD8hicN6fVnDVtOvBhhDjHpnaYB_lLhw>
    <xmx:uDfbYYXbZABKqXfcJxq0UF-EWBuDe3l1tvr2lTy-mjClwJgwRdHhGg>
    <xmx:uDfbYQgfSSOcZ-BqZZ99i3j8YIc1lWYVdnlswAzkvPFtNlLBWrl-2g>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 3516E1EE007B; Sun,  9 Jan 2022 14:30:00 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-4526-gbc24f4957e-fm-20220105.001-gbc24f495
Mime-Version: 1.0
Message-Id: <1edfc6ff-4db8-447f-9eb7-85843258a286@www.fastmail.com>
Date:   Sun, 09 Jan 2022 20:29:39 +0100
From:   "Ramkumar Ramachandra" <r@artagnon.com>
To:     "Git List" <git@vger.kernel.org>
Subject: git bisect bad @
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I bumped my head thrice (yes, thrice!) by using `git bisect bad @`. The =
error displayed to me at the end of one run was the following:

  Cela signifie que le bogue =C3=A9t=C3=A9 corrig=C3=A9 entre ea3595845f=
5013359b2ba4402f948e454350a74c et=20
  [2e100906d5d0c276335665ffefedb906d21165ca ea3595845f5013359b2ba4402f94=
8e454350a74c].
  error: la bissection a =C3=A9chou=C3=A9 : 'git bisect--helper --bisect=
-state (null)' a retourn=C3=A9 le code erreur -3

After the third attempt, I realized: ah yes, computers aren't magic; git=
-bisect.sh is basically a stupid shell script (no offense!).

Perhaps git-bisect.sh can ref-parse the arguments before starting its wo=
rk? Agreed, none of the refs are expected to change during its operation=
, with the exception of the sneaky `@`.

Bonne ann=C3=A9e,
Ram
