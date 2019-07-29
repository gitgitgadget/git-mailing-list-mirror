Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4A43D1F462
	for <e@80x24.org>; Mon, 29 Jul 2019 14:35:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727648AbfG2Ofl (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Jul 2019 10:35:41 -0400
Received: from mail-qk1-f172.google.com ([209.85.222.172]:42587 "EHLO
        mail-qk1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727000AbfG2Ofl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Jul 2019 10:35:41 -0400
Received: by mail-qk1-f172.google.com with SMTP id 201so44262792qkm.9
        for <git@vger.kernel.org>; Mon, 29 Jul 2019 07:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=4/SeGZOccLyitt4Yjz28o00QmVws7O3PtcIM3z6yZ34=;
        b=JAmKyb8gSOa6Qub9lMy9p6nAYLlH69d026K7tetGUgERpIwHSIP5fzeuYaDRS1tK/k
         sJJqWuHFAWIQ9HoOTmy9qn2JhZTx4Bf5pfHSHqqpXTZy96gtJKTRhRbmk0njLDjseMEA
         ojMeVPY5jhqwNe9+TWhJYknV+sL7x2tGvEITI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=4/SeGZOccLyitt4Yjz28o00QmVws7O3PtcIM3z6yZ34=;
        b=bQNioBd/bmSCLMJ/CANfQSI4Go/jEc2zjKn2coKhVBYZFl36+hbkakM09LsTfjcJHp
         u1y2KN6pytzH1K9lnG6HJYEQHok9e9iKVm4nwBNyx/olYNsm8WZTCQehw2TdmXPHTlKX
         JiYOtfedDReRJceA/cUtiXJGlOIAnQsakqqi2QIuk+tIXShcK+hRBqQaq/TxTHdIff0q
         Q3N9UNtD962HNwjUkKkXS0jP65caiWiJk5Z3MZVuHH3HqXsK131557n7zsyeQ/4un3zL
         kD+/phhqd8htgxwD6YP5uUUeJwbrxsgPZxNm6kT1T0lFMs6mBKGZftd+fF09m9KwssLw
         J0FA==
X-Gm-Message-State: APjAAAWtZdhbekS350gIosA/OL9Y8q8yA5i1blMrxIN85S0hwX2szWD2
        5atzPezMLm9JiwF8orZfx5BT/hk1aXTmjrP4Mr+qSg==
X-Google-Smtp-Source: APXvYqzjgaWES8yLyz8eRzBKumMjHZgyMhtG4yBSVYBpM5Apt7QDaRDG8NdQcTB11pAHOzFXexnkKt5pUcaWJTlB4Us=
X-Received: by 2002:a37:a013:: with SMTP id j19mr76025552qke.401.1564410940096;
 Mon, 29 Jul 2019 07:35:40 -0700 (PDT)
MIME-Version: 1.0
References: <CA+fZqCXBjA5jsYg7L7X1VhJZXrp9NP+dR1SQWK9fAf9b1jgpCg@mail.gmail.com>
In-Reply-To: <CA+fZqCXBjA5jsYg7L7X1VhJZXrp9NP+dR1SQWK9fAf9b1jgpCg@mail.gmail.com>
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Date:   Mon, 29 Jul 2019 10:35:28 -0400
Message-ID: <CAMwyc-TuzSd8UdmL95DhCAZ=bRFxjF6jq_10R33jn458Wv_=9g@mail.gmail.com>
Subject: Re: Settings for minimizing repacking (and keeping 'rsync' happy)
To:     ardi <ardillasdelmonte@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, 27 Jul 2019 at 19:41, ardi <ardillasdelmonte@gmail.com> wrote:
>
> Hi!
>
> Some of my Git repositories have mirrors, maintained with 'rsync'. I
> want to have some level of repacking, so that the repositories are
> efficient, but I also want it to minimize it, so that 'rsync' never
> has to perform a big transfer for the repositories.

We use grokmirror to replicate several thousand repositories worldwide
using git-native protocols. It is fast and very efficient.
https://github.com/mricon/grokmirror

Regards,
--=20
Konstantin Ryabitsev
Director, Projects IT
The Linux Foundation
Montr=C3=A9al, Qu=C3=A9bec
