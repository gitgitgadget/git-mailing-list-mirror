Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FAF0C19F2D
	for <git@archiver.kernel.org>; Sat,  6 Aug 2022 19:39:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232888AbiHFTjw (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 6 Aug 2022 15:39:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbiHFTju (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Aug 2022 15:39:50 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E431610C8
        for <git@vger.kernel.org>; Sat,  6 Aug 2022 12:39:49 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id gb36so10188903ejc.10
        for <git@vger.kernel.org>; Sat, 06 Aug 2022 12:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=lyAwb1kbuj2KZ/gUFOPYM4L+JnuTv9WhGwLcih7q/VE=;
        b=ZSCKt2pslCp4flszUm2jee5g+9hyAMh+r44PAvGZuAVFCPL0X4XujZIOFVDTMzJkbj
         qELK8JNS68FeeDHb3epIEsT+xW57hz9OH5yJHxSZ5fiuuoBGwsTdAClIpq+dDqMvWxAp
         eQVViFqdNJg+5jmXB3nQyEbuD2r6K4S96lA13IiSKCBsipgGtXhmvedNnHhihbe9D5RH
         CbToCF86G2VktxHHTqTxLIdiShPp2NteckESjo/1JjLcLHfDYw6vUxuvMN0jkbQ+Mho9
         tN1KMrfyCfXIIexHy0zlzTIBf+TumvstjOyu1OadcOO66IB/lJMhUP2e1Pvyp2xaBW1q
         Uppg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=lyAwb1kbuj2KZ/gUFOPYM4L+JnuTv9WhGwLcih7q/VE=;
        b=6ij4dQktzzsKptXFy8yOJW2JgB93etUV91TKAJo/ddl2W8qM2rO/JtFFHwhry+55I+
         SZIW63TrF4E4YalmLSftXpnsyApqj8Mkgr8XcBuEvXY9cwfaw9vJUCQT0xyoTqPxNTBv
         m4/juwbqQ+X6AoMjGJd3oMGMGteY20Aik8rUSH/LQ/nSKrhR3gfKQCF2kokVsD17v5iL
         tgRPjOO8O8FSrtNiJ+FToUDaXDWN48cBe1amNbmpx17EJeOE/3baIyzlOTxH7z8QPGOV
         4hql0OmCrJdZyE24hcMYmsDvpareN//voiYLTgdyFNPYAjSeOtLSx9ucAD/GcBUBVqDw
         W7UA==
X-Gm-Message-State: ACgBeo1zUmnHyaNoBghEeAUWmG299uZCGxvUZjCuNgU/plbKD/xwKrAZ
        peiZZiADuBWxhiWYipKjCVKll6uY28IYeIV2BFUHfLah
X-Google-Smtp-Source: AA6agR6wd84nVy+ppY61OUVAurZOGDo0U4rMghItrKSPbpuwPXyIpxuH/yKI8eVQ/e149N2OnmoOXC8DxpUONwFzoZ0=
X-Received: by 2002:a17:906:93e8:b0:730:9e5c:b45a with SMTP id
 yl8-20020a17090693e800b007309e5cb45amr8763480ejb.530.1659814788423; Sat, 06
 Aug 2022 12:39:48 -0700 (PDT)
MIME-Version: 1.0
References: <Yu6zEiknXKFMJUVn@zacax395.localdomain> <20220806183757.72168-1-greenfoo@u92.eu>
In-Reply-To: <20220806183757.72168-1-greenfoo@u92.eu>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Sat, 6 Aug 2022 14:39:37 -0500
Message-ID: <CAMP44s1YegUqFzw8L==q2QOmh-6WCJdXYSXUvz8GPCrXuYRVPQ@mail.gmail.com>
Subject: Re: [PATCH] vimdiff: fix 'vimdiff3' behavior (colors + no extra key press)
To:     Fernando Ramos <greenfoo@u92.eu>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Aug 6, 2022 at 1:38 PM Fernando Ramos <greenfoo@u92.eu> wrote:
>
> vimdiff3 was introduced in 7c147b77d3 (mergetools: add vimdiff3 mode,
> 2014-04-20) and then partially broken in 0041797449 (vimdiff: new
> implementation with layout support, 2022-03-30) in two ways:
>
>   - It does not show colors unless the user has "set hidden" in his
>     .vimrc file
>
>   - It prompts the user to "Press ENTER" every time it runs.
>
> This patch fixes both issues by adding "set hidden" and "silent" to the
> generated command string that is used to run vim.

Although I don't see the point of the extra complexity in the case of
a single window, especially since it doesn't really work for anything
other than "MERGED", this does make vimdiff3 work again for me.

Tested-by: Felipe Contreras <felipe.contreras@gmail.com>

-- 
Felipe Contreras
