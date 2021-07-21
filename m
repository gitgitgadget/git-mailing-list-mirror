Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37CA9C636C9
	for <git@archiver.kernel.org>; Wed, 21 Jul 2021 12:27:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A36B6120F
	for <git@archiver.kernel.org>; Wed, 21 Jul 2021 12:27:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237551AbhGULq5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Jul 2021 07:46:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237005AbhGULqy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jul 2021 07:46:54 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9165C061574
        for <git@vger.kernel.org>; Wed, 21 Jul 2021 05:27:29 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id o17-20020a9d76510000b02903eabfc221a9so1933080otl.0
        for <git@vger.kernel.org>; Wed, 21 Jul 2021 05:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=MIdQP2zG5/eI4fVzuNZAYxwOE++VEdLGV4B5H1tnXWk=;
        b=PF+yfxpeB1ep7FLhvfZzqNbC96d/KEmzn8cLbo5ywKNwYHnKZfGdkX7wJhU96TJlyr
         juS38J5i2r4XNB3/BQ1mT6zrGRw6KnG+IDne+1QhBBPNFQq+Z9SbmCQm3+y+nmA+HmX7
         pI6xxeyrp38//HrwotgkGZU8wYm+x7B/RAczdNbM1vTbJRtNa1Tzjmir8HGXO3CTvf6O
         AwLtpEVqQaX3/H976fk0NmB9pZhRYxEzkiigGIHWU1MoAmsX2mJFlSwb9JlOvzWomIFQ
         UIe57GOnuKEnXKXlGXsAYaxgtQN44kaXU5Uk5y2y9h+PkViGaWRLezcwX2zg8VUhL5Nr
         /t4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=MIdQP2zG5/eI4fVzuNZAYxwOE++VEdLGV4B5H1tnXWk=;
        b=A3SrQOOIna6JAhAnyTP38MjB7/8bC5dImL7ssjA211eV/2cLVfNOJUwMc1/5pAfc6Y
         rL4Yh1/wkrVM/oT9cQqzoMJUj6jO0IiSgOxm53KO6o184su/t4ZypjoOFV/6yFD3jGQS
         PFckuvbr+Yt126E11CQb087E22r80U8/gi7nj9B7zur+TKLDT3UmhcL8RdhLU5Uiy745
         pG2nhE7jYSNtybTPxEqSekX7IjFbD3x0vEfDw3a6dIA79eyF89eXOx6EbjQ5AelUscuj
         Tco/UCYVX6tF/1wn14wG0/SLzxqp+maQa90dnwpcXhs50chT2sbPEOQxdx6NasSnp6zI
         n4AA==
X-Gm-Message-State: AOAM532necM6X5xwqlb4egTkfCQA//R/Go5nDUyx9uHOd+eYvGFbblj5
        vkxy6SGMqHjfM0lOMYowMmE=
X-Google-Smtp-Source: ABdhPJwJqq9YYzRpQJgJkyG4T8OlzhLPMaLdww2ztsF2LThG82xvteeR8KKLCwCFtm/zUujbxSdRoA==
X-Received: by 2002:a05:6830:10b:: with SMTP id i11mr26197721otp.35.1626870449263;
        Wed, 21 Jul 2021 05:27:29 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id c26sm1980376otu.38.2021.07.21.05.27.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jul 2021 05:27:28 -0700 (PDT)
Date:   Wed, 21 Jul 2021 07:27:27 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Alex Henrie <alexhenrie24@gmail.com>,
        Son Luong Ngoc <sluongng@gmail.com>,
        Matthias Baumgarten <matthias.baumgarten@aixigo.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Message-ID: <60f812afb2f69_1305dc208c8@natae.notmuch>
In-Reply-To: <f061f8b4e75a42f3c08b0a8fc63ac87c8f8d77ec.1626831744.git.gitgitgadget@gmail.com>
References: <pull.1049.git.git.1626536507.gitgitgadget@gmail.com>
 <pull.1049.v2.git.git.1626831744.gitgitgadget@gmail.com>
 <f061f8b4e75a42f3c08b0a8fc63ac87c8f8d77ec.1626831744.git.gitgitgadget@gmail.com>
Subject: RE: [PATCH v2 6/8] pull: abort by default when fast-forwarding is not
 possible
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren via GitGitGadget wrote:
> From: Elijah Newren <newren@gmail.com>
> 
> We have for some time shown a long warning when the user does not
> specify how to reconcile divergent branches with git pull.  Make it an
> error now.

Yes, but the warning doesn't say anything about changing the defaults or
deprecation.

-- 
Felipe Contreras
