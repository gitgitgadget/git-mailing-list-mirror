Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69F64C433E0
	for <git@archiver.kernel.org>; Mon, 18 Jan 2021 18:28:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41E4522CA1
	for <git@archiver.kernel.org>; Mon, 18 Jan 2021 18:28:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405585AbhARS15 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Jan 2021 13:27:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393685AbhARS1q (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Jan 2021 13:27:46 -0500
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64003C061757
        for <git@vger.kernel.org>; Mon, 18 Jan 2021 10:26:59 -0800 (PST)
Received: by mail-qk1-x736.google.com with SMTP id d14so19479811qkc.13
        for <git@vger.kernel.org>; Mon, 18 Jan 2021 10:26:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=BhmPGBR3P+ohmUMk+JruN5hAjAE3y8qNQ7uZ4Wd4RZM=;
        b=vLs5XdfSYR0zlAynodQIx3u14qMQOxJI+PbuNd0Mj/B+yj0Wr/yreyWL3rEewxg2Fa
         VBrL0SCJypvcTfG55nKxU49NLvYd0wiv34nnRqhC5T5vjDEhB1FRmH1oW/xtH6X1LH4R
         Sc5EJhXmwfwNP9op7HAyoESRXWuPwIf/oKL/gUSSakdEsh446dL+LxzhG05YegudNwCB
         uAXLturEK8hk7VOsTzN+KlPRCs0jf0mNCsq8PUk3aOzVRi1aaqU/zwpgUOGB0L/k0rpa
         D1yCdrcOylkXBJ767S/nNhfcEiTHv9C5/IZpYZiH3ObkYAbugIhZ/2pbzYRzY/JBWKts
         3krQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BhmPGBR3P+ohmUMk+JruN5hAjAE3y8qNQ7uZ4Wd4RZM=;
        b=YoM1wyK8Lnp5GSY8HUA53+wZHez3puBZgopfmhkKQwdwBOecBVO4OfnNqasOhm9Io8
         dIANodA6ixY7x75sXU6MjF3YCv7BPwv6SA2rYEqWzboIaJJCvszSPWygjMtGOI3pW7Qs
         +VKVBrCtxGNrF7ZVtMbuNSoOmqLKhjOxLOlYGRUyxB3QziF8KYdcJt9so5HUm2zx/Ce2
         A23ZBkULzxiwyMr4IU/zvk1dTWCu/HcsRuRt/d0x85j7Gx2KKySlMZ72MEtCquZXcIp9
         GxTROnAtxNZRXcvIHCZHQ/a6kTBRX1A0U7XcX7ehmxyM0y6u/rXBPH8VuLPgHX5mjmYz
         QBGw==
X-Gm-Message-State: AOAM5339HYQapG3UAoJ8Vh1SQNysPGAbY241x+a7nNY/ukN1uib3N62s
        W87BqXUmcg+Tj3PG/CSeAvAJEVxz6jw=
X-Google-Smtp-Source: ABdhPJw3ZQvSLdcZMOj0lqIelzfaTcWQnkpEr4Ae2/0sibrA+JN296NzniruEIBarT75vFnb4oX7iA==
X-Received: by 2002:a37:61d4:: with SMTP id v203mr812293qkb.391.1610994418347;
        Mon, 18 Jan 2021 10:26:58 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:1583:40fe:1fef:8885? ([2600:1700:e72:80a0:1583:40fe:1fef:8885])
        by smtp.gmail.com with UTF8SMTPSA id c14sm10666718qtp.4.2021.01.18.10.26.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Jan 2021 10:26:57 -0800 (PST)
Subject: Re: DEVEL: Help with feature implementation
To:     Aiyee Bee <shane.880088.supw@gmail.com>, git@vger.kernel.org
References: <C8MHFL3YJDSF.1GLOUSV7BYS1X@localhost>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <60516c8b-adc0-18a5-ac26-b147b1857016@gmail.com>
Date:   Mon, 18 Jan 2021 13:26:57 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:85.0) Gecko/20100101
 Thunderbird/85.0
MIME-Version: 1.0
In-Reply-To: <C8MHFL3YJDSF.1GLOUSV7BYS1X@localhost>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/18/2021 1:06 PM, Aiyee Bee wrote:
> Hello everybody!
> 
> I want to implement a feature in git, and I'm looking for some help.
> 
> I wanted to add a history-simplification option to rev-list so that it
> doesn't simplify away any irrelevant commits if they have multiple
> relevant _children_, i.e. when they are the point where two relevant
> histories diverge.
> 
> Basically the effect I want for --show-forkpoints (named like --show-pulls):
> http://ix.io/2Ms6

I think what you really want is --full-history --simplify-merges [1]. This
will show the merges that "fork" the history into parallel tracks where
at least two of them contain interesting commits.

Note that this option is expensive to compute, as it walks every
reachable commit before returning a single result.

Thanks,
-Stolee

[1] https://git-scm.com/docs/git-log#Documentation/git-log.txt---simplify-merges
