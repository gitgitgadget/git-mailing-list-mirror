Return-Path: <SRS0=AWh0=66=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66C4AC433DF
	for <git@archiver.kernel.org>; Sat, 16 May 2020 17:35:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2242D206D8
	for <git@archiver.kernel.org>; Sat, 16 May 2020 17:35:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=spkdev.net header.i=@spkdev.net header.b="W7feru9Z";
	dkim=pass (1024-bit key) header.d=spkdev.net header.i=@spkdev.net header.b="mQ8e9YDo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726296AbgEPRfY (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 16 May 2020 13:35:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726238AbgEPRfX (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 16 May 2020 13:35:23 -0400
Received: from mail.spkdev.net (unknown [IPv6:2001:41d0:8:e379::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BB1AC061A0C
        for <git@vger.kernel.org>; Sat, 16 May 2020 10:35:22 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        by mail.spkdev.net (Postfix) with ESMTP id D971040372;
        Sat, 16 May 2020 17:35:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=spkdev.net; s=default;
        t=1589650520;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=K720SYAO3Xe53WabpeqeWyi498MC0HwTDaLUl3L8hqg=;
        b=W7feru9Zcw3We52jG6en6ouxfuE+rLzCVlMk16Abs0C6GfPFTshDMPL/F38p21yCU1mQB0
        1Z26xdG35qroeE0nu1FB2oGTVEBI7h69MbxSaLlSCnmzUj0kwu3Ju7bFM+b4uJX3BcoWaE
        1RzLecLzTixV1+alvAQx8vy1BG9KRw8=
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.spkdev.net (Postfix) with ESMTPSA id 0DB4C3FDD6;
        Sat, 16 May 2020 17:35:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=spkdev.net; s=default;
        t=1589650519;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=K720SYAO3Xe53WabpeqeWyi498MC0HwTDaLUl3L8hqg=;
        b=mQ8e9YDoP13TODdGls/UBEhWoDCWiWOp2idNByWa1exIZFxwQ4kFspXeXLBzoP8vbip9wq
        VjsZEA08yoK4YGyN5wuyp0ku26gK8gkuQCgpSfBYfIU3VpsxVOaEJsbFDRSkHW96ouywqp
        144x9Zfvr2vzcolSxPlhlgu3pUVQF5o=
Date:   Sat, 16 May 2020 19:35:18 +0200
From:   Laurent Arnoud <laurent@spkdev.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Subject: Re: [PATCH] diff: add config option relative
Message-ID: <20200516173518.GA34961@spk-laptop>
References: <20200515155706.GA1165062@spk-laptop>
 <20200515233130.GC6362@camp.crustytoothpaste.net>
 <xmqq1rnk923o.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq1rnk923o.fsf@gitster.c.googlers.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 15, 2020 at 05:04:43PM -0700, Junio C Hamano wrote:
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
> 
> > On 2020-05-15 at 15:57:06, Laurent Arnoud wrote:
> >> The `diff.relative` boolean option set to `true` to show only changes on the
> >> current directory and show relative pathnames.
> >
> > Usually when we implement configuration settings like this, we implement
> > an option value, such as --no-relative, so that users or scripting tools
> > can disable this feature if they need to.  However, I don't see that in
> > this series.  Would adding such a feature be possible?
> 
> I think I saw a variant that does have --[no-]foobar support on the
> list, but I may be hallucinating.  You definitely would want it, or
> you've broken "format-patch" forever without a knob to countermand
> the configuration (well, you can still say "git -c diff.foobar=no"
> but that's kind of cheating).

Yes I've submitted a v2 patch with the `--no-relative` I will send a v3 to this
thread for review

-- 
Laurent
