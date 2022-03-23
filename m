Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DA4DC433F5
	for <git@archiver.kernel.org>; Wed, 23 Mar 2022 21:47:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345013AbiCWVtE (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Mar 2022 17:49:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232814AbiCWVtD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Mar 2022 17:49:03 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E49AF8E18A
        for <git@vger.kernel.org>; Wed, 23 Mar 2022 14:47:32 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id r1so2313236qvr.12
        for <git@vger.kernel.org>; Wed, 23 Mar 2022 14:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DTRnSY3BD6IVIuaVhYnF901tXn1UevSFhWNZJTTjTk8=;
        b=xECw82U46mInZBZXLG7IVMUL/gSvHcI0NHODk9ulUuQW4kzqW20vKYJKZlICkvUeNf
         DoD3xLke50nlOlHbipw5uIS9kZ/wewkjE4n9zEymlG+cCN9MpknLdKxw50uO5RCdJ4du
         WHl2GLWfBradDc/YgCXX/kCPvRmOqw5uzXkB6NwxnPjqJsRRsq/1iqpkEGevqqtnGpED
         y9YbF94re5Mvv3kwyNNJDlWM6877bM8UG/J45CjU/UuCHGeBveLQ7AckVume2Y35vJ3K
         Iz33oglHpVENh1UdVsnKuLiJcv3Q7BZ0MkM0zXViTbakFhPYl/r4T7jO6dJ0Y31F1LCv
         tPuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DTRnSY3BD6IVIuaVhYnF901tXn1UevSFhWNZJTTjTk8=;
        b=g777EkpOb8ljTxVME3u8euMJro2mJH554VL4c4JaOwbGmY2+khT+rXi1fC3OLPZm0D
         Cpz4mD4uPWyjv7pX0VH9VnQVvz+wExF3tfH3FIFxXXqmDZ1g9nPrObtLAnyrzA+0lns4
         k3fhnrdp36JvH1HN5hZ8/QKS5AorGujsiyKIShOZlb/vIo222EO6MfDWdFKg1I0kSyk8
         uh2JcuWoNEVp+jF/hUq3Mq75X+LHIEu9KX5eQ2oYdhhvg6MlCsyWexDtvKn9diQ6VybX
         SWganEgtVcL8lBdcjIVbH6gvJ3lGyoQbMRK/aHuCoeqvQ4+QpvROHeP/GE7bjJrF5QTZ
         LwCg==
X-Gm-Message-State: AOAM530n460Sl+s3v/F9BDPp+wRI5ZQl4US5rfY8Pj3Dy4cSZUuwGzjg
        3mo3VT+L6+8O9RD4a1rXMnhBgg==
X-Google-Smtp-Source: ABdhPJwV09b+C1NN7Ve7b3QgdEVLTLr/tt7wtu+6z+5VKYYTPIhjP/zlRj+qikHPWVZKHsy0JPmtbA==
X-Received: by 2002:a0c:f642:0:b0:41b:9c7b:864 with SMTP id s2-20020a0cf642000000b0041b9c7b0864mr1817561qvm.51.1648072052041;
        Wed, 23 Mar 2022 14:47:32 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id b2-20020ac87fc2000000b002e1b9ddb629sm797623qtk.47.2022.03.23.14.47.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Mar 2022 14:47:31 -0700 (PDT)
Date:   Wed, 23 Mar 2022 17:47:30 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Mar 2022, #04; Thu, 17)
Message-ID: <YjuVcqVQyv2RZBtP@nand.local>
References: <xmqqv8wcizi4.fsf@gitster.g>
 <YjkloVk0BTqcgIiL@nand.local>
 <xmqqo81wsewt.fsf@gitster.g>
 <Yjty9DhYLDfz5Oay@nand.local>
 <xmqqczicqrio.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqczicqrio.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 23, 2022 at 02:37:51PM -0700, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> > On Wed, Mar 23, 2022 at 11:27:14AM -0700, Junio C Hamano wrote:
> >> I think <Yjpxd8qhwnAIJJma@nand.local> yesterday is the last message
> >> in that thread?
> >>
> >> Let's see how well it goes.
> >
> > Yeah, that is the last message in the thread (at least, at the time of
> > writing this message).
> >
> > Jonathan had a few suggestions of things that we could add to
> > Documentation/cruft-packs.txt. I added details in my reply where they
> > were unclear, but I'll focus on touching up the new documentation in a
> > follow-up set of patches to avoid delaying things further.
>
> If we cannot come up with a clear description, isn't it a sign that
> our thinking is still not clear and merging things in haste would
> produce a suboptimal waste?  If that is not the case, I'd be happy
> to merge it down.

I definitely don't want to rush anything; I was noting that a lot of the
questions Jonathan had have been discussed earlier and throughout that
thread.

So I don't think that what you said is the case, but please let me know
if you feel otherwise and I'd be happy to spend some more time polishing
the language in Documentation/cruft-packs.txt.

Thanks,
Taylor
