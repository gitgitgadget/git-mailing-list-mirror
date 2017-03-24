Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 639FC1FC19
	for <e@80x24.org>; Fri, 24 Mar 2017 22:42:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752856AbdCXWmM (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Mar 2017 18:42:12 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:36790 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752838AbdCXWmK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Mar 2017 18:42:10 -0400
Received: by mail-pg0-f67.google.com with SMTP id 81so598350pgh.3
        for <git@vger.kernel.org>; Fri, 24 Mar 2017 15:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tSRK79GC1dgP0JtbxnadB4Q0qXP0wNx2tnQSkhmrzgI=;
        b=XOQVfCBV+LBJfuHztP3v5pl06LFmTdCjQVREb+Dom+9BelWp2oJO/WQQDcrCzHHb03
         0RnsPFZ6ZKKmvCCyEmZDrUnA1s612XQBKH1nNbwX0xlKH1USaI9oyOJIBZaduYsL38F9
         YVMZLeenRY1I0BCcx176u4j2AjL9FqfraK9mcqm1DQuKZBqcVkgke8xFBGqGinVCTKW2
         TkSVnQZxyGAYvpnKsU9MU97ukvPFsBFtLQJ/Whw3kY2Nwv5ZUziDxXmmyAUZGVqpn9Rm
         MUrKiNp6VBpF1yGFRqmai3WECvxL9RTUy+jQzPyzG/6YdvpUGPAONkK2YjyYMuYOjY78
         RaQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tSRK79GC1dgP0JtbxnadB4Q0qXP0wNx2tnQSkhmrzgI=;
        b=PMiM/Tu6BTNGeQm+au+VFDWMCDaI/9QpWhtrGbMljryZzFGPe/yeH/3R9EhDo8CPEs
         NZ5zri3V6HnvbVvcCMZCOXQTMkYz9LGHiCoStAJOmvthRcRaT4Vr/4lgbh5hufWaE4Pq
         MwtnCXBhr7rYdxAo1tN301t4kyQEhQAdx4m8JneY1Gh6l6FiKFojzsNyy+n92aqlcO08
         EzrGiSGlWlx5AJIqZlYiJ3L35RGrgXAQFDwwGcf6C0hz1aOLyaRvWPxDSrA9UKmbv+BG
         lih59JJnV0EXJVzp1tiwJIOj2Gvnyn1iY7vDh/LidcctqMQ3fOuGd0BlwHU5aqnw1+Va
         uOrg==
X-Gm-Message-State: AFeK/H1PEldXKEshkeMFbs2I5GlUzgRJ2aXn1wuM/q4c7BRn9I374tg8zDzgLYV/euvdAQ==
X-Received: by 10.98.66.155 with SMTP id h27mr11685987pfd.182.1490395329449;
        Fri, 24 Mar 2017 15:42:09 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:1000:5b10:8597:ae41:db75:6a97])
        by smtp.gmail.com with ESMTPSA id y70sm6551689pfa.96.2017.03.24.15.42.08
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 24 Mar 2017 15:42:08 -0700 (PDT)
Date:   Fri, 24 Mar 2017 15:42:07 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     gitster@pobox.com, git@vger.kernel.org
Subject: Re: [PATCH 5/7] submodule.c: stricter checking for submodules in
 is_submodule_modified
Message-ID: <20170324224207.GJ31294@aiede.mtv.corp.google.com>
References: <20170323223338.32274-7-sbeller@google.com>
 <20170324182902.19280-1-sbeller@google.com>
 <20170324182902.19280-6-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170324182902.19280-6-sbeller@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller wrote:

> By having a stricter check in the superproject we catch errors earlier,
> instead of spawning a child process to tell us.
> 
> Signed-off-by: Stefan Beller <sbeller@google.com>
> Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Yep. :)
