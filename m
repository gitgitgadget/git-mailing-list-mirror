Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 088E3C04A95
	for <git@archiver.kernel.org>; Tue, 25 Oct 2022 12:32:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231717AbiJYMcD (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Oct 2022 08:32:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231379AbiJYMcB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Oct 2022 08:32:01 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED9F3183E28
        for <git@vger.kernel.org>; Tue, 25 Oct 2022 05:32:00 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id e15so10152910iof.2
        for <git@vger.kernel.org>; Tue, 25 Oct 2022 05:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dWHTQQegnpKyvwvRrJcBspGRg7VDA+ri0ZOtGTNKGtw=;
        b=FMDOIIMqnPzThhnmpIP9sXIVlAWHccKKthvHjhW6F3+T0IGXlMtczlrludqAFHUKVv
         zmnu5ZJjRMyaREjrCnu01OvFJlnHxFeItSzJoYr4mntMO4lpag9epVeDQlAyMWQEN7WJ
         oJejbE8k/HOc9b74sXBQfnGQhLBQ2eyU1YAKGjHdD/2J8yBh6HkmFY0Gu8lN/5+K0SxP
         BE3DJc+f94FwB+xlgt1LE5FCJU/gxSO2jzJcKMoqwi9RFkjeIiLGyCpOZ9mSrgEa9Lus
         xiTKkdE6/olVcFwZSVDEMAmNY64u8ENgv6jQ8iCnOvl9fzbQqG9o0wjUGLb+gEAaTdip
         TXvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dWHTQQegnpKyvwvRrJcBspGRg7VDA+ri0ZOtGTNKGtw=;
        b=RG0QABT2IuwP0lcfQJWcAPgRiO5TXmAvF9Gcecqarz8aIuXBpzHUarTESJ+zNP9uzM
         FAmUYVVaRG+S/KT3WOSh1C4dAmo8EcQTlKos2LgNCL/2d28s6H3v8B3MO3C9NRAR4Qoo
         HdBHtzLPyxL/2aFI2/XYXvMEgoTxm/glcYn9pJOZy/hEZZTkwvAmEnwup+/IAkaoIjr/
         mqvTBwvpHHRJUtNcjMmPFDOwrjBDdAw3N8tLLpv5Lm7xRtuwYNEqp3JEvjHp3fRB87lH
         8AwyLLoazLfDx3U19BGUF+t/+dIkvwTX63Ey1pTjM8E94+SsSmR5Zz0gDg3wvrZJlCxH
         Hb+Q==
X-Gm-Message-State: ACrzQf0slanAuj93wheje21FcapvyTuoPyvii0goaTHVFzqQvti4ykQl
        fdQPpqg8e9N0a+/0GRUnc9Ck
X-Google-Smtp-Source: AMsMyM4Gxuk9nH4rGVUS8ISjqctQLbSdBoo1sgK2MXypMzZORzM2n8B8akfc/SaWcpsq9k7f6QgTwA==
X-Received: by 2002:a6b:ba41:0:b0:6bd:1970:16ac with SMTP id k62-20020a6bba41000000b006bd197016acmr15243333iof.15.1666701120333;
        Tue, 25 Oct 2022 05:32:00 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:880d:bbf9:8364:e715? ([2600:1700:e72:80a0:880d:bbf9:8364:e715])
        by smtp.gmail.com with ESMTPSA id h18-20020a056602155200b006bbddd49984sm1074250iow.9.2022.10.25.05.31.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Oct 2022 05:31:59 -0700 (PDT)
Message-ID: <3a7f43bd-2c48-6a37-7602-f4c938f7f58e@github.com>
Date:   Tue, 25 Oct 2022 08:31:58 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v2 2/3] glossary: add "commit graph" description
Content-Language: en-US
To:     Philip Oakley <philipoakley@iee.email>,
        GitList <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
References: <pull.1282.git.1657385781.gitgitgadget@gmail.com>
 <20221022222539.2333-1-philipoakley@iee.email>
 <20221022222539.2333-3-philipoakley@iee.email>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <20221022222539.2333-3-philipoakley@iee.email>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/22/2022 6:25 PM, Philip Oakley wrote:
> Git has an additional "commit graph" capability that supplements the
> normal commit object's directed acylic graph (DAG). The supplemental
> commit graph file is designed for speed of access.
> 
> Describe the commit graph both from the normative DAG view point and
> from the commit graph file perspective.

One way to help keep the general term and the file separate is to use
different notation. "commit graph" (with a space, no formatting) is the
DAG. "`commit-graph`" (with a dash, code formatting) is the file (and
its format).

> +[[def_commit_graph_general]]commit graph concept, representations and usage::
> +	A synonym for the <<def_DAG,DAG>> structure formed by
> +	the commits in the object database, <<def_ref,referenced>> by branch tips,
> +	using their <<def_chain,chain>> of linked commits.
> +	This structure is the definitive commit graph. The
> +	graph can be represented in other ways, e.g. the
> +	<<def_commit_graph_file,commit graph file>>.
> +
> +[[def_commit_graph_file]]commit graph file::
> +	The commit-graph file is a supplemental representation of
> +	the <<def_commit_graph_general,commit graph>> which accelerates
> +	commit graph walks. The "commit-graph" file is stored
> +	either in the .git/objects/info directory or in the info directory
> +	of an alternate object database.
> +

So this would become:

[[def_commit_graph_file]]`commit-graph` file::
	The `commit-graph` file is a supplemental representation of
	the <<def_commit_graph_general,commit graph>> which accelerates
	commit graph walks. The `commit-graph` file is stored either in
	the `.git/objects/info` directory or in the `info` directory of
	an alternate object database.

(I did some extra style and word-wrapping changes, too.)

Other than these nits, I find this to be a clear description.

Thanks,
-Stolee
