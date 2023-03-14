Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 263B2C05027
	for <git@archiver.kernel.org>; Tue, 14 Mar 2023 17:21:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbjCNRVz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Mar 2023 13:21:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjCNRVx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Mar 2023 13:21:53 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12232A2F39
        for <git@vger.kernel.org>; Tue, 14 Mar 2023 10:21:53 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id ks17so12222472qvb.6
        for <git@vger.kernel.org>; Tue, 14 Mar 2023 10:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678814512;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q4PtZsllqu3d84FzLVeBleij2VoPhzjhyLMEbmZAwGc=;
        b=gFVryw7/TK9vf0lgLCC5M04t/BKp/0te2nl9pc3tjZyN5uaG/HNaB0i2nYDNhUaiTB
         SEGvlAC5RuOaHCKBKHAGkVfLHzxX/s6kJyJYXozQIlFL8FPE9Ww5V0vCZDvx45pwNn9I
         samswmZukp+o37h7dOd/heTNb1XYscqsAmcRQY8tJuk/9T6TFI6mk6LvDsBX34Rn4rwb
         1OM9PE9Ow+IXiezrs8UznHC4sTiAdtJKej3Ivq3BKAfQgSofyyMTfs1TgpOMTJ6vlI0c
         d7ckezZWmS3fO1iclyfLUpHGlmuZB+bN7huCSKXpvUnn0Un1SfPhreDoFbPrLmib5oiR
         5hbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678814512;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q4PtZsllqu3d84FzLVeBleij2VoPhzjhyLMEbmZAwGc=;
        b=r3N5wYg0TX12Q3vSOD97X1/+EUI5Ft0DN+zO8qcN2yYMaG7QahsUB2QhnzxW9WpGRB
         cFPVVu9Rfjsh1Ok1Kdmu4NI6bett6gHWfbbgyuthBekaXNQbtTDWbD49kTWJBZ+yuqNL
         3d3FfiiI54C1mCC8j90JljfqHZTMmRHvrOgxWCAOBJXdY7WmNF4v0naSJ9xBVPJ39HKh
         cajrZvP3kPzW45PHIw2YgfmiCTUrRW6p6RG3AwjY5TlibN/an65wqEqL+xJQWtEwJ1HE
         YTOmrN/3tksDkDoEOahzSBNYyBg1HGZRv5v/YcxEah7G2vj9Vax5gYIhjT7qVELwqAf5
         7JGQ==
X-Gm-Message-State: AO0yUKWHnSyqML4P4vB/Ww6fMngZeA8gVeqeCs1UA4aDj+q2LA/yUS1P
        AxLcpTLNMig5nzuPUfhmzPQ=
X-Google-Smtp-Source: AK7set8t7IvrhfYsY3Bwa+KSYl5k0IwQIDCKn8hVuxJ1g1dpt+mOzbK7eomUv8LVqItj7Wah4MWEfA==
X-Received: by 2002:ac8:5848:0:b0:3bf:d4c3:3659 with SMTP id h8-20020ac85848000000b003bfd4c33659mr65818697qth.66.1678814511844;
        Tue, 14 Mar 2023 10:21:51 -0700 (PDT)
Received: from [192.168.1.128] (173-246-5-136.qc.cable.ebox.net. [173.246.5.136])
        by smtp.gmail.com with ESMTPSA id dm24-20020a05620a1d5800b00729b7d71ac7sm2135315qkb.33.2023.03.14.10.21.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Mar 2023 10:21:51 -0700 (PDT)
Subject: Re: [PATCH 0/2] diff: support bare repositories when reading
 gitattributes for diff algorithm
To:     John Cai via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     John Cai <johncai86@gmail.com>
References: <pull.1459.git.git.1678758818.gitgitgadget@gmail.com>
From:   Philippe Blain <levraiphilippeblain@gmail.com>
Message-ID: <ddd7cbb6-4f4d-ba0e-857e-5981779326d0@gmail.com>
Date:   Tue, 14 Mar 2023 13:21:50 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <pull.1459.git.git.1678758818.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi John,

Le 2023-03-13 à 21:53, John Cai via GitGitGadget a écrit :
> This patch series adds support for bare repositories for the feature added
> in [1]. When using a bare repository, by default we will look for
> gitattributes from HEAD. When the --attr-source option is passed, we will
> try to read gitattributes from the commit.

When I read that I immediately thought of the config settings 'mailmap.file', 
'mailmap.blob' which allow the same sort of thing, but for the mailmap.

For the sake of consistency of the whole system, maybe we would want to support
'attr.file' and 'attr.blob' ? In that case, maybe we don't need a new command
line option at all...

Cheers,

Philippe.
