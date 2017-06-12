Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5A23120282
	for <e@80x24.org>; Mon, 12 Jun 2017 05:33:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752034AbdFLFdJ (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Jun 2017 01:33:09 -0400
Received: from mail-pg0-f51.google.com ([74.125.83.51]:34727 "EHLO
        mail-pg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752002AbdFLFdI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jun 2017 01:33:08 -0400
Received: by mail-pg0-f51.google.com with SMTP id v18so41662933pgb.1
        for <git@vger.kernel.org>; Sun, 11 Jun 2017 22:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=RP2s9fDOxDc/5bmf5OSdS/lsaTFFT5W117wZrudLY7w=;
        b=sR829PubOc8FWusF5FhniAvGUJ53JczgREcuob6W3YQOWYIlt015CJ9YP6qzt8whZX
         UjPMWbl0SBAuXVbBchhF/j0a9pjJ+KnPa/mCJ9TzV4DxeW+AtK89uLBhX+RkjEeEyBoF
         mgunkUwnA47hXGVmDs91/BxH+nhYhJgxoi0SpfPLi1yCwWkEiO4YM5hS8f0js7HVjqcZ
         7yC2tA+uq53VZ5xB3JqAsCdCFHdL5b4sHStGqzxxp5DVjsUN71aB75NnsazWR2hta4qx
         otOE3fo1/opnx1u/q08QjuAM6RpbHPzi5/3ivhrYa6HNTVF8MSatO+zW+zs25jmC8Yv/
         4OeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=RP2s9fDOxDc/5bmf5OSdS/lsaTFFT5W117wZrudLY7w=;
        b=Sd4wxG1epG3CVzoIeJQWtlPR5gYvhlapA2Nvw0RJWsgt4k/M2b2CxejWSdFBTEHme2
         uia3elKNtoTV8WSCvgXJPAAsWUVGoCSoqKxIASvE+x5nL8HS/+F7pD0fOMCZvq5ipHeo
         +T3+LnxiIZJdiJSkdMj3jI4ShtmQsFV/1ojRACBiv8v6IxT7sTyBSQ019jVFombQI2BN
         tU0cgW3MvsbrOZozZbkTPqslEUfFQQSq8QKX5/p8dlPZ5n2NuHBWXMMeNjX9QMhuWSVE
         xfx6LL40Im/vS2R9XlNk0tpXCTBhqzCXk65cbAf3qKM5PPU1o3YeBNEAfZUHEfzSwITx
         OoFQ==
X-Gm-Message-State: AKS2vOwFsRZt1IDGKuz2hh9ot1TqJ6QmyXpZ8S1aBNKLqb96ydTtWMri
        jkCUoNWoVDXpJBHMOQe3MT+st38/pQkx
X-Received: by 10.99.116.2 with SMTP id p2mr1574551pgc.162.1497245587674; Sun,
 11 Jun 2017 22:33:07 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.218.134 with HTTP; Sun, 11 Jun 2017 22:33:07 -0700 (PDT)
In-Reply-To: <20170608180812.6678-1-pc44800@gmail.com>
References: <20170608180812.6678-1-pc44800@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Sun, 11 Jun 2017 22:33:07 -0700
Message-ID: <CAGZ79kaKfdeyM41S2huGwYq8z3brRVpotA-CZzYe429-cA=mZg@mail.gmail.com>
Subject: Re: [PATCH v1] dir: create function count_slashes
To:     Prathamesh Chavan <pc44800@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 8, 2017 at 11:08 AM, Prathamesh Chavan <pc44800@gmail.com> wrote:
> Similar functions exist in apply.c and builtin/show-branch.c for
> counting the number of slashes in a string. Also in the later
> patches, we introduce a third caller for the same. Hence, we unify
> it now by cleaning the existing functions and declaring a common
> function count_slashes in dir.h and implementing it in dir.c to
> remove this code duplication.
>
> Mentored-by: Christian Couder <christian.couder@gmail.com>
> Mentored-by: Stefan Beller <sbeller@google.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Prathamesh Chavan <pc44800@gmail.com>
> ---
> In future, I intend to use this function in builtin/submodule--helper.c
> as well, hence this change was introduced now.
>

Thanks for upstreaming this early!

I think this is a good change even
without the submodule work thrown into the soup as well,
but with the given promise to have it used a third time this
is a no-brainer later on.
