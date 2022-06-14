Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 030F7C43334
	for <git@archiver.kernel.org>; Tue, 14 Jun 2022 14:14:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242866AbiFNOOk (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Jun 2022 10:14:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240419AbiFNOOj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Jun 2022 10:14:39 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EC9C28704
        for <git@vger.kernel.org>; Tue, 14 Jun 2022 07:14:38 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id d123so9480446iof.10
        for <git@vger.kernel.org>; Tue, 14 Jun 2022 07:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=62MVj2JH+Fjo25vaw1vVaBhZ6lRbgPDuLNaPeAGIuow=;
        b=UpjpcYoQge1dz49SJIUDRwNsI0NYLmq7zQ8LGj0dZykd52epPjdm3e7M6CbvM2f4Yz
         h1gDZtvl0KegSjlLuwYkcsDYpioY7Mdvttso59JDQ3MUVuxcBSPMCbTrgFSz2ONccO3+
         Y7lj9ccVSEnPKqWWV8a20v2jdnzTxH+IQk/FIew1eMwY1NUxfgqw7b3L5TFkQ3Lc0Tmi
         duhCQU8m+S0UUFWZNycC7Tsy9w1/z/oxg11deB7/2cfYDS9cEa4GnifArvpEx7j9pSTs
         H/k/cZNI7Dz+uIv2PYar3BA8RyJqLd0XrzZHkQuflUHPvY5rh0UgleFzvc+mBxvVBRpn
         TK7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=62MVj2JH+Fjo25vaw1vVaBhZ6lRbgPDuLNaPeAGIuow=;
        b=qep1O/19xgZAv0C5FGTx5pYgZ+7aOlVKb3hfILLaJi4yUgsJBdNrH9AD6ELW7A1Oyk
         YDb1lKoaREffaFRy7sLeAt+EtQoPJyrwm5uNE8wQxU94HfTRAA62nyRUaC1BRbn/QUZB
         4hJtgBXvojrZesiTsuBTF29wY6wRkUzwszf1CVCb5PU287VLq9+sIx56nYEJuhSIrbGO
         X/rNNS/qafsh0Tf9dYlxCqya4+++BGpUZxjjDuV2I3+8ZYzsLeh5EP/cpQufjCIPp32o
         sp2ejmZRSZ9s2xDOV3aVLCg92qh08uTB0e+OnJ8GGCXLiYb5PwRW764a/4dGdtbjQ5i0
         LQYg==
X-Gm-Message-State: AOAM531Q/pTPn1CCALQlraLO1RJfyoAEtZjplArbDLW6ozIJ/m25n1fn
        Tgy7WJMVRhXC/45efqfHhLB248Inplwh
X-Google-Smtp-Source: ABdhPJzUM/qgf9oKbScUf6NZpYlTnB8/iUqQ0oHY7SMZmM2gJkWxhWrFUoQK7IuqY6E0yr6pkMKVIw==
X-Received: by 2002:a05:6638:16d1:b0:332:197c:a736 with SMTP id g17-20020a05663816d100b00332197ca736mr3127035jat.94.1655216077916;
        Tue, 14 Jun 2022 07:14:37 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:508:3b97:7c0b:efc0? ([2600:1700:e72:80a0:508:3b97:7c0b:efc0])
        by smtp.gmail.com with ESMTPSA id f29-20020a02241d000000b003319da9014dsm4901394jaa.129.2022.06.14.07.14.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jun 2022 07:14:37 -0700 (PDT)
Message-ID: <0067c46a-7bfd-db9c-5156-16f032814464@github.com>
Date:   Tue, 14 Jun 2022 10:14:36 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] mktree: learn about promised objects
Content-Language: en-US
To:     Richard Oliver <roliver@roku.com>, git@vger.kernel.org
Cc:     jonathantanmy@google.com
References: <77035a0f-c42e-5cb3-f422-03fe81093adb@roku.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <77035a0f-c42e-5cb3-f422-03fe81093adb@roku.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/14/2022 9:36 AM, Richard Oliver wrote:
> Do not use oid_object_info() to determine object type in mktree_line()
> as this can cause promised objects to be dynamically faulted-in one at a
> time which has poor performance. Instead, use a combination of
> oid_object_info_extended() (with OBJECT_INFO_SKIP_FETCH_OBJECT option),
> and the newly introduced promisor_object_type() to determine object type
> before defaulting to fetch from remote.

Have you run some performance tests on this? It seems like this will
scan all packed objects, which is probably much slower than just asking
the remote for the object in most cases.

Thanks,
-Stolee
