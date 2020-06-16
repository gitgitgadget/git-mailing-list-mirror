Return-Path: <SRS0=RX4d=75=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F480C433E0
	for <git@archiver.kernel.org>; Tue, 16 Jun 2020 09:08:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE9BB2078E
	for <git@archiver.kernel.org>; Tue, 16 Jun 2020 09:08:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bVWupky1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728014AbgFPJI4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Jun 2020 05:08:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726052AbgFPJIz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Jun 2020 05:08:55 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE68DC05BD43
        for <git@vger.kernel.org>; Tue, 16 Jun 2020 02:08:55 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id e12so13699930eds.2
        for <git@vger.kernel.org>; Tue, 16 Jun 2020 02:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+ilGB+9RpSOMO0SuIV/EP+oNn2fu9rcdDEBTOFBW4+s=;
        b=bVWupky1GI2J8QwWIMO21kBiyxNwSzHE7c3vScul8XVNoQOIF66qGm0LZ8YxqU5PRM
         JdNbD1UF7E7fVkZq0vHn0l/1Py20rseZxmSmsauhvXlT6Ss94Q81Tw4iCUGlyD6dMRqg
         oQR23pSomcuFQdf1uoAUe8WFeDEC2gG+n+Z2g6+0cJcFG3LRDXXdZzWjTU3IxrZhtThR
         G+l1ITPrceiITq7Ev+IBL2ehbxa52U+Pw9/PtcIdbKNqaAo2tCOpaAvKgqQpX+c1Eoz5
         +v41cl5b+EeDED/2Y0TEt/oDVpZ0chdG/A9Aue4GOGV1j245a7EADUnjrcvB8NkpuKeU
         LtQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+ilGB+9RpSOMO0SuIV/EP+oNn2fu9rcdDEBTOFBW4+s=;
        b=CO11CK1jhSaNOrn1EDiWd5Uzn9+4aojEumrk5KSTUUjwYEsO2ASNKtjr1tbcO0SVUL
         ddLtlqmWdJVDv931oUzn/X1hrksdMCa4YOxnKD/+T4xb1t+Zl8MKbAb6lvhzw1tFn7ZS
         dTe5B8tJbxnd4WeUhthMOdH2zJvXnHDHBAyyKnz9/2NPStrtrmv6sqT9GSVF+i5Na1S0
         RKX0g0QgwBoUyxdc7MnZdv5xqg+XHLcZKihTws5oqNHSaTYCLr+gMfPSPaBCbpTxSoGQ
         sO1arZihQlohFmWRowqrzZ/U2R39h/CCMtM0kme4gkcFAEOYtfxe3aOVwEN1rhhNFHld
         Pdlg==
X-Gm-Message-State: AOAM530WIW4t9inyyiwh7BnMhPd/PvpPHhrEvAWVmnDp5HcYxWXe8JSe
        Aiyoz1MKlY1cQ/D8rJCU5YgmyTtrEJpFjPF3zWs=
X-Google-Smtp-Source: ABdhPJx8V8nGNWlnTQ5xfKmOvHuz/TOz4uSyFyrlsWdtd+oUjs26apXJWiiUJ3jvHScRvot+8wYgkMdxgWEs5EVknKk=
X-Received: by 2002:a05:6402:1153:: with SMTP id g19mr1592890edw.127.1592298533820;
 Tue, 16 Jun 2020 02:08:53 -0700 (PDT)
MIME-Version: 1.0
References: <BY5PR19MB3400EB9AD87DFE612AFD5CC390810@BY5PR19MB3400.namprd19.prod.outlook.com>
 <CAP8UFD3m9ANt6UOyOoMDy2haTJjhzL5ctFiki46ktgH3RLPqjA@mail.gmail.com>
In-Reply-To: <CAP8UFD3m9ANt6UOyOoMDy2haTJjhzL5ctFiki46ktgH3RLPqjA@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Tue, 16 Jun 2020 11:08:42 +0200
Message-ID: <CAP8UFD1y5uUkaHxtBfQFWoqXCKDod7Srfcnk0AHRVbrzit1DgQ@mail.gmail.com>
Subject: Re: Collaborative conflict resolution feature request
To:     "Curtin, Eric" <Eric.Curtin@dell.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "Geary, Niall" <Niall.Geary@dell.com>,
        "rowlands, scott" <Scott.Rowlands@dell.com>,
        Michael Haggerty <mhagger@alum.mit.edu>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jun 13, 2020 at 2:08 PM Christian Couder
<christian.couder@gmail.com> wrote:
>
> On Fri, Jun 12, 2020 at 4:11 PM Curtin, Eric <Eric.Curtin@dell.com> wrote:
>
> > Is there any existing or upcoming feature in git that could help make conflict resolution a more distributed, collaborative kind of task?
>
> You might want to take a look at Michael Haggerty's 'git imerge':
>
> https://github.com/mhagger/git-imerge

Not sure if it could be useful in your case but some people also like
a tool called git-mediate

See:
  - https://github.com/Peaker/git-mediate
  - https://medium.com/@yairchu/how-git-mediate-made-me-stop-fearing-merge-conflicts-and-start-treating-them-like-an-easy-game-of-a2c71b919984
