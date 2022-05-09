Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5B5BC433EF
	for <git@archiver.kernel.org>; Mon,  9 May 2022 16:21:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239008AbiEIQZU (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 May 2022 12:25:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239009AbiEIQZS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 May 2022 12:25:18 -0400
Received: from mail-vk1-xa36.google.com (mail-vk1-xa36.google.com [IPv6:2607:f8b0:4864:20::a36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50DB2AFAFD
        for <git@vger.kernel.org>; Mon,  9 May 2022 09:21:23 -0700 (PDT)
Received: by mail-vk1-xa36.google.com with SMTP id h144so7200834vkh.3
        for <git@vger.kernel.org>; Mon, 09 May 2022 09:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qMq4CbKj/DKVeIohvATMJ+zgm9LHJvm0A2ukxP9lFYk=;
        b=Gc/3K8rY11CGWL811DaA28eitiIBdd4zMITzuIjwOwBiHjPfnG3onbtzvhuHoVVu6W
         YsV4asXg0Bgdxs3whUnriAfKpN0daaPXpWuv8GfBTDWPAmezYa93zHt0q0Uo6TOkFQAv
         59xUxy2S7dfl84c2lxR8ayJXyYrT3avj4GdO0PQHGZARaqyPk2jjX0LaUzW34wlY9U+e
         HRuCheImysW7QjyeJ0FSeFA3rrkcl9iB5J4LXMeg3aaEmBiuMpjXI/YByJL2crKazzRo
         rwGmLzPbEhrJpQnq/iXo56ILNlaeP7x1AandjeMfDRAyF8t1OHXkip9iM2s7Kk6/dDQD
         Vbrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qMq4CbKj/DKVeIohvATMJ+zgm9LHJvm0A2ukxP9lFYk=;
        b=AJ+Onole1OwMJjlWslbPEHG5f7jyffaUiNb63Sha8/RMHW/F6PtFPYRf2DJsLUx04d
         4MdfCqn3JmGQqtZHjVTv1NM10j3JI4i0YMwVvdd9d+lZQuxTyUdzIvklrDKb7IszFMJS
         xfvUjr6IU3uo95meqflohMQnsyNuX2UWkE+7lAA8slUfWptuFtHFY1qy6W/v7sKEASe2
         c90bBxUJmfYVTMRxKKRCN8icd8kKlrq2aqPIvKOjQm4x2UpgSHIkGmcqQ0zIN0XM1QBF
         GzjFcTG5GXXpDlFK7sumtKrpSB2+YVAx5U8Y3TTIJuDlCM5E2J/ugmCZpxJeTZyIjHRB
         yVdQ==
X-Gm-Message-State: AOAM532myvEB3U6kr670pQ/oSBH2X1I1fadV/J6VE2f/7pqF1fbbkID3
        kCiodCjhhtaIQwJDyhAgS1XvrlZaNpLBA3t2qN0=
X-Google-Smtp-Source: ABdhPJxHTQHT09OQn/zoZcZYWvaPpLRjKbzyYn/Tgy/ka2/dK1SIJfUgpcbtVISJfMoJ91ofV4f5Ou8XmrCzWBZwlEc=
X-Received: by 2002:ac5:c197:0:b0:34e:2f08:46f with SMTP id
 z23-20020ac5c197000000b0034e2f08046fmr9042082vkb.14.1652113282367; Mon, 09
 May 2022 09:21:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220428105852.94449-1-carenas@gmail.com> <20220503065442.95699-1-carenas@gmail.com>
 <20220503065442.95699-2-carenas@gmail.com> <nycvar.QRO.7.76.6.2205051439290.355@tvgsbejvaqbjf.bet>
 <xmqqlevfesnu.fsf@gitster.g> <4314bf6d-d76c-bc5b-a7f9-e59c7c181c7c@gmail.com> <xmqq35hig0fr.fsf@gitster.g>
In-Reply-To: <xmqq35hig0fr.fsf@gitster.g>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Mon, 9 May 2022 09:21:08 -0700
Message-ID: <CAPUEspj-74PQwWNXnd0PgQ1NYyvvaqdoZ6ki7=2Q0NOcrZGFwg@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] t: document regression git safe.directory when
 using sudo
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org, bagasdotme@gmail.com,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 9, 2022 at 9:01 AM Junio C Hamano <gitster@pobox.com> wrote:

> But I was totally wrong ;-)  No matter what a unprivileged attacker
> does with these knobs, the actual access will be done by a process
> run by the attacker, and the actual security at the filesystem level
> still kicks in to prevent the attacker from doing anything that the
> attacker cannot normally do.

While I agree with you in principle, wouldn't this approach (while far
more flexible) also be more risky?

Let's imagine a scenario where we enhance SUDO_UID (because it
actually makes sense to do so now since it's probably better to run
hooks as a non privileged user by default instead of root). At that
point all an attacker needs to do to escalate to root is to set its
own SUDO_UID=0 and whatever else we put in the production binary for
him to use.  At least by restricting this overriding functionality to
a real root user (as done in the proposal) we could make that attack
vector less likely.

After all, I am sure that when (I know it is not fair, because it is
not the only way to do so) core.fsmonitor was invented as a useful way
to run things in a repository, nobody expected it could be weaponized
later into a privilege escalation, and feels like doing the same here
might show we have not learned that lesson.

Eitherway RFC v4 is out and waiting for feedback, and I even have an
enhanced (with even more comments and hopefully even better commit
messages) in which every single message has gone through a free
grammar checker[1] which I am planning to publish as v4 proper
sometime this week.

Carlo

[1] https://www.gingersoftware.com/grammarcheck
