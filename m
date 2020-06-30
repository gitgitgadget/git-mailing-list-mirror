Return-Path: <SRS0=HTZL=AL=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F06AC433E1
	for <git@archiver.kernel.org>; Tue, 30 Jun 2020 15:23:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 539832074F
	for <git@archiver.kernel.org>; Tue, 30 Jun 2020 15:23:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MDv1MuuI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389380AbgF3PXI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Jun 2020 11:23:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389250AbgF3PXG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Jun 2020 11:23:06 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 908DFC061755
        for <git@vger.kernel.org>; Tue, 30 Jun 2020 08:23:06 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id c139so18904340qkg.12
        for <git@vger.kernel.org>; Tue, 30 Jun 2020 08:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WFGVY2ijHuIReJA+Zc9/3DG3PM29JLj7p6j1Kh0weLw=;
        b=MDv1MuuIEYdXeHLNbYjJkfGStQ2OGJsGinE6fEMbVpqF2Wgq04GYTNWI382Ls3s9va
         Zf7VFhTUY3hwwTyv88R45ePIl6Y0ZKqZaPvRuvojyEG5WsZHFub+IPWpyB22jYQeJwXx
         hxuvbS/6MJgdz0+7aj7SMe0SMY/eq3p1XHkOBxxN6VyM+Sj3WCbInD28+nVDOnKOLkML
         pMZVpR1Ip0Vdy5rwH1XxM2A9kCtqjGc1acIrn+TrTpjZV7wyeqb6Iluw9dw+1yfHkGZ6
         H47YkF2b80BbMywtZeDw35DSkXvDh8RVa+OFtMRmAo+ve4MUtTy18K8mfNTCTyvm2gG0
         Nilw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WFGVY2ijHuIReJA+Zc9/3DG3PM29JLj7p6j1Kh0weLw=;
        b=Cw2NstpesDWgexrB8nKmQq2nLcyBGU7QSbnm5vaDWruW0EM5eYllOX3/Roz6QHg1zl
         zC6uqx1YUsCfImkz8Fgi/okqmxv9roFjcS5IQpnaWZNjrCjJvZl7wRFBe35GmA0noZaS
         0FMCs7xdcGJF84ReuVm+oiabKz7kRlnISD8odV7Aq7kLdP1XHCYIBxW5+eTr+qMtKd8M
         xzdegvbWR+RbbwvxfJf238uvC6OoFJWRc60un5ZofTZ+IohFcSUwiMIqfiIDcPREWLDE
         x60coXOBiCcb+SVHddb9bstdPgi3/o/+I8eaPq/wU8mGNFSU6ilHrnZD7/XwATTNVv9R
         gJXg==
X-Gm-Message-State: AOAM533G1xHvKXwOzWlzrPFYzmV0/AkmNyBHa6IK8IskphiSbRcC3O3c
        nQ4j5vs2KCEavv+b5pRanlM=
X-Google-Smtp-Source: ABdhPJyRQoQGxaTkGiQUYgAkKxs3NfpG5pmi2G5nEw0nzV/ll1kddVMFZ/lEi3vbHjbds63baqUMsA==
X-Received: by 2002:a37:9c8f:: with SMTP id f137mr20921227qke.63.1593530585689;
        Tue, 30 Jun 2020 08:23:05 -0700 (PDT)
Received: from generichostname (CPEc05627352ede-CM185933998587.cpe.net.cable.rogers.com. [174.112.146.193])
        by smtp.gmail.com with ESMTPSA id g41sm3631479qtb.37.2020.06.30.08.23.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2020 08:23:04 -0700 (PDT)
Date:   Tue, 30 Jun 2020 11:23:02 -0400
From:   Denton Liu <liu.denton@gmail.com>
To:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH v19 02/20] t3432: use git-reflog to inspect the reflog
 for HEAD
Message-ID: <20200630152302.GA1278279@generichostname>
References: <pull.539.v18.git.1592862920.gitgitgadget@gmail.com>
 <pull.539.v19.git.1593457018.gitgitgadget@gmail.com>
 <277da0cf7ed641a085e6f4d843aa5ac0dd56a6c4.1593457018.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <277da0cf7ed641a085e6f4d843aa5ac0dd56a6c4.1593457018.git.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Han-Wen,

On Mon, Jun 29, 2020 at 06:56:40PM +0000, Han-Wen Nienhuys via GitGitGadget wrote:
> From: Han-Wen Nienhuys <hanwen@google.com>
> 
> Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
> ---
>  t/t3432-rebase-fast-forward.sh | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/t/t3432-rebase-fast-forward.sh b/t/t3432-rebase-fast-forward.sh
> index 6f0452c0ea..22afeb8ccd 100755
> --- a/t/t3432-rebase-fast-forward.sh
> +++ b/t/t3432-rebase-fast-forward.sh
> @@ -60,15 +60,16 @@ test_rebase_same_head_ () {
>  		fi &&
>  		oldhead=\$(git rev-parse HEAD) &&
>  		test_when_finished 'git reset --hard \$oldhead' &&
> -		cp .git/logs/HEAD expect &&
> +		git reflog HEAD > expect &&

Tiny nit: there should be no space present after the redirect operator,
so it should be written like this

	git reflog HEAD >expect

>  		git rebase$flag $* >stdout &&
> +		git reflog HEAD > actual &&

Same here.

>  		if test $what = work
>  		then
>  			old=\$(wc -l <expect) &&
> -			test_line_count '-gt' \$old .git/logs/HEAD
> +			test_line_count '-gt' \$old actual
>  		elif test $what = noop
>  		then
> -			test_cmp expect .git/logs/HEAD
> +			test_cmp expect actual
>  		fi &&
>  		newhead=\$(git rev-parse HEAD) &&
>  		if test $cmp = same
> -- 
> gitgitgadget
> 
