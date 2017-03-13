Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DD16820373
	for <e@80x24.org>; Mon, 13 Mar 2017 22:51:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752834AbdCMWv0 (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Mar 2017 18:51:26 -0400
Received: from mail-pg0-f52.google.com ([74.125.83.52]:33754 "EHLO
        mail-pg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751687AbdCMWvY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Mar 2017 18:51:24 -0400
Received: by mail-pg0-f52.google.com with SMTP id 25so72017626pgy.0
        for <git@vger.kernel.org>; Mon, 13 Mar 2017 15:51:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=vImfsS+O96VpcMAmwKUAm6O6SgwPHYmXuEAZtwfxWvY=;
        b=M64sAGstJdLQi5NU2L/mSbd+N8YnShODEAdq23TAf7jaylCQZ++0hoh0rXLa6vOpwx
         KtghnaWBI5DUK2ZfAE/3hCns0DAazrWtmbd8tmOdYogAGw32pF4By2zG5QPlgZ9m2/3q
         Z/LfYbOdwjKwWE9RCQuu/wVOSjPUTV8encH7F8rvfFUXpUxV/2Ru18fNwvjgza8w8UeX
         qZ/SncdbKznrsJgJq3yII5fOciKf85PWhm1K8zLNtstPf89LRNVOCj1SKKHIrd6fxJ+I
         B7ufVP5s8lKAb3BFtC+wmwKHGMZnWqYPD06j6wNRELl0d7rkzbchNXwB+pZ0zzo6hOBu
         gBVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=vImfsS+O96VpcMAmwKUAm6O6SgwPHYmXuEAZtwfxWvY=;
        b=k3FI2Q/NnEk5wuislFn19U1LbK8gftcwaepk3ar6BOQAaxZdqj7RlFJGHnfaDPUMYv
         PLm1i7ImhTASgKQMguJD4MLQRqktjT3QH72kI8dzaX/MUINNEW92IMXbg7GjJGwJs3yz
         tgSC3SQBzm1QO1EqWfgt2vg5+iYAOFFMO5Nx6HQcj6yWqx9YdnFSWkhKkwLDOnuIX532
         oalto6mI7vaMEEQG33bMQPMC5ycAADW36tE3nzDWl7ZXU5n9ScssT9zKDlKzAQk+4AU3
         peiHuMul8udQYczm1KROSMfKQv03TfUaZRFJNDr05B+f5dWmCIDBqZ3I3jnAb5KMe3VX
         QOpg==
X-Gm-Message-State: AMke39kUt+4fmvznDlfZ/B7S3X+gd4qd17HE8MHlpoMEXRcvDA2yJOhR2k72koVnYot0OAXkOxoDubpkXtxcbM2d
X-Received: by 10.98.149.80 with SMTP id p77mr40084582pfd.56.1489445483462;
 Mon, 13 Mar 2017 15:51:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.187.5 with HTTP; Mon, 13 Mar 2017 15:51:22 -0700 (PDT)
In-Reply-To: <20170313214341.172676-1-bmwill@google.com>
References: <20170309012345.180702-1-bmwill@google.com> <20170313214341.172676-1-bmwill@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 13 Mar 2017 15:51:22 -0700
Message-ID: <CAGZ79kZ8mRT8HfxNjJ+CG0Abyubs=uF=R4NWuK9Cyhx0_H3niA@mail.gmail.com>
Subject: Re: [PATCH v3 00/10] decoupling a submodule's existence and its url
To:     Brandon Williams <bmwill@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 13, 2017 at 2:43 PM, Brandon Williams <bmwill@google.com> wrote:
> changes in v3:
>
> * Droped a patch which tried to use a more accurate URL for deinit.  It didn't
>   really fit inside the scope of this series.  It may be something we want to
>   revisit later though.
>
> * The --init-active flag now ensure that all submodules which are configured to
>   be 'active' (either via 'submodule.active' or 'submodule.<name>.active') go
>   through the initialization phase and have their relevent info copied over to
>   the config.
>

This round looks sensible to me.

Thanks,
Stefan
