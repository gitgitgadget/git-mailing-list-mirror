Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C69EC433EF
	for <git@archiver.kernel.org>; Thu, 27 Jan 2022 15:19:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231777AbiA0PTZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Jan 2022 10:19:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231288AbiA0PTX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jan 2022 10:19:23 -0500
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C320C061714
        for <git@vger.kernel.org>; Thu, 27 Jan 2022 07:19:23 -0800 (PST)
Received: by mail-ot1-x335.google.com with SMTP id s6-20020a0568301e0600b0059ea5472c98so2822510otr.11
        for <git@vger.kernel.org>; Thu, 27 Jan 2022 07:19:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=TAqt0chO869o/N4npg7Nkt+gpqKTd8DjwxqJldaRyUU=;
        b=Z6D31nFVeJi5I69Mipb3ActNaq9kttMg1hqytgvAwCBJKtDDIt5Tgb7x5KhprElMQy
         EIicEd3L4YpVpZBLU7kRfdVUQPkEMogaaT9pj+R80L0PSyrSZ58mfTB+FvltZsQ9OM3H
         /c+VclxT74X+VDC9dH+aTFb5X658wKnUpXOuikqCxJLeeQYETMaw53Spl/blnLD+oH58
         q0Mewao/roviVG/cyX8zDr4XS7Ihb9pj8KsWBVNdTq4PPgSOTC7Pvgq4iIUi5Agu5tks
         Fl/3l7gibxZ5wnvEQ06jPYWKgO2WN4OdYWe9hbZX0skEjbmx/8sbPIP3Cwc6y0pN9SWV
         v/NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=TAqt0chO869o/N4npg7Nkt+gpqKTd8DjwxqJldaRyUU=;
        b=F8r2Zd52eYgL+lckQQDHnFeInxLgNBaoFbR1GGXm31nvAlI4bRFMUeo6pzT6IOP7tw
         YZKBzRnzbBhafgTVeHZvT3tA/8Rx5PYsrNHnXoaoUzchE4/tSIiSUYG/EGKpGZAbNHxp
         5I/EJnczLg7hJ5/GUN/VLIsG3Jw2UTkW0EG6fyxIXs0L3i+LYWxYnp+CXMaeuVstNRDC
         qc2pvQWzNyDrYLYYmnkEhRoVdohL+YiLc6S580+n7aJoclRdZeRoak+RvdEKLbdyPGkz
         qmAHW7kRUZHuFmu5iq+fh8GWTSNSOFgoVIiCqyhmWZo9nVC45WQWb+NLAoXqriX5Al31
         BuhQ==
X-Gm-Message-State: AOAM533vYS5iuBtwbHcU71NTJcEMNhNbDQo8Q4rE4SIeDyYmjhIXUTNI
        dMVR0TTprq4leE9mRujr4WE=
X-Google-Smtp-Source: ABdhPJzJoZkrLhmsK0wntV7SfUeJijyN7RQFMyPqn+KQayj7dI1AoDC/unpjm+YVG8ti1QjtfjMxIQ==
X-Received: by 2002:a9d:4e03:: with SMTP id p3mr2340287otf.299.1643296762617;
        Thu, 27 Jan 2022 07:19:22 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:d9cb:250e:9ea6:f8? ([2600:1700:e72:80a0:d9cb:250e:9ea6:f8])
        by smtp.gmail.com with ESMTPSA id bd41sm11074120oib.32.2022.01.27.07.19.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jan 2022 07:19:22 -0800 (PST)
Message-ID: <dda1b3c8-afc6-d9d5-1bfb-4a48ac87ca54@gmail.com>
Date:   Thu, 27 Jan 2022 10:19:20 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 0/5] scalar: implement the subcommand "diagnose"
Content-Language: en-US
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Emily Shaffer <emilyshaffer@google.com>
References: <pull.1128.git.1643186507.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <pull.1128.git.1643186507.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/26/2022 3:41 AM, Johannes Schindelin via GitGitGadget wrote:
> Over the course of the years, we developed a sub-command that gathers
> diagnostic data into a .zip file that can then be attached to bug reports.
> This sub-command turned out to be very useful in helping Scalar developers
> identify and fix issues.

For historical context: The 'diagnose' command was implemented in VFS for
Git and ported to the C# version of Scalar before 'git bugreport' existed,
but they serve very similar purposes.

I wonder if 'scalar diagnose' could include some of the information
captured by 'git bugreport' or whether this implementation of 'diagnose'
could help inform 'git bugreport' in any way.

CC'ing Emily for thoughts.

Thanks,
-Stolee
