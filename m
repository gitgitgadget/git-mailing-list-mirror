Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D162C433F5
	for <git@archiver.kernel.org>; Sat, 30 Oct 2021 20:39:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2ECBB60EFF
	for <git@archiver.kernel.org>; Sat, 30 Oct 2021 20:39:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231154AbhJ3Ulw (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 30 Oct 2021 16:41:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbhJ3Ulv (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Oct 2021 16:41:51 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06ECFC061570
        for <git@vger.kernel.org>; Sat, 30 Oct 2021 13:39:20 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id s13so14946632wrb.3
        for <git@vger.kernel.org>; Sat, 30 Oct 2021 13:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=p4CfEaR6rYOn3oFAx12kYcIxWmf+oQ1GmNZLUC3rkfs=;
        b=cspUPqYt5Y0q0KBJBzEjkOMHy1/aItgTzCygM9snHIqd+u8hevHLsiNZLkygqWTLGj
         BoSkVcLr+Yk5ZILkoqhSFeqxm6UXPO6wDg4Qw4uiSM8/5iQ8X6GDt+LkGgC0GuAPRC0c
         pL+Q4IK5FOYIKEU6/vG/VL9VbJytz+ryfV+0Jh+0idFZSQ5AGLh5O80z4qaHAicQdpv0
         j54mwhAthB7bZhQsOPDFN+VxBQQB4KGR/3I5INmmbKN3IcEH/xU+s6l7J+U6ODWj79E+
         W+4zGoRpwqQsdVNggVi1xA3u5PkySpXMuR5HBHC16o2rqqbf1p+az7keDvj1tMxLyKPH
         d1vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=p4CfEaR6rYOn3oFAx12kYcIxWmf+oQ1GmNZLUC3rkfs=;
        b=Qca44vrOaMxKAGxlGjxmeFaqM/YkN1L4CvcbCXgVvu71/Saap5rWvSRVcbD2+tnBJR
         vdS72kBTNAeL8/neX8hGHkOfHATBOmb+AcQaeEC3DHN2KcaHRVY7nkNXlE5Da9zFf3WB
         yWv2JpJVYU6Sxqn9VVfJRKntSulZbIdgAwbm4TmlZkDpgicdo0o1IeuZRbg24Qe7L08w
         /oezv2X0LdrgtMgxRGpEK1+cxsaUO8Qv25ZNtdkIyydpsdp6sqlK3sjAzmVLlBdLF6df
         xRwF/3eIpljccf21sydJX0T9i5LLHYe6Hro5wcKdqEiTxwaRMFw6gHOYCXMZX30Qsx30
         wsKw==
X-Gm-Message-State: AOAM532l/a2aS9xpF/aY53R3BdX1+dN9vsZ5rjYacknvzjtnKJreUWxV
        fcgSRst/AFP98prMiOM7RbWkxW9KQL0=
X-Google-Smtp-Source: ABdhPJyJaj6IimUlKF9RrOE8iZmP9SNpxszf6/aKCHkWP6G5jx3lXcCaXizwKA2oVWcVuo0uCBm3oQ==
X-Received: by 2002:a05:6000:248:: with SMTP id m8mr3746953wrz.404.1635626359521;
        Sat, 30 Oct 2021 13:39:19 -0700 (PDT)
Received: from gmail.com (62-47-13-59.adsl.highway.telekom.at. [62.47.13.59])
        by smtp.gmail.com with ESMTPSA id r27sm9246006wrr.70.2021.10.30.13.39.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Oct 2021 13:39:19 -0700 (PDT)
Date:   Sat, 30 Oct 2021 22:39:16 +0200
From:   Johannes Altmanninger <aclopte@gmail.com>
To:     "Ryan Hodges (rhodges)" <rhodges@cisco.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Ryan Hodges <rphodges@gmail.com>
Subject: Re: git apply --intent-to-add deletes other files from the index
Message-ID: <20211030203916.zopggbajumvb4z3f@gmail.com>
References: <0DB10E05-094D-4382-AD1F-657878B06A80@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0DB10E05-094D-4382-AD1F-657878B06A80@cisco.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 26, 2021 at 03:11:36PM +0000, Ryan Hodges (rhodges) wrote:
> Hi all,
>  
> I’ve got a quick question about ‘git apply –intent-to-add’.  If I’ve got a patch that just adds one file to the tree:
>  
> [sjc-ads-2565:t.git]$ git diff
> diff --git a/c.c b/c.c
> new file mode 100644
> index 0000000..9daeafb
> --- /dev/null
> +++ b/c.c
> @@ -0,0 +1 @@
> +test
>  
> and I apply that patch with –intent-to-add:
>  
> [sjc-ads-2565:t.git]$ git apply --intent-to-add c.diff
>  
> The newly added file is tracked but other files in the tree get marked as deleted:
>  
> [sjc-ads-2565:t.git]$ git status
> On branch master
> Changes to be committed:
>   (use “git restore –staged <file>…” to unstage)
>                 deleted:    a.c

Yep, looks like a bug to me.
git apply should never change the status of files that are not mentioned in
the input patch.

>                 deleted:    b.c
>  
> Changes not staged for commit:
>   (use “git add <file>…” to update what will be committed)
>   (use “git restore <file>…” to discard changes in working directory)
>                 new file:   c.c
>  
> It looks like Git created a new index with only the newly added file in the patch.

Seems so.

> However, I’d like Git to just add one entry to the index corresponding
> to the newly added file in the patch.  Is this a bug or am I completely
> misinterpreting the goal of ‘intent-to-add’.

Yeah, I think your "git apply --intent-to-add c.diff" should behave exactly like

	echo test > c.c && git add --intent-to-add c.c
