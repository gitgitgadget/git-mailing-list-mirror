Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E72BAC7618A
	for <git@archiver.kernel.org>; Thu, 16 Mar 2023 23:00:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230060AbjCPXAx (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Mar 2023 19:00:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbjCPXAv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Mar 2023 19:00:51 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0D059925E
        for <git@vger.kernel.org>; Thu, 16 Mar 2023 16:00:35 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id x11so1285534pja.5
        for <git@vger.kernel.org>; Thu, 16 Mar 2023 16:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679007635;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=zEUUM2PvYLKg8YcTRSOR6+/attFoh4TryrDH542A1eQ=;
        b=CPVYITrkiacj6wXODx9JFt8ws5T/B5zncf1t8odVApTjASUFE/MMRXAhJpIf4bu10S
         osvCO3251SXIkTM+vt6gLzSHp6vDv4DwwPYWTQnFMFUx4JzVUOBZxXgXHVEn+84wjO+J
         5Y8hVf+R8tMcVtRIZQke0F5Bh6IhfxGUBxI304Jiexp+wzYmJCHcxTgArzahM58wMngA
         6KJZLJLvhXN7Gbd3thZkSdpX0IPU2obexF24OCASjrSCdsc4cuQwPfojq0bTsCOYrokw
         07sx1TrpBrfIrqyhG+jBQtSqUeS4+JN4R+0Y1uDijfvp2snRuMqaSXGtSjfo5mnZA1gJ
         miyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679007635;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zEUUM2PvYLKg8YcTRSOR6+/attFoh4TryrDH542A1eQ=;
        b=yD8gK+K5AExaW3ShSxMy2Gzh7GGKAEKOj9r48qFvWBv9u+5RoolkN7DqzQ0M5vZE2X
         SZqCr8qkFQ5BcnxA1tW3rWCiBdB5wY9ELYzMJNc9RW7BGe6RbzRdukmKeACD/VYcbHHC
         cwfAd4b1ctcMZ40JsHcf5Mj7t+Mkgr0FWYbj4I4+bEVsrW7daTqbTk1W0CEVml05Z95A
         nUSgrgKsI2hPUmiDtREhD5iqBywPiq3Z9jwLRmEJMY3BEVYaAnKB3s3+OuVmtkFxH5oE
         zorhoJJ7KCCqg7AM89Y53FWx0AT439F/m6zZi+2Fu51gs2DZ/jzbiJBHNf/DaMkrd32C
         rREg==
X-Gm-Message-State: AO0yUKU2gqhsWjRuXNS7X8weDK4jyXERqNSRNbEt4dlnDwenuixnaaul
        /v0kpu7QDK4WlYF9Mp6W++I=
X-Google-Smtp-Source: AK7set+cdLm5TnMJ7G8R60+K/yOlbw5sACxIPAce2hrz9xRXeJqrE3SS7uo5wrTu7ow7pUIsdhvK+Q==
X-Received: by 2002:a17:90b:20d:b0:23b:543d:f3d3 with SMTP id fy13-20020a17090b020d00b0023b543df3d3mr5863861pjb.42.1679007635073;
        Thu, 16 Mar 2023 16:00:35 -0700 (PDT)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id gp5-20020a17090adf0500b0023b3179f0fcsm3765956pjb.6.2023.03.16.16.00.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Mar 2023 16:00:32 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Joakim Petersen <joak-pet@online.no>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
        Justin Donnelly <justinrdonnelly@gmail.com>
Subject: Re: [PATCH try2] completion: prompt: use generic colors
References: <20230228145934.4182166-1-felipe.contreras@gmail.com>
        <xmqq4jr4nu3u.fsf@gitster.g>
        <CAMP44s23cvp-YWDN7vzsKQCcWoc43PgURq+J6pwtx0rxOpZLBg@mail.gmail.com>
        <9e317aa7-0037-7076-e159-3a70c581ebc1@online.no>
Date:   Thu, 16 Mar 2023 16:00:32 -0700
Message-ID: <xmqq5yb0i9nz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Joakim Petersen <joak-pet@online.no> writes:

> I've played around a bit with this patch, and it seems to work as
> advertised.

As the change itself is so trivial and likely to exhibit problem
immediatly if it were not right (e.g. for some version of the shell
but not for others), let's queue it.

Thanks.
