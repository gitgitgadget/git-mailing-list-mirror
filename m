Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D057FC352A1
	for <git@archiver.kernel.org>; Wed,  7 Dec 2022 15:27:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbiLGP1M (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Dec 2022 10:27:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbiLGP1K (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Dec 2022 10:27:10 -0500
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E0F7240BB
        for <git@vger.kernel.org>; Wed,  7 Dec 2022 07:27:09 -0800 (PST)
Received: by mail-io1-xd31.google.com with SMTP id h6so6197463iof.9
        for <git@vger.kernel.org>; Wed, 07 Dec 2022 07:27:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7jE49fkNuRT+mpX/QfDgrO2eJzg7q0GAZyQcebr4Cko=;
        b=TSU1GCKsvwC0LQ6W8Hi0VVXzvTNntAkaXRl7J144aBKARCWgXwLU2m+vnIJcFtzUnF
         ThLHNGgB/vCa28qqFfPcSKzIVfDbJs3qgVj5+tdnzFJSHmucMFFGwLzsvp/JKZhDPRZn
         vWKvm6wk+vgYnjK66Zq+v7jsYSEwquOpFuKXw5hQAr1fQC0Y3J5ELVcZkeDJGgGFd6FQ
         eJaBRnJIm6U4oeRwN/hofKT9t+ZYvr4Jy9lhx0CYfyyYO+gPJfftBiJxFMOFAVaDff5n
         VfQ8y6bqz+XozYbdwbWOfTVi4QDrodZrQ96Jo9BsQ6/Wo3sKBC7Slv68AQDZ+7ShhKrG
         JnPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7jE49fkNuRT+mpX/QfDgrO2eJzg7q0GAZyQcebr4Cko=;
        b=NnzPg9nidusudhkIH9w2QpwVGSp6lCxD+nBSveVs8pOLPlwtYVeH/Nw6SMJJd/dodK
         L4oIdOjeawX77egYSci1PCti2Hh7W2qh8f5TdznomL7/lDOUqytDUb5gl7tCZEFldLL1
         Ph2gpU7ooRDZ3UtqzR3by2wa1HU7/b/8dKfDgWh8FLhpKtEVJ89GCOiM/Za2ADv9TDU3
         JU7qY6rM/vib4AiEm06i0Wz/MqNvuZEBn7VOddbRranp4wHv3IURGrJ7XSA8R3XBd3Kx
         fVT9aJQw0A9JzoGVLuMghGH3z/dYvRC7B9VSxGdkf+OwD06DGwdxSVE/Ow9wgzJKI3mV
         /aYA==
X-Gm-Message-State: ANoB5pkRGxz6NVkRqSHKoLBRHH7eZQf8xwxAeTs0t1awxcElDPk52Un7
        LPG3VCVazxNWfu2LDz5ZLr1x
X-Google-Smtp-Source: AA0mqf4eemgFUIvPsf+0HyznRLjWuK8WwvuROE24pGmb+Eqg4+Cxa3WWxvuZXEn6WONJlw8eCCCXWQ==
X-Received: by 2002:a02:6309:0:b0:375:4dbf:6ca4 with SMTP id j9-20020a026309000000b003754dbf6ca4mr32226538jac.315.1670426828691;
        Wed, 07 Dec 2022 07:27:08 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:30a0:a841:72ac:2559? ([2600:1700:e72:80a0:30a0:a841:72ac:2559])
        by smtp.gmail.com with ESMTPSA id l8-20020a0566022dc800b006e0338b60a5sm1237555iow.22.2022.12.07.07.27.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Dec 2022 07:27:07 -0800 (PST)
Message-ID: <affbc458-d4f5-525f-d431-5ec1d489afc8@github.com>
Date:   Wed, 7 Dec 2022 10:27:06 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v3 10/11] bundle-uri: download bundles from an advertised
 list
Content-Language: en-US
To:     Jeff King <peff@peff.net>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, me@ttaylorr.com,
        newren@gmail.com, avarab@gmail.com, mjcheetham@outlook.com,
        steadmon@google.com, chooglen@google.com, jonathantanmy@google.com,
        dyroneteng@gmail.com
References: <pull.1400.v2.git.1668628302.gitgitgadget@gmail.com>
 <pull.1400.v3.git.1670262639.gitgitgadget@gmail.com>
 <69bf154bec63a22df8e5eac89f975625ce73c8ac.1670262639.git.gitgitgadget@gmail.com>
 <Y5CNo5kyByIHDVYh@coredump.intra.peff.net>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <Y5CNo5kyByIHDVYh@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/7/2022 7:57 AM, Jeff King wrote:
> On Mon, Dec 05, 2022 at 05:50:38PM +0000, Derrick Stolee via GitGitGadget wrote:
> 
>> +int fetch_bundle_list(struct repository *r, const char *uri, struct bundle_list *list)
>> +{
>> +	int result;
>> +	struct bundle_list global_list;
>> +
>> +	init_bundle_list(&global_list);
>> +
>> +	/* If a bundle is added to this global list, then it is required. */
>> +	global_list.mode = BUNDLE_MODE_ALL;
>> +
>> +	if ((result = download_bundle_list(r, list, &global_list, 0)))
>> +		goto cleanup;
>> +
>> +	result = unbundle_all_bundles(r, &global_list);
>> +
>> +cleanup:
>> +	for_all_bundles_in_list(&global_list, unlink_bundle, NULL);
>> +	clear_bundle_list(&global_list);
>> +	return result;
>> +}
> 
> The "uri" parameter in this function is unused. I'm not sure if that's
> indicative of a bug or missing feature (e.g., could it be the base for a
> relative url?), or if it's just a leftover from development.

Thanks for your careful eye. This 'uri' is indeed not needed. I think it
was initially there for relative URIs, but the given 'list' is expected
to have that value initialized. I'll make it clear in the doc comment.
 
> If the latter, I'm happy to add it to my list of cleanups.
> 
> There are a couple other unused parameters in this series, too, but they
> are all in virtual functions and must be kept. I'll add them to my list
> of annotations.

Your UNUSED annotations exist in my tree, so I'll try my best to update
them in the next version.

Thanks,
-Stolee
