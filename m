Return-Path: <SRS0=QY2u=4X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42575C10DCE
	for <git@archiver.kernel.org>; Fri,  6 Mar 2020 18:25:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1245820675
	for <git@archiver.kernel.org>; Fri,  6 Mar 2020 18:25:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="jkxX5r8+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726259AbgCFSZt (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Mar 2020 13:25:49 -0500
Received: from mail-lf1-f51.google.com ([209.85.167.51]:35019 "EHLO
        mail-lf1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726083AbgCFSZt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Mar 2020 13:25:49 -0500
Received: by mail-lf1-f51.google.com with SMTP id z9so2697368lfa.2
        for <git@vger.kernel.org>; Fri, 06 Mar 2020 10:25:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YtAzxLtB2fuw+soALcpI4cITUx/bsHRws9T3nf2R21A=;
        b=jkxX5r8+TGN5whajxTnydIPgiq1AU1iKRMXWzSVdp5XM9G+uTQ3cs/QCHUiAEtf9gS
         UfxMt6F1qEWn8y1Tf/VvRp4HbcjfqfRGSARdLjGm+WmLSZ7r6c76NGHZV4TRMPdShsyd
         3jeorCN2aXs0C5aw6eEOYIZIDzGbSbLWYOWGOK+vo6Sfli6084iJxHIrrpDVrNoemq4S
         FyeeufNh49Xr4b2QyBpECCzlMVUM3wbjI2YJzAaNIAKQKcESCukPBKA4UCVU/WoM4vHO
         nnj1CRsfW2oOPP80+eQI7hwDa9xHxtVaDJUVIoHMXe+B1FH9YQ7n+xAzK5xYb2HnYCXP
         AGSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YtAzxLtB2fuw+soALcpI4cITUx/bsHRws9T3nf2R21A=;
        b=mZ4AZnuMHwNAx7UXQ0/hZG0X6TZX3lo/XD/3+/1Sy9DyvWQADjiOKMu0swFNBbh1oI
         2+JmWkrd2LYqQGjqoS9jx24k0FX+4PoG+5efc/FdJnSakaSj+NdeeQ2tJDa7Cdt6eoBV
         o1vUZCJ3IUBTSfvAuB1FmEW2czc0DRsCjw1wJQdmGr6mZUL9KuzRhtCwueVmW/xOaF5+
         6kuTD3gCMjEIbUrgVeqXRlm+fWaGo0nXBDDLInTdetFQ47PmMucvneVBbTUm6V/8eQbr
         APqyRxBGp6XEVzZoONtRrcCwc/rpOTNa83HrCIuMUQCnu28Guo8SLd5w/px+UBaKm66B
         pKEA==
X-Gm-Message-State: ANhLgQ3vYY0tZ3Ke2rmLv+L9NcrCp4Z0XUFi1kyY4Q9jTBFfzXvq4Ash
        uiZ9O9w6gHIGXvLc5KF5F0kpvzjzVak8rRSdo63OjQ==
X-Google-Smtp-Source: ADFU+vt1x9hvOWGzs6LmlBmlOaWlUpJjATUjLpdt1A/uRPsByfAgeENRoh1P7cDeCGfLLkZIL8GBrLQ5sYyWURRsvaA=
X-Received: by 2002:ac2:53b2:: with SMTP id j18mr2660961lfh.144.1583519145023;
 Fri, 06 Mar 2020 10:25:45 -0800 (PST)
MIME-Version: 1.0
References: <CABPp-BHk0TyxEgudMX_-zzpFsUPHCmRkvZezN_49J2ivi2-N+w@mail.gmail.com>
 <14db3e6f-6919-aa58-7084-e4404452820c@gmail.com>
In-Reply-To: <14db3e6f-6919-aa58-7084-e4404452820c@gmail.com>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Fri, 6 Mar 2020 10:25:33 -0800
Message-ID: <CAHd-oW4P34aAoMfyDHDS1Kv9YpJ8ejU-GZpqtoHL8YLaJuEOeQ@mail.gmail.com>
Subject: Re: Git Merge 2020 slides and reproducibility
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Elijah Newren <newren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 6, 2020 at 8:40 AM Derrick Stolee <stolee@gmail.com> wrote:
>
> On 3/6/2020 10:00 AM, Elijah Newren wrote:
> > Had a few different folks ask me at Git Merge about slides for my
> > talk.  I said I'd post them on github somewhere, but in case you were
> > one of the folks and have a hard time finding it...they are up at
> > https://github.com/newren/presentations/blob/pdfs/merge-performance/merge-performance-slides.pdf
>
> Thanks! I guess I can post mine, too:
>
> https://stolee.dev/docs/git-merge-2020.pdf

Thank you both for making your slides available. And for the great
presentations, as well!

---
Matheus
