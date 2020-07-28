Return-Path: <SRS0=DRt7=BH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F2A7C433E4
	for <git@archiver.kernel.org>; Tue, 28 Jul 2020 13:00:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9BAA20663
	for <git@archiver.kernel.org>; Tue, 28 Jul 2020 13:00:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p1oDEeh9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729844AbgG1NAz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jul 2020 09:00:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728990AbgG1NAy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jul 2020 09:00:54 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CC6AC061794
        for <git@vger.kernel.org>; Tue, 28 Jul 2020 06:00:54 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id l64so11672611qkb.8
        for <git@vger.kernel.org>; Tue, 28 Jul 2020 06:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=lReq0E1uOEGMEx2ujVbSoNyGvK0LBKuEK4/aYAG1zaM=;
        b=p1oDEeh9N0cTbEfoN9j+sslrQM6WtwU4TTn58F9Ap7Eu/FeMOqjWsNrZuBHIqC7yz/
         3e3+Os6FPsWOtDxkfUM9pAmoy44UVNSZj2vQUqhq9DxgLDJTFsxPXEJJKnFDcxffE5pf
         TA835BK6VO/h04RhtlBpf1H7azD4Nhs6sLJ/Z7iw4dS/luSZTm2TBDIFAobI9aVU3oea
         /ldbTd1drWvgLS7wdzxEKyduS15CeKYvijLuMWgnidD+zoygt/TSjVpUd75jr0+ZfCUR
         6xuwsjMMRU89Q+nD97pvU+IKQnrpdDuDtCONiFxLmThvCVC0VEahayagr9djyBU944om
         TRGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lReq0E1uOEGMEx2ujVbSoNyGvK0LBKuEK4/aYAG1zaM=;
        b=dZ70Vc0UPdBcySHOknxK8A4xE0vERhKYgkS+YOnEGsyG+Fi4PJaFxFoxZ1oFSIfFzF
         NYziA4AYjDCIisAZj8wbLI+IlexoiyUkW1AbBxEbJATEOlLi4KoqP6LWdsQvcSTw4rqz
         vHH8SBexHnPUi+ZhN4uUZn8xoD6Mta6ueRI9gNnRvehJDKovXXVSHVzlIJsPhfzfboAz
         l9oFllU9KcB+rsMotNtKP5C7fA82R1LqY5nxuc4Cj/cbWerMPxSN3eghVsqTTAd00ptR
         musHJ6143DSNYecRYAs2lYjTbLa5stR0U3DmfzpNPnzZtjLybBg8RtIoiVjkYeoQ3biw
         zv9g==
X-Gm-Message-State: AOAM530ytsv6UgGxWyPPOJob9lLO5oIYDMAXreL7dbPEmlSYTrBbC0Mg
        0e9dheI6xyJ4sXOhDFf28LY=
X-Google-Smtp-Source: ABdhPJxycj/SwkVsgeQZIwT1Z2/Nl6pm25BKehXO6X576IWzJITuNqokN5Bov0J2Xg7XlXFdkBS8+g==
X-Received: by 2002:a05:620a:2150:: with SMTP id m16mr28209342qkm.500.1595941253780;
        Tue, 28 Jul 2020 06:00:53 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:d015:5ac6:e959:4f4? ([2600:1700:e72:80a0:d015:5ac6:e959:4f4])
        by smtp.gmail.com with ESMTPSA id h124sm23391132qkd.84.2020.07.28.06.00.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jul 2020 06:00:52 -0700 (PDT)
Subject: Re: [PATCH 2/6] revision: parse parent in indegree_walk_step()
To:     Abhishek Kumar via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail>,
        =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>,
        Abhishek Kumar <abhishekkumar8222@gmail.com>
References: <pull.676.git.1595927632.gitgitgadget@gmail.com>
 <d23f67dc80b85abe4eba9a9dfc39d50188e23bb7.1595927632.git.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <b997b649-cfeb-4b55-9c83-1c0ee2a5677c@gmail.com>
Date:   Tue, 28 Jul 2020 09:00:51 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:79.0) Gecko/20100101
 Thunderbird/79.0
MIME-Version: 1.0
In-Reply-To: <d23f67dc80b85abe4eba9a9dfc39d50188e23bb7.1595927632.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/28/2020 5:13 AM, Abhishek Kumar via GitGitGadget wrote:
> From: Abhishek Kumar <abhishekkumar8222@gmail.com>
> 
> In indegree_walk_step(), we add unvisited parents to the indegree queue.
> However, parents are not guaranteed to be parsed. As the indegree queue
> sorts by generation number, let's parse parents before inserting them to
> ensure the correct priority order.

You mentioned this in your blog post. I'm sorry that such a small
issue caused you pain. Perhaps you could summarize a little bit of
how that investigation led you to find this issue?

Question: is this something that is only necessary when we change
the generation number, or is it something that is only _exposed_
by the test suite when we change the generation number? It seems that
it is likely to be an existing bug, but it might be hard to expose
in a test case.

> Signed-off-by: Abhishek Kumar <abhishekkumar8222@gmail.com>
> ---
>  revision.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/revision.c b/revision.c
> index 6aa7f4f567..23287d26c3 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -3343,6 +3343,9 @@ static void indegree_walk_step(struct rev_info *revs)
>  		struct commit *parent = p->item;
>  		int *pi = indegree_slab_at(&info->indegree, parent);
>  
> +		if (parse_commit_gently(parent, 1) < 0)
> +			return ;

Drop the extra space.

Thanks,
-Stolee
