Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AD7EC4708F
	for <git@archiver.kernel.org>; Tue,  1 Jun 2021 21:57:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77EAD60FDC
	for <git@archiver.kernel.org>; Tue,  1 Jun 2021 21:57:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234740AbhFAV7I (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Jun 2021 17:59:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234656AbhFAV7H (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Jun 2021 17:59:07 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 000A6C061574
        for <git@vger.kernel.org>; Tue,  1 Jun 2021 14:57:24 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id b9so200187ilr.2
        for <git@vger.kernel.org>; Tue, 01 Jun 2021 14:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qTk7PyKdTOQIAUQ0flJ/rJmFhUPthrTqff92FFgIbmk=;
        b=bMBO5FV8l89vVhQDzWW71B2IvAwfUkLCjqoREZM3O+cqSvSuBLopTM69hpQWMbbkoJ
         bR+Iwvo7VH6Tslbrh++iw47J06tLd/owi8qO9RlFlDbTkqIOC42IinHGWlSMTz7NWNxx
         8NIybw4HSjCQGyFi0+IdhTh0lryk1/XbOLUBRljglK8X4hfdW1rNXojFFPyzn5cExl5M
         94r8DFAbl4w34qZgLUB1r7TkSeML1nCkKSWetFppFgHmtJJ5Ij/SK29PHDwaOflWI3i3
         re9K5aF6G88svQRPhyCIiaPKDcEW+Qxlo3sGm1TBAKWV+WINIaDT7HSdFZUfzBkA4eZV
         bmDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qTk7PyKdTOQIAUQ0flJ/rJmFhUPthrTqff92FFgIbmk=;
        b=ipESRmIztGriASQI4oUGeQV2YWwCp5xubDf0ZaFpaYZdS+rG2emOsH3iJhN2Hz2Z2h
         ThwFvhK2TTTyBIURju9dTRSUmEnPDo0dNzk99nZYLBGJanSy+kXhbIJYznMeFoHLPoiA
         4+SgloP7sWqsO1wVIs8DACypp1//IGqPkIV7D3jeytwxBnbeN+wi/S32uyzeAYc4CawP
         02+sUrsqnQeiIujykWhtDpg81aR8t3UFRntX3ydS7t+pUx96JgEZkv8PAocUsFIWNOc7
         gpyAa6sA6Vxa6gKBVmc+M7+yY40OniUYhUiNI0q4ltg181N3TKFAIqQlewbSLXRJnV0/
         ZCMA==
X-Gm-Message-State: AOAM533AUH5MKCRKqFv9uVEiUzfN7e2TaoR4jFaLc28MVU9u/67+Cee6
        /nH2eRYkdekybEitWSCpDzliy3zPQcnmTIHSAq3APX0Uoxw=
X-Google-Smtp-Source: ABdhPJzTCYnJEZ1xqFsEFmk5tr+ix0g3FhECdkquZ5cDjSVTewUIWBOmnE+OGm3XLelVAzSBURBWKUwhzmBkktH5z50=
X-Received: by 2002:a92:c68c:: with SMTP id o12mr13103129ilg.6.1622584644221;
 Tue, 01 Jun 2021 14:57:24 -0700 (PDT)
MIME-Version: 1.0
References: <60b5d281552d6_e359f20828@natae.notmuch>
In-Reply-To: <60b5d281552d6_e359f20828@natae.notmuch>
From:   David Aguilar <davvid@gmail.com>
Date:   Tue, 1 Jun 2021 14:56:48 -0700
Message-ID: <CAJDDKr7AG_qs2ZmNCuS9zS0oqCT9cWU=CSCfxALEkGuLHBH=OQ@mail.gmail.com>
Subject: Re: The git spring cleanup challenge
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 31, 2021 at 11:26 PM Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> So the challenge is this:
>
>   1. Remove all the configuration that is not essential (just leave
>      user.name and user.email or equivalent)
>   2. Pick 2 configurations you think you can't live without. You are not
>      allowed to change them afterwards.
>   3. Every day you can add 1 additional configuration (and update it the
>      next day).
>   4. The moment you add a 4th configuration you lose.
>
> Once you've lost, reply to this message with the configuration you could
> not live without.

+1 for merge.conflictstyle = diff3, rerere.enabled = true, and
log.decorate = short from me. I noticed others already mentioned
these.

My favorites which no one has mentioned yet are rebase.autosquash =
true and rebase.autostash = true. IMO these two really improve
rebase's usability.

cheers,
-- 
David
