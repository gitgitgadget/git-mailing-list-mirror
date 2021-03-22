Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A44D1C433E8
	for <git@archiver.kernel.org>; Mon, 22 Mar 2021 05:54:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93B3461992
	for <git@archiver.kernel.org>; Mon, 22 Mar 2021 05:54:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbhCVFxv (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Mar 2021 01:53:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbhCVFxY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Mar 2021 01:53:24 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77927C061574
        for <git@vger.kernel.org>; Sun, 21 Mar 2021 22:53:23 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id o2so5965358plg.1
        for <git@vger.kernel.org>; Sun, 21 Mar 2021 22:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Nwtkm98jexnWi6GfiEgKhFCC27so9AAC8jI/RmKqhR4=;
        b=GCpiQZoUz4VGTtnghykfSADj0mgYvpQxa1moyYUzSeBS+ZrDPo7PZMqD9dYLWb8/Q/
         zle4VehQ1AcwGhjGfphVDnRm2t+8zumEzRsAtB4Idr1ngNxY3ebg2QfBPWCXxjUSzhQq
         1y85Lki4mO4b9uU6/kdU2PRzEmZ8AtC98e6NIRWMAFZb1pnUaOl2s2fWJeLfrtRHbUVc
         YI3tNsvyXZ+T3K823C5agxfFrmOYJ2y3w5Qkn9UtVlnxmcfpB2zg+9tsEFwKBFzQOTtC
         QN59cnU6F876A91iAbC+nMlyJuFNvPaIEWvUDAUNvd2NNHjmKT/1tH6aOTyZ7HBYzk8B
         Abdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Nwtkm98jexnWi6GfiEgKhFCC27so9AAC8jI/RmKqhR4=;
        b=YSPo5ETVnydlMb7j8lTW2k1tcaHprtuOeN483G6dl5nN0nO4/6HikpHX7wqojCIWu0
         HYRRapqahEIBVICU1ClOo4wanOgHUhY+XybBFTv7XAwN7vMEY9TAkKYCw6UpENUghWG9
         HBS2km+lsmveiXTdOgq5GlAQDRTNA7GB1NLo0vuVxmAWdSeOi5UMpfUG1mzSCSWDqtuW
         gbDojzYdqgF5yaA0yuPNbU9f3IJG+LD2JoeyBxEZmwKa9bWTQ6YDggMZO3sXdeMuaXqC
         MmrStCkL+Pvki2IbRrRE9LiDRUkmHkUirTCCgOPXYRITjEEbCsNcziOmPx5r2Bk8E/iW
         z35Q==
X-Gm-Message-State: AOAM533Vr2+RIijBxsrzuBsxggTdlwdCXBdsNuzgJKkmae6oNV6DxCRM
        mrJkZjcZFckuGYVCcmRPIulHIWqUqFBKZikT
X-Google-Smtp-Source: ABdhPJzzkQiCb6RAC10J0g9e25RFp8rNEbU3puqDmXhLHSTXV2P2DF0tWOVrEe+nmBQqd39T01teOA==
X-Received: by 2002:a17:902:9306:b029:e6:ac65:468e with SMTP id bc6-20020a1709029306b02900e6ac65468emr25406695plb.16.1616392402853;
        Sun, 21 Mar 2021 22:53:22 -0700 (PDT)
Received: from [192.168.43.80] (subs03-180-214-233-16.three.co.id. [180.214.233.16])
        by smtp.gmail.com with ESMTPSA id p22sm12087131pjg.39.2021.03.21.22.53.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Mar 2021 22:53:22 -0700 (PDT)
Subject: Re: git diff --text does not work during rebase for binary files
To:     =?UTF-8?B?0JTQuNC70Y/QvSDQn9Cw0LvQsNGD0LfQvtCy?= 
        <dilyan.palauzov@aegee.org>
References: <6afc8f1365627f08247f73da7e7e362c0b8ea560.camel@aegee.org>
Cc:     git@vger.kernel.org
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Message-ID: <4ef94ca7-ec69-f350-1d76-6bb8745786f1@gmail.com>
Date:   Mon, 22 Mar 2021 12:53:19 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <6afc8f1365627f08247f73da7e7e362c0b8ea560.camel@aegee.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 22/03/21 00.30, Дилян Палаузов wrote:
> Hello,
> 
> I create a small text file ending with \0 and add it to git:

Did you mean `echo -e "\0" >> a.txt`?

> In .gitattributes I specify:
> 
> *.txt diff merge=text text
> 
> I create several commits by changing the small text file.
> 
> The result is at https://github.com/dilyanpalauzov/git-diff-biinary .
> 
> I do now
> 
>    git rebase -i HEAD~2
> and before the “second commit” type E to edit that commit.
> 
> I change the small file.
> 
> git add a.txt && git rebase --continue
> 
> git says:
> 
> [detached HEAD bc00e34] second commit
>   Date: Sun Mar 21 19:16:15 2021 +0200
>   1 file changed, 2 insertions(+), 1 deletion(-)
> warning: Cannot merge binary files: a.txt (HEAD vs. 04c77de (third
> commit))
> Auto-merging a.txt
> CONFLICT (content): Merge conflict in a.txt
> error: could not apply 04c77de... third commit
> Resolve all conflicts manually, mark them as resolved with
> "git add/rm <conflicted_files>", then run "git rebase --continue".
> You can instead skip this commit: run "git rebase --skip".
> To abort and get back to the state before "git rebase", run "git rebase
> --abort".
> Could not apply 04c77de... third commit
> 
> 
> 'git diff' and 'git diff --text' show:
> 
> diff --cc a.txt
> index 7a61015,dc817ec..0000000
> --- a/a.txt
> +++ b/a.txt
> 
> The file does not contain <<HEAD===>>> markers, despite having
> merge=text attribute.
> 
> HOW CAN I force git diff to show the differences and git merge to
> include the <<<===>>> markers?
> 
> I have to say, that at different occassions git diff --text does work
> ass expected (e.g. when I call git diff --cached --text).
> 
> I call now
> git rebase --abort
> git log -p
> 
> git shows the differences in the small text file ending with \0.  So
> apparently log reads the option, but diff does not.
> 
> Using git 2.30.2.
> 
> Greetings
>    Дилян
> 

Does `file a.txt` shows it as being binary file? I do the similar and it just says "data".

-- 
An old man doll... just what I always wanted! - Clara
