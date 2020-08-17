Return-Path: <SRS0=R55k=B3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72EE6C433DF
	for <git@archiver.kernel.org>; Mon, 17 Aug 2020 13:22:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 48D102075B
	for <git@archiver.kernel.org>; Mon, 17 Aug 2020 13:22:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XytbWfq0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728421AbgHQNWy (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Aug 2020 09:22:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728274AbgHQNWx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Aug 2020 09:22:53 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD271C061389
        for <git@vger.kernel.org>; Mon, 17 Aug 2020 06:22:52 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id w2so7704152qvh.12
        for <git@vger.kernel.org>; Mon, 17 Aug 2020 06:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HS/bGMx8Rdqto/aWN4LX3DfwwXJk3h+p4ZRykHu7Kds=;
        b=XytbWfq0qECSfKltQaIFGT5G/PSdadlzFPWjOPKvyQsSoQFc9fFOSiNlWXaEQ/9JyE
         G8oJqd3AVLmWPQKT8Mpd/irLDTh5x/A2N1YvT9vSiSJDu36YVnHq4Ve0wJ4pTkTM9WKT
         qZQyoKB7xSCme1+KaSb1YjSiKNoA5JMzGMu2ob92TaIgu1piW6/Oo/PJ+ZAT8IRtShnt
         ilHCTBJDZM1VteyooepN7wouACfmUNR00XxxwQ9Pu3+ZTG120PhigoUl3Mf9ao+FVmMz
         +8BdbKVoLwEEqAd3fF8PUco1jJRXBTXZ6d51UnaRPLhXuupqHQGFuXDwu6H+sQR0OUEJ
         PeRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HS/bGMx8Rdqto/aWN4LX3DfwwXJk3h+p4ZRykHu7Kds=;
        b=jvtjchfeR+hphmlNuXQN4TY/lNlL44ZNH658RLw+lC+DPNiEAIXqetEK924DSVqW+P
         9afZ/v7paeF5X622pdQYV7O5B7+3RriAdrUE3iTsHjaZEjaiF4rz/bBXPy1+JL2ke7xD
         blbqpNUaAKzCdapwmgGmDFUsoGnOPnMt2l73jvY4nfwYmxDi86Q+j2Dp0hVy0irYOI6x
         TlJwh/Dp3phCd7X43SberEtBzsKyUJxK7r5wptS4OWBnZCoxOjzqJW7T+yfnmmST2chq
         9YCVlyK5sPdb7wmUKGJZZQBFwrRrdDBnv9hxP8S7+JGtVY2jniFJz46qboLWO61P++Kl
         heyg==
X-Gm-Message-State: AOAM531WGyoor1EedabyWRKJj3gBgWQ8xLbqKXF9YIu5BG2aoyrEHl7h
        sfpdjo9ZQrLRHUNgX76kocmyFncvISYFLw==
X-Google-Smtp-Source: ABdhPJwgKuWw4N83Hz5w8Q1JbPHSoMLC5PY37x5cHFav20ZFCzWejY+U0EXk5/o/C07qV2vyqhd2aw==
X-Received: by 2002:a0c:f9cd:: with SMTP id j13mr14062308qvo.227.1597670568449;
        Mon, 17 Aug 2020 06:22:48 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:28bb:588:e45a:f44b? ([2600:1700:e72:80a0:28bb:588:e45a:f44b])
        by smtp.gmail.com with ESMTPSA id s30sm19987924qtc.87.2020.08.17.06.22.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Aug 2020 06:22:47 -0700 (PDT)
Subject: Re: [PATCH v3 04/11] commit-graph: consolidate compare_commits_by_gen
To:     Abhishek Kumar via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>,
        Taylor Blau <me@ttaylor.com>,
        Abhishek Kumar <abhishekkumar8222@gmail.com>
References: <pull.676.v2.git.1596941624.gitgitgadget@gmail.com>
 <pull.676.v3.git.1597509583.gitgitgadget@gmail.com>
 <6a0cde983d9ed20f043a4977313d714154602012.1597509583.git.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <79ab9d8c-9767-430a-9744-01fa81bdf9bc@gmail.com>
Date:   Mon, 17 Aug 2020 09:22:46 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:80.0) Gecko/20100101
 Thunderbird/80.0
MIME-Version: 1.0
In-Reply-To: <6a0cde983d9ed20f043a4977313d714154602012.1597509583.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/15/2020 12:39 PM, Abhishek Kumar via GitGitGadget wrote:
> From: Abhishek Kumar <abhishekkumar8222@gmail.com>
> 
> Comparing commits by generation has been independently defined twice, in
> commit-reach and commit. Let's simplify the implementation by moving
> compare_commits_by_gen() to commit-graph.
> 
> Signed-off-by: Abhishek Kumar <abhishekkumar8222@gmail.com>
> Reviewed-by: Taylor Blau <me@ttaylorr.com>
> Signed-off-by: Abhishek Kumar <abhishekkumar8222@gmail.com>

Whoops! Be sure to add the "Reviewed-by: above the "Signed-off-by" line(s)
so re-signing off doesn't add a duplicate like this.

Thanks,
-Stolee
