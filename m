Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3628C433EF
	for <git@archiver.kernel.org>; Sun,  7 Nov 2021 13:20:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 902B86115A
	for <git@archiver.kernel.org>; Sun,  7 Nov 2021 13:20:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232589AbhKGNXL (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 7 Nov 2021 08:23:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232562AbhKGNXK (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Nov 2021 08:23:10 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6E85C061570
        for <git@vger.kernel.org>; Sun,  7 Nov 2021 05:20:27 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id t30so21931469wra.10
        for <git@vger.kernel.org>; Sun, 07 Nov 2021 05:20:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Z149mQ7fEk44682JlRH1gXjdWWCrWkzxPSFb+PDlBVg=;
        b=CRhlUVYJwhwaL3exwY1aS2eaqHE2f7V3b0alPWI8cdzY3daLLxoh9qIQbm92pLv+EG
         uc94egqAdR/1xAJTIrmU4miDnAlbv7IhmMuJC/8mwlV4m+jhfmAZcQjj86Ij2ys8wK8r
         4U4IaDWYQt0GFLAfC8bYdXNPVn4CPpKalo4sMJeTa4vljlCNSdMVFvoryxopbJ3jaonv
         BchPOewnZS7Qg8UuL5F/MBsLhyl9RUtI79lobzcyTy27nEK9vZdLmcvm5GwaBSNAB6/Q
         IOdf5qqjH4b/yIAqFVnmKHfbvplB7TLVwk91Xjgtjy02mVAyZpxQubBYx8mcz2rY4Ywm
         2npw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Z149mQ7fEk44682JlRH1gXjdWWCrWkzxPSFb+PDlBVg=;
        b=McgMLWAES4Kj6kezWo8sk6+o9utj/HxuPIz2w1dVI6vjtr4nkpGItnccz04NBfpwme
         SqXGCpM2TegcGaDZwZGf1NYgrsBJqRMiuhIvgWXl67ow11HQsIvYnuII1Su9eRY+dg9v
         pOuzCFNUudzKp9OECtxqE2t+xZnm35sh4FyRY5sBvJnxuy/SlqsES86lnJTpaA+9hf+5
         gn1at/pWHOhXN8pr1OsMoE1CVnt79LsxgkgLW/92VjRDlvrYCtSoRrT7v4PJ9gEc4CKB
         W1PBD+fT8PMGcBvJEjb3yYk09Xc6peFIADe+eQtCuGb7Y0+LQziAmCHEX8WREbzZY4+b
         prDg==
X-Gm-Message-State: AOAM532G0VNrzKCVe7YwLq9ymF5QvwuW6kcWicf0fAMh6BpAN7WfTGq1
        7czW7VrmZYp75BR2vCQ/FBc=
X-Google-Smtp-Source: ABdhPJxYe3QSjALMPcjQUQrSanK91qG3QMDA+Ot2NV10ZBijdjQjllteTRMj4XAUGxUwpnm32GYuxw==
X-Received: by 2002:a5d:5984:: with SMTP id n4mr68012701wri.23.1636291226364;
        Sun, 07 Nov 2021 05:20:26 -0800 (PST)
Received: from gmail.com (193-81-63-211.adsl.highway.telekom.at. [193.81.63.211])
        by smtp.gmail.com with ESMTPSA id h17sm13674555wrp.34.2021.11.07.05.20.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Nov 2021 05:20:26 -0800 (PST)
Date:   Sun, 7 Nov 2021 14:20:23 +0100
From:   Johannes Altmanninger <aclopte@gmail.com>
To:     =?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 09/10] doc: git-init: clarify file modes in octal.
Message-ID: <20211107132023.c5x6j6o3gmoroiyb@gmail.com>
References: <pull.1066.git.1635261072531.gitgitgadget@gmail.com>
 <20211106184858.11500-1-jn.avila@free.fr>
 <20211106184858.11500-10-jn.avila@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211106184858.11500-10-jn.avila@free.fr>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Nov 06, 2021 at 07:48:57PM +0100, Jean-Noël Avila wrote:
> diff --git a/Documentation/git-init.txt b/Documentation/git-init.txt
> -'0xxx' is an octal number and each file will have mode '0xxx'. '0xxx' will
> +'<umask>' is an 3-digit octal number prefixed with `0` and each file

"an 3-digit" should be "a 3-digit"
