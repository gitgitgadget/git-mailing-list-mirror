Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE0FCC636D3
	for <git@archiver.kernel.org>; Wed,  1 Feb 2023 11:34:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230520AbjBALeV (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Feb 2023 06:34:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbjBALeT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Feb 2023 06:34:19 -0500
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46991113F1
        for <git@vger.kernel.org>; Wed,  1 Feb 2023 03:34:18 -0800 (PST)
Received: by mail-qk1-x734.google.com with SMTP id 135so4623093qkh.13
        for <git@vger.kernel.org>; Wed, 01 Feb 2023 03:34:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QaozrRzkBVvru9SIgZf7fOHlqXwfaev0j7sOHt7FQU8=;
        b=Se9i3F4LrIdQZMHBJBYfD7ZEjrkeOYrMaREsZwhHbDl2u9SgkQCzrGXVzyWSFLfbKq
         PR+jKl1SZe0ds0ejns/u6LBiTYRs1u6cOEmsv3+ItDFo297jt2b/MwvBQDzcvIOgY5vk
         xUKv5jSW+zX3Dpak/X8+Fzb2xKe6W1kjDbPyxXFOa4C3RinimfUkKnJwa11tyJWjLPuE
         kJNuNh+JE2ax6qF3JBEmLxl0lCcpNBfMt9f/Jr70XJ3lCHLr3/wy/NwJ78AP1VIi376N
         4yDEEoNoNz1zMJEOhhaYOI5SuWGtVAi12XbMdjG/ga4PcMzrt2A19I4YoFxt8iOXaDSo
         VAVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QaozrRzkBVvru9SIgZf7fOHlqXwfaev0j7sOHt7FQU8=;
        b=pfeza03eO2jZDl71HJKKQMFatiIsvLjNoi1/Hw1cu/p7JoRk+wcHephL5CRGnC+JKD
         eL6BdW23cWDgcgrSFOpEXHb7/DKLvcwS8YIP6cFtau+MF09Pa0CaJhoirgoISHOaDAI2
         vdQOH0wcGYIcNElK3fTlbJHk4m67AjJABflzYRaTIec2HEfTMn0Z+0phetaoSg/PDlPZ
         6nJjJ5/ftX5LHQmTEVmywR29j+gAcDOJg5fFWaGUN4IzRi/dOy+8HeUOimS25GTB85PV
         GdgWJxG0yjJCoas50UlMXiGbWdgxLTZEU/m4nJzpG6dzXcKrViKkdSQieKE7uH7jY6Yv
         Btpw==
X-Gm-Message-State: AO0yUKWy0LEesmQP9n55BZn/nDzFtkJ1+ZCHrFJ+P9iBUgumJ+vl5mP4
        Cq0cYe4guqJgfK5dcioQsON70h0Q2UV842dbptk=
X-Google-Smtp-Source: AK7set9oV8SFFljyOll4mof7ChQQDAuar63+19Sa1HKWEpyPH2CwgVAREl+/pkN6OvBCq0wfsFwTUflmNM9T8aImRDs=
X-Received: by 2002:a37:b4c6:0:b0:71a:2a15:5869 with SMTP id
 d189-20020a37b4c6000000b0071a2a155869mr203399qkf.260.1675251257263; Wed, 01
 Feb 2023 03:34:17 -0800 (PST)
MIME-Version: 1.0
References: <a812a664-67ea-c0ba-599f-cb79e2d96694@gmail.com>
 <Y9jlWYLzZ/yy4NqD@tapette.crustytoothpaste.net> <20230131150555.ewiwsbczwep6ltbi@meerkat.local>
 <Y9mXB1LaYSUJBlwF@tapette.crustytoothpaste.net> <230201.86pmatr9mj.gmgdl@evledraar.gmail.com>
In-Reply-To: <230201.86pmatr9mj.gmgdl@evledraar.gmail.com>
From:   demerphq <demerphq@gmail.com>
Date:   Wed, 1 Feb 2023 12:34:06 +0100
Message-ID: <CANgJU+V0QRFwmTh8ZzY=28kmbUw=DvSLE24LioOXp6_ozq+RdA@mail.gmail.com>
Subject: Re: Stability of git-archive, breaking (?) the Github universe, and a
 possible solution
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Eli Schwartz <eschwartz93@gmail.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 1 Feb 2023 at 11:26, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab=
@gmail.com> wrote:
> That would be going above & beyond what's needed IMO, but still a lot
> easier than the daunting task of writing a specification that exactly
> described GNU gzip's current behavior, to the point where you could
> clean-room implement it and be guaranteed byte-for-byte compatibility.

Why does it have to be gzip? It is not that hard to come up with a
relatively good compression algorithm that is stable if you aren't
expecting super fast performance or super good compression. If all you
need is good enough but stability is a hard requirement then
algorithms like LZW are available (it has been out of patent since
~2003), and produce reasonable results. If people want a stable
archive then they might have to use some tool that git provides to
decompress and they might not get the best compression ratios, nor
speed, but they would get stability. You can write a decent LZW
implementation in a few hundred lines of code. With a bit of care you
could implement it in a way that allows you to compute the true hash
digest of the compressed data without actually decompressing it as
well, which would address some of the concerns that brian raised with
regard to security I think.

Why does this email remind me of that old canard that any sufficiently
advanced piece of software gains the ability to send emails? :-)

cheers,
Yves

--=20
perl -Mre=3Ddebug -e "/just|another|perl|hacker/"
