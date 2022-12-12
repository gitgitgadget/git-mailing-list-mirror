Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CB45C4167B
	for <git@archiver.kernel.org>; Mon, 12 Dec 2022 16:42:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232427AbiLLQmO (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Dec 2022 11:42:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232927AbiLLQlY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Dec 2022 11:41:24 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA53C15A23
        for <git@vger.kernel.org>; Mon, 12 Dec 2022 08:39:07 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id r26so13645218edc.10
        for <git@vger.kernel.org>; Mon, 12 Dec 2022 08:39:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Z/7vcqasZ8DGeAk5/+V7qiff+ICqN3X9cRAxYPf5wF0=;
        b=ZWVrybxhRj0tg5vRGxwi9T4x2sSmnZb/rVesmtejqYZDynpmoag94zYzgRearoNC/b
         5MywrOjK/ASZ9xjoQ4oRV18C8L298KyxhPLSI9cPv7YEBjLM+kMpgh6+qBj/aE4tvXf7
         GH3YLdE6+5j/MEioOsNG3/WjWRYqgyz+/8gQTBb+LPv5Fn/HHP1YTqLDyrzxtgO1Ppxv
         +GlY0o58g78coCr94fCHEJHZP9aOckShooITO8jjLY9AOXYYR2D3cuf705AgXKhrokyv
         goN6oA3S4783kJiTx/cclaKZ+zBnewJLwnD2VEEFPxSlX1RbIhChX4H7tbsIwgDdj529
         adVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z/7vcqasZ8DGeAk5/+V7qiff+ICqN3X9cRAxYPf5wF0=;
        b=4GKc2RVbhtxgYXDZu1D8BUqV98vucnjWE485RNxx9Dv95w9ObRxS3Kc9sSZGD56b6g
         VpyQ2rQoz4Y4dumkJownZ6b1xAvzYcKc0k9H1yMqTlgH1hEr+MAvU4aiimFJDRJjN06o
         drFddi6YU9hQ04LoYyt0hECxmggmugPswXykTB2P58yqIKwdPAXSdskjHgQcUgswA52z
         XRZLFuY5MfZoy9hoXhr1WWgd6cttF9swxWnUutMMsMpHZchDaCkZSxitxgjCUazW7o2g
         NaIlUFPNYaHwWmzzGBugmmS0tiLVQu+i7wdx2e59WtDrQyKZoLxRPVFZBV2ul/pC0dTa
         i//w==
X-Gm-Message-State: ANoB5pnOLdf6/4h071aHf2m5fakm0VQRnj13nNKHfAczQM1WvG/CcFvy
        4DumVF3WmCChKQ8jc/puL2PxAOzh4HXwaR7CvoM=
X-Google-Smtp-Source: AA0mqf5C51PYqFUyqV+O9kIDkynQt0OOFke4mOktkVoFjoeutNvUrgt2y0Fk+ZpY3exmNt3Q+b7XL5JKn4bWnKzPS9c=
X-Received: by 2002:a05:6402:550b:b0:45f:9526:e35a with SMTP id
 fi11-20020a056402550b00b0045f9526e35amr87074852edb.256.1670863145755; Mon, 12
 Dec 2022 08:39:05 -0800 (PST)
MIME-Version: 1.0
References: <pull.1373.git.git.1666970645.gitgitgadget@gmail.com> <pull.1373.v2.git.git.1667073374852.gitgitgadget@gmail.com>
In-Reply-To: <pull.1373.v2.git.git.1667073374852.gitgitgadget@gmail.com>
From:   Simon Gerber <gesimu@gmail.com>
Date:   Mon, 12 Dec 2022 17:38:54 +0100
Message-ID: <CAAyHH30eoRAgtO+QOZZFbx89Nr55xtndu6pRa5k=ZnJZXnZACw@mail.gmail.com>
Subject: Re: [PATCH v2] help.c: fix autocorrect in work tree for bare repository
To:     Simon Gerber via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, 29 Oct 2022 at 21:56, Simon Gerber via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> [commit message omitted]
> ---
>     Fix autocorrect in work tree for bare repository
>
>     Currently, auto correction doesn't work reliably for commands which must
>     run in a work tree (e.g. git status) in Git work trees which are created
>     from a bare repository.
>
>     This patch adds a test case illustrating the issue and proposes a fix
>     which adjusts the usage of read_early_config() in help_unknown_cmd() to
>     match other usages of read_early_config(). In particular the patch
>     removes the call to git_default_config() in the read config callback.
>
>     Changes since v1 (both suggested by Junio):
>
>      * Moved test to 9003
>      * Squashed change and test into a single commit
>
> [diff omitted]

Hi all,

Just wanted to check what the state on this patch is (side-note: I
just noticed that I didn't cc Junio in the v2 submission, my
apologies). As described in the quote (and the parent email), the
patch fixes how auto correct initializes the config. Version 2
addresses the points raised on v1, in particular, I've moved the test
to 9003, and have squashed the change into a single commit. Please let
me know if further changes are necessary.

-- Simon
