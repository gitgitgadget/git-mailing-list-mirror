Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F0B0C636D7
	for <git@archiver.kernel.org>; Thu, 23 Feb 2023 06:23:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233363AbjBWGXy (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Feb 2023 01:23:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230356AbjBWGXx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Feb 2023 01:23:53 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EB5C2B28E
        for <git@vger.kernel.org>; Wed, 22 Feb 2023 22:23:52 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id c1so11858463plg.4
        for <git@vger.kernel.org>; Wed, 22 Feb 2023 22:23:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5v3yJ0FCHJLWch+KrcBOrSFC0ckRl4hNdzX7kEbRo/0=;
        b=HJBaYjQK35yivirh9Mq4322c+I4rjYWIr14Et9Kei7dMrzKWJvQ/CntFnk63iu9ZmZ
         kn0PW6RAZH4PpBJDzvrqhdU4fE9jhI2/cqurH+sgXDxljj25ILa006ZlAEuht80cu4wj
         3adWEMkrj4k9mG3cQIXtKF6jyi5n7imXFPbRidkapNgjmf+Rq/U2eenb2SnU5ba317fu
         YY0zEVDB50csnWheI2h+hbQbReo8VLouB9PKIvxrTRmpvBAu+UxAVVqoTFVuahP/zZyD
         Q6qfh7k0EBueQ7bKToksxJzwUWnAriSpijb3i0RIHqz/wMIlicO9t0xjof4rUpTW/K1k
         t26A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5v3yJ0FCHJLWch+KrcBOrSFC0ckRl4hNdzX7kEbRo/0=;
        b=rOBzQgontjPD/o8lbyxEusln5FeVuYqkP98Cf3EDWsYdLcvKUE9tadZUxSr7o1hVc4
         O3KUX8Zq79lhsHczCkd73B3+KeNu6T0kUe5EIrzqMqvoQzQG5fD9CqwDZNBdcCaQ6iGf
         ktK+cPh0JYkUyT/6Y7RIeSYzlKdWtzmCf/mzDAFyczac0nz55TvKjwnk5bCPsr/IORmu
         PN8i5rEIZtTLU54r7GIhhSZnPJhOaivFM3HG7mHHO7fy9fgup2c5CGDwkgHrb/aypeZ9
         c955kE7InToygJIwQL/Ec1DOA4VBcC0cl280HJF/Z0CuhN/NkDJ3mkh4lylJ5LmlM5Xs
         zS9A==
X-Gm-Message-State: AO0yUKWnODrlHfZzfsd0xAb2RWOrjfPxqY7yQkgzJqFPp7CzUHTRfsm5
        0oWQk5yz+sU4JO+/QextPAMPKoPIuCgLOog=
X-Google-Smtp-Source: AK7set/caZfOVPEPL10LZyhEMHwHb5S4Q/bEkKpR/Kbm1VEwxo7tnobV9ehM3n0XEjpREBlzC9NvYg==
X-Received: by 2002:a05:6a20:1585:b0:c7:5ba5:440e with SMTP id h5-20020a056a20158500b000c75ba5440emr9996782pzj.11.1677133431893;
        Wed, 22 Feb 2023 22:23:51 -0800 (PST)
Received: from [192.168.50.41] (cpe-172-91-184-234.socal.res.rr.com. [172.91.184.234])
        by smtp.gmail.com with ESMTPSA id b17-20020a639311000000b00502f86b2069sm386656pge.65.2023.02.22.22.23.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Feb 2023 22:23:51 -0800 (PST)
Message-ID: <cb69979d-a0f1-d4dc-6e94-2d1652ec69ea@github.com>
Date:   Wed, 22 Feb 2023 22:23:49 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.7.2
Subject: Re: [PATCH v2 1/1] MyFirstContribution: add note about SMTP server
 config
Content-Language: en-US
To:     Vivan Garg <gvivan6@gmail.com>, git@vger.kernel.org
Cc:     nasamuffin@google.com
References: <20230222011317.97943-1-gvivan6@gmail.com>
 <20230223054040.30088-1-gvivan6@gmail.com>
 <20230223054040.30088-2-gvivan6@gmail.com>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <20230223054040.30088-2-gvivan6@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Vivan Garg wrote:
> In the documentation on using git-send-email, it was noted that the configuration
> for sending email can vary based on your operating system and email provider.
> However, it was not explicitly stated that you will need to set up your SMTP
> server details in git's configuration file under the 'sendemail' section. 

This is a bit of an overstatement of the issue. The existing documentation
*does* say that you need to configure Git for your SMTP server:

> You will also need to determine the right way to configure it to use your
> SMTP server; again, as this configuration can change significantly based
> on your system and email setup, it is out of scope for the context of this
> tutorial.

The only thing it could use is a bit more specificity around which options
need configuring. With that in mind...

> This information is critical for users who are new to using git-send-email and may
> not be familiar with the additional setup required to use their SMTP server. By
> adding this note to the documentation, the aim is to provide users with a more
> complete understanding of the configuration process and help them avoid
> potential roadblocks in setting up git-send-email.
> 
> Signed-off-by: Vivan Garg <gvivan6@gmail.com>
> ---
>  Documentation/MyFirstContribution.txt | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/MyFirstContribution.txt b/Documentation/MyFirstContribution.txt
> index ccfd0cb5f3..ca095283d3 100644
> --- a/Documentation/MyFirstContribution.txt
> +++ b/Documentation/MyFirstContribution.txt
> @@ -1001,7 +1001,10 @@ typical `git` install. You may need to install this additional package; there
>  are a number of resources online to help you do so. You will also need to
>  determine the right way to configure it to use your SMTP server; again, as this
>  configuration can change significantly based on your system and email setup, it
> -is out of scope for the context of this tutorial.
> +is out of scope for the context of this tutorial. Additionally, note that you 
> +will need to set up your SMTP server details in git's configuration file. The 

...this sentence seems to ignore the one that precedes it. The documentation
just finishes telling the reader "you'll need to configure Git for SMTP",
which you now follow with "also, you need to configure Git for SMTP" -
basically saying the same thing twice. If you drop the sentence starting
with "Additionally, ...", though, the sentence after (starting with "The
relevant settings...") flows nicely from the existing paragraph while still
adding specificity to the SMTP configuration guidance.

> +relevant settings can be found under the 'sendemail' section (see 

super-nit: "the 'sendemail' section" could be clearer about the fact that
it's the a section *of the '.gitconfig'* - how about something like "the
'sendemail' section of the Git config file"?

> +linkgit:git-config[1]).
>  
>  [[format-patch]]
>  === Preparing Initial Patchset

