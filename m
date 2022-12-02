Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3130BC4321E
	for <git@archiver.kernel.org>; Fri,  2 Dec 2022 16:18:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234009AbiLBQSn (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Dec 2022 11:18:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234001AbiLBQR4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Dec 2022 11:17:56 -0500
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D1FEE51D8
        for <git@vger.kernel.org>; Fri,  2 Dec 2022 08:16:44 -0800 (PST)
Received: by mail-qt1-x831.google.com with SMTP id x28so4685398qtv.13
        for <git@vger.kernel.org>; Fri, 02 Dec 2022 08:16:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W58VKq2beeRPRr+ZtwVCwh8pb3a88/TJfNMTAC/Gmn8=;
        b=XzRWBrYjfl8sIx2t4JebS+Qj+qoi4H930Wg0LDEDxjLh8F/WuC5zL+jwdUfNdXYyay
         nuisMdGMD0h/TIgWQyKyKJV/ISCv9ccX49qIg2296SBB+6NbH+H3D8Vbo+CIWdkdexBH
         /J/O5XihGnB7OpZCiGv+hGtdWpH+WV6Fq39Xtj90mgj3T7auShZyV5JLh+klXelipu22
         uVwcYsJM9jwTTL9WkD4udRFV/As5GR1MVtB6GxHV+m6bBj3cdy6V0Zv+NSJY5TyvZCip
         Bkf/4WhjjyV2avgI+wcpF5dqTLv3O1kcOnPx0IUqaQawBIE2k2opdNTFVu5azUIEMLky
         m1OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W58VKq2beeRPRr+ZtwVCwh8pb3a88/TJfNMTAC/Gmn8=;
        b=WawOjc//vQ+6lya9WdvebKdY6UTSN2S8tWarHYuB6CX5BIJ2tvYRtpYgRhJIs1dqOK
         U9CWjKp3jgkar8jphl5yRWV+4XvJl9uYxjSP8eoT0DLrhlbBqulikEXSBzGBPlMtptj2
         gmHv5STxmII+N+wUrRIKpbMuQkWujtqtNpkIGKO7FVq3Y23Iro2TeD5i1KFqphq4ishm
         ICpoRbOaJfM5RKKQUUEHZNQ2NbL74LUtekV88sLwLuC1EqgMqhVt+1UXJORuBDFd98D0
         HxuhT+kJqUGiAhUvZNz/U4OATlWOePzykh+Eozp5XygAXECRsbdvU7BCOiSIi0MU+kpn
         Bkeg==
X-Gm-Message-State: ANoB5pnCbaFqmokJ9LIEhV4ONV76FEh9uEBtGuPt+5j9i9rPhGRQpu5z
        gqRKLyIrx+la+hgPfsFKXC68
X-Google-Smtp-Source: AA0mqf5hpcUNQQb8dA+SPNOqXtwEbzYwNwyqVSGJAtPJ/1UGVkKOCFdCyzRbp8dQ6hmWZ+NSc7skwQ==
X-Received: by 2002:a05:620a:8019:b0:6fa:5257:9aa7 with SMTP id ee25-20020a05620a801900b006fa52579aa7mr48614472qkb.150.1669997803645;
        Fri, 02 Dec 2022 08:16:43 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:8051:a31f:2c93:87e9? ([2600:1700:e72:80a0:8051:a31f:2c93:87e9])
        by smtp.gmail.com with ESMTPSA id w21-20020a05620a0e9500b006e07228ed53sm5623752qkm.18.2022.12.02.08.16.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Dec 2022 08:16:43 -0800 (PST)
Message-ID: <e4b6363a-58a4-a11e-d33e-c0bc9c755d72@github.com>
Date:   Fri, 2 Dec 2022 11:16:41 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v2 9/9] clone: unbundle the advertised bundles
Content-Language: en-US
To:     Victoria Dye <vdye@github.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, newren@gmail.com,
        avarab@gmail.com, mjcheetham@outlook.com, steadmon@google.com,
        chooglen@google.com, jonathantanmy@google.com, dyroneteng@gmail.com
References: <pull.1400.git.1667264854.gitgitgadget@gmail.com>
 <pull.1400.v2.git.1668628302.gitgitgadget@gmail.com>
 <b62b4b1748194f0c7b81536701f15aa0df8e1d9b.1668628303.git.gitgitgadget@gmail.com>
 <9522d667-da4d-6eb0-8f1c-1396ebc0351c@github.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <9522d667-da4d-6eb0-8f1c-1396ebc0351c@github.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/28/2022 8:59 PM, Victoria Dye wrote:
> Derrick Stolee via GitGitGadget wrote:
>> From: Derrick Stolee <derrickstolee@github.com>
>>
>> A previous change introduced the transport methods to acquire a bundle
>> list from the 'bundle-uri' protocol v2 command, when advertised _and_
>> when the client has chosen to enable the feature.
>>
>> Teach Git to download and unbundle the data advertised by those bundles
>> during 'git clone'.
>>
>> Also, since the --bundle-uri option exists, we do not want to mix the
>> advertised bundles with the user-specified bundles.
>>
>> Signed-off-by: Derrick Stolee <derrickstolee@github.com>
>> ---
>>  builtin/clone.c  | 26 +++++++++++++++++----
>>  t/t5601-clone.sh | 59 ++++++++++++++++++++++++++++++++++++++++++++++++
>>  2 files changed, 80 insertions(+), 5 deletions(-)
>>
>> diff --git a/builtin/clone.c b/builtin/clone.c
>> index 22b1e506452..09f10477ed6 100644
>> --- a/builtin/clone.c
>> +++ b/builtin/clone.c
>> @@ -1267,11 +1267,27 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
>>  	if (refs)
>>  		mapped_refs = wanted_peer_refs(refs, &remote->fetch);
>>
>> -	/*
>> -	 * Populate transport->got_remote_bundle_uri and
>> -	 * transport->bundle_uri. We might get nothing.
>> -	 */
>> -	transport_get_remote_bundle_uri(transport, 1);
>> +	if (!bundle_uri) {
>> +		/*
>> +		* Populate transport->got_remote_bundle_uri and
>> +		* transport->bundle_uri. We might get nothing.
>> +		*/
>> +		transport_get_remote_bundle_uri(transport, 1);
>> +
>> +		if (transport->bundles &&
>> +		    hashmap_get_size(&transport->bundles->bundles)) {
>> +			/* At this point, we need the_repository to match the cloned repo. */
>> +			if (repo_init(the_repository, git_dir, work_tree))
>> +				warning(_("failed to initialize the repo, skipping bundle URI"));
>> +			if (fetch_bundle_list(the_repository,
>> +					      remote->url[0],
>> +					      transport->bundles))
>
> If the repo initialization fails, this line is still executed. Should the
> condition be 'else if' to avoid that?
>
> Otherwise, all of the added logic looks good to me.

Yes, it should. An earlier version of this follows the correct if/else if
pattern.

>> diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
>> index 45f0803ed4d..d1d8139751e 100755
>> --- a/t/t5601-clone.sh
>> +++ b/t/t5601-clone.sh
>
> Per the commit message:
>
>> Also, since the --bundle-uri option exists, we do not want to mix the
>> advertised bundles with the user-specified bundles.
>
> Could you add a test verifying that '--bundle-uri' causes 'clone' to skip
> bundle URI auto-discovery? It's clear from the implementation above that
> 'clone' is currently doing that as-expected, but it might be nice to have
> the test for regression testing purposes.

I can add that to the lib-bundle-uri-protocol.sh tests pretty easily.

Thanks,
-Stolee
