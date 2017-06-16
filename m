Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8D8141FA7B
	for <e@80x24.org>; Fri, 16 Jun 2017 20:37:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751818AbdFPUhv (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Jun 2017 16:37:51 -0400
Received: from mail-pg0-f44.google.com ([74.125.83.44]:35343 "EHLO
        mail-pg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750780AbdFPUhu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Jun 2017 16:37:50 -0400
Received: by mail-pg0-f44.google.com with SMTP id k71so24791301pgd.2
        for <git@vger.kernel.org>; Fri, 16 Jun 2017 13:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=fY6j4jLoB+yH9TBMqLQaxeB9kmQdP2thFsQsUNIlxWQ=;
        b=LIq5iar1ae6lBfdsOSr01F1WAgTggEhZLLw/oTfQ8sLGG589UcXRjP24xrFwpPS4/D
         SxtXpshsMSBdUN+PnFsvE5/ezgwv71F6ronZNW0wQS5fjvZ4rfJHdM4gQZ4I5mHwgAmk
         RrmiwdkRwPSTs8AezgGZfKuimzBXrk8ZiQFTvEE1H2nElEVr1Ch4/mKuzUk+hEwZt6xD
         Eb0vQh89rClQRNu3Z0EEvKGGgQFEy4Cw5ZUeOiD2HykpAjnUZmLaeMwuO3fKv92JMCJz
         3SqiPjSHv3kWNZz2DUWYTtfIhL8/IF0vmOFEZy+a7fpIVgqv+obBhv1oVDLDOwmrQn3z
         vm0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=fY6j4jLoB+yH9TBMqLQaxeB9kmQdP2thFsQsUNIlxWQ=;
        b=lYeYLn0lVZ5ZouxRYh1U+1k+8KGAR19V+sRp035nqUpi2+rpZM1k14jR1pzoVYoGdD
         Et4OOj77yO6Uth8HL9Y1TXl78lQaPh0Y0J5Zry/tJWibImCwVPNq6KK6euupq86fWbu1
         Fk6oOC0by2VzYrX3rUQ9YcYePbgjidcUkJqL0sGG96cJYTIYrgBGtkCu7WuJcTCCw9jx
         F1qD0lTCnG104MVS7d73+QmhEoQDtWo1VQdkAEEmUtuMrbJbRnRihwxTzu9XY8IiV/WG
         witHM3Qm3qwQRuvwXPrtXz+Vir1A+lFJJMmYmBKF8QVXYwdGARFTKKZOKvNIg1KerVjI
         IjmA==
X-Gm-Message-State: AKS2vOyX4ViqXClE50Uq+m5YHdu2QC/UMlCVS2ieZKX+wpLo9gBOG4fG
        zvruKBD7/M4ZNQ==
X-Received: by 10.98.236.66 with SMTP id k63mr13170383pfh.3.1497645469445;
        Fri, 16 Jun 2017 13:37:49 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:402:61d1:2cfd:fa77:c70e])
        by smtp.gmail.com with ESMTPSA id s7sm7189145pfd.86.2017.06.16.13.37.46
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 16 Jun 2017 13:37:47 -0700 (PDT)
Date:   Fri, 16 Jun 2017 13:37:45 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        git@vger.kernel.org
Subject: Re: [PATCHv5 1/2] clone: respect additional configured fetch
 refspecs during initial fetch
Message-ID: <20170616203745.GZ133952@aiede.mtv.corp.google.com>
References: <CAM0VKjmxtqB2zrWOW8T9O1ReWNPTZA7V3-Dei7GecB3nxVh2Dg@mail.gmail.com>
 <20170616173849.8071-1-szeder.dev@gmail.com>
 <20170616173849.8071-2-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20170616173849.8071-2-szeder.dev@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER Gábor wrote:

> Helped-by: Jeff King <peff@peff.net>
> Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
> ---
>  builtin/clone.c         | 36 +++++++++++++++++++-----------------
>  remote.c                | 13 +++++++++++++
>  remote.h                |  1 +
>  t/t5611-clone-config.sh | 47 +++++++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 80 insertions(+), 17 deletions(-)

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks.
