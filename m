Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CD1BC6FD1C
	for <git@archiver.kernel.org>; Fri, 24 Mar 2023 12:54:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230495AbjCXMyc (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Mar 2023 08:54:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbjCXMya (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Mar 2023 08:54:30 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DCBEE391
        for <git@vger.kernel.org>; Fri, 24 Mar 2023 05:54:30 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 790895C00E7;
        Fri, 24 Mar 2023 08:54:29 -0400 (EDT)
Received: from imap49 ([10.202.2.99])
  by compute6.internal (MEProxy); Fri, 24 Mar 2023 08:54:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
        cc:cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1679662469; x=1679748869; bh=vF95qk8MQL/Jl4M+SXqLD2tkLuXOGxH+SN5
        IERKx+f8=; b=JaJStMnrndF0OHGQSMCgrgfMm4Gg7q7khyhHb2UWzcfTVDr/r14
        3sROaLHUFCN08+LWdCo26Ya9uQvlpwJFtowTUSh42jteYlbcL0LhHaGbzeh0beS4
        BA4ieMXmCSQRjIJQt7R34qdUqPEeeCDXXAeJjhfw5AnO6EsSOkIsyYqcaUkkXMWO
        IXs0Z47uJX4EXGOHKoMQ5LXD6YBkJv2IQWbN3ei1yFbNxWmX2o+WM9hHre8Qi9T5
        QUsPduQN2E9V4oLvMmeSjqDSVpgUSDjm671GfHu/u60j42N2cOXz1Et5Ykhvfqpn
        Er4J+SWeol6oMbnIo6iLkYnEGf6RchnLoIg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1679662469; x=1679748869; bh=vF95qk8MQL/Jl4M+SXqLD2tkLuXOGxH+SN5
        IERKx+f8=; b=oqc0pLAHn0Bjs5eIx4KZlsHyG9EF9Xgv3dg4209k/i1t8XuHJPB
        thwzzSsot1KZ70wAA9wv4z9QthlDtkK20pOaUaBRdKz5lerNPy2fa9DMqgoNFhts
        UUsRYCRbUSOhTegFdWG7KiVY1yxBDKDvsC/DtiW7Xdg/aAHh2Qkcefc7Kz3HepDq
        1eipYEwIutI8X0KFxEsgkt5aYwl3OCJWL7RjkhF+0nxdUz7gqPN3K4mfBifRlyvN
        8YUtH34Y/bYASMnN8027bcJu3XDeE4g1W0LAgdNK+iSy+S/33O0HN4EUPPIXszqg
        I4JSq073ygnkZd7x8TaERzSSpT3QTLEVVKQ==
X-ME-Sender: <xms:hZ0dZI93e21lhw0a3d7UUxpQU2LoVnWkpiqr94_idPg0ae-viozmOuM>
    <xme:hZ0dZAt-xgwiXGfQNYlszKLyqLHkNVvCM11Mdi9mjAELg6ih4Av4dQ2bw1z_SH71f
    gEbHkg3hzwPnXAlCg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdegiedggeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefofgggkfgjfhffhffvvefutgfgse
    htqhertderreejnecuhfhrohhmpedfmfhrihhsthhofhhfvghrucfjrghughhssggrkhhk
    fdcuoehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomh
    eqnecuggftrfgrthhtvghrnhepteegleehudejjeefffegudfghffgueeufedutedtudev
    geffjedtgfffueeijedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhl
    rdgtohhm
X-ME-Proxy: <xmx:hZ0dZODkRXmtO_1CiJPHkmrGptXt_uLHW0wYIGuaJ0cpeahjevGdJg>
    <xmx:hZ0dZIcfx_EhSN3YKb6qkalSvrsFnvRDY63hyP-PULBR4WuSL9fBcw>
    <xmx:hZ0dZNN60zZDUwuFmBlWsx9UvbE8QnMDRbB3hH01HWHWU1MazASMWw>
    <xmx:hZ0dZEZHOmrw8YVRSc9P8YpyCxJJ3rRz5fQCWFpzGla_x2NbvCn5IQ>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 425B015A008E; Fri, 24 Mar 2023 08:54:29 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-236-g06c0f70e43-fm-20230313.001-g06c0f70e
Mime-Version: 1.0
Message-Id: <c16793b7-c4ce-4acf-904d-b844769fe17a@app.fastmail.com>
In-Reply-To: <e2ceba47235e2f7e4f6889954111044d@aegee.org>
References: <e2ceba47235e2f7e4f6889954111044d@aegee.org>
Date:   Fri, 24 Mar 2023 13:52:26 +0100
From:   "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To:     =?UTF-8?Q?=D0=94=D0=B8=D0=BB=D1=8F=D0=BD_=D0=9F=D0=B0=D0=BB=D0=B0=D1=83?=
         =?UTF-8?Q?=D0=B7=D0=BE=D0=B2?= <dilyan.palauzov@aegee.org>
Cc:     git@vger.kernel.org
Subject: Re: rebase has no --cleanup option
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi =D0=94=D0=B8=D0=BB=D1=8F=D0=BD

On Fri, Mar 24, 2023, at 13:11, =D0=94=D0=B8=D0=BB=D1=8F=D0=BD =D0=9F=D0=
=B0=D0=BB=D0=B0=D1=83=D0=B7=D0=BE=D0=B2 wrote:
> Hello,
>
> in rare cases I want to write commit messages with leading # sign

Have you considered changing your `commentchar` to something else that
you never use as a leading character in the message proper? For example
`%`:

    [core]
            commentchar =3D %

Looks like:

    git: temporary for demonstration

    % Please enter the commit message for your changes. Lines starting
    % with '%' will be ignored, and an empty message aborts the commit.
    %
    % Date:      Fri Mar 24 13:45:28 2023 +0100
    %
    % On branch master
    % Your branch is ahead of '<remote branch>' by 57 commits.
    %   (use "git push" to publish your local commits)
    %
    % Changes to be committed:
    %	modified:   config/.config/git/config
    %
    % Untracked files:
    %	config/.config/git/gitk
    %

That=E2=80=99s at least what I would do if I used leading `#` since it s=
eems
like less trouble than having to change `cleanup`.
