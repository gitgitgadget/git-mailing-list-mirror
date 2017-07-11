Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4D8C02035A
	for <e@80x24.org>; Tue, 11 Jul 2017 23:51:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756119AbdGKXvV (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Jul 2017 19:51:21 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:33737 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755886AbdGKXvU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jul 2017 19:51:20 -0400
Received: by mail-pf0-f195.google.com with SMTP id e199so861925pfh.0
        for <git@vger.kernel.org>; Tue, 11 Jul 2017 16:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Ki48SMjgQRdJ+mLiO3FBsFhV1vvhUPvwyOlpIYsjLWg=;
        b=DqLOpWcYym0PIB8n0l9VTl7uz7OJtzV7mwPwZWX42cL7gO1G5+7nvzw6e5ifnOzQSU
         PA4T933LeVciVbEy/6ckOMXGODMWUhVY8sAPNXVTbF4ow7LygFv6Inj2xUoOvpyZUsoc
         30UmmYqqAzqjfJMXrgiAlk97m7NvKOBEIoTC2gTGgWPhVO5gFRf2FMNMagxA4R7CSk67
         9cbSp5aP8c2Qv16Re6H1PWmMrOdOpqsu/Mb/zs/dAIKb06f68yBiln28KTU/BMnPJmaH
         rPPP8oSoCw4C4m2qc2eg6965gGYYJXFyAbAWWHBiqFANXc3N7nyXMvGhpqusnCp+8ZlD
         JFgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ki48SMjgQRdJ+mLiO3FBsFhV1vvhUPvwyOlpIYsjLWg=;
        b=BWY+URLaYP4eKMFWhy27Ed2UupcbgLdELBggBydS0XzCsCkx+9DJbFJuwXtgG/wLSJ
         2x8sPkR/FoGCyaIOBE2Hhn/sioGWtoOjughxs/GCpvydLg3ZmlyVVPvxUQ9/5Ne+ngmr
         OEztXeGIjpFVDEHlkOuysT1lgngcLet4SHJ7F9l7zIre4EerahNvEwIGfEobnDfJlGl3
         zNFuosW3i6tOWUFs8rhkFApMtqIqoeESBKj0bEy3Fd9KaiSparG3TOgCmWLje7de3M8x
         k0uNgzZ9LAZCFlK2oD/XWd5d4sD4q1BUGTTZ2YahYVvsQrVNYDBkEmGATS17+qXqDXJZ
         gBgA==
X-Gm-Message-State: AIVw111jnwc2vPLg4IPeZd3/m9+7boX7ItECShdBTBENxKUux1w5GhKJ
        U5vozIqzOpjJwoOd/tQ=
X-Received: by 10.99.95.147 with SMTP id t141mr919435pgb.263.1499817079898;
        Tue, 11 Jul 2017 16:51:19 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:402:114c:7a1:940:72cc])
        by smtp.gmail.com with ESMTPSA id l4sm735516pgr.21.2017.07.11.16.51.18
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 11 Jul 2017 16:51:18 -0700 (PDT)
Date:   Tue, 11 Jul 2017 16:51:16 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, sbeller@google.com
Subject: Re: [PATCH 1/3] repo_read_index: don't discard the index
Message-ID: <20170711235116.GB93855@aiede.mtv.corp.google.com>
References: <20170711220408.173269-1-bmwill@google.com>
 <20170711220408.173269-2-bmwill@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170711220408.173269-2-bmwill@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams wrote:

> Have 'repo_read_index()' behave more like the other read_index family of
> functions and don't discard the index if it has already been populated.
>
> Signed-off-by: Brandon Williams <bmwill@google.com>
> ---
>  repository.c | 2 --
>  1 file changed, 2 deletions(-)

How did you discover this?  E.g. was it from code inspection or does
this make the function more convenient to use for some kinds of callers?

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
