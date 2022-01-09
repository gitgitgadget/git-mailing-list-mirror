Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9D33C433EF
	for <git@archiver.kernel.org>; Sun,  9 Jan 2022 20:48:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232147AbiAIUsl (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 9 Jan 2022 15:48:41 -0500
Received: from wout5-smtp.messagingengine.com ([64.147.123.21]:43255 "EHLO
        wout5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232041AbiAIUsl (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 9 Jan 2022 15:48:41 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 8C5FC3200A3E;
        Sun,  9 Jan 2022 15:48:40 -0500 (EST)
Received: from imap46 ([10.202.2.96])
  by compute3.internal (MEProxy); Sun, 09 Jan 2022 15:48:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=artagnon.com; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type:content-transfer-encoding; s=fm1; bh=5dOvE
        O1mlo5gtLF1ubEFE7KLpOaO2av1DEpB/MTFxL8=; b=p3DmG898xG46mj9LHh4o2
        bxDRng8P5CGeSXL+tFyQemeOkxCyPc4PC+IwceECx/z93gqB/KQkIMYs83uwOA0N
        l/LK9mNuaPpIdVbVUvg46N/BqKBFCRGuSlKaV5ECzG6N55FyLeKJKJRieivRMpc1
        Vil5pCixfeF4/UUQ4UUnBvifQHmIXMep4umOnclVPUyvJKk8k+uivSdFOAwWzuMF
        6rPaT0QQsG1njyZmeW4SGLoHgT9qmi6UQUl8OBAAdHH8/0JkjKMElGbgPu1t80x2
        9rwzFHvjgmps3dvo0tEHSBPSravQItVD8inkJ3IvI9NrcdZMlckTDlwupMJS1p4E
        w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=5dOvEO1mlo5gtLF1ubEFE7KLpOaO2av1DEpB/MTFx
        L8=; b=BCEsYL3AYDpWDynTMde3xmfZ0O4slix8BnNZpw61B234SteSFSwM8HxJ4
        UN4F7rkfYXB0FZNaLbkjAnASSE3zLdUsKT5AWNOhoE5rRmmZuwxaR18xRX7gX9v2
        xzKoAhHMEoPFUGvGKIdDXGut/06rJCff2Fr8jYteyOed1pHZDsFfP2xeeHThpHEM
        I7CXQbmG/5Fil0MQtoSc4TnTIWP6lEThM3T7meMYp9jUJJT+NojJ1h+nsdzB0RF8
        kf6qqfhVzF5IyD3CAcke43nIL6ya1VB8tOVUvMgIkJFUL5ZxVVKmtwWrzc6hHnO1
        qrfpaweUUN5cZ9qI4FA4x30QA3Qyg==
X-ME-Sender: <xms:J0rbYV1Y26bbiwjj_rmgT0-V8ZhKTKeXy52uRJ4hy7rhwzDDpQ9hbQ>
    <xme:J0rbYcFJeoCUwW5O-UkUmfFaGHBiN_ZtV4q5f_JFEwrAhvB721chOZ05gKKD1bxbV
    1x5hzAxW5HI3_W8wec>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrudegkedgudegfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepofgfggfkjghffffhvffutgfgse
    htqhertderreejnecuhfhrohhmpedftfgrmhhkuhhmrghrucftrghmrggthhgrnhgurhgr
    fdcuoehrsegrrhhtrghgnhhonhdrtghomheqnecuggftrfgrthhtvghrnhepkeevueekie
    duleekgfelteduheffkeegveffheeljeegkeevteeiteekvedvvdehnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprhesrghrthgrghhnohhnrd
    gtohhm
X-ME-Proxy: <xmx:J0rbYV4loeVtA5IvESFsgJ6p7_zS1rBS5ayNnbUtknfHzrYUnuwphQ>
    <xmx:J0rbYS3JusglBA4YYMjZEY7aBoZIsEFJohXsnc-3SbyuGIHCj4gVJA>
    <xmx:J0rbYYHaBQAzwA3LxHgydt_eb6GPkYlpodtRWTTO2VPbancBGDtJDg>
    <xmx:KErbYbyTO3sLAPePHaKDLUYynGjmHrutjzMmlQKV-ATUb-9GQ-U7WQ>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id D491B1EE007B; Sun,  9 Jan 2022 15:48:39 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-4526-gbc24f4957e-fm-20220105.001-gbc24f495
Mime-Version: 1.0
Message-Id: <fead25d6-6f5f-487a-ad4c-0657fe9785fd@www.fastmail.com>
In-Reply-To: <xmqqilus3ctf.fsf@gitster.g>
References: <1edfc6ff-4db8-447f-9eb7-85843258a286@www.fastmail.com>
 <xmqqilus3ctf.fsf@gitster.g>
Date:   Sun, 09 Jan 2022 21:48:19 +0100
From:   "Ramkumar Ramachandra" <r@artagnon.com>
To:     "Junio C Hamano" <gitster@pobox.com>
Cc:     "Git List" <git@vger.kernel.org>
Subject: Re: git bisect bad @
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Junio C Hamano wrote:
> So, perhaps there is something you are not quite telling us,
> e.g. your problem happens during a replay an old bisect session
> after HEAD has moved---if we had a bug that records symbolic object
> names in the replay log, it may produce a nonsense result in such a
> case (but I doubt that is the case---I am reasonably sure that the
> log also records concrete object names)?
>=20
> Perhaps you can try again with a better minimum reproducible
> example?

Indeed, I was a bit naive to assume that bisect didn't rev-parse. I'm ha=
ppy to report that I've found the minimum reproducible example.

  # on coq.git, for those curious
  $ git bisect start
  $ git bisect bad @
  $ git bisect good V8.14.1
  $ git bisect run bisect.sh # oops!
  Lancement de  'bisect.sh'
  'bisect.sh': bisect.sh: command not found
  La base de fusion ea3595845f5013359b2ba4402f948e454350a74c est mauvais=
e.
  Cela signifie que le bogue =C3=A9t=C3=A9 corrig=C3=A9 entre
  ea3595845f5013359b2ba4402f948e454350a74c et [2e100906d5d0c276335665ffe=
fedb906d21165ca].
  error: la bissection a =C3=A9chou=C3=A9 : 'git bisect--helper --bisect=
-state (null)' a retourn=C3=A9 le code erreur -3
  $ git bisect run ./bisect.sh # let's try again!
  # churn ... build ... test
  Cela signifie que le bogue =C3=A9t=C3=A9 corrig=C3=A9 entre ea3595845f=
5013359b2ba4402f948e454350a74c et=20
  [2e100906d5d0c276335665ffefedb906d21165ca ea3595845f5013359b2ba4402f94=
8e454350a74c].
  error: la bissection a =C3=A9chou=C3=A9 : 'git bisect--helper --bisect=
-state (null)' a retourn=C3=A9 le code erreur -3

In all three of my runs, there was never a straightforward non-erroring =
sequence of git-bisect invocations (although my terminal history is lost=
). Perhaps git-bisect can be hardened a bit, instead of needlessly punis=
hing the user with a long build + test that doesn't lead anywhere?

Warm regards,
Ram
