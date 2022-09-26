Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2DF6C32771
	for <git@archiver.kernel.org>; Mon, 26 Sep 2022 08:24:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234142AbiIZIYN (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Sep 2022 04:24:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234068AbiIZIYJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Sep 2022 04:24:09 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8439932DBE
        for <git@vger.kernel.org>; Mon, 26 Sep 2022 01:24:08 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id u24so7914334edb.9
        for <git@vger.kernel.org>; Mon, 26 Sep 2022 01:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date;
        bh=5pHCTYQ0Ptb9iZmtYq+rPIsdO+IDCvo3RRcAFZvM6K4=;
        b=qp7zQkQn9fjvEtkfLRJLNwTwYfHu31tNDEpg9dSUFPt/GTaHS8v7DlcuAz/2qcimuk
         +1lyjUN5v/B3Ac1La5g6NFnAjLNdmvIZN6YSpmMQyq9sD/zyuJUUgFc1KlRUcAGLlRJf
         JExx6vBXLgm6T0oXKxBxkyJbIcpuv5icFG62tj9mp5VObkPM2Y0otLGY2CpqAiFLsbQW
         /xhrmWZZo+sXrH7fosDI84WotFrFlG65E7fN0wS8Ez/aHmwxIt0mMMdg5lQCDVieIA13
         /BV4dM8/Ai625ROTd6w9xIGVHxby3PPyrCpNuxigJMa0lEITmD/2UNdUjKCdiHElR6Qc
         YHrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=5pHCTYQ0Ptb9iZmtYq+rPIsdO+IDCvo3RRcAFZvM6K4=;
        b=enkJ4Tfra+ZKY6VH98m97NTqk0x4tUYrkw9E6E30C5oq+PuPRI8xs1m30/1W5uzl9D
         yXkw9cziuuKqLGhVR9hF+GahgHbP/+qcXj8l3PIEUmfQi7d3AYQAPzYUEjvNXiuwJYaI
         HB1c7taW5o5rlHdxRxp2NR8OswmfLnJOHeW4IYcDCHrsz2iRJyFjmkHR8P9H4LdzEbqj
         FSzH9a/UY9Uj5oT+tANYWT5/qxKhz1TDr7b2onMpiWxsBfbzOQLb9ld+j4d9ImuK3H17
         uoMaNFyK2MKzSh4OHmS+JJp7o8lKaDRuH4JeN1lwz+d0yt2CIBDBE7ndCX/2vSQ0Oyte
         ydLQ==
X-Gm-Message-State: ACrzQf0eDs2JXwWHeLzg/AHm/xuI4Zydn6yPpJyCR/jAp/Ret2zPHCSj
        Jbe6Ll1UiPT1tFtIS2QlK7P85ESj5nQ=
X-Google-Smtp-Source: AMsMyM4fRgPxSXtoR2Zv/WCbR/aVsUXzC3OBKg/rArx5ARB8bmuddro8be5HnrxhtA/8ROB9cj7AEg==
X-Received: by 2002:a05:6402:2787:b0:451:d655:9269 with SMTP id b7-20020a056402278700b00451d6559269mr21281456ede.375.1664180646466;
        Mon, 26 Sep 2022 01:24:06 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id b2-20020a1709063ca200b0076fcde2ff37sm7957051ejh.70.2022.09.26.01.24.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 01:24:05 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1ocjPK-003m8j-0U;
        Mon, 26 Sep 2022 10:24:06 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     Stefan Xenos via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Christophe Poucet <christophe.poucet@gmail.com>,
        Stefan Xenos <sxenos@google.com>
Subject: Re: [PATCH 07/10] evolve: implement the git change command
Date:   Mon, 26 Sep 2022 10:23:24 +0200
References: <pull.1356.git.1663959324.gitgitgadget@gmail.com>
 <914028341842a4d57e02ec42a7426d3aa83640f9.1663959325.git.gitgitgadget@gmail.com>
 <61a01fdf-9805-ff8d-6306-ff49f31e93c2@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <61a01fdf-9805-ff8d-6306-ff49f31e93c2@gmail.com>
Message-ID: <220926.867d1q4k7t.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Sep 25 2022, Phillip Wood wrote:

> Hi Chris
>
> On 23/09/2022 19:55, Stefan Xenos via GitGitGadget wrote:
>> From: Stefan Xenos <sxenos@google.com>
>> +static void init_update_state(struct update_state *state)
>> +{
>> +	memset(state, 0, sizeof(*state));
>> +	state->content = "HEAD";
>> +	string_list_init_nodup(&state->replace);
>> +	string_list_init_nodup(&state->origin);
>> +}
>
> In general we prefer to use initializer macros over functions. So this
> would become
>
> #define UPDATE_STATE_INIT {			\
> 	.content = "HEAD",			\
> 	.replace = STRING_LIST_INIT_NODUP,	\
> 	.origin = STRING_LIST_INIT_NODUP	\
> }

*nod*, although our usual style is not to indent the "\"'s like that. But just:

	#define FOO { \
		.bar = "baz", \
		[...]
