Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 327E41F403
	for <e@80x24.org>; Thu, 14 Jun 2018 19:32:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754877AbeFNTc4 (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Jun 2018 15:32:56 -0400
Received: from mail-yb0-f196.google.com ([209.85.213.196]:38799 "EHLO
        mail-yb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754780AbeFNTcz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jun 2018 15:32:55 -0400
Received: by mail-yb0-f196.google.com with SMTP id q62-v6so2662807ybg.5
        for <git@vger.kernel.org>; Thu, 14 Jun 2018 12:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uIiGy88ihJOOH6hNgykniR8nlxn8/7LqTsZx347jpCg=;
        b=vbj9txzHzfpfM+UOdf506saYwL8AGpr74RB3go5hekRxzWVZgxB6/wdVoYQ0YlABpU
         DmPkH5h9YHJjBacnqyEH+9uDh8ebwhWuzLTx+l3z38vNzMGJ3b0Dg4uOFmHdcyhvIn5x
         pZIKnqNAw0+fjk1Lswg+FNYEMAnPgl7l0HJzKvzxnDGB3WQK2JVJUDMzxkjYYmQuG5gE
         ecfLwRD4q/OgceA4dmsVFSQxNXMW7HWXZsOX1ujH5wCPHxLUkLieG0Ly6EAk48qJfJ9i
         5+omocdFUszlnAS4+FJCWpym0QhvBXBe6WnEm2CFUDNODS8tRk6T4YP5U1StJRnOaRqI
         BXtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uIiGy88ihJOOH6hNgykniR8nlxn8/7LqTsZx347jpCg=;
        b=TkWGEa/V+6iGa10qCuZz1k3/hWrWZn3hYGrEMMfTQwHVPFEu3J83H57hJ9suC1P0dX
         SGPMV1reGN/A8IC88K8HYgn/gc7vtoq8tYog1C7XeCwKMcEohji75OBfEgDn3lYoYVUN
         NFNabLj1SzU3aXBkROLsPSlBZkRbJLrerOpvyUHpLWBTWP3fPGSLBZZ7iLk4KBmou7Z+
         Ysq3ZZNaYu5AuFdX58S7LGgwTWcOKCLSUfMZB8RE5MFcM0Zo0B6HphWqCxvUCzT1KxNr
         0HzqpEbDCf0IL1pYI3g341oNHKKLsBD80TQdRPlGZ1KX0f7zHrA8BYaTTs1F/0ANqoy7
         RAQA==
X-Gm-Message-State: APt69E1XxhEdr5Wuau16H1dJIgWEfiqtLpH2LuwmolD+YM7fvSuml5uQ
        imSh9XbrbOTcQ/zY9UWtZ4y1tLHTp3kwQCBh/pi9Dg==
X-Google-Smtp-Source: ADUXVKI+20axPWVcaD8xv2byV4g23/302ZucBbMifR0k9s8Ljv8C6FkZAuWHNUwD6wk+dV8fwjX4TsnsvsF+6viJsxo=
X-Received: by 2002:a25:b308:: with SMTP id l8-v6mr2131327ybj.515.1529004774574;
 Thu, 14 Jun 2018 12:32:54 -0700 (PDT)
MIME-Version: 1.0
References: <20180605175144.4225-1-bmwill@google.com> <20180613213925.10560-1-bmwill@google.com>
 <20180613213925.10560-7-bmwill@google.com>
In-Reply-To: <20180613213925.10560-7-bmwill@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 14 Jun 2018 12:32:43 -0700
Message-ID: <CAGZ79kYVMFx-5EoHwXy8tvQ3jfq=TfJN-FnRAkyToNTMhfa4_w@mail.gmail.com>
Subject: Re: [PATCH v2 6/8] fetch: refactor to make function args narrower
To:     Brandon Williams <bmwill@google.com>
Cc:     git <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 13, 2018 at 2:39 PM Brandon Williams <bmwill@google.com> wrote:
>
> Refactor find_non_local_tags and get_ref_map to only take the
> information they need instead of the entire transport struct. Besides
> improving code clarity, this also improves their flexibility, allowing
> for a different set of refs to be used instead of relying on the ones
> stored in the transport struct.
>

This patch and the two prior refactoring patches are
Reviewed-by: Stefan Beller <sbeller@google.com>
