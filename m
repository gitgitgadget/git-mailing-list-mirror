Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63C83C433F5
	for <git@archiver.kernel.org>; Sat, 16 Oct 2021 05:16:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4414060D42
	for <git@archiver.kernel.org>; Sat, 16 Oct 2021 05:16:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239744AbhJPFSq (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 16 Oct 2021 01:18:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239712AbhJPFSo (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Oct 2021 01:18:44 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D8D8C061570
        for <git@vger.kernel.org>; Fri, 15 Oct 2021 22:16:33 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id e65so8077774pgc.5
        for <git@vger.kernel.org>; Fri, 15 Oct 2021 22:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=p/VhukS/897zhqkc6ugrKfbEFtBvYHnsGOJyZby3R1Y=;
        b=FjKuAXCkT3Arefi2tpnmj4AKaGlgSTAvoOX8XlDq7rMJWalKnLx0OdNnltQxNAfPc+
         tEuNLA9TyMr0yQClZesU69DzX+ieA07Dd0kqvVuKTXAiSgXffAKqfJAXeMUMaSdVT+/x
         J4+qGyZQAilAqFhqQk1TRHNDXNQ1rWHBTZ6HcvCQA0lTQPm826K+fVIGr7lkoNjrlb0W
         CXFWUtlSUTCvS7ziYwh39n766gbjsf8ImRYHnNaMMZbxyCqlnER4EMD+RYbav2B+aK5i
         5BWUdLrZPuB6Il/vKplq0Fm1B3pCPfh8OwmyxvqnxpqlXyHvUKCVd5lYXbYDpgTKQuW2
         vVew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=p/VhukS/897zhqkc6ugrKfbEFtBvYHnsGOJyZby3R1Y=;
        b=U93T5RWYBsvCI4nfR2X942ZSmCjHzaSB/BWBboC0KysFwnfz7IgKh4yv3TOVQuXXuN
         BSU/lJBW9TbGElRuBmUcW1RwSC6fVXmR8Q0dPGv5V15U00DWSfNbmuTWDmbGgv3m743U
         APEe/4A8/IYaZa7jwpsJbRkY7n9e23ip8YiB21CSfHu6fA1XcQ3R4tFXRZmzAX1G3pb0
         WLjWGuG2AKJrH0w9KUDoc+2b/wLpxFI0yA353OlvuH/2PAxnnxZKY/not38F6QHL7FX7
         wH1+AmG335FgdBg/MZaVmV7K1wG1bfSXtIa9WXTc3yPxw4sm/bHJU8ac4nwZzFAeJFs4
         KArQ==
X-Gm-Message-State: AOAM531UiK/A58obnJpIsBW8AcGYTDprj9HwQn1xsx4aauPNJ2gjVOvT
        KjGqOiRckuYIESMB6bX5KJw=
X-Google-Smtp-Source: ABdhPJwSdRvtjxYj19b+NNh3G6TqqYyDzAF53VQsawHDxKDTVcoUyczjmmp9PsIJEtvocg0CFzPTVQ==
X-Received: by 2002:aa7:9823:0:b0:44d:2428:3b62 with SMTP id q3-20020aa79823000000b0044d24283b62mr15677006pfl.77.1634361392980;
        Fri, 15 Oct 2021 22:16:32 -0700 (PDT)
Received: from [192.168.43.80] (subs03-180-214-233-79.three.co.id. [180.214.233.79])
        by smtp.gmail.com with ESMTPSA id 3sm13348509pjk.18.2021.10.15.22.16.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Oct 2021 22:16:32 -0700 (PDT)
Message-ID: <35ccb414-c0fe-ab3a-21aa-ac7b1338df6a@gmail.com>
Date:   Sat, 16 Oct 2021 12:16:29 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v2] Documentation: specify base point when generating
 MyFirstContribution patchset
Content-Language: en-US
To:     Glen Choo <chooglen@google.com>, git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Carlo Arenas <carenas@gmail.com>
References: <20211015122515.47535-1-bagasdotme@gmail.com>
 <kl6l4k9i1ame.fsf@chooglen-macbookpro.roam.corp.google.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <kl6l4k9i1ame.fsf@chooglen-macbookpro.roam.corp.google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 16/10/21 00.06, Glen Choo wrote:
> This reads quite awkwardly because a few lines above, we already tell
> the reader exactly what commands to run:
> 
>    Sending emails with Git is a two-part process; before you can prepare the emails
>    themselves, you'll need to prepare the patches. Luckily, this is pretty simple:
> 
>    ----
>    $ git format-patch --cover-letter -o psuh/ master..psuh
>    ----
> 
> If we do accept this suggestion (and I am not sure if we should, because
> as Junio said, there are strong conventions for determining the branch
> point), I think this would be easier to follow if we incorporate it into
> the existing instructions. Something like..
> 
>    Sending emails with Git is a two-part process; before you can prepare the emails
>    themselves, you'll need to prepare the patches. Luckily, this is
>    pretty simple. First, we'll get the hash of the commit the patchset is
>    based on. We call this commit the 'base'.
> 
>    ----
>    $ git show -s --format="%H" master
>    ----
> 
>    Now, we'll generate the patches, passing the hash of the 'base' to the
>    --base option.
> 
>    ----
>    $ git format-patch --cover-letter --base=<base> -o psuh/ master..psuh
>    ----
> 
>    [...describe --base=<base> the way we describe the other options].
> 

Actually it is up to contributors whether they want to include `--base` 
or not.

-- 
An old man doll... just what I always wanted! - Clara
