Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EF27C05052
	for <git@archiver.kernel.org>; Thu, 17 Aug 2023 02:53:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347703AbjHQCws (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Aug 2023 22:52:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347747AbjHQCwg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Aug 2023 22:52:36 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A49982D5F
        for <git@vger.kernel.org>; Wed, 16 Aug 2023 19:52:31 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1bf092a16c9so5132245ad.0
        for <git@vger.kernel.org>; Wed, 16 Aug 2023 19:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692240751; x=1692845551;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IEjh4jFN/xTJCsNqRlaR2cI/6HCFnljcnailkCfh0yQ=;
        b=qV/Igf9MZsoBxSKqDitdqjZ1CTBSHuaBLmm2CycYiFSva2cjJErQJ9UrbOAa63qXRN
         3+dwVCSuWwj9ZQnnDB2hkDrSTSu83TdsCc42ZJL4qRBH/xMXmxxAFpmrACi9bnvaUUda
         VhTNDEEx9j2Gu/DvtuCFbapwySnluWYnBZwWZxnD7c4A2X8hzEvIHjojW6vsnPfJ7d5W
         0TrXRvGhGyWvlgjnQjpKDErc2XrsVGUewBPUof1O2OR8MDd9jH2/ToNPYI8K8pq4foUU
         otW+7qzUgh03DZcyKbIERfPJ4UsvvdrLnoxr7gZ0PYDhH5iGXHuecemog94f+vHG34XI
         DZMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692240751; x=1692845551;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IEjh4jFN/xTJCsNqRlaR2cI/6HCFnljcnailkCfh0yQ=;
        b=OCbNFInFISYmOMTB4NZ6Msfgi7WJxP1AGYcbY4wm1ryDnn4Lt6G3wRKA01xrQeE9Rs
         5J5AocS8cLZjXlRyozY8l3me+0c6Tqg0xGZTuQ1b0OjOguTzan3It5gmoeAmtcpDw1+Y
         W5QF7AzDcuVcCuKLTI+uwRX1ntYQZl4j1nUwJTYK/svF+vVlAUcfjMLRVeL46cGci9Ti
         ZCYMzvKFmm8Vtc8lwDHyNzU/kr+J0k57XuoRn0Xk9JuLLi/5HaqjoouAQGwh7NwkZzRC
         w3RHDUYhaCcCFMI6jd7nPxglIkpmZw0zenJxrgwoLLyx6/bfCEc+7g3zL4SkV3BHgB4A
         mUIA==
X-Gm-Message-State: AOJu0Yz3NdMpUWuVh1TdD103Zh8p/u+agwCrhtAo1DnTojibBcyDOpEc
        F+QPjumIPAANY84UnOsItAQqST1JpRT92Q==
X-Google-Smtp-Source: AGHT+IF6gkrKPu3uFPx5/u9X+ME1DSbK6Bo2pWju0i6NPSdcEugkPcFLnw2aj/DAXDyg3epaA+gLQg==
X-Received: by 2002:a17:902:d2c4:b0:1bc:2f17:c628 with SMTP id n4-20020a170902d2c400b001bc2f17c628mr4531855plc.56.1692240750983;
        Wed, 16 Aug 2023 19:52:30 -0700 (PDT)
Received: from localhost.localdomain ([2404:2280:2000:10:bbd1:e247:bbd1:e247])
        by smtp.gmail.com with ESMTPSA id jw21-20020a170903279500b001b9da8b4eb7sm13810746plb.35.2023.08.16.19.52.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Aug 2023 19:52:30 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
X-Google-Original-From: Teng Long <tenglong.tl@alibaba-inc.com>
To:     martin.agren@gmail.com
Cc:     dyroneteng@gmail.com, git@vger.kernel.org
Subject: [PATCH 2/4] notes doc: tidy up `--no-stripspace` paragraph
Date:   Thu, 17 Aug 2023 10:52:22 +0800
Message-ID: <20230817025222.75033-1-tenglong.tl@alibaba-inc.com>
X-Mailer: git-send-email 2.41.0.328.g2e11c30e.dirty
In-Reply-To: <f2e31e70ff6cbf105d00aa5d1188554def34e142.1692194193.git.martin.agren@gmail.com>
References: <f2e31e70ff6cbf105d00aa5d1188554def34e142.1692194193.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Martin Ågren" <martin.agren@gmail.com> writes:

> Where we document the `--no-stripspace` option, remove a superfluous
> "For" to fix the grammar. Mark option names and command names using
> `backticks` to set them in monospace.



> Signed-off-by: Martin Ågren <martin.agren@gmail.com>
> ---
>  Documentation/git-notes.txt | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/git-notes.txt b/Documentation/git-notes.txt
> index 9043274ce8..f8310e56a8 100644
> --- a/Documentation/git-notes.txt
> +++ b/Documentation/git-notes.txt
> @@ -179,9 +179,9 @@ OPTIONS
>  --[no-]stripspace::
>  	Strip leading and trailing whitespace from the note message.
>  	Also strip out empty lines other than a single line between
> -	paragraphs. For lines starting with `#` will be stripped out
> -	in non-editor cases like "-m", "-F" and "-C", but not in
> -	editor case like "git notes edit", "-c", etc.
> +	paragraphs. Lines starting with `#` will be stripped out
> +	in non-editor cases like `-m`, `-F` and `-C`, but not in
> +	editor case like `git notes edit`, `-c`, etc.

Oops! I didn't notice to distingush ` and ", there are some places
still using ", but here we think to use ` is the apppropriate
way to surround option and command, etc. in docs, right?

>  --ref <ref>::
>  	Manipulate the notes tree in <ref>.  This overrides
> -- 
> 2.42.0.rc2.215.g538df5cf27

Thanks for fixing this.
