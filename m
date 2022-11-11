Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37AC1C433FE
	for <git@archiver.kernel.org>; Fri, 11 Nov 2022 02:31:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232229AbiKKCbp (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Nov 2022 21:31:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231873AbiKKCbk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Nov 2022 21:31:40 -0500
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9894963CCB
        for <git@vger.kernel.org>; Thu, 10 Nov 2022 18:31:39 -0800 (PST)
Received: by mail-io1-xd2d.google.com with SMTP id e189so2768013iof.1
        for <git@vger.kernel.org>; Thu, 10 Nov 2022 18:31:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QDv9F+tU4dJMYToZk22xIzf7h+2ub+mc30ps9169ZAc=;
        b=D1+Yb7K/fYOLTH5vqnVvDJCjL8juefghBos9CrLTkvHcIW/wJKshMpdI6Rc+S4u+9p
         9UHReMUTHMi5+oUzUaI245Pg9zdISDRQugEgutjXaRSenLjCL31iDt7ZTVCaHBhDK8VI
         h8UvNntOq721fvDizcHT1aRH8ONPSIw2A6ULY7ZvQtkcEE/F/HLwcORx88uNZIWQQRaa
         7H4Jq+qRmJf6b3Pree10g1FjqbUVxIa4RW5cuorv/4uzKGa2CxQt3JySiXHBYz0pWCte
         N+N8b7tprhUwfPcla/grC14TNQnOE1qE9qYure5QzLtU7Gv3C+sOOCijZkEQDytdUyQE
         L0mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QDv9F+tU4dJMYToZk22xIzf7h+2ub+mc30ps9169ZAc=;
        b=OgHxt3xMZKnDyhNeuCHr/8VrKHx9LECR9ML1wkMqP9vCySFmUf5MYpBS9O3viyqSrF
         xiqe5Mfy4ropJBm/8Vk9Yo7ze8Obkezpq0K40Gl8FeRfCt1HtnPohPiz3SfxSX+RuM1P
         GjuHJVerKvNJ6NjUi2I2MMM2RLfYFyCpfWAvSqn9oNI4GJYziAzj2NKXuF766bcXOCwl
         5uiwue4i3PIWr+iZt3i5xQhHbRzc8BvECDWobGETYsgXeaHRSDb9lCLprCK9Ga2swRsi
         G3fDHlLgD84X23CjbhjpXebwgPB74nu4FBLfOGbspXC8AFmKbKbfSapb5fC/hbcP6GM/
         fb5Q==
X-Gm-Message-State: ANoB5pkcEdeELSu84UiqRfXqBJkvrgQSFSDkVtr0YCEd/TMxtSHGwIku
        LUChU7JecD1nAcTJrCnbp3rvJ/bsQScC+g==
X-Google-Smtp-Source: AA0mqf5UyN8YzKNi48AXZ4WLKmISTIMS+Gu3XqetvhhUgLvSr+bohvLZeIWP/JUJfc0LM0Ho0J/Xmg==
X-Received: by 2002:a6b:b343:0:b0:6d5:2f6e:834 with SMTP id c64-20020a6bb343000000b006d52f6e0834mr88920iof.181.1668133898940;
        Thu, 10 Nov 2022 18:31:38 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id x1-20020a056638026100b00374a9dbd061sm394967jaq.73.2022.11.10.18.31.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 18:31:38 -0800 (PST)
Date:   Thu, 10 Nov 2022 21:31:37 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     Glen Choo <chooglen@google.com>, Taylor Blau <me@ttaylorr.com>,
        Glen Choo via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] http: redact curl h2h3 headers in info
Message-ID: <Y220CXetWek/eZEu@nand.local>
References: <pull.1377.git.git.1667955151994.gitgitgadget@gmail.com>
 <Y2xnUyEoCFmbPtUI@nand.local>
 <kl6lpmdu3dl5.fsf@chooglen-macbookpro.roam.corp.google.com>
 <Y21yPIDmwB53e+aj@coredump.intra.peff.net>
 <kl6lk0422zgd.fsf@chooglen-macbookpro.roam.corp.google.com>
 <Y22ze1m6ayQCv9B5@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y22ze1m6ayQCv9B5@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 10, 2022 at 09:29:15PM -0500, Jeff King wrote:
> > - Write our own HTTP/2 server for redaction tests. I assume this won't
> >   be trivial, but maybe not prohibitive, e.g. [1] implements its own
> >   http server for credential helper tests.
>
> These seems like a lot more work than just setting up HTTP/2 support for
> Apache. I checked the recipe from b66c77a64e, and it still works. It
> does indeed find the bug (my curl is 7.86.0) and confirms your fix.
>
> I think a simple path forward could be something like:
>
> [...]

Thanks. Your plan looks very sane and seems like it hopefully wouldn't
be too much effort.

I'll leave it to you and Glen to figure out how to divvy up the patches,
but I'm sure you can figure it out ;-). Thanks in advance.

Thanks,
Taylor
