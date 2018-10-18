Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4A2691F453
	for <e@80x24.org>; Thu, 18 Oct 2018 18:50:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726647AbeJSCwa (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Oct 2018 22:52:30 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:40711 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726424AbeJSCwa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Oct 2018 22:52:30 -0400
Received: by mail-ed1-f65.google.com with SMTP id r1-v6so29236027edd.7
        for <git@vger.kernel.org>; Thu, 18 Oct 2018 11:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KvRVth/To2kw8ZIFPr+Uz1SwHNO339oUh+tZ45c0CrM=;
        b=sdim8BELfWbTmJXsU1vbfqaLKDoA/wO+Bw37WX/a2B7LmXdqQoAT/A0ICE5BaQq49M
         4sLzfbaqnkyAGlI8jr7nKVuMuXLpPD9SOXHueH5/l79OYCjzS9aHeI2Vtapz4evBhdG/
         DlEHv4kkFLrk9AW+tpa1AnYPITENlyYUEgVVr17bDGV+rmFKLiPfayJUi2w+jZwtr/dN
         jsjwzkSgCNHop2oHfX67ILn6hEehxC7se5hMNe57SF8wFfVD/TrvbpbXD7dFq+D06krj
         HSemei3+3gVne2NOn8l8VH/3BdlDsJPWyQNofOmWab1NWZwpmKmWtiKN4y8NrExkZUI6
         4Nyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KvRVth/To2kw8ZIFPr+Uz1SwHNO339oUh+tZ45c0CrM=;
        b=HY/21A17wOA68LzDy8I27Pn3wfD4oCl3YjMZT/PNwWU3K/QuXvK61fVMKJ+TMNO3PT
         2vVa1t4/itzkIC9+3vNC3X8nY6TYQ5PGFqSpphesCB9XjbEJO0SAPCv+k2t5lELt9ubN
         ZTVTktv0Z499uer/Z5CQO15ZS3u9RYta7FpRY+QIVEnvu1+/jzrcxFTpp61M02lPfipk
         1f/B2bhmrYQe2fKF5pf2SIGZz91rNIiDKjhXuM3tWb3KpRCZEsf//bhecQRKe4nFR4ay
         kGTCPvNlPda3fnZtndt2ims2P67p89m/1m+8mXnY2xJw6Qzd86rpEBCLaakRKk4/CSoW
         yTXw==
X-Gm-Message-State: ABuFfojF4BXVt7zTkZlogZyBkgHaacZ3ttZpl0/dNLPIQQO4r2cc++sl
        AAw/9pE808/u7eXm1HsfQEsSQZ173tPiW7CbptQbOg==
X-Google-Smtp-Source: ACcGV62wKVLLhLH6E3zgHA/Xb8XgRMrxmJoMvrMtcFWXUzxpxIUl5SzLwASy/lMY554/HjzeuDWnXoheUAB/WVdwLRc=
X-Received: by 2002:a50:ba89:: with SMTP id x9-v6mr4382780ede.191.1539888608921;
 Thu, 18 Oct 2018 11:50:08 -0700 (PDT)
MIME-Version: 1.0
References: <CAD1gVxMg0ZiKqFABrnwt0v_=wr2X_3ErkR92RmCAtFQnuM+L5w@mail.gmail.com>
 <xmqqr2gu8dsx.fsf@gitster-ct.c.googlers.com> <ae6fc699-6e09-2979-40dc-9cc49f4f8365@kdbg.org>
In-Reply-To: <ae6fc699-6e09-2979-40dc-9cc49f4f8365@kdbg.org>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 18 Oct 2018 11:49:58 -0700
Message-ID: <CAGZ79kYChLNDB_f1KR2k7G9FvHkX7x_yXdhxMRpLFWpRR0SoPg@mail.gmail.com>
Subject: Re: [PATCH] diff: don't attempt to strip prefix from absolute Windows paths
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     andreenkosa@gmail.com, Junio C Hamano <gitster@pobox.com>,
        git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 18, 2018 at 11:38 AM Johannes Sixt <j6t@kdbg.org> wrote:

> There is one peculiarity, though: [...]

The explanation makes sense, and the code looks good.
Do we want to have a test for this niche case?
