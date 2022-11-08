Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C07BC433FE
	for <git@archiver.kernel.org>; Tue,  8 Nov 2022 21:43:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbiKHVnu (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Nov 2022 16:43:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbiKHVnt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Nov 2022 16:43:49 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F624DEAA
        for <git@vger.kernel.org>; Tue,  8 Nov 2022 13:43:48 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-37010fefe48so146901547b3.19
        for <git@vger.kernel.org>; Tue, 08 Nov 2022 13:43:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Ph02t4qiYFUA5lcka6J33/L2hIUqQEbe0oyletFQ1To=;
        b=fxGMF3x55v5yjc/JmhSxi08gQ0CCoNv4JN227tjc7Vd7+MexnQd7lFlEmmnfM3i8KT
         frsIm59mMRVN5RcDfZWYcDmGf3J9w+Qqmz29jSymY/il8O3ZyjsZBkhpOUrYkgp/06iE
         4h8xkRQwBAPowVaQTU7Pnl991B35rwVPoz5eCot2gr2TgfQssYIK/cUaf4IvuC8emGXO
         dpuE4Ql9fRCTWxHSyfK8qtPrRc0EbMNG0iqzR1NpsGQQ+SV+po0VBFL+4pEj/TcYRZZ7
         Ttz8bc1KxXqMonlygk/fXn4Fl5hq+dJWljJmB2UbHhZXQN/M8fo7NKSC/De+BWpOPjL+
         wO4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ph02t4qiYFUA5lcka6J33/L2hIUqQEbe0oyletFQ1To=;
        b=OjCY+LV+tnfvOyK1r4stlQqDLUMyOTwPyGKzcHLFip8VyCA1JNg0SuKWrb4ye/FlJB
         wpbyI7ZlUVTk7l/aUue8RrP/Lhko9xsL0xbchpjnX01Wym+yDG9dZ6SwFJSUrG+Z4sCe
         7wuN/Gi4M6zn+A1py1szej1w5sZi4ZWx7938KGK+vEWiJfAuLUizPFGb9JNUK9gcIT9R
         OuW6YJouXfuGMJNzUShAlu1v93PdBeVwdHeuKW8ESn/JhHLvHz2EMW1K0rqbs10tYD7x
         o1uRHl49lVDn23ZSjRL1VzdOaiHkHfTM693EaUGWHkAUjxgzoxngsWoqcyzLUOnvTIPg
         fE2A==
X-Gm-Message-State: ACrzQf0WgmQAVCPvYWen6Rqsr+l5AHEUaQbVGHJllUqCiRefhz6UpiBH
        pX6GFoLV0gW5x3dHIuhEnFwnKe6O7jG7JDOtcm5D
X-Google-Smtp-Source: AMsMyM7g6Lb4NN1+BMyOt0037rLLid+svA3iiHr1COLQPMaEIJumjmxMZpiNN/EnIiojM9A9GRglGIPuus3NA1kz83uP
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a81:50d:0:b0:36a:6711:f7dc with SMTP
 id 13-20020a81050d000000b0036a6711f7dcmr54320749ywf.276.1667943827720; Tue,
 08 Nov 2022 13:43:47 -0800 (PST)
Date:   Tue,  8 Nov 2022 13:43:43 -0800
In-Reply-To: <Y2mjTGvBUYpIicFl@nand.local>
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
Message-ID: <20221108214344.272053-1-jonathantanmy@google.com>
Subject: Re: [PATCH] submodule: explicitly specify on-demand upon push
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:
> On Mon, Nov 07, 2022 at 04:25:52PM -0800, Jonathan Tan wrote:
> > This now means that any push.recurseSubmodules configuration in any
> > submodule is no longer respected: only the configuration (or CLI
> > argument to override it) of the superproject is used. Update the
> > documentation accordingly.
> 
> Hmm. Is that a desired outcome or an unfortunate side-effect of the
> implementation below?

What started this effort was investigating whether push.recurseSubmodules
could be set to "only", since that is something that would be useful at
$DAYJOB. It turns out that push.recurseSubmodules is not documented to
take "only", but it is supported, with the caveat that if a repository has
push.recurseSubmodules=only, you cannot recursively push in its superproject
because there is a check that submodules have been pushed, and with this
setting, that submodule is not pushed (since only nested submodules are
pushed).

In addition, there is the usage of the word "recursively" when describing
"--recurse-submodules=only"...

  If only is used all submodules will be recursively pushed while the
  superproject is left unpushed.

...even though this is not true with the default configuration. (Having said
that, there is no "recursively" with --recurse-submodules=on-demand, so maybe
it is the non-recursive meaning that is intended.)

So all this led me to think that it's best if only the top-level configuration
is used, but I'm open to other ideas.

> Not having thought about this a lot, the behavior I might expect is
> something along the lines of recursively pushing throughout the
> submodule tree, stopping the recursion as soon as we get to a nested
> submodule which says "don't push any of my children".
> 
> On the other hand, I could sympathize with a compelling argument that
> the superproject alone should be in charge of determining what gets
> pushed.
> 
> Though TBH, it seems like the former is more convincing. If I depend on
> an external repository through a submodule, and that repository itself
> has submodules, it would be nice to configure (once) that I don't want
> to even try and push any of that repository's children.

I just tried this and the behavior is reasonable except possibly for when
push.recurseSubmodules=only is configured in a top-level submodule. Let's see
if other people have something to say. For me, this would also be fine since we
can just make sure that we don't configure "only" in top-level submodules that
have their own nested submodules.
