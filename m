Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B68A6C43334
	for <git@archiver.kernel.org>; Wed,  8 Jun 2022 15:11:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242808AbiFHPLO (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Jun 2022 11:11:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243362AbiFHPKt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Jun 2022 11:10:49 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47A144928D2
        for <git@vger.kernel.org>; Wed,  8 Jun 2022 08:02:36 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id y196so18572840pfb.6
        for <git@vger.kernel.org>; Wed, 08 Jun 2022 08:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=432aSrn6t1iv+OBJFdebd3OP5VE1Z9SWHZ9tZ1U3WBQ=;
        b=M35/+YGj3Sil55UcuUZ6NE78KpM39lLuo0RvC5NfewtDzZ966bIWUBzP4h5o7HKv//
         EmffdKZJoSJTgOeX9Jw1tjhpPOZjWRGLzDdovDAfeuphABIsXNmTZaOhzF2rb9BIsj6+
         xH6xXATcIBZ5gcY0Xwf/NSSA4scfwTjCj07mS+3JYVLbKIwOJuI/HDi/FQy6n8cVpAka
         9pWzqBrBIikvuzAV9UgxHevSf6HuJg7Ml1ZXFgHnRhZloBTIC8WlRWGyfjbZZ/q5DCBZ
         TGS/7Ne0esED6oKyg4xVBhGhXLAwRnwkZZXBXH70aSS+41gSthwjiO7c0U5cvB+cWpJK
         MvyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=432aSrn6t1iv+OBJFdebd3OP5VE1Z9SWHZ9tZ1U3WBQ=;
        b=44NDy52Ss7aUdY0AKMsL7BZ0VI/WJqxTIfUPEeh6oEbLeGnlJUGCX/imLRZAxdzdAX
         8vTP5uTxm4PKj2yHhyF6S9Qh6lyOLPGRnm6dw0sZGXfLXBC5KhWbsB8jdPytl6FNrEsg
         uYKE4yinwKtYZeto4EDGxF5u9/1L88SXCcPo/S65W2ku54WApNmnkZo498cjg9F0GWeB
         jQlbEL+3OjkUr23hRc91JKyMn0iMSXcP/xPJC8J0Mn6jA71GyLBJxqslaPs4GJBlA2lM
         wq3AkUKnxosdizjVuZrgq65tOWZ1X8dtW93dq3dqvZoo6xwfXDIytxxDYNi6qAoG3DnM
         4HnA==
X-Gm-Message-State: AOAM533KVarWf4uYJDetyhMzSzBf2LZscqd07KxQFrsLZpsKlACW5S6I
        0aM8gk3M+XTB1JWyBbn5SbQ=
X-Google-Smtp-Source: ABdhPJyyNVx81NVe/4NzpETRJWSlkSdUmPtCODkAs33sqXqKVwO8qXw4SL//YPaLz6nyGAFqsLjMNw==
X-Received: by 2002:a63:f156:0:b0:3ab:ada6:b463 with SMTP id o22-20020a63f156000000b003abada6b463mr29862466pgk.462.1654700555473;
        Wed, 08 Jun 2022 08:02:35 -0700 (PDT)
Received: from localhost.localdomain ([2409:4061:2d90:e070:8c4e:1fcf:53b1:688a])
        by smtp.gmail.com with ESMTPSA id a13-20020a170902710d00b0015e8d4eb1d2sm14773148pll.28.2022.06.08.08.02.30
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 08 Jun 2022 08:02:34 -0700 (PDT)
From:   Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>,
        Git <git@vger.kernel.org>, Taylor Blau <me@ttaylorr.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v2 1/3] bitmap-format.txt: feed the file to asciidoc to generate html
Date:   Wed,  8 Jun 2022 20:32:11 +0530
Message-Id: <20220608150211.9831-1-chakrabortyabhradeep79@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <xmqqa6aowc6r.fsf@gitster.g>
References: <xmqqa6aowc6r.fsf@gitster.g>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> wrote:

> Is bitmap-format the only one that is not fed to AsciiDoc, by the
> way?  Are there other 'text-only' document that is worth converting
> to AsciiDoc? 
>
> It is outside the scope of this series, of course, to actually
> adjusting them, but since you are already doing the homework, I
> thought you might already know the answer, which may become a source
> of inspriation for others to find something to work on.

No, bitmap-format is not the only one. There are more text-only files.
Some of them which I found till now are - technical/chunk-format.txt,
technical/commit-graph.txt etc. There are more but I don't know if they
actually need html conversion. These two texts (which I mentioned) is I
think worth having html files.

I was thinking of adding those in my commit but later I thought it would
divert the patch series.

Thanks :)
