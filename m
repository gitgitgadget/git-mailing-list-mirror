Return-Path: <SRS0=3/hf=DT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AAE8C433DF
	for <git@archiver.kernel.org>; Mon, 12 Oct 2020 21:31:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C272C2080D
	for <git@archiver.kernel.org>; Mon, 12 Oct 2020 21:31:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1602538271;
	bh=So+fPIertv9Hck4AKuRd6NltKpXM/ZJJ8wHsy7VyKnU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=vjYNwhLaZPTa5Y197IrOj+FuzOftbB9oYodfxaQLw4YwnPkhl1IWowbPuWyR2NqwP
	 XBVWqhp3clommEBDNGbV8g9WE5kx/ilpLxJBkbd2zKtKkOzafy+lHbd9HKdEo+rtMb
	 BkEnJd+tEMcGkMxAyW+sMOgOk8x9S0+TNnkbLiiE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730144AbgJLVbK (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Oct 2020 17:31:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730048AbgJLVbK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Oct 2020 17:31:10 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E509C0613D0
        for <git@vger.kernel.org>; Mon, 12 Oct 2020 14:31:10 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id 140so17290039qko.2
        for <git@vger.kernel.org>; Mon, 12 Oct 2020 14:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=EBdDQyi9IsJoIooQLaEPMA2N/jh3A+rsCdnYCY+C/fI=;
        b=UmyH7hHr9YvScgL0dlgXni6Y8lf4do4Zl8g1wKuPkVfM1IEyOdLWijzLuMBpBdjSME
         O7JfXTHKMOVFpXHkawQIE9Am5c3O259345XabWA0o05c3V/1tuUUMdOhfZj8iiIxCRWQ
         vozfmWMkS8nza5cop6vv0Lu17ToZFzgfPTaMc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=EBdDQyi9IsJoIooQLaEPMA2N/jh3A+rsCdnYCY+C/fI=;
        b=aUBXXWB+OgLtO2GHNpKNP/UT/tXLKMF/6v+DxHwky2PaZOwd1Q6KKu1j/j36bHcW/S
         nm+LUA4pLQOqOHAeUPbCvfyNWasuhfclxJ7SFxZNjk3DoKeqAGd+bHiuJ5sK3mvxoTeY
         2xLnUG5k3DwABrm1MIHpAuMuefgRNLlUuwKNzffq0MBpEcanWbf279txYvHxrceTlaQl
         PbBgpGqucbsT+eEZLsbS2c3Z6i3KCxU455yGC/lRAUBshiDbBh19fYscfAUTZyq9H6gh
         WlGRU5eWKiDn/oh4f3lDn3Jx7M/QL2bO7+4zgk7zWSuONHQodgOEufQ4jDfBIiGMGg+7
         CKsQ==
X-Gm-Message-State: AOAM532wPu/f9nTPHdSY82Ub98HoeDHg7YAv9KC5PFM5b6VDYqZulR6f
        zJy8n8RvP2rjKa1pc4Jlg72xNQ==
X-Google-Smtp-Source: ABdhPJwYgoO88dA/RSkU1mAlkCOLMTjo/X+7cLIAi4Yp52uCn6QdhS0i2Xhv2e0OtUwyOAsHOStFmA==
X-Received: by 2002:a37:478e:: with SMTP id u136mr12019569qka.93.1602538269629;
        Mon, 12 Oct 2020 14:31:09 -0700 (PDT)
Received: from chatter.i7.local ([89.36.78.230])
        by smtp.gmail.com with ESMTPSA id a200sm13327743qkb.66.2020.10.12.14.31.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2020 14:31:09 -0700 (PDT)
Date:   Mon, 12 Oct 2020 17:31:07 -0400
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     gitster@pobox.com, git@vger.kernel.org
Subject: Re: Patchwork now does the right thing with GGG submissions
Message-ID: <20201012213107.ad3j2wetrfs62pvp@chatter.i7.local>
Mail-Followup-To: Jonathan Nieder <jrnieder@gmail.com>, gitster@pobox.com,
        git@vger.kernel.org
References: <20201012180034.tu4rmeoadhy5j4w7@chatter.i7.local>
 <20201012193850.GE3740546@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201012193850.GE3740546@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 12, 2020 at 12:38:50PM -0700, Jonathan Nieder wrote:
> > Just FYI, I made the necessary tweaks to patchwork to make it 
> > properly
> > assign "From" for gitgitgadget submissions:
> >
> > https://patchwork.kernel.org/patch/11832689/
> 
> \o/ Thanks much for this.
> 
> For the curious, any links to the change behind the scenes that made
> that happens?  Does it use Sender[1] or a different field?  Does the
> change live in [2] or [3]?

See my other email explaining how it's implemented. As to where it lives 
-- it's implemented as a procmail rule:

:0
* ^From: .*<gitgitgadget@gmail\.com>
{
    :0 bw
    INBODYFROM=| formail -xfrom:

    :0 hfw
    * INBODYFROM ?? .
    | formail -I "From:$INBODYFROM"
}

Currently, we fully blow away the From:, but after the 2.2.2 upgrade 
we'll be setting it as X-Original-From if we don't find one already 
present.

It's my goal to start publishing these procmail rules as part of a git 
repo in the future, so you'll be able to see all rules that are applied 
to incoming mail before we pass it along for patchwork processing.

Best regards,
-K
