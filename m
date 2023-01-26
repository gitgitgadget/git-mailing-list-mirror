Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89DC3C05027
	for <git@archiver.kernel.org>; Thu, 26 Jan 2023 16:38:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231897AbjAZQi4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Jan 2023 11:38:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231734AbjAZQix (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Jan 2023 11:38:53 -0500
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E82D826586
        for <git@vger.kernel.org>; Thu, 26 Jan 2023 08:38:44 -0800 (PST)
Received: by mail-oi1-x22c.google.com with SMTP id d188so1868235oia.3
        for <git@vger.kernel.org>; Thu, 26 Jan 2023 08:38:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wRQCsDtGCRsfmpNUhqGExdLqS7qsRawm3fxX/spjnDs=;
        b=JyY0aE7J04v3xKAk9AgsjcY/kTX++TNyJ/gL4OcjtRlBqB8Pn6jlyf11LP/d3C9hx1
         nt+CIfG8D1Rd4W8Uhng8192mBKyQx/lNCKf6mSOj9LcFiUsrlqf5WiOSacg2FAXLKkAI
         PvkUOvyb+sBcHzin31fmnKSO2SvhZfT7tFIIpJXWgiUX6J7D+Ut5418q73xeV1oDY9Ex
         zHa71fymbBwCyhHZC7Vpqh9adBGZzCzO7u/+Nc8Q2jFU7K0YtuCWBA59DF5wvq7oMrtx
         DEeRhReNvo5N7uvEt3EJKdsKH8HqFu2hydpcDAjcUMhgztkru54V4BFpTlN2VVAMPEX/
         tGfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wRQCsDtGCRsfmpNUhqGExdLqS7qsRawm3fxX/spjnDs=;
        b=VRedVcvYNGb5sIp5B1EPp56FGN2MP0H2gi7g/YynTi8GxOxd2ksdxHuIVoYdxz2O1w
         P/UcdcScvv2OnSGzwqKMkRdgpIY3dWFgkmrnjf5wXwNrag51sXlU2432kQGBMOF/+JU0
         SBEFQgT6vuKCBZ7b4+Y1suS+/NNEAnf/nEPPrwygpYEwwUY16c/7wFkB4VI7sMn2+47M
         0kmTTgtFzzr7DbHt+WsudyQVQrxMK0zNLx9XUlMrJScfPYcLjMweQPblscQ/vB3E7CDh
         TzeVhtwA/QdC/+xfgh4iCrTl+voKfC6qmvrFQ9f6EAOCP96v1qEKLW2NahDFbR06ZXZ+
         Z0fw==
X-Gm-Message-State: AO0yUKX31BP1C92SNDKJ2h4Q3ucGDqHnlOzTKT7wMaBnREa0+1efdXoW
        aT8mGu5oM6aHXGTYLJ3/0amSQ4Q1Rvr67EI=
X-Google-Smtp-Source: AK7set801XdYOiDfKOSfhE7iXOFfFoZ7V5TrqbYD2Dazv3Fqo1K+Hbwz9WvR/8VA7jsBN13O9KfGAw==
X-Received: by 2002:a05:6808:1383:b0:364:8dcc:58ec with SMTP id c3-20020a056808138300b003648dcc58ecmr1586082oiw.3.1674751124146;
        Thu, 26 Jan 2023 08:38:44 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:e5b3:c0fa:dc26:df9d? ([2600:1700:e72:80a0:e5b3:c0fa:dc26:df9d])
        by smtp.gmail.com with ESMTPSA id o4-20020a9d7644000000b00686574e98d6sm656128otl.72.2023.01.26.08.38.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Jan 2023 08:38:43 -0800 (PST)
Message-ID: <fcc08ee2-dc58-09da-dc60-c438cfbf6602@github.com>
Date:   Thu, 26 Jan 2023 11:38:42 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: git log --follow wrongly includes delete commit
To:     "Steinar H. Gunderson" <steinar+git@gunderson.no>,
        git@vger.kernel.org
References: <20230126130509.ovii7ji7hi5wm7qx@sesse.net>
Content-Language: en-US
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <20230126130509.ovii7ji7hi5wm7qx@sesse.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/26/2023 8:05 AM, Steinar H. Gunderson wrote:
> I'm in the Chromium repository; it can be checked out at
> https://chromium.googlesource.com/chromium/src.git (you don't need the
> sub-repostiories). HEAD is pointing to 4e0db738b37c. git 2.39.1.
> 
> When I run
> 
>   git log --raw --follow base/third_party/xdg_user_dirs/xdg_user_dir_lookup.h
> 
> this is the first commit that it lists (snipped):
> 
> commit 5d4451ebf298d9d71f716cc0135f465cec41fcd0
> [...]
> :100644 000000 9e81e1b53029f 0000000000000 D base/third_party/xdg_user_dirs/xdg_user_dir_lookup.h
> 
> This indicates that the last thing that happened to the file is a delete.
> However, the file isn't deleted; it's alive and well. git log without
> --follow does not list this commit at all.
> 
> So either git log --follow is listing a delete commit that doesn't make
> sense, or it's missing whatever commit put it back into place afterwards.

It's actually a third option: it was deleted but also renamed in an
independent point in history, but the delete is more recent "in time"
that it shows up first, and the merge that resolves the issue doesn't
show up at all.

You can see this when using --full-history --simplify-merges --graph,
since it will explore enough of the graph to recognize that deletion
while also showing how things got merged strangely:

$ git log --summary --full-history --simplify-merges --graph -- base/third_party/xdg_user_dirs/xdg_user_dir_lookup.h
*   commit 1e78967ed2f1937b3809c19d91e7dd62d756d307
|\  Merge: 5d4451ebf298 9e9b6e8ee772
| | Author: grt@chromium.org <grt@chromium.org@0039d316-1c4b-4281-b951-d872f2087c98>
| | Date:   Tue Jul 19 16:14:55 2011 +0000
| | 
| |     FileManagerDialogTest.SelectFileAndCancel flaky.
| |     
| |     BUG=89733
| |     TBR=robertshield@chromium.org
| |     TEST=browser_tests
| |     Review URL: http://codereview.chromium.org/7447001
| |     
| |     git-svn-id: svn://svn.chromium.org/chrome/trunk/src@93027 0039d316-1c4b-4281-b951-d872f2087c98
| | 
* | commit 5d4451ebf298d9d71f716cc0135f465cec41fcd0
|/  Author: jbauman@chromium.org <jbauman@chromium.org@0039d316-1c4b-4281-b951-d872f2087c98>
|   Date:   Tue Jul 19 15:45:49 2011 +0000
|   
|       Roll ANGLE r704:r705
|       
|       BUG=
|       TEST=try
|       
|       Review URL: http://codereview.chromium.org/7375016
|       
|       git-svn-id: svn://svn.chromium.org/chrome/trunk/src@93026 0039d316-1c4b-4281-b951-d872f2087c98
|   
|    delete mode 100644 base/third_party/xdg_user_dirs/xdg_user_dir_lookup.h
| 
* commit 9e9b6e8ee77229781fa8581b7f46413024404a5f
  Author: thestig@chromium.org <thestig@chromium.org@0039d316-1c4b-4281-b951-d872f2087c98>
  Date:   Wed Dec 2 08:45:01 2009 +0000
  
      Move some XDG code from chrome to base, make DIR_USER_CACHE generic rather than Chromium specific, and clean up a few headers.
      
      BUG=none
      TEST=none
      Review URL: http://codereview.chromium.org/449048
      
      git-svn-id: svn://svn.chromium.org/chrome/trunk/src@33565 0039d316-1c4b-4281-b951-d872f2087c98
  
   create mode 100644 base/third_party/xdg_user_dirs/xdg_user_dir_lookup.h

(Note: I didn't include --follow here as it filtered the --graph
output in a strange way, including dropping the merge commitswhich was
confusing to me.)

In conclusion: while I agree that this output is confusing, it is due
to the interesting shape of the commit history, and not actually a bug
in --follow.

Thanks,
-Stolee
