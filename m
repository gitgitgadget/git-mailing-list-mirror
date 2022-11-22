Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0808EC433FE
	for <git@archiver.kernel.org>; Tue, 22 Nov 2022 19:40:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233356AbiKVTkK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Nov 2022 14:40:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233912AbiKVTkI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Nov 2022 14:40:08 -0500
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9906701BD
        for <git@vger.kernel.org>; Tue, 22 Nov 2022 11:40:07 -0800 (PST)
Received: by mail-pl1-f173.google.com with SMTP id d20so14622951plr.10
        for <git@vger.kernel.org>; Tue, 22 Nov 2022 11:40:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rYWcEUFtBxxk9ePaWHlM/lxuWoa+FOVA7Me992p/NZY=;
        b=YrPT/62d1cSFRBc7BIFaHbPOcUkK81q+KYQnlO/sKKGr5XxN3bVBWk4HUuX7E+/Bk9
         Y81JAq4mkthfHCYPxV9rndFEpBf4Docd4LykTCzfqKKoHWHjQQ6OQuKyP3uljhXqTEnr
         dQoifZP/bqNh0Z4JU27ZdmmVpoBMKqEX/eqpmDnEc/uIjgNP3wz4bKWVZVF0w89LBee5
         dgdqIHZE5PdjdqKYBkDG8bi2vd9jwDu8Nym3uXEJ14Hgtwo8L2zMJqaba6QtQLZxgS2n
         VOZEJu0JNTyMVLNIL79YfVoEv35aasy+Dwxy8WPpuO+WiPkQwNRoWiVNWo5zPgnV7ngL
         2vog==
X-Gm-Message-State: ANoB5plHJbqKu0R9olmij9aAUH35bRZbFEtxBS26D0049q0fUTaCHvD/
        1lmJapvzdQiBPtNSnTU933kVcdoZPGMz5hcAY1odMKhxGZE=
X-Google-Smtp-Source: AA0mqf5zqbNmCnA1f+kXh9usQ1WcMhyI8tTxVfjNUZcQAcot8B7DUh902u8Yy8bfCeheODdgu5c+m4anruwJxhUyt5s=
X-Received: by 2002:a17:902:aa07:b0:188:eee6:e1a6 with SMTP id
 be7-20020a170902aa0700b00188eee6e1a6mr6279130plb.120.1669146007170; Tue, 22
 Nov 2022 11:40:07 -0800 (PST)
MIME-Version: 1.0
References: <CANYNYEHXU8ivgAOa8EO5e9kOcbu6XF7rj+9EcSrbDQE+Rvyw_Q@mail.gmail.com>
 <CAPig+cQrXb-YUSzmfgJ2PRoiOP3goVACRCrX9C39kf3oDH+BHg@mail.gmail.com>
 <CANYNYEF+Gsas5s7u3rb3CQeFPL1MoCTweA4e3L90vCD0rPsNgg@mail.gmail.com>
 <CAPig+cS-BWJoWgo3UEk0X6fRjsysR0_23ppn9WX02Gy+ugVdOQ@mail.gmail.com> <CANYNYEEPZjGEogaSqqCO_qnzLqnrd0d0+z-Nv7v7GhKj_M-x-g@mail.gmail.com>
In-Reply-To: <CANYNYEEPZjGEogaSqqCO_qnzLqnrd0d0+z-Nv7v7GhKj_M-x-g@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 22 Nov 2022 14:39:55 -0500
Message-ID: <CAPig+cQwxOr7udp4Zg=8dHycRDJrLFMZe1HKm5s5Hp=HSjuOcg@mail.gmail.com>
Subject: Re: chainlink.pl /proc/cpuinfo regexp fails on s390x
To:     Andreas Hasenack <andreas@canonical.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 22, 2022 at 1:42 PM Andreas Hasenack <andreas@canonical.com> wrote:
> On Tue, Nov 22, 2022 at 3:14 PM Eric Sunshine <sunshine@sunshineco.com> wrote:
> > The project doesn't take pull requests directly, but GitGitGadget[1]
> > will convert a pull request into a mailing list patch. It looks like
> > https://github.com/git/git/ is one of the repositories with which
> > GitGitGadget works, so presumably it should work. You could probably
> > come up with a well-written commit message by paraphrasing your bug
> > report.
>
> Ok, let's see how this goes. I opened a PR in
> https://github.com/git/git/pull/1385 and if someone could add the
> required /allow, I can take the next steps.

It looks like Dscho already /allow'd you, but GitGitGadget is
complaining that you don't have a public email address on file with
GitHub, which GitGitGadget requires so mailing list replies can make
it back to you. Once you correct that, you should be able to /submit.

The patch itself and the commit message look fine.
