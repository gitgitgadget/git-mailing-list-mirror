Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E92C61F404
	for <e@80x24.org>; Tue, 18 Sep 2018 05:51:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727227AbeIRLWw (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Sep 2018 07:22:52 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:40164 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726399AbeIRLWw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Sep 2018 07:22:52 -0400
Received: by mail-ed1-f66.google.com with SMTP id j62-v6so839777edd.7
        for <git@vger.kernel.org>; Mon, 17 Sep 2018 22:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=jyihK3b5sDpYOFHBqJ0Vgk4oNYen4SpY1X9DppLRDZQ=;
        b=OKZuuaqf7lwOLiQ6YzaHJ6aLP8JIntBJQOyjTPHArzssSpZ5cludpu1Itk9XunZFtZ
         8scvr9YayeV293GXLSWiuDV+3K2ArQRwBKcLh8Tt9oQTwImJpoJdZqjhmDAblMvF8ThW
         VCWamKcSLz7KhSnInVxdcyphtz6Q9tF8XjLglL4FlEm0HPS0Oigld4rDvplN7nO6GLHn
         exY8J0IBMQoolpwBWmLvmKmp0/RAP0kbdYcDFxwL0LyKsBw0QpWjzmV4ZmsvbASagv6N
         3NaTuZ+9fS+0w6k1+1vcWyq+wB0YX/wOsqQ8IFCmAat/Ckf4R14a3aTuU8+qVA9yU+Z9
         8bdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=jyihK3b5sDpYOFHBqJ0Vgk4oNYen4SpY1X9DppLRDZQ=;
        b=FQcbgdSzU0ockKktqkKEPqP2JxeVZVbHLlD9Sq4tdE4vF34DrN3+mn2LhNHTAvGLLr
         lSrKWPkSLTp0ZJ+PkFvT0wRfKpEX0qsZSOFzLaZnDabT1VfJFgcqS/kLn6KeAGTbTmAb
         52TP7+cYj04ij2kYMWA8JowFjKvF9uTq0mYDrmrJkoSpXPTd65v8dzsPnNy/Y7yBMg41
         PQHGBSpS/kZkEsAp29oDipGJlfCAop3pPjcF4tTcOiI8xSvK0T2MjO7ky4rsKuQgORVL
         zIv+g4eGv2xyJGeSYM89iuyHoDjojVxBw0A89zjMTVDaYS7Hs5LZqnZq7wgHKlDnNbF7
         rGtw==
X-Gm-Message-State: APzg51DHAa2hnaOeUJKkdgREpZb+5TdwwJsOJSKMKqcVsXPFqe6gux2K
        AY2MPcjIHza+bSdV8m6eM41n8zYEXTQ=
X-Google-Smtp-Source: ANB0VdYuJZRXPuj7xES7PRoFYX7qSgrNErdVLuDcRpwHSX+SZ1uXWadooChdl4hrOjYo5dRH8thG9g==
X-Received: by 2002:a50:af03:: with SMTP id g3-v6mr49653276edd.220.1537249911597;
        Mon, 17 Sep 2018 22:51:51 -0700 (PDT)
Received: from evledraar (157-157-127-103.dsl.dynamic.simnet.is. [157.157.127.103])
        by smtp.gmail.com with ESMTPSA id f26-v6sm7158731edb.28.2018.09.17.22.51.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Sep 2018 22:51:50 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v2 6/6] revision.c: refactor basic topo-order logic
References: <pull.25.git.gitgitgadget@gmail.com> <pull.25.v2.git.gitgitgadget@gmail.com> <3b185ac3b1cd54e0ffee8e5b42cc0ea3d1fac3c7.1537243720.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <3b185ac3b1cd54e0ffee8e5b42cc0ea3d1fac3c7.1537243720.git.gitgitgadget@gmail.com>
Date:   Tue, 18 Sep 2018 07:51:49 +0200
Message-ID: <87y3bzjqtm.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Sep 18 2018, Derrick Stolee via GitGitGadget wrote:

> diff --git a/revision.h b/revision.h
> index fd4154ff75..b20c16c0e0 100644
> --- a/revision.h
> +++ b/revision.h
> @@ -24,6 +24,8 @@
>  #define USER_GIVEN	(1u<<25) /* given directly by the user */
>  #define TRACK_LINEAR	(1u<<26)
>  #define ALL_REV_FLAGS	(((1u<<11)-1) | USER_GIVEN | TRACK_LINEAR)
> +#define TOPO_WALK_EXPLORED (1u<<27)
> +#define TOPO_WALK_INDEGREE (1u<<28)

Maybe lead with a commit to indent these bitfield defines so this change
doesn't end up making these two new flags (due to the length of the
name) misaligned.
