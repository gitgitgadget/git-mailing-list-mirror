Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0226CC77B7C
	for <git@archiver.kernel.org>; Wed, 10 May 2023 19:21:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbjEJTVq (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 May 2023 15:21:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjEJTVp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 May 2023 15:21:45 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 102CB5255
        for <git@vger.kernel.org>; Wed, 10 May 2023 12:21:44 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 4452C5C0269;
        Wed, 10 May 2023 15:21:43 -0400 (EDT)
Received: from imap49 ([10.202.2.99])
  by compute6.internal (MEProxy); Wed, 10 May 2023 15:21:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
         h=cc:cc:content-transfer-encoding:content-type:content-type
        :date:date:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to;
         s=fm2; t=1683746503; x=1683832903; bh=++X8qurLPyVUdNoR6SAyvJEZ1
        UzpuHm2f7nLnKkUKCo=; b=wIokVmMh8SM17raPEfqHdFn0UhCwWMPf/llkYvVSr
        a7cIHy7DXVsS6wgSTNUKngeeRq+0FA4KCSII2GRekBdYg0ARlafB0gyML1u8SNm0
        h9h85eQTcxLiyz9G0smHICxlVjGIX/06FKwTMfNeZU4xdFrsZgeE2yqrdCDSkO66
        VtmEBv7hjoYK0bjGY0tTTeW30xK2FJ+Qb78/eft1yN0k8PHiylzuexHRrb8h5vDI
        IfYsQc5UYEZd0/ojlTN6ObNYvX9E4x+XOmMZQt/nxBZojhvOxmJAtekFPx5GeA5S
        LfW1EuKuzDDBuIdSa5R3FKlmfg3x8UoDGcVEUR7t+fg9Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1683746503; x=1683832903; bh=++X8qurLPyVUdNoR6SAyvJEZ1UzpuHm2f7n
        LnKkUKCo=; b=WuyuIDxMsLaCzJqelI2nabsk1qDNckcM1xzRFTAn50IP1moi9Nr
        +KAvub0q3FLRxfNVQmlFG8euUMV7YHydgrOQR54GHoYpG/fZmzO/b4qqv7wpqgmM
        uB8IsVo9o9DlLlmHgL9tPPHN76TCc1qkL6r0cizGhzAikW8iWNZV2oVOWOYcjTAZ
        EfCvovOFLksmQKDG2L4kFxCU9T7+TkDmwi6laFxkXdg/NT8zIVW/uQYwMuQEPoba
        YA4hP9O8T6lcfbzmtyD4plN1Xrhe7NL+NoUcXqZiwYBYV4xibdHAHaQvVB3oY4/F
        KFvcWS5QnuBvWkNtuQzHiMgJnY8oRa5DYOg==
X-ME-Sender: <xms:xu5bZLxP9Zhw2DpQdeEdNinyy4JnxSGILfw5Egn_i2Tq5CYXbjJerT4>
    <xme:xu5bZDT3W1cFWLPugxpYEkm77T_tsk-e005UvGLFbxgQ9HdMVJ-3h0NPvLmtzFXru
    tB6Xh6iEbV3KwIYog>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeegiedgudduhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepofgfggfkjghffffhvfevufgtgf
    esthhqredtreerjeenucfhrhhomhepfdfmrhhishhtohhffhgvrhcujfgruhhgshgsrghk
    khdfuceotghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgvqeenucggtffrrghtthgvrh
    hnpedtkeduvedthfelueevheffhedvveeiueeiheehudehveegueetteduuddtfeelueen
    ucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomheptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgv
X-ME-Proxy: <xmx:xu5bZFVRkcU2wIQ7oD9Rvv7-xWufnX278BxIahSVFYVFiFgLtLG4yQ>
    <xmx:xu5bZFhrMaPF-aG8NMntt8xUvtJoSi1HjEsg1lw8LACBmnGbgQdtWA>
    <xmx:xu5bZNCI32NSmj29e-4hHicqOPmEUaQ3vCpP-u6_mlR5pvixYXUscw>
    <xmx:x-5bZMMcOdvgXjQ0q8UHhSojUoQds_1Ikovog35Ni6wOy26-SjIdqA>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 3DFF715A008E; Wed, 10 May 2023 15:21:42 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-415-gf2b17fe6c3-fm-20230503.001-gf2b17fe6
Mime-Version: 1.0
Message-Id: <2908b005-9478-4c59-ae8e-150be44a15a9@app.fastmail.com>
In-Reply-To: <ed930ef4f795f30792bc14d9c1939484e4976db8.1682671758.git.dyroneteng@gmail.com>
References: <cover.1682671758.git.dyroneteng@gmail.com>
 <ed930ef4f795f30792bc14d9c1939484e4976db8.1682671758.git.dyroneteng@gmail.com>
Date:   Wed, 10 May 2023 21:19:46 +0200
From:   "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To:     "Teng Long" <dyroneteng@gmail.com>
Cc:     avarab@gmail.com, git@vger.kernel.org,
        "Junio C Hamano" <gitster@pobox.com>, sunshine@sunshineco.com,
        tenglong.tl@alibaba-inc.com
Subject: Re: [PATCH v9 4/6] notes.c: introduce '--separator=<paragraph-break>' option
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I realize that this series is going to be merged to `master`.[1] I was
trying out this new change since I might have some use for it when the
next version is released.

On Fri, Apr 28, 2023, at 11:23, Teng Long wrote:
> From: Teng Long <dyroneteng@gmail.com>
>
> When adding new notes or appending to an existing notes, we will
> insert a blank line between the paragraphs, like:

The test case[2] `append: specify an empty separator` demonstrates that
`--separator=3D""` is the same as the default behavior, namely to add a
blank line. It has (according to the commit messages) been like this
since v5 of this patch.[3]

v4 of this patch special-cased `--separator=3D""` to mean =E2=80=9Cno
separator=E2=80=9D. And this was the same behavior as the original
`--no-blankline`,[4] which eventually mutated into `--separator`.

Why was this changed to act the same as the default behavior (add a
blank line)? I can=E2=80=99t seem to find a note for it on the cover let=
ter of
v5 or in the relevant replies.

It seemed that v4 of this patch (with special-cased empty argument) was
perhaps based on Eric Sunshine=E2=80=99s suggestion:[5]

> Taking a step back, perhaps think of this in terms of "separator". The
> default behavior is to insert "\n" as a separator between notes. If
> you add a --separator option, then users could supply their own
> separator, such as "----\n" or, in your case, "" to suppress the blank
> line.

(And then reiterated in a v4 email [6])

Was the idea perhaps to eventually (separately) add a separate option
which functions like `--each-message-is-line-not-paragraph`, like what
was mentioned in [7]?

Maybe I=E2=80=99ve missed something. (I probably have.)

[1] https://lore.kernel.org/git/xmqqpm785erg.fsf@gitster.g/T/#md9b208014=
57c3eb24dc0e793f5dfbeae2f2707fd
[2] On `next`, 74a8c73209 (Sync with 'master', 2023-05-09)
[3] https://lore.kernel.org/git/a74c96d6dd23f2f1df6d3492093f3fd27451e24c=
.1676551077.git.dyroneteng@gmail.com/

   Commit message on v4:

   >  * --separator=3D'': we specify an empty separator which means will
   >  append the message directly without inserting any separator at
   >  first.

   Commit message on v5:

   > * --separator=3D'': we specify an empty separator which has the same
   > behavour with --separator=3D'\n' and or not specified the option.

[4] https://lore.kernel.org/git/20221013055654.39628-1-tenglong.tl@aliba=
ba-inc.com/
[5] https://lore.kernel.org/git/CAPig+cRcezSp4Rqt1Y9bD-FT6+7b0g9qHfbGRx6=
5AOnw2FQXKg@mail.gmail.com/
[6] https://lore.kernel.org/git/CAPig+cSF7Fp3oM4TRU1QbiSzTeKNd1qGtqU7goP=
c1r-p4g8mkg@mail.gmail.com/
[7] https://lore.kernel.org/git/xmqqh6yh3nk4.fsf@gitster.g/

--=20
Kristoffer Haugsbakk
