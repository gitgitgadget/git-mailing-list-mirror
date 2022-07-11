Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C592C43334
	for <git@archiver.kernel.org>; Mon, 11 Jul 2022 21:02:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbiGKVCd (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Jul 2022 17:02:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbiGKVCc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Jul 2022 17:02:32 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3816F1F639
        for <git@vger.kernel.org>; Mon, 11 Jul 2022 14:02:31 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id a14-20020a0568300b8e00b0061c4e3eb52aso2390914otv.3
        for <git@vger.kernel.org>; Mon, 11 Jul 2022 14:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=zPNWdU4gp/F94xeAnQHrxF4l9Mm/hFsojqNeS4byj6g=;
        b=T7X9JKloaQrvL4QH7BlEsrx2W4bqRXHOWbMjWeVo7p/BQg1Eo1OGq8x82vkCHamvRL
         xyDbcFXqmA4+OCBjP6CYyLY9e0jxXrQgqp3YdOQMGzlqXpZ0buhTNJ/v/3FdDqjNfnrJ
         5fT21WAe8tkDyqh9QKNh4zcmTfyRDwBnv2ENclLou8Y7+gmZh1ZY6FZHfH0M3iekpNNB
         Z8V84omSS4CpJ+pdbSFb1WFKI1AjQEShq6nzJO59TQp8W6MRJV1FG4lagIL5i2cl/5fu
         YGlAED6i38mGYT/qo+vlfAiVVsxMkkvn+/XqX9JDAC0eC6FF6TXSDreiebN+xw7NsJHd
         0qjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=zPNWdU4gp/F94xeAnQHrxF4l9Mm/hFsojqNeS4byj6g=;
        b=n4MPfMXom5wczy3JVVvIw2gDtWaeJGtW4h9vQRDXgXQB3aeSiTCX5AZM92VWwZ5pDr
         MYhIecbk/5hpvCKbvLEX7JLtwJbh7WoZ5pYxAn1UAnwd6huqNrEjs207hqvGh+NBDjuz
         LAXatYHesquAprH0GEjaURRdpkXatMtvvusYQNcB/+78d12y9ETcMp47T4Th2yB2Z8Ku
         dMWx2k/Ma6AzDUIH8ntz0bMCnZ1DjgtByGKrppervEc/JfQfwEdwgjE0elpMIF6t8NJT
         pWMoFP+VLl7nedU4uMER4JmfzsJWWQ3HeJILQiApOoVI/DwkJJCfA76gXyMVbvXYcSDp
         aX0w==
X-Gm-Message-State: AJIora/D8+keEH1kpJQGpN1z3IdjZlTwO7ZutxD3yypsX9A7vq4xFDBg
        rCw3dMQTRmS0UNfR3QnLqy3GvyT53vH6k0EkParDVIKIWok=
X-Google-Smtp-Source: AGRyM1vcH4iXfCBEY13eUPPji1QJSbqF7bzhN6MuJeAyoUL7uurynMOTXYka/1KfEXAuaILQsJmrm4JoXMcFnMnul7M=
X-Received: by 2002:a9d:174:0:b0:61c:1b21:9f08 with SMTP id
 107-20020a9d0174000000b0061c1b219f08mr7994639otu.17.1657573350270; Mon, 11
 Jul 2022 14:02:30 -0700 (PDT)
MIME-Version: 1.0
From:   Gerriko io <gerriko.iot@gmail.com>
Date:   Mon, 11 Jul 2022 22:02:19 +0100
Message-ID: <CALF=2ANoq1eL-RqK_dLaVThoxbvfhzgPJXFHyD1kX8CFCPx3XA@mail.gmail.com>
Subject: Why is reflog so obscure?
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I am trying to make sense of reflog as I need to know this to use
revert and reset properly.

I cannot find the most basic information in the git documentation or online.

Surely the most basic question is whether the reflog is sequential or
just random logs or whether it is in time ascending or descending
order.

Without this information I am left baffled and have to guess what this
line means out of the many:

a0bbd34 (HEAD -> master, origin/master, origin/main)
refs/remotes/origin/main@{0}: update by push

Why does it have to be so obscure?
