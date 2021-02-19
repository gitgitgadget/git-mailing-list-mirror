Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B7A0C433E6
	for <git@archiver.kernel.org>; Fri, 19 Feb 2021 06:10:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 37CDF64EC7
	for <git@archiver.kernel.org>; Fri, 19 Feb 2021 06:10:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229641AbhBSGKj (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Feb 2021 01:10:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbhBSGKf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Feb 2021 01:10:35 -0500
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DAE4C061756
        for <git@vger.kernel.org>; Thu, 18 Feb 2021 22:09:53 -0800 (PST)
Received: by mail-ot1-x32b.google.com with SMTP id b8so4168415oti.7
        for <git@vger.kernel.org>; Thu, 18 Feb 2021 22:09:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=abOz5GTnCyhIW+DU4y+9cztbSNvT4W1GdbEc7eMbwxQ=;
        b=dwmcG7rOI/rjhscUiy0FVAs9DDjjCdAPDyl8+VZOMedgkyHNUp5Xx7K2MsY1d08TQ/
         cAKEzUTkri2Qq+4OSk/fY99AhIV5c0360VZgMOHqtuf8uc9X5YRv20DSJ+9h358dTjeD
         Cvo9y8AsEro9m6ENN7y3tYsyAW1gD1E2ak8qTdkc61dXyhDysc0sh9x76uT5VugWZLTh
         m2fXgVTAZNmCzbdjQeiACBPA2611UiDYTRdu3UXv7G0kFTRracv1ioap5hDqlyE0kiy0
         6nZRPZ4n9GRphO5YOciUmqXBcT9eOnR3S5ec76H/RNyhWzHfGZEkGRU6kEU8XX1b1U8L
         gtUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=abOz5GTnCyhIW+DU4y+9cztbSNvT4W1GdbEc7eMbwxQ=;
        b=e20BeTNS3qQEWtVr37W3opEA86fWAcEhZ0L9XVORq+NHEWynP2j/eMUdFqmueDfrTN
         eil35NCvbDxd5dZ61TK0WTn1zH5EIWfSlH59KVaYZKW18bVcydGLr8rwVez9QNHPs/ih
         NNVK04dKgUt8WIECeRnNGIGT/V6qFt8+6rLb2J9IPd8jZ31nZWGS7FHTvprK7JzDgk/3
         lAwPMMSbEh5J8FlvT1aDp3J+G3G8MngYFD0IaqnYZb4CZS/+nBNm1qUZF9BibDqUM9Tu
         M56LSyBC1sEjAjV9NgnIc0Hyg/Hn/+FZGHkt8A0GLVVr0TL8Ll+BcS8+ZfWj2jXo4D4i
         zt+A==
X-Gm-Message-State: AOAM532kjltdD/m5tqellItJ2AObILnvtuW7FsnEQ9IEkEjiBYBsLlgo
        +zXSMCg00i1YTUPw8uXTDQTLvWApcBdvpsKBrnw=
X-Google-Smtp-Source: ABdhPJxKpARdluF83fR+e9EshriUqpAObqIsVWrxnjKicUq+i73Ed2BtFwTOSDKDD4jx9kfWylm5fDtvefLapWmbCQY=
X-Received: by 2002:a05:6830:1d43:: with SMTP id p3mr1727338oth.184.1613714992978;
 Thu, 18 Feb 2021 22:09:52 -0800 (PST)
MIME-Version: 1.0
References: <20210217072904.16257-1-charvi077@gmail.com> <20210217073725.16656-1-charvi077@gmail.com>
 <20210217073725.16656-6-charvi077@gmail.com> <xmqqlfblfae2.fsf@gitster.g>
In-Reply-To: <xmqqlfblfae2.fsf@gitster.g>
From:   Charvi Mendiratta <charvi077@gmail.com>
Date:   Fri, 19 Feb 2021 11:39:42 +0530
Message-ID: <CAPSFM5dEEdXwgtfz==6e_745N93kWNT4tgxRGMBmz4BPynGXKQ@mail.gmail.com>
Subject: Re: [PATCH 6/6] doc/git-commit: add documentation for
 fixup[amend|reword] options
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 19 Feb 2021 at 00:53, Junio C Hamano <gitster@pobox.com> wrote:
[...]
> > +
> > +     When used with alternative option `reword`, let's say
> > +     `git commit --fixup=reword:<commit>`, it works similar to `amend`
> > +     option, but here it creates an empty "amend!" commit, i.e it does
> > +     not take any staged changes and only allows to fixup the commit
> > +     message of the specified commit. It will reword the specified
> > +     commit when it is rebased with `--autosquash`.
> > +
> > +     `--fixup`, with or without option, can be used with additional
> > +     commit message option `-m` but not with `-F`/`-c`/`-C`. See
> > +     linkgit:git-rebase[1] for details.
>
> You must dedent the second and the subsequent paragraphs and replace
> each of these blank lines that mark inter-paragraph breaks with a
> line with a single plus '+' sign on it.  See how "is mutually
> exclusive" explanation is appended to the description of "-m" as its
> second paragraph.
>
> Side note.  It probably needs "exclusive -> incompatible".
>
> The description in git-rebase.txt you touched is another good
> example.  Mimic the way its second paragraph "If the autosquash is
> enabled..."  is formatted.
>

Got it. Thanks for pointing this out, I will correct it.
