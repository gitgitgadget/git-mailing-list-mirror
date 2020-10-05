Return-Path: <SRS0=R7wA=DM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C4BCC4363A
	for <git@archiver.kernel.org>; Mon,  5 Oct 2020 23:27:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 04BE0204EC
	for <git@archiver.kernel.org>; Mon,  5 Oct 2020 23:27:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="krbk9j8r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727029AbgJEX1U (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Oct 2020 19:27:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725973AbgJEX1T (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Oct 2020 19:27:19 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BAD4C0613CE
        for <git@vger.kernel.org>; Mon,  5 Oct 2020 16:27:17 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id d23so287050pll.7
        for <git@vger.kernel.org>; Mon, 05 Oct 2020 16:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3eTnnt4S1FzTxq1CCbNR3TM4eS589urjia4/Dg6O75o=;
        b=krbk9j8ryIlO2el0rFsmpGdCHPyeMdcexM3c8vlKUJit1hxq0zL/XYBJ5S5zXEpkKs
         mPBPOS9puXHwSOU2yRkwEknPuzB7F7b7h830hHb8o77PtbMpoe8CZ9L4bCGe2QGwikb4
         1ttjdNz/BMJAeuFlSxtqaSu2/runAo5Rvq/0FxZ+sK+lAkgQs0iEVFcFIA+srajyITvU
         nfpY7mEP+0DJClyznzjCvSatTDurIGszqpZGlWkMjjvQFjfUqX6C2MQOkeV+p2UhhA8R
         P6UAYOi4lhRrTJUkrEft2/tnKsC/smOx6jcwjJH3NV39j/nU2OEdWirj6JEICGe0SATi
         Kyug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3eTnnt4S1FzTxq1CCbNR3TM4eS589urjia4/Dg6O75o=;
        b=Zt2SKCtLC5Nt+s9H/xVuWNoxBqpxhDv+67tkqX7XHtiB+0AiGbIMcwTF41y0NL5vHB
         YxxNwpj0R9gaWP6DauO2Dtu0TbA69IX+8NbbQtXOjxPi0oxfftSHwxt7V3RngpCLmBxE
         xKBDRLF1j1Ov2XQ4Ln+PA6TDCeDOdZR9rZ3syq5mlhxj1OQtu5U1QBX25egbe0SVckxa
         hFk6aIneOGn1IW5mu6FWyHAaIna93CTrhMZJ7iU492XXmpzcKjq+j5oKA0aTfCfjHXOw
         0vchitVSO38I721Hu/1rURvws8LXkNNbLbiD+lw7VKDJDLXQzJbUYBUf4dpJN0mchAI+
         1Jwg==
X-Gm-Message-State: AOAM533IRy0u2yn2CQhgd+xW3lcCn+4nVE8Kp7+QmaeBJauGlqrsHHxv
        O7pLbbuQbwSGOOEjGDdw4cc=
X-Google-Smtp-Source: ABdhPJxnvVI+hYzGe/ewbF7xREWs3ZlMs+rBz61AKkyvDvhMLJVsVuZNZglekRKIr0mwvE44yNcqlw==
X-Received: by 2002:a17:902:8543:b029:d3:9c44:7230 with SMTP id d3-20020a1709028543b02900d39c447230mr730597plo.10.1601940437126;
        Mon, 05 Oct 2020 16:27:17 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:a28c:fdff:fee1:cedb])
        by smtp.gmail.com with ESMTPSA id j6sm1030000pfi.129.2020.10.05.16.27.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2020 16:27:16 -0700 (PDT)
Date:   Mon, 5 Oct 2020 16:27:14 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v4 3/9] hook: add list command
Message-ID: <20201005232714.GB1393696@google.com>
References: <20200909004939.1942347-1-emilyshaffer@google.com>
 <20200909004939.1942347-4-emilyshaffer@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200909004939.1942347-4-emilyshaffer@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer wrote:

> --- a/Documentation/git-hook.txt
> +++ b/Documentation/git-hook.txt
> @@ -8,12 +8,47 @@ git-hook - Manage configured hooks
[...]
> +COMMANDS
> +--------
> +
> +list <hook-name>::
> +
> +List the hooks which have been configured for <hook-name>. Hooks appear
> +in the order they should be run, and note the config scope where the relevant
> +`hook.<hook-name>.command` was specified, not the `hookcmd` (if applicable).

A little bit of futureproofing: this may want to mention that the
output is intended to be human-readable and is subject to change over
time (scripters beware!).

Thanks,
Jonathan
