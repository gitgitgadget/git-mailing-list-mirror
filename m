Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EE1EC433EF
	for <git@archiver.kernel.org>; Mon, 28 Feb 2022 09:47:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234452AbiB1Jrq (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Feb 2022 04:47:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230193AbiB1Jrp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Feb 2022 04:47:45 -0500
Received: from smtp5-g21.free.fr (smtp5-g21.free.fr [212.27.42.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FB556A016
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 01:47:06 -0800 (PST)
Received: from [192.168.3.156] (unknown [92.173.128.58])
        (Authenticated sender: jn.avila@free.fr)
        by smtp5-g21.free.fr (Postfix) with ESMTPSA id 661125FFCF;
        Mon, 28 Feb 2022 10:47:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
        s=smtp-20201208; t=1646041623;
        bh=RS9g+2C4UO2tW69Xoy7kfZutVPaSRFcxU1uqF7iA3RE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=T5LhCuRtHJHdCjRokRW8/wtF0JLTTEuQbn3WHp8SiisHhfJOKda45Jq0ATFZTa1qc
         L5pYFD8Z/NRAch5rtbDZ4cfzZ6922mGrciaiKZgEEY2SRIyrrBL4/2P3SA8QcFroZ8
         myvYaycV1ItJn2bF/HeVBrmmcyRDssFxmYmnPGvjTP8kWmii6brggCpcLKiPntTm2E
         AToNSTOuXu1plHo2zzuYJEUQf1uCR6xtyc4k2nJx1bU52h3Xzxq4F9zHtrCjykZuxE
         Ro1pq3hf2Olamxo2QAmewo+A/p3Lik9CDWI7zmm1PQ4pclgSQg7Ou9lcCPWG3SMn3F
         JlHF+dH29RPiQ==
Message-ID: <90fcd727-414f-fc1f-fab3-2cbce5790aa0@free.fr>
Date:   Mon, 28 Feb 2022 10:47:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] worktree: add -z option for list subcommand
Content-Language: fr
To:     Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
References: <pull.1164.git.1645801727732.gitgitgadget@gmail.com>
From:   =?UTF-8?Q?Jean-No=c3=abl_Avila?= <jn.avila@free.fr>
In-Reply-To: <pull.1164.git.1645801727732.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Le 25/02/2022 à 16:08, Phillip Wood via GitGitGadget a écrit :
> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
>
> @@ -696,6 +702,8 @@ static int list(int ac, const char **av, const char *prefix)
>   		usage_with_options(worktree_usage, options);
>   	else if (verbose && porcelain)
>   		die(_("options '%s' and '%s' cannot be used together"), "--verbose", "--porcelain");
> +	else if (!line_terminator && !porcelain)
> +		die(_("'-z' requires '--porcelain'"));
>   	else {
>   		struct worktree **worktrees = get_worktrees();
>   		int path_maxlen = 0, abbrev = DEFAULT_ABBREV, i;


Please better use

  die(_("the option '%s' requires '%s'"),  "-z", "--porcelain");


In order to make a no-op for translators.


Best regards,

JN

