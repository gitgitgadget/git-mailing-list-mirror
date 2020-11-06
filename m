Return-Path: <SRS0=eTRQ=EM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAE66C388F7
	for <git@archiver.kernel.org>; Fri,  6 Nov 2020 00:51:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5BB9F20759
	for <git@archiver.kernel.org>; Fri,  6 Nov 2020 00:51:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VatjM3dp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732415AbgKFAvO (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Nov 2020 19:51:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729784AbgKFAvO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Nov 2020 19:51:14 -0500
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B4E2C0613CF
        for <git@vger.kernel.org>; Thu,  5 Nov 2020 16:51:14 -0800 (PST)
Received: by mail-pl1-x641.google.com with SMTP id p4so1631614plr.1
        for <git@vger.kernel.org>; Thu, 05 Nov 2020 16:51:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9abuu28L4NMfgCPV6H9FFu3pPzhx/U9bat6GfnV0L08=;
        b=VatjM3dpVFWFCsfjyiAz94cbWe0QTxapeuR7OxDmH4P6ejalBqER/k9dOpKKHlUPXs
         oMz86ndNIlnVe32tJ7vmqaexYvrONbZ2DYNUwmhgaCWf5mcDywehrhdRhgemKkETT9yC
         1FW+d6ucI8emguGItOWUh/h4twcT9uhlx2AQcLHqwZlr3NCFX6CBrn5grbF1gvLS+B3o
         KXPI6Qxtm7jOXMB/HsWhNWO/zS6N1pRcxxhenrFTtrU8VtU/JQHDuJo14++Jd+yzRiAi
         tcz2toW4oMiHwcrPgHe7+IZzZAumN1SjHnWSi5op6d8eSLPbt5MT+xsNTVkggvZtLZuc
         +/cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9abuu28L4NMfgCPV6H9FFu3pPzhx/U9bat6GfnV0L08=;
        b=T/AwMZUnOaAuHAKm3TZvKgfDOxPlPl8S5k0c+/tz8jgqP5CS/Rdm+v5KxrcZBL+jk0
         rAKpR4WTed85FOO/XgfItYh2sGAlVyo3+4YErTE4g6HWOMoc8xcQt/VurQI8p653RiKB
         VscTLwiu0cLHQaVAosItbTR/w3wOGPaUDBoLcEN95cp4HLaOmv5BKtgEgjiPrLAV9k0I
         LFYVK5TcRXmiVh2dnPEb/J+Y9fLo8g5dYUWO01k/eeCJ6/PhwDj8ZMexKEMnI571c+2T
         s+K46rRdxAneEEpod+bxNlUDrsNpXw2yjNQPzIuvBdkYE2PIt7VP8Zn4B58875n120f4
         ma6w==
X-Gm-Message-State: AOAM530cd42rnJ9oUAFAYpeuz6LHQQOa9k5jgrDQkKZS4rTMrkGVsEAy
        HzfutXVAyTs2VTtY2/wOkZE1IXtWfTY=
X-Google-Smtp-Source: ABdhPJwLWLDxvNJ+ey531tYbd+dTg/LbIArED/924xAFU7TRnx/tIlqWaQFFvHpBxYYvfFdpDs930w==
X-Received: by 2002:a17:902:bc47:b029:d6:d98a:1a68 with SMTP id t7-20020a170902bc47b02900d6d98a1a68mr4395941plz.63.1604623873535;
        Thu, 05 Nov 2020 16:51:13 -0800 (PST)
Received: from google.com ([2620:15c:2ce:200:a28c:fdff:fee1:cedb])
        by smtp.gmail.com with ESMTPSA id x19sm3317192pjk.25.2020.11.05.16.51.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 16:51:12 -0800 (PST)
Date:   Thu, 5 Nov 2020 16:51:10 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] rev-parse: add option for absolute or relative path
 formatting
Message-ID: <20201106005110.GA3479573@google.com>
References: <20200908185017.2005159-1-sandals@crustytoothpaste.net>
 <20201104221659.GA3183353@google.com>
 <20201105031153.GA1332931@camp.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201105031153.GA1332931@camp.crustytoothpaste.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

brian m. carlson wrote:
> On 2020-11-04 at 22:16:59, Jonathan Nieder wrote:
> > brian m. carlson wrote:

>>> This impetus for this patch is Git LFS, which is written in Go.  Go
>>> lacks a cross-platform way to canonicalize paths in the same way that
>>> Git does, so when Git produces relative paths, such as in some cases
>>> with --git-common-dir, we end up with problems when users are doing
>>> things with unusual paths on Windows, such as when using SUBST
[...]
>> Can you describe the user-facing symptom?  While reviewing
>> https://lore.kernel.org/git/20201009191511.267461-1-sandals@crustytoothpaste.net/
>> I'm trying to understand the motivation and I'm getting stuck at
>> trying to understand the basics of the problem being solved.
[...]
> The goal is to resolve paths the way Git does and allow verify that a
> path is within the repository.

Ah, thank you.  So if I am understanding the above and [1] correctly,
this means:

- when a path is within a repository, converting it to a path relative
  to the repository root

- when a path is not within a repository, learning so

and that making relative paths with ../../ portion that exits the
repository is *not* an important part of this use case (though it
could be useful for other things).

[...]
> This is also generally applicable for scripting, where realpath(1) is
> not always available (e.g., on macOS), but mostly this is here to make
> Windows work more nicely, since it has more complex path functionality.

Thanks much.  I think this tells me enough to understand the series.

Sincerely,
Jonathan

[1] https://github.com/git-lfs/git-lfs/issues/4012 --- thanks to Emily
for the pointer in [2].
[2] https://lore.kernel.org/git/20201104230157.GH2774782@google.com/
