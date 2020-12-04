Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1AF7C433FE
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 23:21:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2CB522B4E
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 23:21:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727358AbgLDXVw (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Dec 2020 18:21:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726508AbgLDXVw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Dec 2020 18:21:52 -0500
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7004AC0613D1
        for <git@vger.kernel.org>; Fri,  4 Dec 2020 15:21:06 -0800 (PST)
Received: by mail-qk1-x72e.google.com with SMTP id z188so7139022qke.9
        for <git@vger.kernel.org>; Fri, 04 Dec 2020 15:21:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=3Slx75cKonm4wP8r7PAo9Wxzezl22thRB+mA9y6JEXs=;
        b=pv+bowrjG+jI1AYUIcipNcCC6N1Fcb5ynx1dRXJaSYVNBQ18xeRk2WSprBNrKk+hBW
         gH7+7w70E5vwhqMMHQ755yd/8TwJq0JA+VdDtPX/hWiA5vV3tRYS8fo01gFgWBXg4uRp
         PSQvhkJ76QG4TlaI+4SpX3oGlcyKCzjhte+V/fs+QV9ZPncbnfzPCASntWxEfJOgw79K
         fBglmbeI92pKtPmB9PqUcag7nMJUoEFlhtzWzSiyGcrVlBGbPrC9pyELd+gbtwnzs27L
         KDaYbgjHgVXXedtaAyrQ3oGiynwP4RHrjI78r1Fn5G62hvcFG+WWOVSUdoX40jzvb+uZ
         JC2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=3Slx75cKonm4wP8r7PAo9Wxzezl22thRB+mA9y6JEXs=;
        b=QwgtFtj8FwnWZ9ZVjYmD0TEUMses25NW2iT52kHYi7RvOiJIc/FuHsmVhesb+ZGRuY
         esQXPq1JLQyXikCr2yJQ0rhyx+9UMHj6eX2Al84D1RFbGNDnqI0bAFHenvG2Pg6l3szw
         doVFXHI5wIh0bMD5lt57qmHqA9zVg9Ht1jxiQD0EbAffbhrqVXdO0Zi6NJnLy9Gtym0M
         uhNDFtne4a0h9fd0KcD8s9+zXPlyHCssFmRbNUT2bqP65M1pdVMEesKBnTXVkUAE0za3
         7A4PxbLD261RtO5cKVc/EUTn/dIDwMs7fQKZMtNghhk5JVzlBhdK+GFIzqEQ4f8jIjod
         u2/w==
X-Gm-Message-State: AOAM5307MKGmmYS9IGu7sprGzWtcl8hmLPQqI0uBY1ER0EgrVB9v5YW5
        7BWbm61vdbR/UQr21BwmknTJ/NSBFf7pbA==
X-Google-Smtp-Source: ABdhPJwreB3rWspx5ly9BvcmDt0kwxQP5nYU2ImeRBA8XcMPlbLfzlbHoPns9ygai1CitfVn3UmMGg==
X-Received: by 2002:a05:620a:62b:: with SMTP id 11mr11808997qkv.229.1607124065270;
        Fri, 04 Dec 2020 15:21:05 -0800 (PST)
Received: from [192.168.1.127] ([192.222.216.4])
        by smtp.gmail.com with ESMTPSA id s134sm7145812qke.99.2020.12.04.15.21.04
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Fri, 04 Dec 2020 15:21:04 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: 'git worktree repair' can't repair when main and linked worktrees are moved
From:   Philippe Blain <levraiphilippeblain@gmail.com>
In-Reply-To: <63AC7AC2-5D32-479B-BF9E-0E5C31351A1B@gmail.com>
Date:   Fri, 4 Dec 2020 18:21:03 -0500
Cc:     Eric Sunshine <sunshine@sunshineco.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <8F01BDC6-81AD-4052-B11E-FFAA6A4C641E@gmail.com>
References: <63AC7AC2-5D32-479B-BF9E-0E5C31351A1B@gmail.com>
To:     Git mailing list <git@vger.kernel.org>
X-Mailer: Apple Mail (2.3124)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> Le 4 d=C3=A9c. 2020 =C3=A0 18:14, Philippe Blain =
<levraiphilippeblain@gmail.com> a =C3=A9crit :
>=20
> I tried several things:
>=20
> ( cd git && git repair )

Oups, please read 'git worktree repair' here and below.

> ( cd git && git repair ../git2 )
> ( cd git && git repair /old/path/to/old/filesystem/git2 )
> ( cd git2 && git repair /old/path/to/old/filesystem/git2 )
> ( cd git2 && git repair ../git )

