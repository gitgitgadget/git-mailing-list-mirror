Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECDB2C00140
	for <git@archiver.kernel.org>; Mon,  8 Aug 2022 06:37:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235526AbiHHGh6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Aug 2022 02:37:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbiHHGh5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Aug 2022 02:37:57 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F75B11A20
        for <git@vger.kernel.org>; Sun,  7 Aug 2022 23:37:56 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id j8so14753285ejx.9
        for <git@vger.kernel.org>; Sun, 07 Aug 2022 23:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=80yQ9efSBMzgu75kKdYHspEvSRr1sz2fAUlj9G8uLqA=;
        b=EPcivhaVciypVMu/uDctAXn8CBT9aJKEs8kOQaFy5bMQG7aHu6PcMlccgvhM+DD+n8
         S0CugmCTT64xuilmb+mO1QiBet58OGQeNJMbh35hRHIXaKNrce1Z1z+Tb/2wZlCGuzG5
         hziKYk14gOvIWT0kJpQX3zSxFpwKQ88rkL687vUW7tOAsUQRP3XVwb2wzVpVpTm3WB+0
         x/E7MkGjo7fw//dZcROd+nE/qUxnZ5BH9GbpZRJnauXxFwTOZzz4T/61CIn37KmllH4n
         gUKiclkxkw/51eVikfO1l2zxbq/RsYZXi221t4mcuE574g2kqFtR9s5ObDEbqSW1ZFYD
         7Vug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=80yQ9efSBMzgu75kKdYHspEvSRr1sz2fAUlj9G8uLqA=;
        b=vznLdmlPs7NI9ZZqAN8uVsoHP6aPPPjXksysw7Mmpl0/0XiCzPY+IwPiW0tYcf9oBj
         3XzFsaOST/9HlJO5o0BkPHJLpzRYReX/jW4rV6Da6xvSf4PG+a6+dCeZmkbZiRxZpuxo
         nWZiWvvrvsE82YKXdN4Q4X6nYH+ZPFjbFkuUCoMLOtxp7GKSosbN7DSwcTsbUhGUrLa4
         5QoyeDXnIR0dmAaAXZZZg92tyD2o3f7YZyJu9qIPQ44LlG7wK6XSJOtL9SmE7OHXHlLS
         cPdc0Q0ETyyLKKBp90bBoGaKunoRgEMHqNNxK57xcQ6Ad3YrE+fg/yUZNN8BPp/LjUxb
         L5mw==
X-Gm-Message-State: ACgBeo1/51bnQgxwYLZhBidCbTvXwF9XCgkais1feg+QIhVonAueIKeM
        dG/1hGf5NuF08HPv3mDQBlAnQMUMqgww6niDLVIC1aUDleg=
X-Google-Smtp-Source: AA6agR6Va1TVrJMHAcYtDiYAHlXicUFELj0rD+bEjWXmUZJQ9aNwq3TnIywZZ4S2P8LeYT6ovz2VpvKmj1xp7MvRY7Y=
X-Received: by 2002:a17:907:28c8:b0:730:9ccc:331f with SMTP id
 en8-20020a17090728c800b007309ccc331fmr12528264ejc.608.1659940674700; Sun, 07
 Aug 2022 23:37:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220807024941.222018-1-felipe.contreras@gmail.com>
 <20220808053459.184367-1-greenfoo@u92.eu> <20220808053459.184367-3-greenfoo@u92.eu>
In-Reply-To: <20220808053459.184367-3-greenfoo@u92.eu>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Mon, 8 Aug 2022 01:37:43 -0500
Message-ID: <CAMP44s3v_4PdOfaviXCxik1LL5k_kkmZ2Yp=+Qfb8CqyNCdMUQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] mergetools: vimdiff: fix single tab mode, single
 window mode and colors
To:     Fernando Ramos <greenfoo@u92.eu>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 8, 2022 at 12:35 AM Fernando Ramos <greenfoo@u92.eu> wrote:
>
> vimdiff3 was introduced in 7c147b77d3 (mergetools: add vimdiff3 mode,
> 2014-04-20) and then partially broken in 0041797449 (vimdiff: new
> implementation with layout support, 2022-03-30) in two ways:
>
>     - It does not show colors unless the user has "set hidden" in his
>       .vimrc file
>
>     - It prompts the user to "Press ENTER" every time it runs.

For the record, in my version these two issues are fixed in a much simpler way:

--- a/mergetools/vimdiff
+++ b/mergetools/vimdiff
@@ -325,7 +325,7 @@ gen_cmd () {
        if ! echo "$LAYOUT" | grep ",\|/" >/dev/null
        then
                buf=$(get_buf "$LAYOUT")
-               FINAL_CMD="-c \"echo | ${buf}b | bufdo diffthis\" -c
\"tabfirst\""
+               FINAL_CMD="-c \"echo | set hidden | ${buf}b | silent
bufdo diffthis\" -c \"tabfirst\""
                return
        fi

>         # Add an extra "-c" option to move to the first tab (notice that we
>         # can't simply append the command to the previous "-c" string as
>         # explained here: https://github.com/vim/vim/issues/9076
>
> -       FINAL_CMD="-c \"$CMD\" -c \"tabfirst\""
> +       FINAL_CMD="-c \"set hidden diffopt-=hiddenoff diffopt-=closeoff\" -c \"$CMD\" -c \"tabfirst\""
>  }

These diffopt settings look awfully familiar.

https://lore.kernel.org/git/20220807024941.222018-7-felipe.contreras@gmail.com/

-- 
Felipe Contreras
