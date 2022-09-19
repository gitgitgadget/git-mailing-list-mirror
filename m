Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53021C54EE9
	for <git@archiver.kernel.org>; Mon, 19 Sep 2022 16:08:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbiISQIb (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Sep 2022 12:08:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbiISQI3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Sep 2022 12:08:29 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A4FE103D
        for <git@vger.kernel.org>; Mon, 19 Sep 2022 09:08:28 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id ay9so10210600qtb.0
        for <git@vger.kernel.org>; Mon, 19 Sep 2022 09:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=QsrFSXMAOAnyZaXq3wxaGXBK5LbgrUh+ghlP8kMXrnQ=;
        b=F30zDzfqvKD1S8CKEkSNhdIfilJqk0rSbxINKZfDnhOhNWgBqNv57VuW43WuK4qt/g
         w2AgCfrhxLfG8dsANUC+HSu+NkQbygJcfMFfr38azBrtw0khGSpDfUED8jII0Z5wla1H
         UgO5zw+E5XFXUtnY/kXmgG58rSPXSKTJZtnvI1c6+TD/G9qwn1IXonwWFkJsvFySFBiv
         NX/73oYQnStA4CtzTtaorISjw7LaoSDarAgUGIuN9CbgX6WgqgaCYu5OnGg+Vt2bxmuN
         OsC2VMUDLYGKhPZ/qTbKTcLoy7XXjYkq6cEYQOjfpmZBazSSOS2gHtAG0Ur7PIGY5Lct
         kibw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=QsrFSXMAOAnyZaXq3wxaGXBK5LbgrUh+ghlP8kMXrnQ=;
        b=tZNeq9hK3esijC8IAKRkrAcW4zza61zlOv3/W6HPkl6+fhNwrTT5JOj2vwGxaQkek4
         NLP1SrlrS0osifme0h7tJ1LZ8DBTEFw8zVfwjIKDL9PNLdrNffneCuTGJy7pKc2+YDsG
         z7Ss4RdqS/mduOce+sDpqJMBX/TFwfDAl5cxkOeDdPc1oCfjVeFUzUGUdyB5NOE1qocx
         yroSVyT36VkXsfwRHsRT7sn9JxkilPEC5zq2/lR2VJpjdzLl4rNqTwBuAqvB/J+9qTPf
         /pit1q4ExfuQJFPAinlvRYTFRD3zieSBZ1Dxu6Z9aBeDlIBfwtENnZiA1PUyv10OBd7Q
         J7wg==
X-Gm-Message-State: ACrzQf1q5OoXlq4o//FdhAgmw/X0VA64CW3dCfxsdeZQP+3VV/MfSZ2Q
        0/YC0rCp7AvugR/E8hcU8agd
X-Google-Smtp-Source: AMsMyM5/OQZ5001BOIh7q9gBsM+aalgxfVkW3K2WuxO2DTAkPeD3mjdpXe658D6fCVkbrgPFavVM9Q==
X-Received: by 2002:a05:622a:4204:b0:35c:ddac:9896 with SMTP id cp4-20020a05622a420400b0035cddac9896mr8903276qtb.478.1663603707499;
        Mon, 19 Sep 2022 09:08:27 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:fd97:43ff:6c00:2cf8? ([2600:1700:e72:80a0:fd97:43ff:6c00:2cf8])
        by smtp.gmail.com with ESMTPSA id f16-20020a05620a20d000b006b95b0a714esm11780180qka.17.2022.09.19.09.08.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Sep 2022 09:08:27 -0700 (PDT)
Message-ID: <452acd3b-14bd-a3c8-df58-39b5e9edfd0b@github.com>
Date:   Mon, 19 Sep 2022 12:08:21 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH 0/8] [RFC] Enhance credential helper protocol to include
 auth headers
Content-Language: en-US
To:     Matthew John Cheetham via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Matthew John Cheetham <mjcheetham@github.com>
References: <pull.1352.git.1663097156.gitgitgadget@gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <pull.1352.git.1663097156.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/13/2022 3:25 PM, Matthew John Cheetham via GitGitGadget wrote:
> Hello! I have an RFC to update the existing credential helper design in
> order to allow for some new scenarios, and future evolution of auth methods
> that Git hosts may wish to provide. I outline the background, summary of
> changes and some challenges below. I also attach a series of patches to
> illustrate the design proposal.

It's unfortunate that we didn't get to talk about this during the
contributor summit, but it is super-technical and worth looking closely
at all the details. 

> One missing element from the patches are extensive tests of the new
> behaviour. It appears existing tests focus either on the credential helper
> protocol/format, or rely on testing basic authentication only via an Apache
> webserver. In order to have a full end to end test coverage of these new
> features it make be that we need a more comprehensive test bed to mock these
> more nuanced authentication methods. I lean on the experts on the list for
> advice here.

The microsoft/git fork has a feature (the GVFS Protocol) that requires a
custom HTTP server as a test helper. We might need a similar test helper
to return these WWW-Authenticate headers and check the full request list
from Git matches the spec. Doing that while also executing the proper Git
commands to serve the HTTP bodies is hopefully not too large. It might be
nice to adapt such a helper to replace the need for a full Apache install
in our test suite, but that's an independent concern from this RFC.

> Limitations
> ===========
> 
> Because this credential model was built mostly for password based
> authentication systems, it's somewhat limited. In particular:
> 
>  1. To generate valid credentials, additional information about the request
>     (or indeed the requestee and their device) may be required. For example,
>     OAuth is based around scopes. A scope, like "git.read", might be
>     required to read data from the remote. However, the remote cannot tell
>     the credential helper what scope is required for this request.
> 
>  2. This system is not fully extensible. Each time a new type of
>     authentication (like OAuth Bearer) is invented, Git needs updates before
>     credential helpers can take advantage of it (or leverage a new
>     capability in libcurl).
> 
> 
> Goals
> =====
> 
>  * As a user with multiple federated cloud identities:

I'm not sure if you mentioned it anywhere else, but this is specifically
for cases where a user might have multiple identities _on the same host
by DNS name_. The credential.useHttpPath config option might seem like it
could help here, but the credential helper might pick the wrong identity
that is the most-recent login. Either this workflow will require the user
to re-login with every new URL or the fetches/clones will fail when the
guess is wrong and the user would need to learn how to log into that other
identity.

Please correct me if I'm wrong about any of this, but the details of your
goals make it clear that the workflow will be greatly improved:

>    * Reach out to a remote and have my credential helper automatically
>      prompt me for the correct identity.
>    * Leverage existing authentication systems built-in to many operating
>      systems and devices to boost security and reduce reliance on passwords.
> 
>  * As a Git host and/or cloud identity provider:
>    
>    * Leverage newest identity standards, enhancements, and threat
>      mitigations - all without updating Git.
>    * Enforce security policies (like requiring two-factor authentication)
>      dynamically.
>    * Allow integration with third party standard based identity providers in
>      enterprises allowing customers to have a single plane of control for
>      critical identities with access to source code.

I had a question with this part of your proposal:

>     Because the extra information forms an ordered list, and the existing
>     credential helper I/O format only provides for simple key=value pairs,
>     we introduce a new convention for transmitting an ordered list of
>     values. Key names that are suffixed with a C-style array syntax should
>     have values considered to form an order list, i.e. key[n]=value, where n
>     is a zero based index of the values.
>     
>     For the WWW-Authenticate header values we opt to use the key wwwauth[n].
...
> Git sends over standard input:
> 
> protocol=https
> host=example.com
> wwwauth[0]=Bearer realm="login.example", scope="git.readwrite"
> wwwauth[1]=Basic realm="login.example"

The important part here is that we provide a way to specify a multi-valued
key as opposed to a "last one wins" key, right?

Using empty braces (wwwauth[]) would suffice to indicate this, right? That
allows us to not care about the values inside the braces. The biggest
issues I see with a value in the braces are:

1. What if it isn't an integer?
2. What if we are missing a value?
3. What if they come out of order?

Without a value inside, then the order in which they appear provides
implicit indices in their multi-valued list.

Other than that, I support this idea and will start looking at the code
now.

Thanks,
-Stolee
