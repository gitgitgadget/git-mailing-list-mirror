Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBE9EC433E0
	for <git@archiver.kernel.org>; Fri, 22 Jan 2021 21:41:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE49623B09
	for <git@archiver.kernel.org>; Fri, 22 Jan 2021 21:41:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729224AbhAVVkv (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Jan 2021 16:40:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729342AbhAVVkh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Jan 2021 16:40:37 -0500
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF6AAC06174A
        for <git@vger.kernel.org>; Fri, 22 Jan 2021 13:39:57 -0800 (PST)
Received: by mail-qt1-x82f.google.com with SMTP id c1so5311760qtc.1
        for <git@vger.kernel.org>; Fri, 22 Jan 2021 13:39:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=aGwzMjMtTkhkD7eZ51ZSVcOhBhKErxBIHTicOGrQiTc=;
        b=H5nufc2DQ2V9CHQ/d5Cw7WxgcyMbWLrBLOxi5yrhqX6evrYmnlqygzBXIkbnA6gZDw
         lBg0q9Mq2kCjm6ghwfLSjNUUjYE003zOZ1OSXd5XO0Pt3CwNc1zIRTac/XBy8TMt3tnu
         JdhMr/47ajZHUfLr4ppXK1ZlBiyL/PRI+LFAo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=aGwzMjMtTkhkD7eZ51ZSVcOhBhKErxBIHTicOGrQiTc=;
        b=g1iB/4Cvi4XKBKMeXnvQCt1tMkMk1+z+C7wRi/SpBf7s1f5Y62nAGltBmjkrllGesx
         iH8Ojs9ji3bqef5mhCjHtvlN09XW4Hwh5DPZI/q+A6kFGonphb1f+hPEb2brvVjgIBSV
         9CJCQ0OHUFwieg+F8rsVn6BbXIC7glxj8YpjYIFuKfpBEoiMUuTf0IRp3sAPlDfcT65x
         faJGy9tbOjYdSYaoenhOC2RJSvaClDIsJMk2VUI7dFcSWWVIVymklCTn3GAB1l7HNiC+
         +Aukv4bwlzW9Pyru3EzWyLmhekKu5RffDEtjOCR17tTyE0vg1g4YQ0Ttn9BkIcNLz4+I
         dycQ==
X-Gm-Message-State: AOAM53320onerqnJ9yaq8gfMaBnkHvHCm9ixjLpWKY82KAIPkuCfPxuH
        bZSano9y/C9Bx/y3QyeasZAt+A==
X-Google-Smtp-Source: ABdhPJzVvr93ZQ8QAR7Lgy8cNFIhk7s+R/+3kTnEa3FLJb7h586E9YFFZYOps5M7+alXCrR05oICZg==
X-Received: by 2002:ac8:59d6:: with SMTP id f22mr664323qtf.230.1611351596868;
        Fri, 22 Jan 2021 13:39:56 -0800 (PST)
Received: from chatter.i7.local ([89.36.78.230])
        by smtp.gmail.com with ESMTPSA id x15sm2203255qtr.72.2021.01.22.13.39.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jan 2021 13:39:56 -0800 (PST)
Date:   Fri, 22 Jan 2021 16:39:54 -0500
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Jason Pyeron <jpyeron@pdinc.us>, git@vger.kernel.org
Subject: Re: git archive setting user and group
Message-ID: <20210122213954.7dlnnpngjoay3oia@chatter.i7.local>
Mail-Followup-To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        Jason Pyeron <jpyeron@pdinc.us>, git@vger.kernel.org
References: <043f01d6f0fe$d6ad7660$84086320$@pdinc.us>
 <cef51cd3-c6b5-ed24-f695-83be3a6743b4@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cef51cd3-c6b5-ed24-f695-83be3a6743b4@web.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 22, 2021 at 10:00:04PM +0100, René Scharfe wrote:
> Adding support for using a custom user and group should be easy.  Is
> this just a cosmetic thing?  Regular users would ignore the user info in
> the archive, and root should not be used for extracting, and on systems
> that don't have a logwatch user this wouldn't make a difference anyway,
> right?

Right now, "git archive" operations are bit-for-bit identical across all
versions going back at least 8+ years. In fact, we've been relying on this to
support bundling tarball signatures with git tags themselves (via git notes).
E.g. you can see this in action here:
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tag/?h=v5.10.9

If you click on "(sig)", you will download a signature that can be used to
verify the tarball generated using "git archive".

I would argue that adding user/group support to "git archive" operation is
not really solving any problems other than "it's different from when I run it
as a regular user" -- and can introduce potential compatibility problems if
implemented.

So, I would selfishly vote not to implement this.

-K
