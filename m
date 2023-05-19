Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14B3FC77B7F
	for <git@archiver.kernel.org>; Fri, 19 May 2023 09:00:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbjESJA3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 May 2023 05:00:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbjESJA2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 May 2023 05:00:28 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23144A2
        for <git@vger.kernel.org>; Fri, 19 May 2023 02:00:27 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id DC2583200975;
        Fri, 19 May 2023 05:00:23 -0400 (EDT)
Received: from imap49 ([10.202.2.99])
  by compute6.internal (MEProxy); Fri, 19 May 2023 05:00:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
         h=cc:cc:content-transfer-encoding:content-type:content-type
        :date:date:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to;
         s=fm3; t=1684486823; x=1684573223; bh=X1fkyt303ZHLGRkN0qgpwzlv9
        22IFh1FOZqfDfKc75Q=; b=gCXwZite6fTmKE9bYGWpx23Zjasq6bfCDlrw4BQE7
        bxW7GYX+/pFaRuoZlvbHBi43DoUzM+MvS4JOBfK6xawUn3k+a/aStPdwggQGYCJ0
        ZphYJeSgxXqVrJlk9UoUarn/spQ0EUwe96FZw/fk2OvsYwFKhgGZPEWRgIW11Yo2
        6pVkX+oczD4ehhgBXS93VXjaZTYLzAqKucj5E0ea3KiPvcaplt5Fc5Q6GHujOnbz
        FtQjR+VkZ0E5LDA+KYaoPuR+qRqjcqWEGnfAZkUA//82kTu2b2jkySI8bZ++woZv
        Piraow4CTHI5bQTkhqql0RGOJkQXhBRJ/KbIsCpypIYlA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1684486823; x=1684573223; bh=X1fkyt303ZHLGRkN0qgpwzlv922IFh1FOZq
        fDfKc75Q=; b=o1+9L5sMVzn1gvbFSdhL8OK/CqFeq8WPXnlZgcq0uX7F2MbfGGd
        Yg+k0FiZhk53FTiZO340DcSuIV7Hcu687iGlAzN8C4DTaz+X2U3k3+qBQIuRi1Z1
        S3W+mvDF6oUb/OnHh7ezjgLLwy2N0rbWq13ydkvvh7eDEBSVerJBelT8DuJfLYL4
        GlNbxmIvYE8NmuNUQlfIkHT596rbtxDh7+NcuFTFoTGoRBDpxR0EvpzUX9KfJrQr
        E761A2WT4ImokDX69W00nvJjI+k1xVjcLuH6v6OxSBkHzEU2qSO+hHuO8yRD8JYJ
        X11V7tDZaxvWBBGzpEcu7Nzc9jAU+qGjLAA==
X-ME-Sender: <xms:pjpnZGTcx39Fn1uAayuxj6yKd8I5Z7y_wFkKV4epFpiCUMfozwsJDmg>
    <xme:pjpnZLzKQCToAFoJoHBVTHdveHpWGlHgUup9PRwYnoXHl3iuHYHWjNV-F63hJoaLv
    JQiZ2LFrTzUDrCE4w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeeihedguddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdfm
    rhhishhtohhffhgvrhcujfgruhhgshgsrghkkhdfuceotghouggvsehkhhgruhhgshgsrg
    hkkhdrnhgrmhgvqeenucggtffrrghtthgvrhhnpedviedtvdetleetvdetvdeiveehgfei
    ffeujedtudfhtdeigeejheehteehfeehveenucffohhmrghinhepghhithhhuhgsrdgtoh
    hmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheptgho
    uggvsehkhhgruhhgshgsrghkkhdrnhgrmhgv
X-ME-Proxy: <xmx:pjpnZD2Sa4oN5Kuq1nipGJC1_GYETnEXymZbONDQjT3fW-HcFc09Qw>
    <xmx:pjpnZCB-T5Dsvu1TJ1rUJ1uf9-ocyRXEYWm8F-bUqOrWDXOUHIA-nA>
    <xmx:pjpnZPg37R6Dv1fL07CHJiQo4dYWlb3UBCknBTTBqkvvKG4KDQ_tKw>
    <xmx:pzpnZBcZNWuMU29dPM2bimH0yVhGUJ5OFMjhxcMx-WMAE7_CEpOcIg>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id D8C2815A008E; Fri, 19 May 2023 05:00:22 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-431-g1d6a3ebb56-fm-20230511.001-g1d6a3ebb
Mime-Version: 1.0
Message-Id: <de4a7ce5-f12e-46be-a897-adb36068dd47@app.fastmail.com>
In-Reply-To: <20230519101505.416d0963.hanno@hboeck.de>
References: <20230519101505.416d0963.hanno@hboeck.de>
Date:   Fri, 19 May 2023 10:59:21 +0200
From:   "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To:     =?UTF-8?Q?Hanno_B=C3=B6ck?= <hanno@hboeck.de>
Cc:     git@vger.kernel.org
Subject: Re: git push --quiet is not quiet
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi

On Fri, May 19, 2023, at 10:15, Hanno B=C3=B6ck wrote:
> I believe this is a bug in git: According to the man page for git push,
> the -q/--quiet parameter should "Suppress all output".

Looks like the message is coming from the remote. If I make a fresh
fresh commit in a fork I get this message from GitHub:

```
remote:
remote: Create a pull request for 'test-push' on GitHub by visiting:
remote:      https://github.com/LemmingAvalanche/git/pull/new/test-push
remote:
```

The delta message has the same `remote:` prefix.

`git push --quiet` does keep quiet when I test it locally (i.e. no
interference from the forge).

--=20
Kristoffer Haugsbakk
