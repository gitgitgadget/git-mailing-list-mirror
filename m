Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE7D8C636D3
	for <git@archiver.kernel.org>; Mon, 30 Jan 2023 19:26:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237463AbjA3T0W (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Jan 2023 14:26:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236501AbjA3T0L (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Jan 2023 14:26:11 -0500
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AFA73BD83
        for <git@vger.kernel.org>; Mon, 30 Jan 2023 11:25:58 -0800 (PST)
Received: by mail-oi1-x22c.google.com with SMTP id s66so10953792oib.7
        for <git@vger.kernel.org>; Mon, 30 Jan 2023 11:25:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lWU4yRKZ4sAEBosdwxFlzZ9sduBBjQgF+f/AGnRjCa8=;
        b=hYs965YEKaTRfOXNATzMl/176Eyo81rW2PHLXZd+KmW4DUmUtKDN7NEHK91uEHIBM6
         oGEoroBU3fdf/+Zk8+ovjkOfQm4Y5Y7f0R5zP5Bxn42k3mOGYk1ckkeCfaIhV91/0jAF
         PgK9RP10/kyi+Gy/3CvTIVNx0LAGU9Bm2h7mn4BS/5nmPioK2bwjSP85LXvgByWNDOSU
         qVuXW9isUWQevWgiY+GVJ+mzDfwum/1XYqwu7IKU/ZiTeeZbZf3269pCqSxM4FxamoYr
         wr5YOvmUrAeqoihf8Zhgjp1715wogd03qIjA7BSHXUCDcDZ2QoqefIBnp7DLnjxB1vU2
         4dWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lWU4yRKZ4sAEBosdwxFlzZ9sduBBjQgF+f/AGnRjCa8=;
        b=lr0+7DiYrUwP4bf2uOVkVUkv5VnI3S+J7oVr/l93vZtuWE5iNSFT9oYhzPJVldCDrc
         /TmhuS6y5eu0Ha/FKEiE1jn/gVcmqsd29zr3ZQEB4OSyKLSS7wGs6uiIpGQQ1i+1ow7U
         KzWAxqvBEE6X9Bm20+JnmuHQG6YF79LZNau+RBAk80xBsEzOQ0/H/pt00xF8MtRYzGeV
         ZnZtaOlTW06Ri1OVWDbZ+TroqMLdSov2rFcmKELfjSLb3Ndlb82Wp0Uw6Svty2W4aCNW
         53QSNcgIddhy9zj09q6BLFGbPqBcJzreKhwAV6XiZZqri6QTGeXuKUfEXv+y6zrSAs1k
         ObPA==
X-Gm-Message-State: AFqh2kpRA5dsP7XjAS/G8s9XJ2TCrkC2hdQuIMO5O/zUj4e1+4sI63TF
        mnMhlQu3FDYNdfvko3aESR2wg0TzDyT1UW4=
X-Google-Smtp-Source: AMrXdXuaQQ4l2gUEWWN6KsOxr9rRbAwqdQ9l2IplfGseNEjB1JOsWy/sNqPIOkA12LdjDPpV7k4bgQ==
X-Received: by 2002:a05:6808:138c:b0:364:5a4d:49c3 with SMTP id c12-20020a056808138c00b003645a4d49c3mr29491139oiw.10.1675106757986;
        Mon, 30 Jan 2023 11:25:57 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:ecb7:2dbf:e64c:6f68? ([2600:1700:e72:80a0:ecb7:2dbf:e64c:6f68])
        by smtp.gmail.com with ESMTPSA id e3-20020a056808148300b003785fa67bf8sm908330oiw.1.2023.01.30.11.25.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Jan 2023 11:25:57 -0800 (PST)
Message-ID: <1958e192-3ffe-ac10-4097-6da5eba02f4f@github.com>
Date:   Mon, 30 Jan 2023 14:25:55 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 3/3] scalar: only warn when background maintenance fails
To:     Victoria Dye <vdye@github.com>, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org
References: <pull.1473.git.1674849963.gitgitgadget@gmail.com>
 <d75780e0567b5f765816ab7522afe550ebaa3521.1674849963.git.gitgitgadget@gmail.com>
 <xmqqleln90ka.fsf@gitster.g>
 <3ade6d9f-8477-40c2-d683-d629e863c6ab@github.com>
Content-Language: en-US
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <3ade6d9f-8477-40c2-d683-d629e863c6ab@github.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/27/2023 5:18 PM, Victoria Dye wrote:
> Junio C Hamano wrote:
>> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

This reply almost got lost in the shuffle, but mostly because it
wasn't super-relevant if we were going with the --no-maintenance
option. It's relevant again, so I wanted to point something out.

> I see Stolee's approach as more in line with how FSMonitor is treated by
> 'scalar', which is "only turn it on if it's supported, but otherwise do
> nothing" (the main difference here being that a warning is displayed if
> maintenance can't be turned on). That still fits the stated goal of 'scalar'
> ("configure all the niche large-repo settings for me when I
> clone/register"), but it makes 'scalar' more forgiving of system
> configurations that don't support maintenance.
> 
> That said, this doesn't distinguish between "maintenance couldn't be turned
> on because the system doesn't support it" and "maintenance couldn't be
> turned on because of an internal error". The latter might still be worth
> failing on, so maybe something like this would be more palatable?
> 
> --------8<--------8<--------8<--------
> diff --git a/scalar.c b/scalar.c
> index 6c52243cdf1..138780abe5f 100644
> --- a/scalar.c
> +++ b/scalar.c
> @@ -252,6 +252,10 @@ static int stop_fsmonitor_daemon(void)
>  	return 0;
>  }
>  
> +static int have_maintenance_support(void) {
> +	/* check whether at least one scheduler is supported on the system */
> +}
> +
>  static int register_dir(void)
>  {
>  	if (add_or_remove_enlistment(1))
> @@ -260,7 +264,7 @@ static int register_dir(void)
>  	if (set_recommended_config(0))
>  		return error(_("could not set recommended config"));
>  
> -	if (toggle_maintenance(1))
> +	if (have_maintenance_support() && toggle_maintenance(1))
>  		return error(_("could not turn on maintenance"));
>  
>  	if (have_fsmonitor_support() && start_fsmonitor_daemon()) {

The tricky thing about this is that have_fsmonitor_support() is
something we can detect at compile time, while have_maintenance_support()
would not (unless we start building for a new platform).

The case that brought this up is a platform that has both 'crontab'
and 'systemctl' on the PATH, but when executing those commands an
error occurs due to permissions.

So, if we wanted to distinguish between permissions issues and/or
other unrelated failures, we would need to be able to parse the
output of those commands. That seems fraught with potential errors,
so it seems like we should _attempt_ to enable maintenance and warn
with whatever failure is presented.

The only thing I could think is that we could define a custom exit
code within 'git maintenance start' that means "we were able to
start the scheduler process, but it failed" to differentiate from
other kinds of failures, such as failing to write to global config.

Thanks,
-Stolee
