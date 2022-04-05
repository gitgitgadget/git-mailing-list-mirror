Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E345C433EF
	for <git@archiver.kernel.org>; Tue,  5 Apr 2022 07:34:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231536AbiDEHgQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Apr 2022 03:36:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiDEHgN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Apr 2022 03:36:13 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE9C6AE56
        for <git@vger.kernel.org>; Tue,  5 Apr 2022 00:34:14 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id g15-20020a17090adb0f00b001caa9a230c7so1689110pjv.5
        for <git@vger.kernel.org>; Tue, 05 Apr 2022 00:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=BUL3gxA4GWNLtg6CzqIYWGnOh6fLe361R5JawiKohNs=;
        b=GldJVTBriRVT72F0p5RaXdT2bsi/9lKmwcso6aGBYrS45e5qShWLBOjoW3RQuxk8t4
         TzbbHB6tbULDOxGJV2SepA/vIDIrlBhCEco2kMG1D9tVKFlsW8s36p+cJC4PPi+iO8m9
         PzA50LYDPxTaQgwfF2u/9g/oY7cO2gb9ejxcJ64JnbNNdIIYdiS8VuaywOxZrAaRCl7y
         zQnBIUnK1Auffor4iQEiwdNNU/EUId1fcPsz/I/YEMBT6Wfhck67aTfiZqyNEh0dyQNc
         CSWj1P/qbQ6Q3k44C+DlbVIODcYGNvn6DSFPsq+MwTw5p/lYl1w/5FvD9vjO7Hq8XEn1
         Qv1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=BUL3gxA4GWNLtg6CzqIYWGnOh6fLe361R5JawiKohNs=;
        b=pk1aMTlbvOWXR4oIWQ4tUF00laRp995Q4FdGzOhu0wKvKJieYhO09LyzQ5WSX0A83r
         EVBOcD9b+I9PEULgrZJGNaczpxhrFaCg2wMKTy+Ydv/UPcN8WYmx3RdeKmhwKIs9Kuf7
         v+whuwAfexFA0FTMcqs5bx2E1OInvZPZcY0ryQl/KpfiudDeq9ixqIvaVjS08OS4ewQs
         WbNYQshYCQyixq1QJfwAUDnZ8d9DHs33ITXowYSaR0de4rX7C0GrXyJYFRRYswaoeZ1H
         hfMcdsonjkeDLN9HTiu6VV1pHUDO7LVCQrTALfA7oNu0LkYWKCmr/ifGBPFZnDsILpt4
         hDpg==
X-Gm-Message-State: AOAM530XsIahpluIHWofPRiA/u554gH6z88ZmMRs3KbpxmDbR4/EYR1j
        Wz6ytsowAFqWg9Ai6EBTmtQ=
X-Google-Smtp-Source: ABdhPJy7t16peqTaoow7v9kP8DR9KLp9JyCwrNdD6+D+SROI/RZ7uLCG82mvikyvG5WAxbQEjOUavw==
X-Received: by 2002:a17:902:bf07:b0:14f:a3a7:97a0 with SMTP id bi7-20020a170902bf0700b0014fa3a797a0mr2175163plb.105.1649144054323;
        Tue, 05 Apr 2022 00:34:14 -0700 (PDT)
Received: from [192.168.43.80] (subs28-116-206-12-39.three.co.id. [116.206.12.39])
        by smtp.gmail.com with ESMTPSA id nv11-20020a17090b1b4b00b001c71b0bf18bsm1440834pjb.11.2022.04.05.00.34.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Apr 2022 00:34:13 -0700 (PDT)
Message-ID: <b2f5d6af-8da1-3a3a-cc21-848c14a8fb98@gmail.com>
Date:   Tue, 5 Apr 2022 14:34:05 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2] blame: report correct number of lines in progress when
 using ranges
Content-Language: en-US
To:     Edmundo Carmona Antoranz <eantoranz@gmail.com>, gitster@pobox.com,
        whydoubt@gmail.com, git@vger.kernel.org
References: <20220404182129.33992-1-eantoranz@gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <20220404182129.33992-1-eantoranz@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 05/04/22 01.21, Edmundo Carmona Antoranz wrote:
> When using ranges, use their sizes as the limit for progress
> instead of the size of the full file.
> 

The progress limit is defined by number of affected lines, right?

> +test_expect_success 'blame progress on a full file' '
> +	cat >progress.txt <<-\EOF &&
> +	a simple test file
> +
> +	no relevant content is expected here
> +
> +	If the file is too short, we cannot test ranges
> +
> +	EOF
> +	git add progress.txt &&
> +	git commit -m "add a file for testing progress" &&
> +	GIT_PROGRESS_DELAY=0 \
> +	git blame --progress progress.txt > /dev/null 2> full_progress.txt &&
> +	grep "Blaming lines: 100% (6/6), done." full_progress.txt
> +'
> +
> +test_expect_success 'blame progress on a single range' '
> +	GIT_PROGRESS_DELAY=0 \
> +	git blame --progress -L 2,5 progress.txt > /dev/null 2> range_progress.txt &&
> +	grep "Blaming lines: 100% (4/4), done." range_progress.txt
> +'
> +
> +test_expect_success 'blame progress on multiple ranges' '
> +	GIT_PROGRESS_DELAY=0 \
> +	git blame --progress -L 1,2 -L 4,6 progress.txt > /dev/null 2> range_progress.txt &&
> +	grep "Blaming lines: 100% (5/5), done." range_progress.txt
> +'
> +

Why not using test_i18ngrep?

-- 
An old man doll... just what I always wanted! - Clara
