Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84B75C433EF
	for <git@archiver.kernel.org>; Sun,  8 May 2022 15:44:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235076AbiEHPsT (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 8 May 2022 11:48:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235064AbiEHPsQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 May 2022 11:48:16 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB0162AF4
        for <git@vger.kernel.org>; Sun,  8 May 2022 08:44:25 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id t16so9416510qtr.9
        for <git@vger.kernel.org>; Sun, 08 May 2022 08:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7KXla6N0fh0hom5EGKZIIgAuxFqdeSmaEg06H2VQegg=;
        b=lFfZ1/GtrrfbXX+2FXFb02SZojLJ4dfQuC0uJIbiCLRz2FSdtRhho14kWRTGTkrqUX
         pD8OdX1q0ybWuojg5xB2wydzfrFciPmJscmCKfkIJn72SjhM555TnNGKsEAyk51Uv2HM
         dHGNfZ2p6roYHC87wdzRPKvD/SVIkHMyiUO4O4FntJSrsTvwaj0Oo+QRrU+I1LObSxDI
         y/bbt7sPIA5XTjZB5cbYa/svYIQueZcw9frV1aJgb5U5V0SklpWItDDxSECLPXaVqOOS
         0MOXUQZKh8RNUJXS8u95jAYuAGtmMvLMQ3/Soavk+1rKRtqle27/S5Pa5rJVjcf7bUJG
         WZNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7KXla6N0fh0hom5EGKZIIgAuxFqdeSmaEg06H2VQegg=;
        b=JjaLzaLsSRzjM0tPHlrRsVaLJy5HkpG7NXTCm+0kQDomeZjJ4ov6yVhS5/cJiOsPOm
         h0EiZPnTptoIt2csW0zRhadkDJLA+fYU6sfxf8w78AwqP8usMY4oAMY2/UiK2mduInvG
         g7Vrna7HM/PiQsdLcVhn7nNc5xOdBvlEPSbdrOOwv3UT8jE8zhpmSE4hDCED3reM2B94
         XcAx/C7HVwQ13XnZZWhGOz3nFiu5+vOsmcmkdOJqnkvXSEbyuWDIW/glE+i6x1ii/AtY
         gkpA/P7T1MzDT8suvvwHcKpWn8ftrBbrCUhPo4nEJNp/EjQbc6qESOy5aRjYmoK8yCUu
         ZBcg==
X-Gm-Message-State: AOAM530nocWgDa+Bq4IL+6eDxg5IC4D9tOd5Git2ZXd5yib7BMBPLwFH
        jOy9SPHpp1JYlYsWsvpEAIs=
X-Google-Smtp-Source: ABdhPJyhhnS6ZNxiqxzvZ87FObXhwkMxQB2XAsMMuB9FjHLE3087Mfi8TKmneMFYWaPNN2BoW+ning==
X-Received: by 2002:a05:622a:1aa1:b0:2f3:b4b0:6fc8 with SMTP id s33-20020a05622a1aa100b002f3b4b06fc8mr11771984qtc.430.1652024664933;
        Sun, 08 May 2022 08:44:24 -0700 (PDT)
Received: from [192.168.1.127] (173-246-5-136.qc.cable.ebox.net. [173.246.5.136])
        by smtp.gmail.com with ESMTPSA id x8-20020ac87a88000000b002f39b99f6b1sm5974156qtr.75.2022.05.08.08.44.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 May 2022 08:44:24 -0700 (PDT)
Subject: Re: [PATCH v3] builtin/remote.c: teach `-v` to list filters for
 promisor remotes
To:     Abhradeep Chakraborty via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Philip Oakley <philipoakley@iee.email>,
        Junio C Hamano <gitster@pobox.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
References: <pull.1227.v2.git.1651591253333.gitgitgadget@gmail.com>
 <pull.1227.v3.git.1651933221216.gitgitgadget@gmail.com>
From:   Philippe Blain <levraiphilippeblain@gmail.com>
Message-ID: <f15e2673-ddc3-27ff-d31c-7fa32af27ae7@gmail.com>
Date:   Sun, 8 May 2022 11:44:23 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <pull.1227.v3.git.1651933221216.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Forgot to comment on the patch itself :P

Le 2022-05-07 à 10:20, Abhradeep Chakraborty via GitGitGadget a écrit :
> From: Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
> 

>  Documentation/git-remote.txt |  3 +++
>  builtin/remote.c             | 18 +++++++++++++-----
>  t/t5616-partial-clone.sh     | 28 ++++++++++++++++++++++++++++

I think the tests woud fit better in t5505-remote.sh, since the patch really
adds a feature to the 'git remote' command. 

>  3 files changed, 44 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/git-remote.txt b/Documentation/git-remote.txt
> index cde9614e362..a125bd839f7 100644
> --- a/Documentation/git-remote.txt
> +++ b/Documentation/git-remote.txt
> @@ -35,6 +35,9 @@ OPTIONS
>  -v::
>  --verbose::
>  	Be a little more verbose and show remote url after name.
> +	For promisor remotes it will show an extra information

I found it sligtly awkward to use the future tense here. Maybe just:

    For promisor remotes, also show which filter
    (`blob:none` etc.) that promisor remote use, wrapped in square brackets.

And technically, it's not really the remote that "uses" the filter, 
but more the local Git client. So maybe something like this would
be more accurate and simpler:

    For promisor remotes, also show which filter (`blob:none` etc.)
    are configured, wrapped in square brackets.

And even then "wrapped in square brackets" *could* be dropped, I 
think.

Apart from that, the patch and test look good, thanks for working
on that!

Cheers,
Philippe.
