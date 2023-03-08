Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 838D8C64EC4
	for <git@archiver.kernel.org>; Wed,  8 Mar 2023 21:40:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbjCHVkX (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Mar 2023 16:40:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjCHVkU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Mar 2023 16:40:20 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 532ADD30B4
        for <git@vger.kernel.org>; Wed,  8 Mar 2023 13:39:43 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id u5so18995336plq.7
        for <git@vger.kernel.org>; Wed, 08 Mar 2023 13:39:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fangyi-io.20210112.gappssmtp.com; s=20210112; t=1678311537;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=z6ZIAv4H24+zojmE00WX+XCcytY0eSes2d3Mf0P2gLo=;
        b=iareK49JjRHSPbmFWya8mgYE8u2WzxFZe+J5Pxzxcb8fRDnfsgXvriPnvlUHDbSqmd
         nyqOuOO9IVCh8RDJozPFVI6rLpvS5EI7Dt/g0FxTDgm7olTdGNm8Jb9KsR05JdzXT/Y8
         /d1XLfIka48t+sTLivY+bVLwTe7TK4m9x4G1bCqMfAbA1uKHhfNa2JKscqV0kvzHNVL4
         USmXMN5ehecjZBkWiF8oG4yL2SQOplICEiArqbtiUODRtYMWugwds3AcGv3kXMunRN9P
         xvfM5OefExK3zjlo4upXyZlOGKR+S4Hjo85hIWlcZEnch3skAMIn+6KXY/QhlgEGnOGR
         4yCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678311537;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z6ZIAv4H24+zojmE00WX+XCcytY0eSes2d3Mf0P2gLo=;
        b=xJKnhjl1Yc4JJqgYRSz/1ayfKlXCH1x7jxkYlVBocLq+C21qLkNY60YfVE3u/qCi+V
         8HtlbRgiM6cq9Msb9KbRYV5WKD/sSrlqrcWUxqWsPjao0gM7qcSioZZfUDGysmhwOvHd
         TVdcF7zqxefgMMfpV0FYM7j2gFu7udHNNmkqg7TkIi3cdBbwIjns0TdS9L0AFMDwfFM8
         eIt72tLCHgmKNn7UjQihf2jwVPfJS6BSzr6kzk/LJzigYUydJer7wdzD0W8zo4wpWYqF
         KLkWhr3R1iIiW2T6FucMN2d6JjlWYN5HagoRjJjIzEUY1wjsNx+s18wujVqiGEpuoTOb
         KZ5A==
X-Gm-Message-State: AO0yUKWxOl8AHoLVclL0xwuFIt42SR+6uWNEM+cVA+4SyvaqePkqjpm/
        9BQJYCPgjuCkfR0s7ITO416H0XvBz6A886r9Tb89xA==
X-Google-Smtp-Source: AK7set9e/TwAff32Z028DUEBiXL0WaIbCbfjeIiwb81+83kOzcMkcEdfij34NkiZVXy3mKQ9fRkD9jnlGYX+5xG3SMk=
X-Received: by 2002:a17:902:9a03:b0:199:2f45:19dc with SMTP id
 v3-20020a1709029a0300b001992f4519dcmr7553065plp.9.1678311536956; Wed, 08 Mar
 2023 13:38:56 -0800 (PST)
MIME-Version: 1.0
References: <xmqqcz5snyxz.fsf@gitster.g> <007e6f051381d86da6881644ce300b6eea944194.camel@fangyi.io>
 <xmqqttyww9tl.fsf@gitster.g> <xmqqpm9kw9no.fsf@gitster.g> <37ed877d5927c7cebba7e47769be3a069eacd6c6.camel@fangyi.io>
 <xmqqa60ow7nr.fsf@gitster.g> <xmqqjzzrrmcg.fsf@gitster.g>
In-Reply-To: <xmqqjzzrrmcg.fsf@gitster.g>
From:   Fangyi Zhou <me@fangyi.io>
Date:   Wed, 8 Mar 2023 21:38:46 +0000
Message-ID: <CAEpW-9=1G9Ra1wrwa_xMNF_k=8Ojqw6dqdv=7YfpP8zA9rg2GQ@mail.gmail.com>
Subject: Re: fz/rebase-msg-update (2023-02-27)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 8 Mar 2023 at 20:59, Junio C Hamano <gitster@pobox.com> wrote:
>
> During -rc period is when we are supposed to concentrate on
> regression fixes, and I am not strongly inclined to merge it, but
> merging it would not be _too_ bad, either.

(Apologies for sending again, forgot to reply all in the previous mail)

Thanks for the context. I misunderstood your earlier email and I
appreciate your comments. I understand your position as the maintainer
and I'm fine with the patch not being included.
I would like to politely point out that l10n contributors usually
start working when rc0 is tagged, and occasionally there are small
inconsistencies that are found during the l10n process and patches are
sent to address them. I've done so in the past without issues. I would
argue there needs to be a way for those consistency fixes to be
included (I sent my patch after rc0, before rc1 is tagged). l10n
contributors usually need to revise after rc1/rc2 are tagged anyway.

Thanks,
Fangyi

On Wed, 8 Mar 2023 at 20:59, Junio C Hamano <gitster@pobox.com> wrote:
>
> Junio C Hamano <gitster@pobox.com> writes:
>
> >>> Besides, localizaiton teams are already working on what has been
> >>> in 'master'; it disrupts their workflow to change end-user message
> >>> under them.
> >>
> >> The patch fixes a newly added i18n string, not the option itself,
> >> see
> >> https://github.com/git-l10n/pot-changes/blob/pot/main/2023-02-04.diff
> >> I found the issue while conducting the localisation for v2.40.0.
> >
> > Exactly.  That's not a regression.
>
> During -rc period is when we are supposed to concentrate on
> regression fixes, and I am not strongly inclined to merge it, but
> merging it would not be _too_ bad, either.
>
> If we ship the final without the patch, what happens to users in the
> C locale is that they may see a message that says that the
> rebase.autosquash variable is incompatible with use of 'rebase' via
> the apply backend.  If they then inspect their configuration with
> "git config rebase.autosquash", they will sure find it set, and
> nobody gets hurt.  Users in locales other than C may get the same
> message in their language, and again, there is no harm done.
>
> If we ship the final with the patch, users will see the message
> about rebase.autoSquash variable if they are in the C locale or
> locale whose translation can be updated in time, and their
> inspection of "git config rebase.autoSquash" would show that the
> configuration is there.  But it would equally well worked if they
> said "git config rebase.autosquash".  IOW, your "hotfix" may be
> fixing something that is no big deal in practice, even though it
> would have been much better if the original patch was done that way
> for consistency.  The only losers if we merge the patch in the last
> hour before the release are those users in locales whose translation
> is not adjusted in time.  They will see the message about
> rebase.autoSquash variable untranslated.
>
> So, I dunno.  To me, merging the topic as part of the ~20 other
> topics slated for 'master' post 2.40 release looks like much better
> than hastily merging it down before the release.
>
> Thanks.
