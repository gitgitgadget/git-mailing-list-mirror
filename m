Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46BFAC4338F
	for <git@archiver.kernel.org>; Sat, 14 Aug 2021 10:22:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 208E760F21
	for <git@archiver.kernel.org>; Sat, 14 Aug 2021 10:22:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237770AbhHNKXY (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 14 Aug 2021 06:23:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237804AbhHNKXN (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 Aug 2021 06:23:13 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83F9AC0613CF
        for <git@vger.kernel.org>; Sat, 14 Aug 2021 03:22:34 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id d4so24753877lfk.9
        for <git@vger.kernel.org>; Sat, 14 Aug 2021 03:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ucqSMFIgRX9M7tYeoA5ok62Bh9TpNJeKNgKNCyV/snU=;
        b=f4ytlo8VwjLJKoWPBjP84wlThdzJWywG/ZygIuARCPdgKwYrrfXJwHcZwghpo2CPVb
         hK3Urm2ZeZp3xaDnGADKQdzQM62kjshuBpopkip9VQCSOZpateEyQ7xERi1SXzIXNlyo
         M6mmtEM0mXpr+714gXcLGKi1cLwRlKc+7tzirzkdNKXj6uG59ay0mbYqmzRtUuwrfo3O
         VUKdk+ANQ17H6ILRKAR1+ggyuknv/cA59hFp9kiE035tMoGnsNt0+CXLm9HuaF/2Pb3i
         Sz+oYnx6ozsl/wTpdCUKaqWh0EQCpcWoQVP2N+EN7mAcmy+wVS5mV8eJBkGAerBNcnS5
         nFTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ucqSMFIgRX9M7tYeoA5ok62Bh9TpNJeKNgKNCyV/snU=;
        b=albjf0nB9civ1BYRw2ABt+M2JBc1bPE2y6eO7lsD4YPj0vkuf8pw/nnP7uhG2PJhWM
         OcJwm/dkvOFKFu/2O9e/tvFbZjHcaAC0ER5kEBOPAwj+sJrzb4ONKFzrdW6Cbsrk8Ssj
         Y1EOa/pJ0bLaocMotGITyF7UtrosoyvVjWI0ersjtzgw7H4NYxGmq93TNR9NTFadRMJq
         NnnIfBsN4vMLMPD6Uc93YHsj1rqgpRp/u/K55litHXqUJhOFXoZxz/fUFGTfucO7VovB
         FVIoiiWuOKleeZAG3loMSExoZqwZHag3xXCKhNrnL/rEB+Zo1oemDSi4sVFiZgNxcneO
         6ehA==
X-Gm-Message-State: AOAM531o3wSBawmfRcoRAjbRSxtusKLhUXQrYy25vQPuwf7J+5pEKUVY
        ve+PGt2+/AI7kCnzlf3tH4HmXtfiWqVMkoIMKrv5E4Nd
X-Google-Smtp-Source: ABdhPJy0tyK6z/uwyxpezt+svrU+ArsU9nqHRdMkLRq8/YNaLMxYrcVVuIiXfEd33l4Qn7zecnCylI1GMIcfezacVT8=
X-Received: by 2002:a19:ac42:: with SMTP id r2mr4640950lfc.167.1628936552853;
 Sat, 14 Aug 2021 03:22:32 -0700 (PDT)
MIME-Version: 1.0
References: <75911f47-1433-f0a4-7d46-f1fb2fd44cf4@rawbw.com> <CAPx1Gvdb=rtjWmc1Qe5iZyuwSF+s-YO7G__VUZ=iZw3x4bAKCw@mail.gmail.com>
In-Reply-To: <CAPx1Gvdb=rtjWmc1Qe5iZyuwSF+s-YO7G__VUZ=iZw3x4bAKCw@mail.gmail.com>
From:   Chris Torek <chris.torek@gmail.com>
Date:   Sat, 14 Aug 2021 03:22:21 -0700
Message-ID: <CAPx1Gve4GoMtH5s-3-RQgf0szvpW-DdFn7GygzAzg_e6vTCrLQ@mail.gmail.com>
Subject: Re: 'git log' doesn't keep log of un-removed and then renamed directory
To:     Yuri <yuri@freebsd.org>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I should add: to make this work in that future smarter
`git log` command, be sure to:

 1. commit the un-removal first; then
 2. commit the rename (you can just `git mv` the
directory and commit)

so that the future smarter `git log` has an easy way of
finding this.  Ideally, it would find this even without that,
but having all the files / sub-trees have identical hash IDs
will make this much faster and easier.
