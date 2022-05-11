Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85650C433EF
	for <git@archiver.kernel.org>; Wed, 11 May 2022 06:20:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239539AbiEKGUc (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 May 2022 02:20:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239272AbiEKGU2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 May 2022 02:20:28 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01CDB1EEE0F
        for <git@vger.kernel.org>; Tue, 10 May 2022 23:20:25 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id w17-20020a17090a529100b001db302efed6so1157281pjh.4
        for <git@vger.kernel.org>; Tue, 10 May 2022 23:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PRJZZuMj5cwL3mGTHL+YSp8nsWBQvORtdZTy5L/sXF4=;
        b=T0eUvT2ktKJP/wDbk1KjrrsU43fwZUlYYbJ9P4N89s010PxQU0ewTszcXi8hxGVU60
         sbXhVI9mTxTqD2wJTxhnujmGCp3L9mVO8CevD4X9YXPHucKGSYqKWLzXfkwnK+Z+2y5O
         aGdl0XBxwEY+E535LVDpRb6Fx9RQCRG4gi7ePfQHVS5hO1MvRWCVs7U/VFEX4dXfy750
         ARfsqTUfGk0nQgAAZS9b508HUs/+Qcz0DBamSLGaCtfbYfnGlOdDmsF/O5vfb61qGpjW
         hbzDWHZtnx4Dp8e3rifSUSoRFfdT43tz6eXDq4BbzfqL4FZb0o2vJUEX0k+eV8npQdxO
         u4HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PRJZZuMj5cwL3mGTHL+YSp8nsWBQvORtdZTy5L/sXF4=;
        b=tAUkVl2QFtPIUSq22P1ePhEfZKlYU95OIU0b2B/21yJOnCFtloOfjnqHE3UmNSGmOw
         0a6u3uQ+nMD8DPAQUO92ijoA3ZTL/usNtkuC/lmfaPu5HOLUYvX8BSeChBHnGAFmwxMo
         Px9RYJ5pq5rtWmRkWeWnpKNGju3x5yBdLGB+8qcAZbVQtfy5fzd92ymwA7Y/i3dIWleo
         NEz9OD9Mv/T/etEN2tHKx6HQP9le2N+kwoLPWceIZ5pkDVnY9jN4txUKNWNgMcrp2As9
         fZDCUbi7ezGkEna45sl1dUC2QIy7EDfLIA7ti9YoHSo/hAGX+ijI9vknBZQ8OCrt5ouE
         h9Pg==
X-Gm-Message-State: AOAM531UWJsiTz8qJhVHMfHM6fZJpobpGsOy9TH0wmFrtGKROaIGkF24
        K4sgbOoPtjA48n4+jw0UdOjRvpbmQfPgfg==
X-Google-Smtp-Source: ABdhPJwbllHO+vRXf40E75+Px9IJNQhGwNYRBBGu0Lo+4/NbUgPQOqeDled0ozkQW4lJWhftjYN8yA==
X-Received: by 2002:a17:90b:4b4c:b0:1dc:4c07:aa63 with SMTP id mi12-20020a17090b4b4c00b001dc4c07aa63mr3654659pjb.237.1652250024277;
        Tue, 10 May 2022 23:20:24 -0700 (PDT)
Received: from localhost (subs02-180-214-232-26.three.co.id. [180.214.232.26])
        by smtp.gmail.com with ESMTPSA id bf2-20020a170902b90200b0015e8d4eb1c1sm789741plb.11.2022.05.10.23.20.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 23:20:23 -0700 (PDT)
Date:   Wed, 11 May 2022 13:20:19 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Victoria Dye <vdye@github.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Subject: Re: [PATCH v2 1/5] MyFirstContribution: add "Anatomy of a Patch
 Series" section
Message-ID: <YntVo0G8G2mQYCLZ@debian.me>
References: <pull.1226.git.1651086288.gitgitgadget@gmail.com>
 <pull.1226.v2.git.1652233654.gitgitgadget@gmail.com>
 <59af7e5e5ad84103b39ac9511791eb06b88df3c6.1652233654.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <59af7e5e5ad84103b39ac9511791eb06b88df3c6.1652233654.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 11, 2022 at 01:47:30AM +0000, Philippe Blain via GitGitGadget wrote:
> +We can note a few things:
> +
> +- Each commit is sent as a separate email, with the commit message title as
> +  subject, prefixed with "[PATCH _i_/_n_]" for the _i_-th commit of an
> +  _n_-commit series.
> +- Each patch is sent as a reply to an introductory email called the _cover
> +  letter_ of the series, prefixed "[PATCH 0/_n_]".
> +- Subsequent iterations of the patch series are labelled "[PATCH v2]", "[PATCH
> +  v3]", etc. and sent with a new cover letter, itself a reply to the cover
> +  letter of the previous iteration (more on that below).
> +
> +At this point the tutorial diverges, in order to demonstrate two
>  different methods of formatting your patchset and getting it reviewed.
>

In case of single-patch series submissions, the anatomy is simple: first
the email subject is commit message title prefixed with "[PATCH]" or
"[PATCH v_n_]" (in case of n-th iteration), then commit message and the
actual diff.

Regarding n-th iteration series, sometimes it is desirable to break the
threading so that the original thread (of previous iterations) doesn't
get too long, by sending the series as completely new thread. Some
contributors (including myself) prefer that way. In that case, the link
to previous iteration is provided to aid reviewers.

-- 
An old man doll... just what I always wanted! - Clara
