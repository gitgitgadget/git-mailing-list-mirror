Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DF1DC47E4B
	for <git@archiver.kernel.org>; Thu, 15 Jul 2021 14:36:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 763E8613C3
	for <git@archiver.kernel.org>; Thu, 15 Jul 2021 14:36:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236484AbhGOOjt (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Jul 2021 10:39:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236342AbhGOOjs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Jul 2021 10:39:48 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB015C06175F
        for <git@vger.kernel.org>; Thu, 15 Jul 2021 07:36:54 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id d9so6699545ioo.2
        for <git@vger.kernel.org>; Thu, 15 Jul 2021 07:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=axZRJXFOZpPgdyk4DJ5QgZ44YblkynWOCF5Sbt0yYLQ=;
        b=CBmSvitJkC7MmTspYjiVaJNuFeqNh2rjiwcBoe+RShj2WsAtuDQalrJ5FcjvQPsL/t
         wNvURezHlrwC1fjMitirLbjXADjhGLcuIZoVTOzJZPFqx4+FwHPme1+n3lRYwYP6RIf1
         nVmkAlwEO99f7Lxs8SWaiMQgnzSdEUjBK6WpMHs6UY2XsggXk63GJInPWqlgF8dqhqTN
         MvbmTCoMjZ7McZkFImFTMPNwkLX3+ihSd+pUlzW/O2YYCrXn3QJAQOW3Rnh2mhI5Mk/V
         rZGSyuzh+juYSdnDycvujFJSmwjvNOFHCmK0l3xG9A2jNG94ODp6hD88bRjvyu4slco4
         iiKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=axZRJXFOZpPgdyk4DJ5QgZ44YblkynWOCF5Sbt0yYLQ=;
        b=DN+RqEzDXaqAL9BszPOg/IvPAoN89NUwmn10aJfy7MVtR7lzCGQGgm+8FrWV1dKpXY
         v+6zR7WAjZCAYElcYr3IH53GO9sQSUwamIkiEEoL0vZw4qqwuB/klwX8zcPIgwXd4I11
         psE57s/7Q2mjMww7TQ3yHyoEfg7QvDn/lzvMNBpFgBWtMn4HI9X4x+3QUeUKAtJVldL5
         i3rjf4Bh9fxJcUOjKXCIhdr1jnKVvxtDMqKeJzzHof93pOCFtjWfstd0aVmko8spljtH
         Z4Kc/eYxbCwLmX2u15rsrDOgMembcH7aQP6ipXD7uolMMb69p62FSltc53/YkHr12xB1
         HOfg==
X-Gm-Message-State: AOAM532k144giScRabQ7lLinHtS0onCQnVfreuzaniWg7Pr1Jj9ZDRlE
        HGHUScSnojLjEt22q9qs32ROzA==
X-Google-Smtp-Source: ABdhPJx6nPIWWxBtC9O87neS9qpvzf0Xv2i31/SJqeY34Nozwve9hy+5v93rgf/aIE5zoSdNml3eIw==
X-Received: by 2002:a05:6602:17ce:: with SMTP id z14mr3376189iox.73.1626359814250;
        Thu, 15 Jul 2021 07:36:54 -0700 (PDT)
Received: from localhost ([2600:1700:d843:8f:d40c:332:312b:8a8c])
        by smtp.gmail.com with ESMTPSA id v18sm3077514iln.49.2021.07.15.07.36.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jul 2021 07:36:53 -0700 (PDT)
Date:   Thu, 15 Jul 2021 10:36:53 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net, dstolee@microsoft.com,
        gitster@pobox.com, jonathantanmy@google.com
Subject: Re: [PATCH v2 00/24] multi-pack reachability bitmaps
Message-ID: <YPBIBXUB53b0Hixx@nand.local>
References: <cover.1617991824.git.me@ttaylorr.com>
 <cover.1624314293.git.me@ttaylorr.com>
 <87lf6yxqeh.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87lf6yxqeh.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 25, 2021 at 11:06:21AM +0200, Ævar Arnfjörð Bjarmason wrote:
>
> On Mon, Jun 21 2021, Taylor Blau wrote:
>
> > Thanks in advance for your review, and sorry for the wait.
>
> Thanks for working on this, exciting feature!
>
> Just a note on my comments on this. I left them after some light reading
> and would describe them as some combination of "musings", "shallow",
> "nit-y" and "bikesheddy".

Thanks for your review. It did help me catch some important issues, like
referring to ctx->m.pack_names[i] when a read at "i" may have been
invalid.

> I.e. I did not have time (or I feel, the familiarity) to give this
> series the sort of review it actually deserves as far as the actual
> important bits go, i.e. nits aside whether this feature works and
> behaves as desired. Sorry, but hopefully at least some of comments were
> somewhat useful anyway.

They were useful indeed. I'll sit on the changes locally since most of
them are pretty benign and I think subsequent review could be done on
top of v2 without seeing my local changes.

I know that reviewing this is on Peff's list of things to do, but there
are competing priorities (and we have all-company meetings this week, so
I would not be surprised to see a lack of movement until at least next
week).

Thanks,
Taylor
