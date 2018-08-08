Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 872E31F405
	for <e@80x24.org>; Wed,  8 Aug 2018 18:51:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729687AbeHHVMN (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Aug 2018 17:12:13 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:39041 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729664AbeHHVMN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Aug 2018 17:12:13 -0400
Received: by mail-yw1-f67.google.com with SMTP id r184-v6so2327530ywg.6
        for <git@vger.kernel.org>; Wed, 08 Aug 2018 11:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UD2DnA/yW7QKzDihHK4/QP7jjS/8ZpRLLxsjSYUmjqs=;
        b=PhN3KyiYpRenSd7ZcW9CCA/LF6K3+JXy6O7j7FKCbBSkaHmrEv60in5P1gY/tX+yGm
         sXeIECPpGQ2AuhBjGB3YmEW/uxTpxTbK2DEOUx0vvtonS5gLVRTBKdHJrgsGqg+H6aag
         CHEdUNDe8aO+tod6AfK/xDSY/yJByXw8dD6TvyKuckattGr4xPDAhF1KKIkdIkmvF5IA
         46dUpvWD5+KsLEFvySEsw+LLZW+PPR8iw+khekxUP7PWJHCgYTrT4KWB/8PokKVjCBBP
         z+seCXriS3CMU+c1axYbTwGiA5RG0/rZnFy+Ymdxn35JUuPhUhYS0wDCvxaUlrmXXZnZ
         tZMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UD2DnA/yW7QKzDihHK4/QP7jjS/8ZpRLLxsjSYUmjqs=;
        b=oq40/BUQzlFWQrojQt6b/2dz7u3Z5jk47EC0hVnVCKZuE0ltatAR8qvU7XGK1UBZ25
         D1YNM+28HKag2Crh6JeIp4RRwW5Q0Vs0KC8ZbX3K9UKyWiOycXlkw1Vm30fR8PHMbzsy
         0Skv2YRz182f4EU5s7bbo7hMrnRb4oZu26W7qZjl8SKnKF1UYrS+692jKazbVK7rPGPj
         7WdpawX0o3/Tu8iSdO+hrMPApJGahbcu1csbgRyoe0dJUAnXkoIZDhCaDhig5DSVBX5s
         X6+VwJZtsRvNk5LiATr7B2ldBBJmrFrbhVAT8nCeD2eGmCheXDae1CZc6coGbWYvG2v8
         haAQ==
X-Gm-Message-State: AOUpUlHma4+feoeHNeflvHkXhs3CsthTtldRxwZv7mpAJPySBv3UlJ7U
        iZw2UiNk2BVnLrt1ypibSlbF/SdHyb0KxUxdzOORVQ==
X-Google-Smtp-Source: AA+uWPz9QVu3JEpJrIxLpuQjU1eJ5ZsGm9vSI4MKv8Uzk22/GFf4na04BFdMfBWDT/oI2IYYLShAtIjwr3jM7748QgY=
X-Received: by 2002:a25:3624:: with SMTP id d36-v6mr2119167yba.292.1533754273211;
 Wed, 08 Aug 2018 11:51:13 -0700 (PDT)
MIME-Version: 1.0
References: <20180808134830.19949-1-predatoramigo@gmail.com> <20180808134830.19949-9-predatoramigo@gmail.com>
In-Reply-To: <20180808134830.19949-9-predatoramigo@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 8 Aug 2018 11:51:01 -0700
Message-ID: <CAGZ79ka1uokeUzyZ37=o7J0Tu0k8P4fKj8hv8L-GpktU5i7+mQ@mail.gmail.com>
Subject: Re: [PATCH 08/11] builtin rebase: support --force-rebase
To:     Pratik Karki <predatoramigo@gmail.com>
Cc:     git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Alban Gruin <alban.gruin@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 8, 2018 at 6:51 AM Pratik Karki <predatoramigo@gmail.com> wrote:

> @@ -551,10 +560,21 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
[...]
>                         ; /* be quiet */
>                 else if (!strcmp(branch_name, "HEAD") &&
> -                       resolve_ref_unsafe("HEAD", 0, NULL, &flag))
> +                        resolve_ref_unsafe("HEAD", 0, NULL, &flag))

This line is changing only the indentation whitespace?
Would it make sense to have it in the previous patch?
