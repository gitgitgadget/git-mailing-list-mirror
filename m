Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A3D9C76196
	for <git@archiver.kernel.org>; Fri, 31 Mar 2023 18:09:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231308AbjCaSJ6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Mar 2023 14:09:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229967AbjCaSJw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Mar 2023 14:09:52 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C2BF10FA
        for <git@vger.kernel.org>; Fri, 31 Mar 2023 11:09:49 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-544f7c176easo429764557b3.9
        for <git@vger.kernel.org>; Fri, 31 Mar 2023 11:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google; t=1680286188;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HSAvc1g3nyRNqpvXvfuiiI5eKY+Iyd502ybmaksOpBI=;
        b=EJEJGNqyBQJZmILtu0AzSORx1mQzLT+5GsmA0mX7uHOaTIs4maeK2RVghuL8AEV/nL
         YoJc2JP92Nbo4DIOVRzMD8sD4ec5oX4wFtpWOi2X2obuSLgk6Lq/MQH1hwgwnUldIA+0
         FFpPouuJWvG1Y6X1j2vz4+P8p1VF8d99ZWSkvqpfKyIm582YEA84jrR36IR/U2us42Km
         E9vUriZIyfs3oqW9dcvxxB5KH3PsMEbXAzZwTfcodVmvyM/3pq64pS26P4PPFP0zSw8l
         SvCRCL7Zz3Hl1+8FRQmyzhe4KE3p2Hl0rt1sx0oCun601hnAjtI2dZHM9s8D7nqB51Pe
         nkKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680286188;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HSAvc1g3nyRNqpvXvfuiiI5eKY+Iyd502ybmaksOpBI=;
        b=d+ZD2MwBo06q/REJdmAriF8kKIMcCzK+lF3V+AOFYdpsMMqrXRlR7mlBsCFwT26l6M
         +ifH6vTJPDjaz+FtjyyqOy6bbi0ToMe3N+MFCslnweWsEcd/Oz7rAokDbQDW1A+pAeQp
         QEoB0GCpVe1L9vuxaI0gSZtwIlc7nAxcwoLTwrpyf/VRWO4g8K8o8UHsVDokcOj48wAD
         pejmgebuQSrn/3r/BmJKD7Xanfd1LCYXt5Mw31saEjIirKSQPl9h/dRg+4Q45ItZZo3i
         +z4ZaoV5L0lM7STHjjLxVnBYXmTKsUdZW2eiZbjnEFk6TGd/iulQgYK52RX4HubfDfma
         qC2w==
X-Gm-Message-State: AAQBX9dps7HlqvyIuY2wtbYZ0YqYlrjK/eeB2kn4rgszJiij9L3QnBO3
        G1rCYeBHqne6aPKUtvwSjTsR
X-Google-Smtp-Source: AKy350YUFxZ42IGsiVBnTooGA6RPZWjLluYXupSJXaaP/lF7xGi37K82HfSsmzSD2ebnc9y9Tw4Uvg==
X-Received: by 2002:a81:7508:0:b0:544:e183:762d with SMTP id q8-20020a817508000000b00544e183762dmr28982386ywc.37.1680286188452;
        Fri, 31 Mar 2023 11:09:48 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:5800:f61e:eebf:ee2e? ([2600:1700:e72:80a0:5800:f61e:eebf:ee2e])
        by smtp.gmail.com with ESMTPSA id q35-20020a814323000000b00545a08184f8sm665077ywa.136.2023.03.31.11.09.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Mar 2023 11:09:47 -0700 (PDT)
Message-ID: <780308b8-6e61-fe20-78c2-47df1c1737c9@github.com>
Date:   Fri, 31 Mar 2023 14:09:47 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH] fetch: download bundles once, even with --all
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, vdye@github.com
References: <pull.1508.git.1680278344173.gitgitgadget@gmail.com>
 <xmqqo7o8g89a.fsf@gitster.g>
Content-Language: en-US
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <xmqqo7o8g89a.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/31/2023 1:06 PM, Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> From: Derrick Stolee <derrickstolee@github.com>
>>
>> When fetch.bundleURI is set, 'git fetch' downloads bundles from the
>> given bundle URI before fetching from the specified remote. However,
>> when using non-file remotes, 'git fetch --all' will launch 'git fetch'
>> subprocesses which then read fetch.bundleURI and fetch the bundle list
>> again. We do not expect the bundle list to have new information during
>> these multiple runs, so avoid these extra calls by un-setting
>> fetch.bundleURI in the subprocess arguments.
> 
> It is a good observation, if we assume that all these remotes want
> to share the same expectation on what the list of bundles described
> in bundleURI should be.
> 
> I expected that people use multiple remotes and do a "fetch --all"
> before starting work from a cronjob or while fetching coffee first
> time in the morning to fetch from repositories holding work from
> different folks and manged by different groups, and these groups do
> not tightly share the object management recipes at what bundles to
> pre-package and list in the list served at a bundleURI.  If there is
> such an arrangement between repositires to share the object
> management, even if the repositories fetched with the "--all" option
> are truly multiple places, it may make sense to assume that these
> repositories you are fetching from want you to use the same set of
> bundles that are managed the same way to be used.  But I am not sure
> if that assumption holds true.
> 
> Where does fetch.bundleURI come originally?  If we set only one
> globally for the local repository at "git clone" time, perhaps that
> is a problem?  IOW, instead of fetch.bundleURI, we would want to
> have something per remote, e.g. remote.<name>.bundleURI, instead?

fetch.bundleURI is either set by 'git clone --bundle-uri' when the
list advertises a bundle.heuristic value, or can be set manually by
the user.

This indicates the use of a "standalone" bundle server that is
managed independently from a Git remote. The bundle list is downloaded
from a static URI instead of during protocol v2 in the 'bundle-uri'
command.

In that sense, the static bundle URI is not paired with a remote,
but instead presents a place where objects can be downloaded perhaps
faster than any Git remote (by downloading from a static file, or
because the bundle server has a faster link to the client machine).
The objects added to the client object store can then reduce the
size of the fetch from each other Git server remote, of course only
if the objects in the bundle(s) are also present on those remotes.

If there are remote-specific bundle lists, then the protocol v2
command will be a good way to communicate bundle lists that are
custom to those remotes. However, even in that case it is unlikely
that sourcing bundles from multiple sources will be useful, since
the bundle downloads will likely have significant common data.
 
> Putting that design level tangent aside, everything I see in this
> patch makes sense, assuming that the fetch_bundle_uri() call done
> fairly early in the parent process is sufficient to tell the child
> processes that deal with individual repositories to reuse the info
> that was already retrieved that call.

Thanks for looking closely.

-Stolee
