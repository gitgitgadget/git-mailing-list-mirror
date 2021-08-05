Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C80DC4338F
	for <git@archiver.kernel.org>; Thu,  5 Aug 2021 10:02:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09F3160560
	for <git@archiver.kernel.org>; Thu,  5 Aug 2021 10:02:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240110AbhHEKC1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Aug 2021 06:02:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240009AbhHEKCZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Aug 2021 06:02:25 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26FE5C0613C1
        for <git@vger.kernel.org>; Thu,  5 Aug 2021 03:02:10 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id l11-20020a7bcf0b0000b0290253545c2997so3271105wmg.4
        for <git@vger.kernel.org>; Thu, 05 Aug 2021 03:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=YVI8tpXUp39EdE1Fg2ORn4ZoI19oMC4Y6ecivk9Xo34=;
        b=AN32rIjNjX4k3tnaVIfzhwzUwO7XpmMhdGXaD/0Hi6LmUh4n8COi4d8PqxteoYqnlh
         VKZ6J7WZn8oFm0KRvp9Ab6wwqb+Wz/nUqm1AylI+vt7Nee3jl12bDYhlubsMAQm3tLK5
         vqpghIpu3Z/6fD9P+1nQO0YhLAYCVNDVJJ/ehCUIcfXqNjGQ/MjGTW+cB4RDa0gT0Frx
         FF3ylaj/IkMPFgRM3sSkqd6xT4oQfO+9qpXblw3JhNg+5vt2iI9LCLvM9zTCB3j1eh7r
         rK6VruSUBy6BQ6jpFCmLntN6sOCGWweE71orrlt3oGraBm3FwynkqdCn3gyPOZLRkaXy
         hWJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YVI8tpXUp39EdE1Fg2ORn4ZoI19oMC4Y6ecivk9Xo34=;
        b=TPSXII3USr646dSf527aRBuGxqiyYgF4Gv5Eg3q2lfdsY4QtJ8k+iRpAHBZuUY1VmR
         oe2YYUZki9FeN+on/x+QgXyrvdzA/+Mynoneie8BrWMUBifE0xaeVE0jM6w/SZLxxWp9
         vSiIqiVYsktnc2t/Yf8woeX0yYlafASu7tXUX1GrFrlSHWJKfSOhM9tfnWimSJJUMtBb
         UzdN97lEhMOs147AQ26OrIG7l5NZCtL5BYwUWtufvuLZAoweY9tKZDuXpbTwLcKOPYAr
         GLBMzCBJyY+TRXLXJ+TQPV2iEbeV7JUBinIRAwGrcwSRObSw4eYJWfghj7PuMr/Efz/m
         V+hA==
X-Gm-Message-State: AOAM530Wd8+L75utiPpSjqk4utKNyocdy+ltyrKQaH/TXEap1/mTYzzM
        T2UEQKx3bXktq5pbIqETGxmBmr0yH/Y=
X-Google-Smtp-Source: ABdhPJzjS7TGPh9zo9irPy+4f3tUD0Mx+XNX294jy3xw5ep3vZESv/e3bbwtqyvca9ejFesm9kj28Q==
X-Received: by 2002:a1c:4b0a:: with SMTP id y10mr3954855wma.111.1628157728740;
        Thu, 05 Aug 2021 03:02:08 -0700 (PDT)
Received: from [192.168.1.201] ([31.185.185.232])
        by smtp.googlemail.com with ESMTPSA id m39sm7787501wms.28.2021.08.05.03.02.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Aug 2021 03:02:08 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: commit following rebase has unexpected commit message
To:     Victor Gambier <vgambier@excilys.com>, git@vger.kernel.org
References: <CAMsiUYDD3jTyP-pK7PiydECkUAJspzosc8mWNSFpcLru70zXbQ@mail.gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <d47652d2-7353-f4ff-5549-ef1c2bc6a381@gmail.com>
Date:   Thu, 5 Aug 2021 11:02:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <CAMsiUYDD3jTyP-pK7PiydECkUAJspzosc8mWNSFpcLru70zXbQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Victor

On 04/08/2021 15:19, Victor Gambier wrote:
 > Thank you for filling out a Git bug report!
 > Please answer the following questions to help us understand your issue.
 >
 > What did you do before the bug happened? (Steps to reproduce your issue)
 >
 > git switch -c first
 > git switch -c second
 > [modify a file]
 > git commit -am "foo"
 > git switch first
 > [modify the same file in a conflicting way]
 > git commit -am "bar"
 > git rebase second
 > git restore --staged .
 > git restore .
 > git rebase --continue
 > [modify any file - can be the same file again]
 > git commit -a
 >
 > What did you expect to happen? (Expected behavior)
 >
 > The text editor should pop up and the first line should be blank (no 
default commit message).
 >
 > What happened instead? (Actual behavior)
 >
 > The text editor pops up, and the first four lines of the default 
commit message seem to pertain to the rebase:
 >
 > 	bar
 >
 > 	# Conflicts:
 > 	#	frontend/src/styling/rounds.ts
 >
 > Even though the contents of the commit correctly pertain to the very 
last changes and are unrelated to the rebase.


Thanks for the detailed report, I think the problem is that when rebase 
stops for the user to resolve conflicts it writes .git/MERGE_MSG which 
is removed when the conflict resolution is committed or by 'git reset' 
if the user skips the commit. In this case the commit is effectively 
skipped but the file is not removed and so seeds the editor when you 
next make a commit. I'll try and put a patch together next week.

Best Wishes

Phillip

 > What's different between what you expected and what actually happened?
 >
 > The default commit message.
 >
 > Anything else you want to add:
 >
 > A second anomaly is that if you replace the last command with git 
commit -a --no-edit, the two lines starting with '#' are NOT ignored and 
will be present in the final commit message.
 >
 > Please review the rest of the bug report below.
 > You can delete any lines you don't wish to share.
 >
 >
 > [System Info]
 > git version:
 > git version 2.30.0.windows.2
 > cpu: x86_64
 > built from commit: f8cbc844b81bf6b9e72178bbe891a86c8bf5e9e7
 > sizeof-long: 4
 > sizeof-size_t: 8
 > shell-path: /bin/sh
 > uname: Windows 10.0 18363
 > compiler info: gnuc: 10.2
 > libc info: no libc information available
 > $SHELL (typically, interactive shell): C:\Program 
Files\Git\usr\bin\bash.exe
 >
 >
 > [Enabled Hooks]
