Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B35A8C83F33
	for <git@archiver.kernel.org>; Mon,  4 Sep 2023 17:57:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353363AbjIDR5i (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Sep 2023 13:57:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233583AbjIDR5h (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Sep 2023 13:57:37 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD253CFD
        for <git@vger.kernel.org>; Mon,  4 Sep 2023 10:57:31 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 2CE2B5C00D7;
        Mon,  4 Sep 2023 13:57:31 -0400 (EDT)
Received: from imap49 ([10.202.2.99])
  by compute6.internal (MEProxy); Mon, 04 Sep 2023 13:57:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
         h=cc:cc:content-transfer-encoding:content-type:content-type
        :date:date:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to;
         s=fm3; t=1693850251; x=1693936651; bh=SQTbc/nndSjWc/7aMDamZlpkV
        U1hPNpclVi16X1+e7Q=; b=ny2tylGiTIVLefCeJ6x3zwdUSb4sKvnS7cUppnD/d
        P22cbUJrUtuPqdKm2XU/27m12aUs9qm6KLBMMp7l4YrdGOX8MSZatFC+lG1al1NB
        b8MYByO/gVj7guBoSmxsnacTsNFrhfhrHDqYs6wG5NZxFQiXb+O52X58P/JVOfQD
        6jNT+Ey/mQ2w1TUW7ZvSSnZK4Evnml1lCgNmKlzCxHf3oUVLYMKjhAzeTcmpDOFU
        xdBDJbDosUt499toXml4u+d2WtCgX2zhyzxLZA1cJh4zl3S3bKxl9lEaNV/KfOBR
        FW/AdeFdIFCOspX4DY/f22v3xpDRUiBQiM9/a0PziFPeQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1693850251; x=1693936651; bh=SQTbc/nndSjWc/7aMDamZlpkVU1hPNpclVi
        16X1+e7Q=; b=QVgvJTftUEkEyysTMcg4ZGBfaMWI3G2/+tNT8i+IJQPvfZtskJC
        sXJ1uEJLL7GYogSOC7Fb4pm7EAt0MznRdMHxWE7+a3zYbXdox4f7NoXtyLJQGFXn
        nTLO9+YMdrmFFbnMCu/DAM8SLB9XVqpwQ0PkisUb3XlmQCXLOJH7FddLaMaI96PH
        7RhTZz7gCtUAv6dLX7u4e0l9t9PcDCML5L+uglAzvI1PrMRuenDFDf/GWuQZhcss
        JIWl9mJm4tOMGpqKpD5LuhHtNAIrVNr8bj9lAqJbDJCfymy0eH34iI2JtBPNmQKW
        ChstC9Yct1vMRjrAg3DafC0jw2wAleWaAiw==
X-ME-Sender: <xms:ihr2ZN-gSWbWYicen5eLeNRwljpqycyP701Pb8VSeiqroKmgdeqTYBs>
    <xme:ihr2ZBv1a6tfNPYs_QxzLN6SK5haxKNN_Wuky0q__-NYZVi_pnPAbU4tItT6ibDik
    D0M5WozxAi-kpjJwQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudegkedguddvtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedf
    mfhrihhsthhofhhfvghrucfjrghughhssggrkhhkfdcuoegtohguvgeskhhhrghughhssg
    grkhhkrdhnrghmvgeqnecuggftrfgrthhtvghrnhepfeelgfejvdfgtdefgffhfeekvdev
    vdegueffieetgedtheekvefhfeefkefguedunecuffhomhgrihhnpehsthgrtghkohhvvg
    hrfhhlohifrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghi
    lhhfrhhomheptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgv
X-ME-Proxy: <xmx:ihr2ZLD2cVHLGB6jHdYSqbUzFeXvhYpgHp2D0srJ49qDFcpUoBr6NQ>
    <xmx:ihr2ZBeVS2BD42wdytLnPk1dxZEPTEenbjzRyjdFqAgoSuevCB6f0g>
    <xmx:ihr2ZCPpmIc8QxVC7kMFuR9ZnX9Z8qI2FDTdvQITt_ow-YhbdBG0cA>
    <xmx:ixr2ZLbXXJ9EoZ92W7GpqoI31APjWJP-SP3-uB4OCuWDgxwxKP7Gqw>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 5991D15A0091; Mon,  4 Sep 2023 13:57:30 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-701-g9b2f44d3ee-fm-20230823.001-g9b2f44d3
Mime-Version: 1.0
Message-Id: <b5833396-7e04-465f-96f6-69d5280fa023@app.fastmail.com>
In-Reply-To: <CAPMMpoixKnr4BkKd8jeU+79Edhqtu4R7m8=BX4ZSYKdBHDzK=w@mail.gmail.com>
References: <CAPMMpoixKnr4BkKd8jeU+79Edhqtu4R7m8=BX4ZSYKdBHDzK=w@mail.gmail.com>
Date:   Mon, 04 Sep 2023 19:56:33 +0200
From:   "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To:     "Tao Klerks" <tao@klerks.biz>
Cc:     "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
        "Taylor Blau" <me@ttaylorr.com>, "Patrick Steinhardt" <ps@pks.im>,
        git <git@vger.kernel.org>
Subject: Re: Is "bare"ness in the context of multiple worktrees weird? Bitmap error in
 git gc.
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Tao

Context for my own use: I use the default clone (named the same as the
upstream repository) as the main worktree and name worktrees according to
some topic. So if the repository is named `work-application` then I might
have worktrees named things like `deployment-work`, `next-version-work`,
and things like that. All of them sibling directories since they are all
Intellij projects (to your point about making tooling treat them the same
way). I usually use the main worktree so I am fine with one worktree bei=
ng
*special* (that it contains the `.git` directory).

I can understand that the main worktree/linked worktree dichotomy might
feel artificial if you use, say, ten different wotrkees equally often. Or
maybe one worktree per branch.

And then from that vantage point it might feel wasteful to dedicate an
unused main worktree=E2=80=94with its own working tree=E2=80=94to just s=
it somewhere for
its `.git` directory, essentially.

On Mon, Sep 4, 2023, at 16:41, Tao Klerks wrote:
> Because worktree use was so useful/widespread/critical on this project,
> and we already had a custom cloning process that introduced selective
> refspecs etc, we introduced a special clone topology: the initial clone
> is a bare repo, and that folder gets a specific clear name (ending in
> .git). Then we create worktrees attached to that bare repo.

This is interesting as a Git user. I've been encountering questions on
StackOverflow where the questioner is using a bare repository which they
make (or try to make) worktrees from. I've been telling them that making
worktrees from a bare repository is a contradiction:[1]

> Bare repositories don=E2=80=99t have worktrees per definition. Or at l=
east
> that=E2=80=99s what `man gitglossary says`. Of course what `git worktr=
ee` allows
> you to do trumps that. But it might be ill-defined.

The glossary says under =E2=80=9Cworktree=E2=80=9D (on Git 2.42):

> A repository can have zero (i.e. bare repository) or one or more
> worktrees attached to it.

And as someone who never has needed to use a bare repository + worktrees
I've just left it at that.

=F0=9F=94=97 1: https://stackoverflow.com/a/76273222/1725151

Cheers
