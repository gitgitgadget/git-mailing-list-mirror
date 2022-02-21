Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45B75C433EF
	for <git@archiver.kernel.org>; Mon, 21 Feb 2022 02:35:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343888AbiBUCgT (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Feb 2022 21:36:19 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236377AbiBUCgT (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Feb 2022 21:36:19 -0500
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2062C3CA63
        for <git@vger.kernel.org>; Sun, 20 Feb 2022 18:35:57 -0800 (PST)
Received: by mail-io1-xd36.google.com with SMTP id d19so3854942ioc.8
        for <git@vger.kernel.org>; Sun, 20 Feb 2022 18:35:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZDaTvmppyc2wMBh96XyojGrxQvAKXrDwbW1DGNWWG0k=;
        b=bJMufWEV0GMxFcxOH75Pl87z9La5U4nPOXKjvAAeJf8mo+9nerSRHkFWHKo2sPbTaV
         T7xZRUgYpnvFcuNrXOaHj0700grpG+G6zeN7OXyzyIfW6TyKfFsFNbK7lBff+GpRzSxO
         N2dX2AMdJFYsBJLxnw50U4HRDfE2yhvmKmuFEnXH3gNsuXHbeZDF9fwqYXDwZ8d8ks++
         Yp/c90pf4WLn6Qlqr/Z+ORDP3FQkuZRKGCXamwBuiBor5fr7/WbbkWrPI5pYCxu92YUE
         8nuYa+ln5dzSPffo4OM1vSLgX+xTKG4UOO7GdTtAmAGbazfRm8Ko39D6yYLUolM3ppeN
         aUBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZDaTvmppyc2wMBh96XyojGrxQvAKXrDwbW1DGNWWG0k=;
        b=CJLXi0WU8DowebE02BR+slFDhHBeiA7CnGnGYu2QoZm0IKxMYBcx9yHPvY5K4sGwAK
         59lHA553OGs3LWh4kv4G1qv/AhoKgvvSXyh15HA81CuQsu7c1qRCijuV/EhnENgcEs1s
         /HINGVPT4a8xzaymguuKpNnChWdRjOKnb9g4kYU/eqtVOrtOep12GAnUT09YozAP9LCT
         bV341iF9U1mDYF9nDRO/+c6sYDxo6u9DkBfk9tfy5JnFqMT68KmvbnmLtW59XmJgWMUo
         58yVo0smQM3wj9JNaloPWu4chOcUMDFASfRVWWJPkiCLAIJNoKXGWwCIixa/Ef8aR44x
         SFGQ==
X-Gm-Message-State: AOAM531ZAcB9Km1Uw/BvmhTt3L+bA1vkDWmU5Hs1Hgby6QXVgA7XqfdC
        zNIgFtSa0iZGjUHI7sd3YFcvmhuMSAVPwGz1
X-Google-Smtp-Source: ABdhPJx9m7vY66/H9oQIEHEpIC/X2JUPvLoUwdVN71bXQxxpY7i9m1WI6Tx0dXhYX24dcEgkzqBx4g==
X-Received: by 2002:a05:6602:27cc:b0:5f0:876e:126b with SMTP id l12-20020a05660227cc00b005f0876e126bmr14508081ios.129.1645410956526;
        Sun, 20 Feb 2022 18:35:56 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id d16sm8853632iow.13.2022.02.20.18.35.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Feb 2022 18:35:56 -0800 (PST)
Date:   Sun, 20 Feb 2022 21:35:55 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2 1/2] merge-ort: fix small memory leak in
 detect_and_process_renames()
Message-ID: <YhL6i3x1l4qwQJg+@nand.local>
References: <pull.1152.git.1645290601.gitgitgadget@gmail.com>
 <pull.1152.v2.git.1645320591.gitgitgadget@gmail.com>
 <f1f7fc97fe2fe5079365bb91c71fb7033378995d.1645320592.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f1f7fc97fe2fe5079365bb91c71fb7033378995d.1645320592.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Feb 20, 2022 at 01:29:50AM +0000, Elijah Newren via GitGitGadget wrote:
>  merge-ort.c | 15 +++++----------
>  1 file changed, 5 insertions(+), 10 deletions(-)

Both versions of this patch look good to me (in fact, I appreciated
seeing both v1 and v2, since v1 makes it more obvious what is changing,
but v2 does the whole thing in a little bit of a cleaner way).

> diff --git a/merge-ort.c b/merge-ort.c
> index d85b1cd99e9..3d7f9feb6f7 100644
> --- a/merge-ort.c
> +++ b/merge-ort.c
> @@ -3086,12 +3086,11 @@ static int detect_and_process_renames(struct merge_options *opt,
>  				      struct tree *side1,
>  				      struct tree *side2)
>  {
> -	struct diff_queue_struct combined;
> +	struct diff_queue_struct combined = { 0 };
>  	struct rename_info *renames = &opt->priv->renames;
> -	int need_dir_renames, s, clean = 1;
> +	int need_dir_renames, s, i, clean = 1;

And this entire patch looks good to me, but I did wonder about why "i"
is an int here. Shouldn't it be a size_t instead? Looking at
diff_queue_struct's definition, both "alloc" and "nr" are signed ints,
when they should almost certainly be unsigned to avoid overflow.

Thanks,
Taylor
