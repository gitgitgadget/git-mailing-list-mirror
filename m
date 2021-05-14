Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17DC5C433B4
	for <git@archiver.kernel.org>; Fri, 14 May 2021 01:40:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D82886142E
	for <git@archiver.kernel.org>; Fri, 14 May 2021 01:40:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232137AbhENBly (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 May 2021 21:41:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230460AbhENBlx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 May 2021 21:41:53 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05D92C061574
        for <git@vger.kernel.org>; Thu, 13 May 2021 18:40:41 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id t4-20020a05683014c4b02902ed26dd7a60so15115604otq.7
        for <git@vger.kernel.org>; Thu, 13 May 2021 18:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:message-id:in-reply-to:references:subject:mime-version
         :content-transfer-encoding;
        bh=BLBsYuz1SfgAsS0JkfLTd4BxNMFP/dTO1LbFHkO4+yg=;
        b=XKv/N1g4xH5NLGs+u9/wWa8iqM32R5aNPB8Pn2HWoYfWbtye3PR0topdA7seZpQcUc
         2tgZGvYF4o0xlFzA+516GwuN3PtK7hpSxYyLgYo/apleJw/jsiXKXQFH/oH+PF7oenhA
         7IO839a/PKBFUEdD90fdoOtMHV7a6Ad/ABFun9jNUngR5rj9WlvMTVxeYoqF5j3sdbUJ
         X7YDGgKtA74u9L9QvCd7ilkWrKdoEbEHAN+ozYyaaZVeTkvxsxW45rLNs1QW2uHahVK6
         MR3npmav5g5uHiw6vpeTn1VhW10k4gwqD0SObVaxZIUHUOtH4Q0XUKU0Y3aDkVgGtAV6
         nxFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:message-id:in-reply-to:references
         :subject:mime-version:content-transfer-encoding;
        bh=BLBsYuz1SfgAsS0JkfLTd4BxNMFP/dTO1LbFHkO4+yg=;
        b=Yt9HVfkc98gdokguB4LWzN9ndMDXs2hMx5GqoUOk10OJ21oaJxAsJ77bLJMTkmBrc1
         0bTw7kYEuyfx8ZvoU1ImYOkPUhJFgZIEd183NfE/EfC0rdaExzU2rGl5Nj+90E5M5xXr
         g15PJ/iqPxmYU8cU8NBKdsmf6DQMdPgxUmuRbMhxctdsB2mnM4yqRJuWcnGfYf4GLvro
         MmKalkfy0KiKaDxa0Y3GhQ5ag0Id18eZ/30SwuEiP3rj8j5DS0gsDMDRPHqvBrHtQS0x
         1TLUnxZ/ch6G8a8hclGVQLu9QmM4EKYC4Osz5TJP31bGKpm08zxvUWxmLkOHrdHyqXeS
         lKqA==
X-Gm-Message-State: AOAM532akIki7yZEETOS9vSI1Tub3RCMO6yb+8YkqguPCKQPCJ6YKJgj
        4MpPkKndWcp3f8eyN3MrFuU=
X-Google-Smtp-Source: ABdhPJwknNYWM34W5ByTCt24Luz+zkAamoMEjMttbXaSPtRk0y9IDaOYIs0fAOLbTiqiUuaR2MTUBw==
X-Received: by 2002:a9d:d0e:: with SMTP id 14mr38416430oti.12.1620956441297;
        Thu, 13 May 2021 18:40:41 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id u24sm1013520otg.73.2021.05.13.18.40.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 May 2021 18:40:40 -0700 (PDT)
Date:   Thu, 13 May 2021 20:40:39 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     =?UTF-8?B?TWFydGluIMOFZ3Jlbg==?= <martin.agren@gmail.com>,
        git@vger.kernel.org
Message-ID: <609dd5171e7de_19566208ca@natae.notmuch>
In-Reply-To: <cover.1620928059.git.martin.agren@gmail.com>
References: <cover.1620928059.git.martin.agren@gmail.com>
Subject: RE: [PATCH 0/6] AsciiDoc vs Asciidoctor, once again
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin =C3=85gren wrote:
> These patches reduce
> =

>   ./doc-diff --from-asciidoc --to-asciidoctor --cut-footer HEAD HEAD
> =

> from ~1200 to ~1000 lines. It's the usual mix of things where one or th=
e
> other of the tools renders something less well, or where we're doing
> something odd in the source and we just happen to notice it in the diff=
.

These changes are good, but what happens the next time somebody
inadvertedly introduces something that "trips" asciidoctor?

We should be submitting bug reports to the asciidoctor project as well,
so in the future it's less likely we find ourselves in the same
scenario.

Preferably the bug report should be in the commit message.

Cheers.

-- =

Felipe Contreras=
