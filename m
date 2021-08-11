Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72164C4338F
	for <git@archiver.kernel.org>; Wed, 11 Aug 2021 06:32:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4BBB860F38
	for <git@archiver.kernel.org>; Wed, 11 Aug 2021 06:32:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234757AbhHKGc1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Aug 2021 02:32:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234674AbhHKGcV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Aug 2021 02:32:21 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18296C061765
        for <git@vger.kernel.org>; Tue, 10 Aug 2021 23:31:56 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id fa24-20020a17090af0d8b0290178bfa69d97so3130983pjb.0
        for <git@vger.kernel.org>; Tue, 10 Aug 2021 23:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=XIuSnrTGcN4ZxgiakuJrQNCWJPUGOmdvSF0nn5d06mw=;
        b=keJTJjmcHbg29R9YhrfIATVsRYjX+34DrltVZQYVsEUJ7me6+uEsgpE820f31pMQHN
         Wa6P4zBvt7VfF0P3csw+ck3bKrLTJuYeY8FmWDO5k/U+KPjOoFtiSHs7hAAqHZA+KMA3
         EIqmKyHVm1A89g8VIsTc6b1vB3Oxz4LkQCNc754bGxCTAp63GaxC+DFH9krL4RbJHkEC
         5Zj+QIZn6aL/IJ8l5gN/YbxV2cR2gdXTkrEaYhFHAhp/DpDXiIAk7Mp89/FYFA4dFAOt
         jtNXTJhKCmxDfZFqQg36sVX80W1SOsRprvCHRr3BLCHAb8xHSwX6UQDwd9vOk8aPfNpA
         MEMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XIuSnrTGcN4ZxgiakuJrQNCWJPUGOmdvSF0nn5d06mw=;
        b=YrseJr5lPfJsxa6mPjgRTegOfJCxcwtoX26yjzTUotTCoktg8pBv4a4IPERCWcqj6f
         H0XiqQF1tQLX9m71YsEYHWwACHuCx8lrsafCc0I39Axkp1e1BO0OiPmkF84swfY+7KLW
         CeEmt4gF6IP4DWK81myM90Psw0QT/fVEuIpwmGlYM0ZWS4yGtM+otnpGIUD2/zHLT1LJ
         HYIamCuS/YOFCFbTSx1gRX78z5f42Lm92bfiauap3aoeYyv0o7Ukw2GUpFzU9JAlLyXy
         aOQDoGNUFueaYgn3lQlOs8q+Bp32e7pTC+up+LyX9gsoFhLzAmv5JVxXC/9qfN6fz2pU
         gjmg==
X-Gm-Message-State: AOAM533exMwGl133czwd3vihgOchc9MBSTvmVFSkZ3iZJ3jznhkclKXP
        3mEJeqMo4F3r+vLd189JA/wEOben/jQ=
X-Google-Smtp-Source: ABdhPJydIhQiDAIoZ4Al5BXUGcehyVeKEp5omtjQOoB/Z9fN3KPoTx04HHGgXnrJgIcVrNl3P3AbAw==
X-Received: by 2002:a63:594e:: with SMTP id j14mr113089pgm.249.1628663515207;
        Tue, 10 Aug 2021 23:31:55 -0700 (PDT)
Received: from [192.168.43.80] (subs03-180-214-233-23.three.co.id. [180.214.233.23])
        by smtp.gmail.com with ESMTPSA id u21sm11634748pgk.57.2021.08.10.23.31.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Aug 2021 23:31:54 -0700 (PDT)
Subject: Re: Branch Management
To:     mail.chris.az@gmail.com, git@vger.kernel.org
References: <01d001d78e36$8d47f380$a7d7da80$@gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Message-ID: <4b533ee7-4aa7-6ad5-6722-fca3eaadf464@gmail.com>
Date:   Wed, 11 Aug 2021 13:31:52 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <01d001d78e36$8d47f380$a7d7da80$@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/08/21 05.24, mail.chris.az@gmail.com wrote:
> I have a private git repository (private.git) on a private server
> (PRIVATEREPO.COM).  That repo is updated via development on my local system.
> All works great in that area.  I have 2 branches, "master" and "version".
> 
> I want to update my production system via git from the private git
> repository via command line.  The production system not only contains the
> files from the repo, but also additional files and directories.  I need
> those files to be left alone.
> 

You can specify which files and directories you want to ignore in 
.gitignore. For example, based on your use case:

```
/var/prod/
/etc/ohmyapp/ohmyapp.conf
...
```

> I was able to successful clone just the "master" branch using:
> 
> # git clone -b master git_user@PRIVATEREPO.COM:private.git production.git
> 
> I am now ready to move the new "version" branch.
> 1.  How can I do that?
> 

Use `git checkout version`.

> The "version" branch contains some new files that are not in the "master"
> branch.
> 
> Now suppose that I move to the "version" branch, but determine that I need
> to go back to the "master" branch.
> 
> 2.  How do I go back to the "master" branch and remove any of the new files
> that were uploaded from the "version" branch?  I don't want any remnants
> that the "version" branch was even there.
> 

Practically speaking, `git checkout` updates working directory to 
revision specified in the argument, ignoring `.gitignore`.

I assumed that you have app+default config committed to your repo (not 
including /var-like production data of course). In that case, a simple 
`git checkout` will do most of the job; you need to figure out how to 
handle .gitignore-ed trees (since these maybe version-specific).

-- 
An old man doll... just what I always wanted! - Clara
