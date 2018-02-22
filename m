Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 940F81F404
	for <e@80x24.org>; Thu, 22 Feb 2018 19:29:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751346AbeBVT3l (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Feb 2018 14:29:41 -0500
Received: from mail-qt0-f180.google.com ([209.85.216.180]:42886 "EHLO
        mail-qt0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751180AbeBVT3j (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Feb 2018 14:29:39 -0500
Received: by mail-qt0-f180.google.com with SMTP id l19so7730559qtj.9
        for <git@vger.kernel.org>; Thu, 22 Feb 2018 11:29:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=bREdhXA01Z9u154b5TFzjNmNXvflJYnUFaUPNTAVc2E=;
        b=c3erGqMzIQIqH7Zw05DdFQJCgjgk61we8+YIyNPEwHhCJKbVqN7jK8kwG27zQTZ5K+
         7jfLRamvGjCdRnH3ak5ovCMW7gMXJ4Dpt9Jnxfu6xE0L6Jh5nZO0qqoNUvtGB7l251vH
         zLfqSg09nJwzPeHe5X3IBZZolVoRP7WC4WFHIYj+RK1WCkM9udF6rWYaeY4qD0H0+Eyr
         gyUVHcuEFDLzueckXzZLTM1UxvddKa7PE1VnTkQjAT21i/SAve8ZCYADR6i3zjnu9K+G
         f3krfNmfBtbuw6ynWtx+/seoEsdFJvnjzJWIHxHPYMH9BybtBS7j2Kkj75pixXyTQJUt
         6EZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=bREdhXA01Z9u154b5TFzjNmNXvflJYnUFaUPNTAVc2E=;
        b=qnRL0YVGUgjVUwDi9ZLHrNL+QjqER8qoJ2JyaC3h7dSZ5q2iDtIvUzVU4jo2p8bUMI
         ksAnm7xiUL+jVfPo5XaUzni4fWG0vPHTWmlS1HZztnynb0JLht1FPRmjs+wQ3jYtclIs
         uIX2fYN2TdQ+eGDpH+ZyAz4AhLqyzbCMlExLVc5FSTsiax4EpAl7xgP9lQrn2LB4qm6J
         yFfNuBhKl1x4OfDrh7Qcl+OclvNcwpDbOZvshgOoz7ze1W0gtTDXgqTQYZwfiVLSEu6H
         Ich5VRIeqNmeuac5xj1itYCJ4WSd/XaPpmb7B/QGfLSdHu1EOW6wMs+M6VYZmkzBnUVT
         PZ9Q==
X-Gm-Message-State: APf1xPAVskcHoh0Mm8XUz0+bUsURvnz24sT/eYt2tXc4+cao+Fdyn+1S
        oQBkdLBML9UQlIi89gBy5FtBqpGd
X-Google-Smtp-Source: AH8x2271Ip844zRdsPvlk0VCf7firNmRTR5oKydDf12g1rYXw14kMorr3/4RCOgTWhyK94iKjqAvZA==
X-Received: by 10.200.4.159 with SMTP id s31mr12842836qtg.144.1519327778627;
        Thu, 22 Feb 2018 11:29:38 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13e:c4e6:7a22:56f1:df04? ([2001:4898:8010:0:ae1c:7a22:56f1:df04])
        by smtp.gmail.com with ESMTPSA id h5sm518816qkd.61.2018.02.22.11.29.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Feb 2018 11:29:37 -0800 (PST)
Subject: Re: Bug: git log: boundary commits do not respect order (e.g.
 date-order, topo-order) 2
To:     Josh Tepper <josh@clarifai.com>, git@vger.kernel.org
References: <CAPFeJUAF99buo=yTZQeHawU-npLHk0iJ1iQxYwMroFdDcKhqjA@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <cc579f55-cb5c-d6fb-c03f-f180137e5c25@gmail.com>
Date:   Thu, 22 Feb 2018 14:29:36 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAPFeJUAF99buo=yTZQeHawU-npLHk0iJ1iQxYwMroFdDcKhqjA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/21/2018 6:57 PM, Josh Tepper wrote:
> When using git log, boundary commits (ie, those commits added by
> specifying --boundary) do not respect the order (e.g., --date-order,
> --topo-order).  Consider the following commit history, where number
> indicates the order of the commit timestamps:
>
> <view with a fixed with font! 3's ancestor is 1, 6's ancestors are 4,5>
> 0----1----2----5  <--A
>         \         \
>           3----4----6  <--B
>
>
> Executing the following command:
>
> $ git log --boundary --date-order ^A B
>
> Should produce the following order (boundary commits shown with dashes):
> 6 -5 4 3 -1
>
> However, it in fact produces:
> 6 4 3 -5 -1
>
> Please advise.
>

Hi Josh,

Looking at the docs [1], I don't see any specifics on how the boundary 
commits should be ordered.

Clearly, the implementation specifies that the boundary is written after 
all other commits. For a full discussion of this, see the commit message 
for 86ab4906a7c "revision walker: Fix --boundary when limited". Here is 
an excerpt:

      - After get_revision() finishes giving out all the positive
        commits, if we are doing the boundary processing, we look at
        the parents that we marked as potential boundaries earlier,
        see if they are really boundaries, and give them out.

The boundary commits are correctly sorted by topo-order among themselves 
as of commit 4603ec0f960 "get_revision(): honor the topo_order flag for 
boundary commits".

So, I'm not sure that this is a bug (it is working "as designed") but it 
certainly is non-obvious behavior.

In what use case do you need these boundary commits to appear earlier?

Thanks,
-Stolee

[1] https://git-scm.com/docs/git-log


