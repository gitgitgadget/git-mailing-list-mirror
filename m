Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEDDEC61DA4
	for <git@archiver.kernel.org>; Wed, 22 Feb 2023 21:18:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232553AbjBVVSw (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Feb 2023 16:18:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232576AbjBVVSq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Feb 2023 16:18:46 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FAB61ADFC
        for <git@vger.kernel.org>; Wed, 22 Feb 2023 13:18:45 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id x34so7104975pjj.0
        for <git@vger.kernel.org>; Wed, 22 Feb 2023 13:18:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5krIwyT+8OS7XJSGe+bVcXb+w+VtayFDhQ59kbGa7wU=;
        b=jrDCUkJw7xpX+xYrMRXvmFbE0kM+SfDv5nmg519kycZ/6Dcxs01gTeJzGt5CLu7kkr
         g3aSz467+GvcrGCpuiPXhQsKIHDZ64hENuOzCWglw4ynaOlre/G4pKahmVq942BKWutc
         3RSpX4U8rKe8RvsAqkz2ZVt1SRPHOpZAz6vn8QvunL/TyrFQvXxuraW+79lpwMQGtMcS
         wOPqSkPHCJwZoG0T+4vEmZy/fcr3DgQgDKDoaPsnEBWHUlkjvR7/m8j9gzJzbbhvB4Bb
         1xUKCRaNgPA9sDbIUtp4Sh/FjjcftTWHiFu0NiHOiNs5Y1vRe1Sgh/dqfJyyIANoykoB
         5j7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5krIwyT+8OS7XJSGe+bVcXb+w+VtayFDhQ59kbGa7wU=;
        b=RTxne41q/vcgyotQFgxeDnaMsugJhkkZg5yK+XmI4NSOM6XcAYOk1iC5AaHxQrrTR8
         RpO0bpLR8Nqy/jMHmPAEY8osXnCFzI0r8JcSKqEDfGx98USzuqrLgbXeMJy6PzOMsq8+
         yMpSgOh1jTQcdkPR/q6nM7KEYANrjFeOYDqyDaJOIQboJnbLGiqjKS3UsY2GXCvyQARa
         wcTrcRMB0ezj0Jj10qW9JudO8tmnGK/Fb5xwbI+IyfpcD0/PelpEBZjoDLhyOYKkydCN
         Zzna/7WBAsGt1lsHFRM/OGvORt1NDCZtmcaMlpmKdKobpDVzgJs1jgk1nYY/kGkfUhkB
         Y2Lg==
X-Gm-Message-State: AO0yUKVQ92qULjbqXsTL3siSx3UNvBwmBgk2KX6DuW+rRHuR7JLjEE9g
        1yYWII9rlAXNg3eoM5UpiUjd
X-Google-Smtp-Source: AK7set9l1mTim8Iy8AVr71Q5eq1IUqmaBK1siwR0qPo/q3EU5QogXPQpZt0Bv/m0dN24559u0riUxQ==
X-Received: by 2002:a17:90b:224f:b0:234:157:a264 with SMTP id hk15-20020a17090b224f00b002340157a264mr9128263pjb.43.1677100724756;
        Wed, 22 Feb 2023 13:18:44 -0800 (PST)
Received: from [192.168.50.41] (cpe-172-91-184-234.socal.res.rr.com. [172.91.184.234])
        by smtp.gmail.com with ESMTPSA id bs7-20020a632807000000b004fadb547d0csm4014286pgb.61.2023.02.22.13.18.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Feb 2023 13:18:44 -0800 (PST)
Message-ID: <a6b0cf3b-af44-3d35-3de1-62aaf65f1543@github.com>
Date:   Wed, 22 Feb 2023 13:18:41 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.7.2
Subject: Re: [PATCH] Documentation/MyFirstContribution: add setup template for
 git send-email
Content-Language: en-US
To:     Vivan Garg <gvivan6@gmail.com>, git@vger.kernel.org,
        Emily Shaffer <nasamuffin@google.com>
References: <20230222011317.97943-1-gvivan6@gmail.com>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <20230222011317.97943-1-gvivan6@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It's generally good practice to CC contributors that have been recently
and/or heavily involved in the code you're changing. Given that, I've CC'd
Emily Shaffer (original author of the doc, including the section you'd like
to change).

Vivan Garg wrote:
> The doumentation under [[setup-git-send-email]] fails to describe what

s/doumentation/documentation

> needs to be done with the SMTP server information. Although the email
> provider will tell you the specifics (such as the serverport), it must
> always be added to gitconfig. By adding this, a new contributor can
> simply find the information and insert it into the template, saving them
> the headache of figuring out what to do with the information.
> Therefore, add a template that describes what to do with the
> information obtained through the email provider.
> 
> Signed-off-by: Vivan Garg <gvivan6@gmail.com>
> ---
> The commit subject line is over 50 columns long, but the file path takes 
> up the majority of the space, which I thought was important because it 
> shows that only the documentation is being edited.

Earlier commits related to this file start with just "MyFirstContribution:",
so you can leave out the "Documentation/" prefix to stay under the 50
character width.
 
> 
> The reason I felt compelled to include this is that, while it is simple 
> to find the SMTP server information required from the email provider, it 
> takes a little extra effort to figure out what to do with that information.
> However, because it must always be added to git config, making this change 
> makes it easier for anyone to find which fields they need and what they 
> need to do with the information. 
> 
>  Documentation/MyFirstContribution.txt | 30 ++++++++++++++++++++++++---
>  1 file changed, 27 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/MyFirstContribution.txt b/Documentation/MyFirstContribution.txt
> index ccfd0cb5f3..37fd416b29 100644
> --- a/Documentation/MyFirstContribution.txt
> +++ b/Documentation/MyFirstContribution.txt
> @@ -999,9 +999,33 @@ provider, and so will not be covered in this tutorial, beyond stating that in
>  many distributions of Linux, `git-send-email` is not packaged alongside the
>  typical `git` install. You may need to install this additional package; there
>  are a number of resources online to help you do so. You will also need to
> -determine the right way to configure it to use your SMTP server; again, as this
> -configuration can change significantly based on your system and email setup, it
> -is out of scope for the context of this tutorial.
> +determine the right way to configure it to use your SMTP server; this
> +configuration can change significantly based on your system and email setup, 
> +but at a minimum, you'll need to edit gitconfig and set the following 
> +parameters:

The section you're replacing explicitly states that providing example
configuration is out of scope for this document. That's for good reason; the
example config you've provided isn't universal to all developer setups. It
would be more confusing to a new contributor if we recommended a config
that's incompatible with their setup than if we left it open-ended as it is
now.

However, if you still want to make the guidance in this section more
specific, you could add a 'linkgit:git-config' link and note that the
relevant SMTP configs are under the 'sendemail' section.

> +
> +----
> +$ vim ~/.gitconfig
> +
> +[sendemail]
> +    smtpServer = smtp.gmail.com
> +    smtpServerPort = 587
> +    smtpEncryption = tls
> +    smtpUser = my_email@gmail.com
> +    # (Optional: we'll leave this commented out and use a different way)
> +    # smtpPass = PASSWORD
> +[credential]
> +    helper = store
> +----
> +
> + . This example uses gmail as the email provider and the official data
> +   available as of 21/02/2023. You should check the latest information for 
> +   the email provider you intend to use (including gmail).
> +   
> + . The `[credential] helper = store` tells git, when a user runs a git 
> +   command that requires authentication, to store the credentials in a file
> +   on the local machine so that the user does not have to enter them again 
> +   in the future.
>  
>  [[format-patch]]
>  === Preparing Initial Patchset

