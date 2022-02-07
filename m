Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 116C1C433EF
	for <git@archiver.kernel.org>; Mon,  7 Feb 2022 14:29:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1392336AbiBGO2m (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Feb 2022 09:28:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1391059AbiBGOLA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Feb 2022 09:11:00 -0500
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A427C0401C0
        for <git@vger.kernel.org>; Mon,  7 Feb 2022 06:10:59 -0800 (PST)
Received: by mail-qv1-xf2c.google.com with SMTP id h9so1670603qvm.0
        for <git@vger.kernel.org>; Mon, 07 Feb 2022 06:10:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=StncPyhrpv7rZDBaU7/qOU/Cg29pLmcfVr2w0cEzVBU=;
        b=RnEn3isU19UTr30tzJzPVq77A7KwTPCwRxOGD8lILgyQvovmT8A18F5q35DJJVRKvb
         j+xzfc+0TFeDNE+BM2SrPcpWX0gNtiFS9lcJ5VKCZpSV8D9Z8HFg4NUgmxue2QwOsCTi
         /uhwxs/GJQRpkqys+x0sfP9uPuqmtVVU1CfWK0aNG1iclq8QweNrVRtqoqRsTNBTBRdC
         usuIqP8P0HG09WlZYujdMkbtjv0xddktP+yiwH5AQlG4/0oIMNSYHeSw7i7C02KGd8Im
         4B9naA5ZZdyqS9K4E5YOtLG8VpvXIna6AqIIQpSPkOj4R/EO99BSA3IsFXkGzJEz1Q7D
         CAuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=StncPyhrpv7rZDBaU7/qOU/Cg29pLmcfVr2w0cEzVBU=;
        b=ZB1TLYRVRI2M6uDQ8uywYRMDTvEPo06hT+fWKU0HxTmw1/2db7R1fUwLbDuYnrav+h
         2b6/7dqn7mwMzs3ysMFJUMiHNM+xolVc5YrPmVVc81PTg+XBWdDxI0k3T+pcIoneR3WR
         WjeN4aWA/sDRD+P2NNTzXWFLFo0sqDxgKhQ2ZIgYdyzWqNNGrtZ7CUKe+Q8PiUXnQbDB
         2JOFhZ5UIlyeYuPoR0KmcfWlar/VUzaCV8rw6TB1FwXGYtI68bhmNEingQV+7eLd61gQ
         GS5hMOfYpJNVwN+0EkhIfHgEuvSSpSqsJ/1ErRPrgB3Uelo+I/0d1bRi1rbYS0bFvzKv
         JRQw==
X-Gm-Message-State: AOAM533QiIEELpSQI8Qm5YuTUCC+tgTO9+8KU+MS2YW0aXxv6IRejiCk
        tq5y5CXSn44GZ/7dbt+v2P4=
X-Google-Smtp-Source: ABdhPJxN48wsh/2fDatJR6OUcFG8bwtWjWCab/LQ6Fl/Gd/MuseykmDP52EGTzFA2wODPpjV4E0BFw==
X-Received: by 2002:a05:6214:2129:: with SMTP id r9mr1056479qvc.76.1644243058551;
        Mon, 07 Feb 2022 06:10:58 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:2d61:adc7:f4c3:dd65? ([2600:1700:e72:80a0:2d61:adc7:f4c3:dd65])
        by smtp.gmail.com with ESMTPSA id u17sm5615635qkp.90.2022.02.07.06.10.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Feb 2022 06:10:57 -0800 (PST)
Message-ID: <7d1d3cb5-2bfc-4f82-5230-d4c8d5896649@gmail.com>
Date:   Mon, 7 Feb 2022 09:10:56 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v5 5/5] worktree: copy sparse-checkout patterns and config
 on add
Content-Language: en-US
To:     =?UTF-8?Q?Jean-No=c3=abl_AVILA?= <jn.avila@free.fr>,
        git@vger.kernel.org,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     sunshine@sunshineco.com, allred.sean@gmail.com, gitster@pobox.com,
        Elijah Newren <newren@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.1101.v4.git.1643136134.gitgitgadget@gmail.com>
 <pull.1101.v5.git.1643641259.gitgitgadget@gmail.com>
 <85779dfaed39220e18129e823aff9c95ade5985b.1643641259.git.gitgitgadget@gmail.com>
 <2328375.k9UJiU4Qo1@cayenne>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <2328375.k9UJiU4Qo1@cayenne>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/6/2022 5:36 AM, Jean-Noël AVILA wrote:
> On Monday, 31 January 2022 16:00:59 CET Derrick Stolee via GitGitGadget wrote:

Hi Jean-Noël. Thanks for your attention to the translatable messages
here:

>> error(_("failed to copy '%s' to '%s'; sparse-checkout may not work correctly"),
>>       from_file, to_file);

>> die(_("failed to copy worktree config from '%s' to '%s'"),
>>     from_file, to_file);

>> error(_("failed to unset 'core.bare' in '%s'"), to_file);

>> error(_("failed to unset 'core.worktree' in '%s'"), to_file);

> In the first patch of this series, you use _("unable to set '%s' in'%s'). Does it make sense to reuse this string here?

I would argue that "unable to set" is not appropriate for any of these
messages. Perhaps the "failed to copy" messages might be able to use
"unable to set", but the information that the config setting is coming
from settings the user controlled is valuable.

The "failed to unset" means "we are trying to _remove_ this setting
from the config file", so "unable to set" does not seem to work here.

I'm open to revisiting this if you disagree.

Thanks,
-Stolee

