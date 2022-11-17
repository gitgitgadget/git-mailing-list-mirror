Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 598A1C4332F
	for <git@archiver.kernel.org>; Thu, 17 Nov 2022 21:55:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240911AbiKQVzl (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Nov 2022 16:55:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234814AbiKQVzk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Nov 2022 16:55:40 -0500
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86F466D48A
        for <git@vger.kernel.org>; Thu, 17 Nov 2022 13:55:39 -0800 (PST)
Received: by mail-io1-xd2f.google.com with SMTP id p141so2486883iod.6
        for <git@vger.kernel.org>; Thu, 17 Nov 2022 13:55:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DlV5hKectYDWHRWEHzIjV03ggwFtrqIfokcQOxEiL/Q=;
        b=z5+PL461otWI9HFea+5neDoFhVLrx3DiOQXI1qHXnImcjaR5QdcreYBsqO4AjZKm7P
         Gr5owwgEn9a7N3Dn1FbAG8jkm2lSKJTuuqD0Zw7DCj2ZLJfJsRHFXt563GSa1rt5n0vn
         ttQVD6flnXGcFK3yGSm/SYYGxDeQRB2yRHqUF1nMClTcwOY9keLgVEpB44PlNegwyPxy
         XNeIKLWfHlPhYXNScqne60JTO1mxaQvZqaSv9/ivufwx9Vnt1KKpHjg6IgXQoHvqLs34
         1xk0c4tDuTqtB+4MGH1jZ43XijM90vNi/WWdB3caQTmEwAaac+YeREShsBMJcv+iN/EJ
         3vOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DlV5hKectYDWHRWEHzIjV03ggwFtrqIfokcQOxEiL/Q=;
        b=iqNEcoh/Wgvztpb9ONRuI96Qymw7UCvs/x0XUh6C1McGp51wBGXmgKCF6nIEM5zbHe
         ecYeQFDQwKUkD4SAJRfTkN5V6SXJCkpf2RLP18kRT4G5VBna/ysC3CNrvAi2c6ZqntDw
         +RXMC4+63E9e8eb6hrK8ltHNzc74n+qY7OcTeiKHW8GWoEsMTfYWAu01+7pj97Rlt6gc
         Ss6GQNLj3wwuTkbzzLlGDE2myEoLb5osd6cHWYY+4ZjS41sYO6XezHkPo+5IwgrKh0AH
         0N3U1GgVsPLls1e/fkzuZ1+mHJqcTQRT05Hd24gsrpgJsHALYjVS0lxaMD+rZkOHrDud
         Ecug==
X-Gm-Message-State: ANoB5pkQck3aY7+oNwvg6vp0Bt7cNPbXUii9bm32LzcT8VYoJdu7JndT
        0Jn8JiqGyHPvt5Gl5iPJ8H6o2A==
X-Google-Smtp-Source: AA0mqf44WaJeHNHlwMlIiAunDnM5SiopTOI4vzB3DDYXLt46+TBbX2RU37j+r7ouwPtlrrrPGhXt0Q==
X-Received: by 2002:a05:6638:3456:b0:376:96a:f3e9 with SMTP id q22-20020a056638345600b00376096af3e9mr2001369jav.139.1668722138941;
        Thu, 17 Nov 2022 13:55:38 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id n25-20020a5d8259000000b006a129b10229sm729101ioo.31.2022.11.17.13.55.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 13:55:38 -0800 (PST)
Date:   Thu, 17 Nov 2022 16:55:37 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Matthew John Cheetham <mjcheetham@outlook.com>
Cc:     M Hickford via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, M Hickford <mirth.hickford@gmail.com>
Subject: Re: [PATCH] Docs: describe how a credential-generating helper works
Message-ID: <Y3at2UY6OzFiMlNZ@nand.local>
References: <pull.1379.git.git.1668217470500.gitgitgadget@gmail.com>
 <AS2PR03MB9815DCB5C310C4AC7B82D3A6C0069@AS2PR03MB9815.eurprd03.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <AS2PR03MB9815DCB5C310C4AC7B82D3A6C0069@AS2PR03MB9815.eurprd03.prod.outlook.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 17, 2022 at 09:28:53AM -0800, Matthew John Cheetham wrote:
> This looks like a good, clarifying addition to the docs!

Thanks, both. Will queue.

Thanks,
Taylor
