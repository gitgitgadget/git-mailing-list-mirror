Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 868D1C433B4
	for <git@archiver.kernel.org>; Sat,  8 May 2021 04:23:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5BBB261377
	for <git@archiver.kernel.org>; Sat,  8 May 2021 04:23:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229521AbhEHEYB (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 8 May 2021 00:24:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbhEHEYB (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 May 2021 00:24:01 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0D60C061574
        for <git@vger.kernel.org>; Fri,  7 May 2021 21:22:59 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id x188so9300707pfd.7
        for <git@vger.kernel.org>; Fri, 07 May 2021 21:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=S7UGSQ16it4yoOHatUEiJy9sLTb4ieVgqZZOOdqhsCE=;
        b=pfz+eIN2h033XdneOHX687MN69ROBNgAQCuSbLq+qIDDEICfw6dMRW3ujFrcRsA8yt
         ZL9h7IH3AMVKVa/0Uk/JepScfGa5rUdNL4tZLWQwaTVGit9UjiMIWb5QldszrWjwcJAT
         5T3axP+ZKBBpqumIvawIv8WHcXM0RtrwpOyT7uKx+RWH1QcfRyYQPUaXI2+ADG8sZbJD
         QPQN69eetUIU9YLcN1TcV4ETnhL7SDuf3h5Yljr5/5nUECr3afWDgFxG/dLOYTFnXkVU
         Qsz6wjcLNGOQEjlVYZq2Kbd+KIv41j8HjpyCNx4SjE/hO1YHqGG22zZjni6FnF6GCkvy
         ZS/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=S7UGSQ16it4yoOHatUEiJy9sLTb4ieVgqZZOOdqhsCE=;
        b=jwG81/lQQ26MGBIpAv5q5R6LfFsRiiBeZd61Yl7jGKOJoj6e0pxt+ZLaOzh9CRKtUn
         9Zm8KASDkbbYLUKoxnr5k/aYLwqrtw4FD4A2qKShF08+lGo7YLEpEdI/75E33UBImm9x
         4qLL3jmDKNQm57iZSgH4/amW4ykjA8mbCSlMltpEhQKEtCu09m+7ejpUvu2kL4RZ7jPC
         MXPlITnTQhGdOL38QwQEGkuvpalaU+j29YOOMU9Qa8pLtl2uWfBSfztLCzhQvtulMOsi
         MXOZb83gvmqas4KCr/ErFAmxk9Cz2f5Pb6FF9bEESZSsOywftpEg73Fx+GK69agUSj+y
         RUyw==
X-Gm-Message-State: AOAM533KZxmxH+TWN0Wfi3jlIhsFe4vLqa/xdmRr0mPwwCpNFmcg66je
        kLYgJyl+E1PhvxyXA8HhA1z++9KO60AJ/w==
X-Google-Smtp-Source: ABdhPJxlWL26ap3LES9As1HxN8d2e3DfnuiWLOnrOnHGbcI8PfGglq2SGNNJg6TLpzH/6UMZIaU09A==
X-Received: by 2002:a63:8c52:: with SMTP id q18mr10921288pgn.356.1620447779270;
        Fri, 07 May 2021 21:22:59 -0700 (PDT)
Received: from [192.168.43.80] (subs03-180-214-233-72.three.co.id. [180.214.233.72])
        by smtp.gmail.com with ESMTPSA id r16sm3180912pgk.16.2021.05.07.21.22.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 May 2021 21:22:58 -0700 (PDT)
Subject: Re: [RFC suggestion] Generate manpage directly with Asciidoctor
To:     Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Git Users <git@vger.kernel.org>
References: <3461c7b0-594d-989e-3048-2fc6583084ad@gmail.com>
 <YJWiQH2nf0B14Zy7@camp.crustytoothpaste.net>
 <YJW81zNr5bgW+yVs@coredump.intra.peff.net>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Message-ID: <cfe45519-9c47-7773-080a-af222a775011@gmail.com>
Date:   Sat, 8 May 2021 11:22:55 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <YJW81zNr5bgW+yVs@coredump.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 08/05/21 05.19, Jeff King wrote:

> I _thought_ the original asciidoc was marked as deprecated /
> unmaintained at some point. But it does seem to have gotten a few
> releases in the last year (it looks like maybe the python 2 version was
> EOL, but somebody decided to make the effort to port it to python 3?).

Asciidoc.py [1] now supports Python 3, however it only handles legacy
AsciiDoc syntax.

[1]: https://github.com/asciidoc-py/asciidoc-py
-- 
An old man doll... just what I always wanted! - Clara
