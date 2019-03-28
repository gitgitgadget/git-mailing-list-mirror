Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.3 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ACB8320248
	for <e@80x24.org>; Thu, 28 Mar 2019 21:28:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726321AbfC1V2Y (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Mar 2019 17:28:24 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:37863 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726268AbfC1V2Y (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Mar 2019 17:28:24 -0400
Received: by mail-pl1-f193.google.com with SMTP id q6so5545348pll.4
        for <git@vger.kernel.org>; Thu, 28 Mar 2019 14:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=X1E5TEpifL3PZjNaYmyME72RLqXqZbLLejuU8T74SnI=;
        b=DFHpUeWB9FgidgEvVDSqYVT/20tCrY1AgWgEh7PUeYU4dTMB+u/d0BC5W+20H2QVpN
         PrB1Ru+h39yVLLj49NK7Jf4Yla2tSh0Yh66RD91mDgBT618XG9g3dnOpGxI3rzAfKTbh
         1VfQkXwWzTl+a3s3hzSlKLA9TA61BXgFKF+xindviONeAflfjMT53KB75eqJTcpU4SoA
         CESlK86Iy/MK9jqAI1H2X1BUx2W79hH05Gowb6dS8fiuv4Jtt98BQj30ELU5STn1PtYq
         0cJMomGnliNKWMig2hfRuuo6kXmfEOvkYcGFbqhL9QH3I5WVMzRSsSyRa6mpgeEih+7B
         TW9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=X1E5TEpifL3PZjNaYmyME72RLqXqZbLLejuU8T74SnI=;
        b=NWvod4lu4IlOgPg85zYwnnBoDZ1p8SGnSSHUCwBQ+5vbdDrF3DxyThtE/hdEPIfcTW
         ylYiwEViLce9GZMEtT2QzG8N3MzW50DnqSCFEp3RpCv6vlxzCcOkQTQuwtXWb4eWgA7y
         MJ9kaVQWmkBqFX2sCS3EMCVIu9sndXhrayUi1jPKK4pMNZzEhVaKfGt3IVwpA5ZFe2ue
         B0+mQY9wX88KQxbsuHxeM6/qci37zQ8QXpb0QUi/Z/OUZbIUCa2hqf9PrusBzYw1WMta
         NVXGNkuYz3ohZ1W5M5oUTDnaKlEBZCPTGdN7qH3PxgkwBoxL+LquP7K7HGR2EPJYaUpu
         bgXQ==
X-Gm-Message-State: APjAAAWGgxZmkFI9dyg6nznf2qR5h53vwXVuIAlEzGKOquhP+YcoOLdC
        3i8a4rljHNIUH6gblpxWIg75zKeyp8q/aw==
X-Google-Smtp-Source: APXvYqz97yvOxFlMU61h3xLenMzrLZ0qKKAw/x8wSjs9Wp4PHopCiFlBrtK+cFzFRtM4nAArK/oqNg==
X-Received: by 2002:a17:902:7d81:: with SMTP id a1mr37667576plm.202.1553808503735;
        Thu, 28 Mar 2019 14:28:23 -0700 (PDT)
Received: from google.com ([2620:0:100e:913:5bb:3076:546:99b0])
        by smtp.gmail.com with ESMTPSA id b16sm139610pfo.168.2019.03.28.14.28.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Mar 2019 14:28:22 -0700 (PDT)
Date:   Thu, 28 Mar 2019 14:28:14 -0700
From:   Josh Steadmon <steadmon@google.com>
To:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
        jrnieder@gmail.com, avarab@gmail.com,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH 4/4] trace2: use system config for default trace2 settings
Message-ID: <20190328212814.GB60888@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
        jrnieder@gmail.com, avarab@gmail.com,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <pull.169.git.gitgitgadget@gmail.com>
 <7e0d4e20fbb3abbc787bc216d2c4bd8c18860aed.1553779851.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7e0d4e20fbb3abbc787bc216d2c4bd8c18860aed.1553779851.git.gitgitgadget@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

One quick comment:

On 2019.03.28 06:31, Jeff Hostetler via GitGitGadget wrote:
[...]
> diff --git a/trace2.h b/trace2.h
> index 8f89e70c44..cda8349058 100644
> --- a/trace2.h
> +++ b/trace2.h
> @@ -38,7 +38,8 @@ void trace2_initialize_clock(void);
>  
>  /*
>   * Initialize TRACE2 tracing facility if any of the builtin TRACE2
> - * targets are enabled in the environment.  Emits a 'version' event.
> + * targets are enabled in the system config or the environment.
> + * Emits a 'version' event.
>   *
>   * Cleanup/Termination is handled automatically by a registered
>   * atexit() routine.
> @@ -125,8 +126,8 @@ void trace2_cmd_alias_fl(const char *file, int line, const char *alias,
>   * Emit one or more 'def_param' events for "interesting" configuration
>   * settings.
>   *
> - * The environment variable "GIT_TR2_CONFIG_PARAMS" can be set to a
> - * list of patterns considered important.  For example:
> + * Use the TR2_SYSENV_CFG_PARAM setting to register a list of patterns
> + * configured important.  For example:
>   *
>   *    GIT_TR2_CONFIG_PARAMS="core.*,remote.*.url"
>   *

Looks like the example needs to be updated with the new var name as
well.
