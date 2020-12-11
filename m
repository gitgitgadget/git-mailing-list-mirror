Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C69FC4361B
	for <git@archiver.kernel.org>; Fri, 11 Dec 2020 03:02:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ECC4F23C82
	for <git@archiver.kernel.org>; Fri, 11 Dec 2020 03:02:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404953AbgLKDB6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Dec 2020 22:01:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404635AbgLKDBb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Dec 2020 22:01:31 -0500
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96915C0613CF
        for <git@vger.kernel.org>; Thu, 10 Dec 2020 19:00:51 -0800 (PST)
Received: by mail-qt1-x843.google.com with SMTP id b9so5504312qtr.2
        for <git@vger.kernel.org>; Thu, 10 Dec 2020 19:00:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xnAj6P36mRFrOKlNFGBIp59D8zj41WyOisgqN/6E1gQ=;
        b=Gl9QI9sE73Hub3GGL5GHCwqujxktsRwiSHWKJxmft2NAeTRxo4CXmtI8/3sLmkmnfW
         00Hea5ZrZfjHeXm0AYy9w0Mi01KxxIC8gaAvNK+YLu/QqIyhJc1Pbg3o8SMhw6zZB+Rp
         XQGh8NHg3s27j1o19XcZpOWsnww1y6j+OAe5CXlhDvbIWR2FAxyFpx63Ic6pfSNNwKC6
         20oagtLgxP4uqy48v4X1NRTu9C5rbaAqEEejjm2mwv4Kfh9jmNb79qZm3bjD/0acVa2/
         H2XwQgV6mAAzHAHGZHHstFCM5jVr5Po8y1Wkl1Bl6+p7zb7PPlTpTjCd2KYiSf8rFl1p
         a5HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xnAj6P36mRFrOKlNFGBIp59D8zj41WyOisgqN/6E1gQ=;
        b=STkRZa2oxzHHIVNwuplGJQHF8CPpIChY3vEljtON3e1b0qDdWo4SYlCa3nABx8LGYg
         hru2Yz1Bq3MrA/shuHo0+W8KReoARANx73RlE3EqQpCHwLjx6oRMIzqCihMfDBv56qmz
         eEG/5LtBm3J+PrQPWZjHZr/14de6zzfuSzpu6mK0YliesCqMrN42uos9i8oxW6CaPupS
         CSb4zKbVm8LACfWAU/691PcC+keOVT+b0fpic9a6c3TGIrIMhQ0VQEFU1R4sAoIxPSVb
         /ACZK4/bZJiYjaWrAdQyIx26Z9qjP70QteGQFjmGafKpC0KAfSwj4S4nR846rOdm3iaV
         lOKQ==
X-Gm-Message-State: AOAM530IsmGbW6neM2Fej6H2oqrJ1edc7n96K02DFcuWF7CXwHpMqOuR
        wm4Sd5xly3eCjR4DeZtT/Ds=
X-Google-Smtp-Source: ABdhPJzKR+Aoy6FLy7TPWNwX9N2WPSb//1PkOV75g4h1ZpdloUZ5Hx0XJ2hIDVfUULSLnEEbZvdsDg==
X-Received: by 2002:ac8:45d7:: with SMTP id e23mr12743050qto.149.1607655650677;
        Thu, 10 Dec 2020 19:00:50 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:585e:c315:5afa:f8a1? ([2600:1700:e72:80a0:585e:c315:5afa:f8a1])
        by smtp.gmail.com with UTF8SMTPSA id k32sm5476988qte.59.2020.12.10.19.00.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Dec 2020 19:00:50 -0800 (PST)
Subject: Re: [PATCH 04/11] merge-ort: implement compare_pairs() and
 collect_renames()
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>
References: <pull.812.git.1607542887.gitgitgadget@gmail.com>
 <207bb9a837cb855721daa88caaad80e37cb40ffe.1607542887.git.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <8d744966-2344-1dbc-f2a2-7411be3bfc8b@gmail.com>
Date:   Thu, 10 Dec 2020 22:00:49 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:84.0) Gecko/20100101
 Thunderbird/84.0
MIME-Version: 1.0
In-Reply-To: <207bb9a837cb855721daa88caaad80e37cb40ffe.1607542887.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/9/2020 2:41 PM, Elijah Newren via GitGitGadget wrote:
> From: Elijah Newren <newren@gmail.com>

Perhaps worth pointing out comparison to score_compare() 

> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>  merge-ort.c | 27 +++++++++++++++++++++++++--
>  1 file changed, 25 insertions(+), 2 deletions(-)
> 
> diff --git a/merge-ort.c b/merge-ort.c
> index 1ff637e57af..3cdf8124b85 100644
> --- a/merge-ort.c
> +++ b/merge-ort.c
> @@ -625,7 +625,13 @@ static int process_renames(struct merge_options *opt,
>  
>  static int compare_pairs(const void *a_, const void *b_)
>  {
> -	die("Not yet implemented.");
> +	const struct diff_filepair *a = *((const struct diff_filepair **)a_);
> +	const struct diff_filepair *b = *((const struct diff_filepair **)b_);
> +
> +	int cmp = strcmp(a->one->path, b->one->path);
> +	if (cmp)
> +		return cmp;
> +	return a->score - b->score;

Hm. I wasn't sure what would happen when subtracting these
"unsigned short" scores, but I see that score_compare() does
the same. Any potential for an existing, hidden bug here?

Thanks,
-Stolee
