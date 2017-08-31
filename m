Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 61303208CD
	for <e@80x24.org>; Thu, 31 Aug 2017 18:06:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751422AbdHaSF7 (ORCPT <rfc822;e@80x24.org>);
        Thu, 31 Aug 2017 14:05:59 -0400
Received: from mail-yw0-f172.google.com ([209.85.161.172]:35413 "EHLO
        mail-yw0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750908AbdHaSF5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Aug 2017 14:05:57 -0400
Received: by mail-yw0-f172.google.com with SMTP id s187so1963121ywf.2
        for <git@vger.kernel.org>; Thu, 31 Aug 2017 11:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=EJxVY+29WGbOfPttxgiUinU/c72SQ/oSzJuUyWB8ZZI=;
        b=YYiDMKJzzBp3tsgNEAvZOPb/zVdEXMmypkL3GvO6h0TOeBIMFFxuLIPtVZd6Jg4G6N
         MhAJbhG0Dss50Nj+1QMZBdtiAbMkYJofXagxn3iOyevtuqUzvZ/IhQgRwgtPtEqNEK3z
         wZZZP31dEbrqs0NqOJVoCS22TN7BoIm9ezzSmp2l25SY3ghoj60RxKL+bm49BeggdgPi
         36KU1fUS5u22Oz7skqosRnNRJwdNzkOcpNie1sYxgeOUAhD6u6qWhLjaDtBl5UI2vslM
         wNUOxW7ZdkXM6UJvAFjBIpqXGKX4KAimeSI3dVWhH3iqtilIYEruLMyeq5JvtNIupa6K
         mGgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=EJxVY+29WGbOfPttxgiUinU/c72SQ/oSzJuUyWB8ZZI=;
        b=jvXV4rX2eh/Cw/qWI3jJJolLRZ9janrtzeEd0m0t4x4VBqZzHQlf0fagbgQnQux4v6
         DCcSF6El8WLh+onpPLtJXVrUUVtB5JGi98llAcnVupCYk2ZPbns4dgfK1EVwexn/TCxY
         YQg0tSrOEnEAr6dH0/nuDUNM4vhZVi/7BZn1EeqM5F7RF5vtzMWEjHMUIu/Q7Sme5rfF
         3KmZsr273jOxG9/ozIZLgZJkPrp1fK66zBJPdYZ2D8HUuZ0lXZF7EHGvx9DsRrGS9ZHB
         WMxNzUEm3aR6L4oor4F0WgvuoZCTQ/H7e8jYZ9yMWJ61daHJLqhJY2B6+LsBpIsogT0Q
         EGuA==
X-Gm-Message-State: AHYfb5hcYU9+OcB+lbJROeNU0Goe2AI7Nyw5o9gjhrrHXEqfPSjVKKv4
        1jy8Rt+14D1D0s4836oZF+8RMHLU+CiouBo=
X-Google-Smtp-Source: ADKCNb4bTSzfKaCXVMGbNIZIXnjUvLds1sl3ReLkhkt+CXxKzQsZRpg4e+N1eZNiEN+psaeJAYUEPN1ZbeEw9sSQiA8=
X-Received: by 10.129.79.196 with SMTP id d187mr5315681ywb.29.1504202756333;
 Thu, 31 Aug 2017 11:05:56 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.116.21 with HTTP; Thu, 31 Aug 2017 11:05:55 -0700 (PDT)
In-Reply-To: <20170830175005.20756-1-l.s.r@web.de>
References: <20170830175005.20756-1-l.s.r@web.de>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 31 Aug 2017 11:05:55 -0700
Message-ID: <CAGZ79kYfk6p+pQuCgriSHMVjZp8m8cv2wCF-c-sApDwYyd-saw@mail.gmail.com>
Subject: Re: [PATCH 00/34] plug strbuf memory leaks
To:     Rene Scharfe <l.s.r@web.de>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 30, 2017 at 10:49 AM, Rene Scharfe <l.s.r@web.de> wrote:
> Release allocated strbufs in functions that are at least potentionally
> library-like; cmd_*() functions are out of scope because the process
> ends with them and the OS cleans up for us anyway.  The patches are
> split by function and were generated with --function-context for easier
> reviewing.

Thanks for this series! All patches look good to me.
Stefan
