Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B96CF1F453
	for <e@80x24.org>; Wed, 31 Oct 2018 15:08:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729246AbeKAAHL (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Oct 2018 20:07:11 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:37682 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728920AbeKAAHL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Oct 2018 20:07:11 -0400
Received: by mail-qk1-f194.google.com with SMTP id 131so10006480qkd.4
        for <git@vger.kernel.org>; Wed, 31 Oct 2018 08:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=Tk8ObhPUTwOhhUtXr60TP5fITpXaEPIRsj5iM3NlfFI=;
        b=vJG7o0xt5ch4USS2HC/t61tpvZMlUVNxEjzx7y4iwvY1ISAYVuoa2I4yedNF1i/4zx
         IFRuUq4bzgZ+UOzDnTux/UBDAq7HC/cTXQAiAcxUFTzYjE1HfPQhNsBQ38DNb9Oma0jI
         JQ+vfMQdV80zUChlHW759+OY+Ob4mfSlnbcN2yfFEaBYppY09qJI/i3kEeNGAIhM7MmV
         pIs/DKpXnysGpetaoDfkFSI/GiFQfQcEfAtzHOls3afnyHQQ51SgAQ5v2I+DoUAOuEIq
         ihib1ZTqsRAtQq35/qR4C9REaw1+UCQaPMnN4aBcG6bfn1Hr+TCF6gttCLT5yctA5vnB
         CkFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Tk8ObhPUTwOhhUtXr60TP5fITpXaEPIRsj5iM3NlfFI=;
        b=dLmtBsj6lTudi3ElSrolBje+/vyKk7g/wyI7X0zhVrtkGOqwjVGT0JFVe1dOOJxAIl
         x4qNYR26ST6rX9EveCMSTlLx2RVXVPU2PcuHxC7l1VYr30z9bLn2/xLkv78B0Q/clF6w
         tY2QhxCY2ATH/Pip5n5ayRpHYPJgd4HDvmYHkwdCwzHq8OoEikFjOhwNfUFo7TpoDzd3
         JJf1GmSWTjNhG6plqNDd7S7vY503N4hQvRP3qCq0HfwV917e8q4MOGuJrVCzrWtveML6
         +1PKfVpCZvjlaCdQD7vESz5+4qBUQmqJxoV8qmCV1V0AWwm4QXEeDxPqhriZmTiXJjVE
         t9xw==
X-Gm-Message-State: AGRZ1gKXJVzwDPbBAtWzdmZWDI0dF2jh3g0TSTI7OI8iYBTRHyLvwmIM
        GjrVRIGrlFYPmY1C+BXdPaI=
X-Google-Smtp-Source: AJdET5e22SCB7ft8j+uBDzU7ulEvk5/k58M8ojvkwK6CDETle6job46xoy0cy7mjjxOrlvuV6AyWig==
X-Received: by 2002:ac8:3114:: with SMTP id g20-v6mr2963123qtb.312.1540998525594;
        Wed, 31 Oct 2018 08:08:45 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:1547:f48:38e6:a522? ([2001:4898:8010:0:fe7c:f48:38e6:a522])
        by smtp.gmail.com with ESMTPSA id g80sm2579790qkh.41.2018.10.31.08.08.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Oct 2018 08:08:44 -0700 (PDT)
Subject: Re: [PATCH v3 8/8] merge-recursive: improve
 rename/rename(1to2)/add[/add] handling
To:     Elijah Newren <newren@gmail.com>, git@vger.kernel.org
Cc:     gitster@pobox.com
References: <20181014020537.17991-1-newren@gmail.com>
 <20181019193111.12051-1-newren@gmail.com>
 <20181019193111.12051-9-newren@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <d23b4e26-4df4-273d-a75c-a0af915a6e5e@gmail.com>
Date:   Wed, 31 Oct 2018 11:08:45 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:64.0) Gecko/20100101
 Thunderbird/64.0
MIME-Version: 1.0
In-Reply-To: <20181019193111.12051-9-newren@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/19/2018 3:31 PM, Elijah Newren wrote:
> [snip]
>
> +			char *new_path = NULL;
> +			if (dir_in_way(b->path, !o->call_depth, 0)) {
> +				new_path = unique_path(o, b->path, ci->branch2);
> +				output(o, 1, _("%s is a directory in %s adding "
> +					       "as %s instead"),
> +				       b->path, ci->branch1, new_path);

I tried really hard, but failed to get a test to cover the block below. 
I was able to
find that the "check handling of differently renamed file with D/F 
conflicts" test
in t6022-merge-rename.sh covers the block above. Trying to tweak the 
example using
untracked files seems to hit an error message from unpack-trees.c instead.

> +			} else if (would_lose_untracked(b->path)) {
> +				new_path = unique_path(o, b->path, ci->branch2);
> +				output(o, 1, _("Refusing to lose untracked file"
> +					       " at %s; adding as %s instead"),
> +				       b->path, new_path);

It could also be that I failed because I'm less familiar with this part 
of the
codebase. Elijah, do you think it is possible to hit this block?

Thanks,
-Stolee
