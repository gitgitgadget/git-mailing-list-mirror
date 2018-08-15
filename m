Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6B4791F404
	for <e@80x24.org>; Wed, 15 Aug 2018 13:28:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729289AbeHOQU6 (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Aug 2018 12:20:58 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:35008 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729128AbeHOQU6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Aug 2018 12:20:58 -0400
Received: by mail-qk0-f193.google.com with SMTP id u21-v6so727640qku.2
        for <git@vger.kernel.org>; Wed, 15 Aug 2018 06:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=kHQnUeCdlTwXHr+A8kpbPVhWlyw2zF06cUGCxaZj6go=;
        b=T60AwQvW18catRIhFy3Ni7b5qSOEImuOi7Lkkd/BkroQOEszZmYRCkf6ytDcQef7lO
         clUBM9t7m5qq9h2fvD+D2cdRJz1eHXiLybS+BPG1/3MWd6DFLbp9jjRXad+7z/Qz/Dih
         046H1JJ35i5zsjZ2NZfRr1fHzG3NjaGmlRZCQ8ZMsTL7TDl20diKC2lqXePuO3hP6+Zu
         xECEH97LOzUga0D5tepEqw/eRnXBiPDrGXmMa21olqIzXfDFQZRpJ3+vgS0nlvyjRAu8
         q9kvZXVdNIu3VlozY+IR+lhKT12fXf4gxRjckP9fZGP9JnO85NmjCNK9LHs6OiY737yu
         ESpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=kHQnUeCdlTwXHr+A8kpbPVhWlyw2zF06cUGCxaZj6go=;
        b=IuLi3Ffm3N8DCaqPZPgrke+by/LsLPb23I2WJOEZI5DhDd+ZO3kwTBefwzbSTR+NET
         7gnwqStzkYYlyoGxo6Iahz5i+DocvjGkW8tlVA28EGzpjVRm3TDiv+TptbOLsPfaGRhk
         DJE0WCzJp79sY/BFHfYJNIwRwUYoOQFwqc/++LZohD8lJndWgX7fJaOxkCbuvYl4I2Ph
         17kEN0/dqZpMfbBUsyD0EHABqA/aVJOv5J/36RSAqItTKtZl0AzoYpGI9kpW05wPMr+V
         qv6Ps6PolANOGiIUL7OjIfUEArmYWLwkQmLzsAPWilsdyXWQ/ZG9eahdhwcGXA/OYc2i
         fBbw==
X-Gm-Message-State: AOUpUlF1TIBm0oykbChkI96CEEvcbB2zPLRx1p5ICWLQTHvy6t6PN90p
        JVqNiUKL6sd1/R46F+w4OhE=
X-Google-Smtp-Source: AA+uWPxwyOCCLF1HafOKh6UqhBlvuqh9BzWX7LJeSzVm0+ikpaQ0T8TQYZnQjEJbVHv2ZvKTHKKUUQ==
X-Received: by 2002:a37:b446:: with SMTP id d67-v6mr24039820qkf.104.1534339726790;
        Wed, 15 Aug 2018 06:28:46 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:6962:3b9:979a:51c3? ([2001:4898:8010:0:5298:3b9:979a:51c3])
        by smtp.gmail.com with ESMTPSA id c138-v6sm12775483qkg.79.2018.08.15.06.28.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Aug 2018 06:28:46 -0700 (PDT)
Subject: Re: [PATCH 4/7] for_each_packed_object: support iterating in
 pack-order
To:     Jeff King <peff@peff.net>, git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
References: <20180810230729.GA19090@sigill.intra.peff.net>
 <20180810231549.GD19875@sigill.intra.peff.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <2ac79ea0-dd58-965d-1158-d08a7731e25d@gmail.com>
Date:   Wed, 15 Aug 2018 09:28:44 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180810231549.GD19875@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/10/2018 7:15 PM, Jeff King wrote:
> diff --git a/commit-graph.c b/commit-graph.c
> index b0a55ad128..69a0d1c203 100644
> --- a/commit-graph.c
> +++ b/commit-graph.c
> @@ -730,7 +730,7 @@ void write_commit_graph(const char *obj_dir,
>   				die("error adding pack %s", packname.buf);
>   			if (open_pack_index(p))
>   				die("error opening index for %s", packname.buf);
> -			for_each_object_in_pack(p, add_packed_commits, &oids);
> +			for_each_object_in_pack(p, add_packed_commits, &oids, 0);
>   			close_pack(p);
>   		}

This use in write_commit_graph() is actually a good candidate for 
pack-order, since we are checking each object to see if it is a commit. 
This is only used when running `git commit-graph write --stdin-packs`, 
which is how VFS for Git maintains the commit-graph.

I have a note to run performance tests on this case and follow up with a 
change on top of this series that adds the FOR_EACH_OBJECT_PACK_ORDER flag.

Thanks,

-Stolee

