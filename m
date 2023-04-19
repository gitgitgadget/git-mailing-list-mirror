Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA7EBC77B73
	for <git@archiver.kernel.org>; Wed, 19 Apr 2023 15:48:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233671AbjDSPsw (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Apr 2023 11:48:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233631AbjDSPsv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Apr 2023 11:48:51 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A439FB463
        for <git@vger.kernel.org>; Wed, 19 Apr 2023 08:47:55 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1a50cb65c92so1123765ad.0
        for <git@vger.kernel.org>; Wed, 19 Apr 2023 08:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681919229; x=1684511229;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fDYRKe1Q5jqiCT80SPnQFNMZ9f26ikZ8LB/s7wTgCxs=;
        b=QEbihmnPl+kWS81xcu+xNq1aNbNEg0Gxg5liqavWkQrqxxQc2UJrd36xVE5Vh9PhHb
         I6FCl5aS8d4zKVLc4CocI8zevrcboDyGAhliXHt1RXlyt4PQiaEBHnM2B8LtybQZ1IxI
         ppsW2jpj/2X3wdaXvxbTq57RKFBaWcRK8Tug8GkOo8QZ1KKTsSteCghFYj8NA9K0DJT1
         x9sKWxlZEAXFvaKe7Z5wrKeVABF50yHFvOge7yU2sC6ITHiGqPRfbeNaVsQ4+uWmxP4S
         1kREEkAuageuFQ9HXToPA2nPc6Wv3hDn2ztqszJ0Tna0HawJE9Ys7tTg69V7FXGof5ze
         hXkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681919229; x=1684511229;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fDYRKe1Q5jqiCT80SPnQFNMZ9f26ikZ8LB/s7wTgCxs=;
        b=DNmTjM9Sd7YDkLigOZfigZ03vGim0e3sTacSbka1Zz4x3E5wlOjnbSpYlVNVQykoqS
         +BYgcOIM0XJZrMuHHxv2+Sf67+Gwuic1i3ElMbJmfJ4gFjIEoU1JsDbGzGREMnOMcHI3
         X61J+pW0BRzddjiMS8M46cjJKdBZnYpRU25gABcO3h9lDVEuIll97j9W2vyu1RuaNavY
         zaX1QszV+TZYKGWa7r1HfcAIuIs+B7JV7NTaHyOoyykix9ixzMJRIkguGsJstx8xVGme
         2a8InU1b3h/xieLSAPGjCDHrwrtTo1wJZHBDyGTbM72haGAnJqH30A4r5Gd5eGp/svNl
         V+MQ==
X-Gm-Message-State: AAQBX9crMQJDVrMg3ZrFLIW/51pz2RLKZPXl+zmp2ZvXCP53HgLhqykC
        T2WTVGsFHu0FdpVUNkO07GE=
X-Google-Smtp-Source: AKy350bR3FRvw/cHG1J9omTIZ1j4dGyQPlgEzAxnNjj0tGUgmQOgS8TE/soFJXlD3zvdz/Lh3pyqCQ==
X-Received: by 2002:a17:903:2595:b0:1a6:a8dd:4aeb with SMTP id jb21-20020a170903259500b001a6a8dd4aebmr5616321plb.23.1681919229178;
        Wed, 19 Apr 2023 08:47:09 -0700 (PDT)
Received: from localhost (170.102.105.34.bc.googleusercontent.com. [34.105.102.170])
        by smtp.gmail.com with ESMTPSA id k8-20020a170902ba8800b001a6e9d170b8sm5252233pls.265.2023.04.19.08.47.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 08:47:08 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Shuqi Liang <cheskaqiqi@gmail.com>
Cc:     git@vger.kernel.org, vdye@github.com, derrickstolee@github.com
Subject: Re: [PATCH v3] write-tree: integrate with sparse index
References: <20230404003539.1578245-1-cheskaqiqi@gmail.com>
        <20230419072148.4297-1-cheskaqiqi@gmail.com>
Date:   Wed, 19 Apr 2023 08:47:08 -0700
In-Reply-To: <20230419072148.4297-1-cheskaqiqi@gmail.com> (Shuqi Liang's
        message of "Wed, 19 Apr 2023 03:21:48 -0400")
Message-ID: <xmqqildran7n.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Shuqi Liang <cheskaqiqi@gmail.com> writes:

> Update 'git write-tree' to allow using the sparse-index in memory
> without expanding to a full one.

Sorry, but after this exchange

    https://lore.kernel.org/git/xmqqmt3bw9ir.fsf@gitster.g/

I am confused what we want to do with this version.
