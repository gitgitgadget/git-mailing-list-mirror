Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96555C6FD1D
	for <git@archiver.kernel.org>; Wed, 15 Mar 2023 17:45:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232229AbjCORpm (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Mar 2023 13:45:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232496AbjCORp3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Mar 2023 13:45:29 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1D9496C2C
        for <git@vger.kernel.org>; Wed, 15 Mar 2023 10:45:06 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id c19so17038413qtn.13
        for <git@vger.kernel.org>; Wed, 15 Mar 2023 10:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google; t=1678902295;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iIFQnIkToCLp3yg6OtO+9SFDQp9mgEwwwCt6ECIkL5g=;
        b=PTBmIS0zwqI9Zk2uCq5L6aGQGHwIxWtVrJ19pSl+sk7v+fybYqEVp4YnlxiwG8as/E
         6asD6hHEirJD8PLjBo9u3bnQDI83cCJ3Hu9wK5b2NJSuiV8Hjhc3wJOw1RqmrcyePwt2
         PYHMEUiTxfkQBgwO+XgrYqUVZy7iSSKiwOzIfoSjRvP3IbR7rw7TxK5EOvoeplqUvMs+
         bt0JYUuLf1meJzSWEtmROwL3uXXRTf7MBPBjuwnZZDBX7p4Yj+TBAutWakeKZfPJzkMQ
         QK3hVKzO1cdiE+u0WZC2Flmbmtxmv3edk6bPMjxGy1f154Bxa89Q2biATnkisc0UWr34
         1wGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678902295;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iIFQnIkToCLp3yg6OtO+9SFDQp9mgEwwwCt6ECIkL5g=;
        b=I6qv1W4/spzyWNuxbKYa3Agg6PMxftuQsiFl3WjpKYS6qhUOD+GNw8+AXW+0gsLLDk
         ateDZTM+cyVwRDYlK8jg2n8eMOgJbRGPUMNGQxKbtu/3oT742EnboA5SKvAYUGOpKLU6
         qcJNZRy4rxeec+zqmIkRydUCNbtLdpLt5mUSEBnhfAooclsHlrFnX43VtmrTfbY8SR/z
         CxtbHLAmRRJvdHwKwjJ0qZ5+Lj7sulY8G+teADK9dfMqoTgg1fv0kmYjirYhKxrGPYNF
         QzBMYN0iRNTWCUZ/EgDXv8aYmI84giXLOn7CLu8gUJS3mJhvvzW3mpd9Y01XNsMaZhZb
         ++7g==
X-Gm-Message-State: AO0yUKUL+1mzliceFVMJEhV3EBwB4cfnu6ItgD4KPh/LvsylU8SSYHht
        XxI79SJgD6cxkx7a7VO4Lfyc
X-Google-Smtp-Source: AK7set+9Z+tpdGc8QC/1WwQ8x3Ac1EsVIAfXg2Ro98E+BIpC8saR5+aRPwIedQqVPEVMOw2HAGGpfw==
X-Received: by 2002:a05:622a:1906:b0:3bd:1a07:2063 with SMTP id w6-20020a05622a190600b003bd1a072063mr1191707qtc.45.1678902295533;
        Wed, 15 Mar 2023 10:44:55 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:b4dd:42a2:285c:8312? ([2600:1700:e72:80a0:b4dd:42a2:285c:8312])
        by smtp.gmail.com with ESMTPSA id dm24-20020a05620a1d5800b00729b7d71ac7sm4162666qkb.33.2023.03.15.10.44.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Mar 2023 10:44:55 -0700 (PDT)
Message-ID: <97a34499-7dc0-72f7-abd2-1bd0a78fa956@github.com>
Date:   Wed, 15 Mar 2023 13:44:53 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2 0/8] ref-filter: ahead/behind counting, faster --merged
 option
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, me@ttaylorr.com, vdye@github.com
References: <pull.1489.git.1678111598.gitgitgadget@gmail.com>
 <pull.1489.v2.git.1678468863.gitgitgadget@gmail.com>
 <xmqqedpw5se6.fsf@gitster.g>
 <74656b93-8c67-ffe3-4aea-4c184345384d@github.com>
 <ZBIA7+85Lld+lpUS@coredump.intra.peff.net>
Content-Language: en-US
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <ZBIA7+85Lld+lpUS@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/15/2023 1:31 PM, Jeff King wrote:
> On Fri, Mar 10, 2023 at 02:25:52PM -0500, Derrick Stolee wrote:
> 
>>> Having read all the patches, I am very impressed and pleased, but
>>> are we losing anything by having the feature inside for-each-ref
>>> compared to a new command ahead-behind?  As far as I can tell, the
>>> new "for-each-ref --stdin" would still want to match refs and work
>>> only on refs, but there shouldn't be any reason for ahead-behind
>>> computation to limit to tips that are at the tip of a ref, so that
>>> may be one downside in this updated design.  For the intended use
>>> case of "let's find which branches are stale", that downside does
>>> not matter in practice, but for other use cases people will think
>>> of in the future, the limitation might matter (at which time we can
>>> easily resurrect the other subcommand, using the internal machinery
>>> we have here, so it is not a huge deal, I presume).
>>
>> I think the for-each-ref implementation solves the use case we
>> had in mind, I think. I'll double-check to see if we ever use
>> exact commit IDs instead of reference names, but I think these
>> callers are rarely interested in an exact commit ID but instead
>> want the latest version of refs.
> 
> One thing I'd worry about here are race conditions.
> 
> If you have a porcelain-ish view (and I'd count "showing a web page" as
> a porcelain view) that requires several commands to compute, it's
> possible for there to be simultaneous ref updates between your commands.
> If each command is given a refname, then the results may not be
> consistent.

> I don't know if this is how your current application-level code calling
> ahead-behind works, or if it just accepts the possibility of a race (or
> maybe the call is not presented along with other information so it's
> sort-of atomic on its own). Presumably your double-checking will find
> out. :)

I completely agree on both of these points.

The major lift in this series is that the two commit walk algorithms
are being contributed to the core project in a way that are easy to
modify our 'git ahead-behind' builtin to use the "new" internals
without any UX change. Actually porting the application layer to use
'git for-each-ref' instead would be a second step, where I'd plan to
do this deep dive. From what I understand, though, these race conditions
do exist already, but they are minor relative to the cost of doing a
lookup of all the ref values and then calling this backend.
 
> I do otherwise like exposing this as an option of for-each-ref, as that
> is the way I'd expect most normal client users to want to get at the
> information. And if this is step 1 and that's good enough for now, and
> we have a path forward to later expose it for general commits, that's OK
> with me.

And if we truly need more general committish inputs for tips (HEAD~10,
too), then a new builtin could be built on top. Modeling it after
for-each-ref (for-each-commit?) would be a good start to make the
behavior as similar as possible. Doing that in full generality might
require strange updates to ref-filter.[c|h], but we can cross that
bridge when we come to it.

Thanks,
-Stolee
