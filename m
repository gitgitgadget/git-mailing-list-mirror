Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54938C54EBD
	for <git@archiver.kernel.org>; Sat,  7 Jan 2023 00:37:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236387AbjAGAhF (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Jan 2023 19:37:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236794AbjAGAgk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Jan 2023 19:36:40 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ABE240C0D
        for <git@vger.kernel.org>; Fri,  6 Jan 2023 16:35:55 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id w13so1479643wrk.9
        for <git@vger.kernel.org>; Fri, 06 Jan 2023 16:35:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ugemgnT6eWiKyDxIeaMjSCD8aOYSsWtY9m4/jbaXhBg=;
        b=mD8NEA1rrD/sxrBmeS0tDa/9wnW1Ov6M2I/PTQ8m1SfuHy+ufpvngJE4byhSzX7cy5
         I/bVTiTLQK2tvxaTYHYxUj9jAWQZiYSdh6g9fqK1+qwqhRNY/IHYI5zjnNhcHy5ZQZTD
         AFz19Ktc8v8sD9ku1pYNP5D+xNWMlNvnRB74ye/giTo/xhXQyhpdMXUqLoHv899OcwpB
         75EqWn4QrNn1tDeGX7B95OVgYBKl6iQa3LiZBnOVv/QTIHjApNarDLqn6g8wDf0JpIex
         LIc7+UP06QluZg1c5bVilmlIiNx/pfUCu5ea5GsV9ioFh/2OuI8CfYjTQJZEkoMzo8f5
         FY8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ugemgnT6eWiKyDxIeaMjSCD8aOYSsWtY9m4/jbaXhBg=;
        b=x1sc307emHDJCYAszsbHiLcE1y2f3dpFzQ5qPyYyMjJXhaXAKjqpt9AF/9DLvvWjSu
         dqOSbwlNgoieIF1msM7LxlxLIv4ITzB6IO48MsEKQbfLMf9sDVR4C25xLYlWxcW3ryvU
         sTe7ZR7c7mBq3gdCAwP0tW/LwxevSD3QOikAtphcW9IK5XmCrs8HuTh2h6BS2pLimFXt
         H4D2M3omSpeiCYvue2Tfvmu6z5Js7v3OkqSbxi1CJAWi7n0zkDVI+urPw+cqAhIjb4U+
         fhjYdB+84f8leCdnhgAyLKEYNbsztanHGZAug9WPTFoXuvT3Ve1Mzp7U4pv9ZhsMd4MS
         xH+A==
X-Gm-Message-State: AFqh2koWnSJDUQZnNQFcQ+vthzWLJJ5fcLZRPyIHvlM8gvblbJkCy+GV
        MANmLgIWt1uvakewwUg0YJLj29VH7Lo=
X-Google-Smtp-Source: AMrXdXvo4fFLvnSkBCrvcNKqjP1LDnIhDb/ZODrD+CB8IljREO1qqDj+coTe9FQf3vZVbRpumagGyw==
X-Received: by 2002:a05:6000:501:b0:26b:8177:a5e6 with SMTP id a1-20020a056000050100b0026b8177a5e6mr33924458wrf.51.1673051753996;
        Fri, 06 Jan 2023 16:35:53 -0800 (PST)
Received: from [192.168.2.52] (94.red-88-14-213.dynamicip.rima-tde.net. [88.14.213.94])
        by smtp.gmail.com with ESMTPSA id h15-20020a5d548f000000b002425dc49024sm2416463wrv.43.2023.01.06.16.35.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Jan 2023 16:35:53 -0800 (PST)
Subject: Re: [PATCH 1/2] branch: description for orphan branch errors
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>,
        Derrick Stolee <derrickstolee@github.com>
References: <ffd675e9-8a64-ae05-fc3b-36ae99092735@gmail.com>
 <dd86016b-3232-563b-940e-03bc36af917a@gmail.com> <xmqqy1qmhq8k.fsf@gitster.g>
 <18ca1e65-3e26-8352-cabd-daebdd0cf7f2@gmail.com> <xmqqr0wau6px.fsf@gitster.g>
 <db348ac3-571c-f6ba-c889-9f476f4ae04b@gmail.com> <xmqq8rifp63p.fsf@gitster.g>
From:   =?UTF-8?Q?Rub=c3=a9n_Justo?= <rjusto@gmail.com>
Message-ID: <9a050344-27ea-4f26-e66a-2795596eb11d@gmail.com>
Date:   Sat, 7 Jan 2023 01:35:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <xmqq8rifp63p.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On 7/1/23 0:59, Junio C Hamano wrote:
> Rubén Justo <rjusto@gmail.com> writes:
> 
>> Thinking of this as a whole, perhaps after this series we can add:
> 
> Why "after"?  If we already know that the existing patches are
> making things worse and need to fix the regression with a future
> patch to make it usable again, why introduce a regression in the
> first place?
> 

I'm not sure if it is so worse, and if the optimization is a fix.

We're actually paying for worktrees twice in:
reject_rebase_or_bisedt_branch() and
replace_each_worktree_head_symref().

Making the change this way makes more obvious IMHO what we are moving
and why.

Start moving the ref_exists() in 1/2, easily leads to 2/1 and this patch
squashed with 1/2, for little gain (IMHO) and worse history.

This is why I think it's a good sequence.  But I understand your point
and I'm not opposed to doing it as you suggest if you think the current
way doesn't pay off.
