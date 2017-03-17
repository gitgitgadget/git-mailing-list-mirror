Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1720120951
	for <e@80x24.org>; Fri, 17 Mar 2017 23:00:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751087AbdCQXAb (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Mar 2017 19:00:31 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:36450 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751047AbdCQXAa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Mar 2017 19:00:30 -0400
Received: by mail-pg0-f66.google.com with SMTP id 81so3646796pgh.3
        for <git@vger.kernel.org>; Fri, 17 Mar 2017 16:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8JzJQEcko/orIMEJd3kf558CqUhwD4tWlAQVAZQFqrs=;
        b=NiTgTVCK7puLjuF/n1H1MoeYXYZKjfdcXqzIcWQOuecZrf4dkhcf1sOcltI0gGpgjB
         WeZM430b81R0xfn8/q3c2kjn/MZtJLLBZ342HZPwJ91d43PrYP8T6zpdS3bplTbv8y4O
         BE52bV1FYZYALzME+uTNX5M011G4IsRB1nl0/mDhQ6mDMHU7+X/ABjS5MrLr1b2xJ0De
         VnDr/eM1/s3mfyOsiwWHbvpf5k7wFTjXMhZfy/BxwUXAyUiQGQc2dZhLzQTYSUA21pzP
         77tNtZcfJ/3dFffvnXQe0jhQhrXGTo2a4wuEgrHkDXFJ2B4TfuCyZKxMqQPg+gyMrYnn
         uhDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8JzJQEcko/orIMEJd3kf558CqUhwD4tWlAQVAZQFqrs=;
        b=ZHCIB2EVTrDzKC4v5OcyhznqcNgqcLPd7neAdbuyVDkVLaxBSn5X8hIbUSHmceXFmG
         1lyRE9V0xX7LtjdIhxzqzyYZ9Py1oZSvwRPUykp5bakUWL4y+l1D2L16GQDMOX4zaWs1
         a5yPo+ncw5T4MwpVB1jsE5m/Z9uUrMZYi4WzwPkGXYNmSiPVfTtYvPpxzJRtm5ay604Q
         subT2oceC85JuDY7r7C70UKYYpe7QWzN8YkhP00LbFvr/qDTs3c8RbLvy18kmkqByN8p
         zJvADJL2/nSNY8UbnrjjSQ7UUs3BC6RLT338T+3KXRTTfP4kNCuv9xg7ozeSNYSsiDha
         3yeA==
X-Gm-Message-State: AFeK/H3HNG4nU3fEg4BndzyNXRY7rrSsSG7Fx9oBv7vfVIHTCV6tPb0t4KEVlcsq9sxPjw==
X-Received: by 10.84.212.136 with SMTP id e8mr23366848pli.140.1489791603397;
        Fri, 17 Mar 2017 16:00:03 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:1000:5b10:cc9f:ca23:5f26:6394])
        by smtp.gmail.com with ESMTPSA id g29sm18768629pfg.37.2017.03.17.16.00.02
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 17 Mar 2017 16:00:02 -0700 (PDT)
Date:   Fri, 17 Mar 2017 16:00:00 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, rahul.bedarkar@imgtec.com
Subject: Re: [PATCH 2/2] grep: fix builds with with no thread support
Message-ID: <20170317230000.GS26789@aiede.mtv.corp.google.com>
References: <20170317182403.GA110341@google.com>
 <20170317184155.128674-1-bmwill@google.com>
 <20170317184155.128674-2-bmwill@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170317184155.128674-2-bmwill@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams wrote:

> Commit 0281e487fd91 ("grep: optionally recurse into submodules")
> added functions grep_submodule() and grep_submodule_launch() which
> uses "struct work_item" which is defined only when thread support

nit: which use (s/uses/use/)

> is available.
[...]
> Reported-by: Rahul Bedarkar <rahul.bedarkar@imgtec.com>
> Signed-off-by: Brandon Williams <bmwill@google.com>
> ---
>  builtin/grep.c | 21 +++++++++------------
>  1 file changed, 9 insertions(+), 12 deletions(-)

With or without that commit message tweak,
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks.
