Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 28BF81FA7B
	for <e@80x24.org>; Tue, 13 Jun 2017 22:05:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752456AbdFMWFh (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Jun 2017 18:05:37 -0400
Received: from mail-it0-f41.google.com ([209.85.214.41]:35730 "EHLO
        mail-it0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751802AbdFMWFg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jun 2017 18:05:36 -0400
Received: by mail-it0-f41.google.com with SMTP id m62so49332751itc.0
        for <git@vger.kernel.org>; Tue, 13 Jun 2017 15:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fFbH2UhR7AoVUM50Muu/lQhWPqiZVksehlO6jQ6OIzY=;
        b=lzHCtaMCfr6uZ1sOKCg/m4Qi+/dNXUBZXKXOKbqUSaC/zlGt6DVG0+LgCKCa1+Xy8i
         T+QDCYgtpL4Jj+wf9ne/OcwiKAbntQDZHk0cukON4t26N1b8v3KkqAiuUrx8RUYRDAkw
         nlliJ7ACk8hjWXQpjFGCg5MAO97RZ1+9atTy2aEM3ZpvKonhE0UycWxjGY/v042bYGe1
         y5kAAPcFL6aoRAHuPkl2SnGClNvhDt8tKrgOXLbILJx44BkycFd6pjp2Bwwj7JQtD1+q
         7eEdZQLBYgtnx9+MsR1TwRqAKx+GrmjsHhzfKBAjxx0tPGa4HeQnog8tas+xS3nXMS/E
         KCqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fFbH2UhR7AoVUM50Muu/lQhWPqiZVksehlO6jQ6OIzY=;
        b=PXwDGn87umFtwD2lguqBQoqkDG+f5nY5T73A3YGDBDdUC574huAN4x0Ua//7aMMH+D
         oGUsy27iFMGQgx/SoOyEYHNtkIUI9Gph/K+kdpJxkxTbUlFoU137iVRAXZvhmcVO69sH
         /CfGd8iltm3Xlw+ETXyxE3ppwucdYvc3umdPrwaxOGWDC2qEtHSxGIqdki68tD2QQ0rT
         yLGO8t4zyKHouFMZYpVGmfKADVgZJwdPNYlt6ldb3rsMslzVkLrrPYRxFQHrxGcaNPvx
         FEsyTgLK3JLZgCmSDdEAyW2bMgyCzTpC3UwjGDZA7igdgYrA3+SHpI9gjRBbgaxGswzY
         D0SA==
X-Gm-Message-State: AKS2vOw71JbPkfHzsm3srMQ+uwLlAPcoEUJedt4gT9feOo6Hgh+MmNYZ
        +pO4GzcKf40/Pw==
X-Received: by 10.36.3.198 with SMTP id e189mr2783670ite.92.1497391535977;
        Tue, 13 Jun 2017 15:05:35 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:402:8130:47b0:791f:5985])
        by smtp.gmail.com with ESMTPSA id o14sm2538389itb.8.2017.06.13.15.05.34
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 13 Jun 2017 15:05:34 -0700 (PDT)
Date:   Tue, 13 Jun 2017 15:05:32 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Brandon Williams <bmwill@google.com>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 4/6] config: don't implicitly use gitdir
Message-ID: <20170613220532.GO133952@aiede.mtv.corp.google.com>
References: <20170612213406.83247-1-bmwill@google.com>
 <20170613210321.152978-1-bmwill@google.com>
 <20170613210321.152978-5-bmwill@google.com>
 <20170613210806.GJ133952@aiede.mtv.corp.google.com>
 <20170613213815.GP154599@google.com>
 <20170613215138.GM133952@aiede.mtv.corp.google.com>
 <CAPc5daWpXnkNyuGNtFi4YTyB+Np5Yw8yZCGwu5VNzv+WON1u2Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPc5daWpXnkNyuGNtFi4YTyB+Np5Yw8yZCGwu5VNzv+WON1u2Q@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> On Tue, Jun 13, 2017 at 2:51 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:

>> What is the next step, then?  You can find the notion ridiculous but
>> it's how this project has worked in my experience (and how other
>> projects with similar patch-based workflows work).
>
> Does "patch-based" have much to do with this? I agree that distributed
> nature of the development would bring this issue, but I tend to think that
> using merge/pull based workflow would not alleviate it--am I mistaken?

Thanks, you're right.  Distributed is the relevant feature.

The same issue can even come up when using a centralized version
control system like Subversion or Perforce --- without attention to
API compatibility, someone's change that was thoroughly reviewed and
well tested locally in a developer's working directory can introduce
subtle breakage once they run "svn commit", causing it to merge with
the latest upstream changes.  The problem becomes more likely the more
distributed a project is since each developer becomes less aware of
the other changes that their modifications need to be compatible with.

Jonathan
