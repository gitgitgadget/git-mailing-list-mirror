Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 286931FA14
	for <e@80x24.org>; Thu, 13 Apr 2017 00:50:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755405AbdDMAu1 (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Apr 2017 20:50:27 -0400
Received: from mail-pf0-f171.google.com ([209.85.192.171]:33737 "EHLO
        mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754785AbdDMAu0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Apr 2017 20:50:26 -0400
Received: by mail-pf0-f171.google.com with SMTP id s16so21076185pfs.0
        for <git@vger.kernel.org>; Wed, 12 Apr 2017 17:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=exXuvrFNIGHAA7u+g/FtpDAoPZ0py7ftdAywAQoZvF0=;
        b=IN56rBea60hwQeqGWskW9KDSkMO/ZsN0TILO9ByXayAWWmfsq4WJFAVI35dS+ve9qp
         tHW9cirXL5eBy2Mt3XxIgrBgiyDVPdYj3Fc5wKVYhZLrqrKSHkKX2dh3iZv7ZFYXYoqs
         U6Ds6jNHd9dRZU3jDJR8vx48s83aCyAOBBTIUR5fB/mvmG4M+cGlS7UT9s8PZkNB/PVO
         kPG/uTZuHWvex5Ye5VTeuLkKu3nHhE+fVC9S5RLYoYoAMz+jbHA4VhfS/9pNsR4FB5Pt
         YZfAh/Jem6WseoKjHnNybJa+PovLkwKF5i4b6Y7JEwfOD+HJLH4pid3AebpngP2w9kNf
         kRgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=exXuvrFNIGHAA7u+g/FtpDAoPZ0py7ftdAywAQoZvF0=;
        b=GC/aMfYsuYau1qX9VdKaPgVtLY1LD793hkP0QVONv5ZWEdUUnzJjqtdR2tv4yeHQll
         DeDsi88qO/6aV1IvxVB1LPHO5hMXHdFb61uKGu1/BccJFi+6pSw7762wmQnMmcchHLWJ
         lU3NmWMxMWbXeRRiBUQ76P+7kDpPtnO6vUt+khAP9tdjv/r/9lRviVKlOchZaPrws5ds
         WrQ5n9ej0DYcgXFTpQe+E9zxrrDma0D2oT5wnuH8qo/8lGqvIN82t1AFyvb81atb9DWP
         9DncxLj+NcEe98QwT/pqRedHCj4kjA7IlUASRs7hiqg0jnIt4Q5Sg53brxdip6+wp6GO
         Yr8g==
X-Gm-Message-State: AN3rC/6dlimkPnyGnoP0u5wlKEGgzKVZchJKV3Kc1oHUEpYj49fXBf5J
        mhJoZBfMpsGyBaj/CxNGxhxtXN5/4bl/
X-Received: by 10.84.231.206 with SMTP id g14mr647782pln.12.1492044625457;
 Wed, 12 Apr 2017 17:50:25 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.163.239 with HTTP; Wed, 12 Apr 2017 17:50:24 -0700 (PDT)
In-Reply-To: <CAEA2_RJfcOc6FD41FNzU9LYs2xfzGZJxQyb2x8txuQqUE8RtNQ@mail.gmail.com>
References: <1491442767-54068-1-git-send-email-bnmvco@gmail.com> <CAEA2_RJfcOc6FD41FNzU9LYs2xfzGZJxQyb2x8txuQqUE8RtNQ@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 12 Apr 2017 17:50:24 -0700
Message-ID: <CAGZ79kbTjVSRgWc5su89pL5t_mSEubjT_cQ0Onu4EdcKVmyL7w@mail.gmail.com>
Subject: Re: [PATCH v8 0/5] [GSoC] remove_subtree(): reimplement using iterators
To:     "Daniel Ferreira (theiostream)" <bnmvco@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Duy Nguyen <pclouds@gmail.com>,
        Michael Haggerty <mhagger@alum.mit.edu>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 12, 2017 at 5:06 PM, Daniel Ferreira (theiostream)
<bnmvco@gmail.com> wrote:
> Hey there! I'm sorry for bothering you, but any chance you might have
> overlooked this patch for a review?

Sort of. I read through them and found no issue back then, but did
not reply anticipating someone else would .

>  (I'm just not familiar with how
> long patches usually take to be reviewed, and since I always got an
> answer within two days of sending it I wondered if you may have just
> not noticed it.)

I reviewed it again and found just a very minor nit, no need for a resend
if that is the only nit.

Thanks,
Stefan
