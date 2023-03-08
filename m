Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CEE3C678D5
	for <git@archiver.kernel.org>; Wed,  8 Mar 2023 23:09:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbjCHXI7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Mar 2023 18:08:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbjCHXI6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Mar 2023 18:08:58 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86F34618A5
        for <git@vger.kernel.org>; Wed,  8 Mar 2023 15:08:57 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id y2so408152pjg.3
        for <git@vger.kernel.org>; Wed, 08 Mar 2023 15:08:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678316937;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z/sdQ/tEA+SPoc6hP8QJkVJmd3N+l/ZsjdS7thSfa0Y=;
        b=hpTZhtw9+dTWVJVFSeEdOr+2cS/jFChhcVKsE7jOedOdpeqK2YObW6NC/UbZ547w0T
         XqKD919yITClEZrENGCTPlvlemNPfR4yq4JZqtcHU/5xG6DTKetZv5VV/IWLFOAGQBNH
         ipVWtkSQ1WF8viEtbMYB3wFxTcS9LcpMexrMXsRUTZG1oSVNdCWYc/RPdADVzhffrtsc
         U/qU+kAGPMFnpcQNalP6PmDtgo0WyKODbMn5EEr1FrqiWjFUMDpJPcCUJCtGRvwisxxj
         u9b3eIzKaXxIpzNG0DofdVcKAAnsAHGkXb21ojDYsbq6OfSU7GlXGyWn2uOj3/OS4iFt
         cQEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678316937;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Z/sdQ/tEA+SPoc6hP8QJkVJmd3N+l/ZsjdS7thSfa0Y=;
        b=Gd/NFkL3Ji+E8zUFONKMQOF5oNjo/GlaIQbou+nij0amXwzT9S8Nzou2Pzp6XBLC7I
         MzynnLXtTVwGUdB3pmt0+YDuTTHVRdgRuMdtkPokgLqYlK5Q7nXtFD2rvMyQaUS+e1hs
         WgcWpueI23J2dbrmNZ3jEcB+Lu7V/t5GI4tITBcdwkT5XtbM5fZRnm5kpKcvXZcqgC45
         YNx2ENj5jo+xGRr0/4znH309/adc6tYU2ARu2vr3wK0ju+xKTi+fY/OwMhD/xixtqC6X
         tXomUhKxKQG9C8hmQRp8DrL0/ztE4YmQ0lZFJT/jqiz+H/FZ9Cg5C84dBwG7IpouXFlQ
         W6gw==
X-Gm-Message-State: AO0yUKUj4KS5iASoUptLVpYV/2cbilhkTI3MhSKIGfeHpl9UHPnHy6VQ
        nM/d5UK93MgQrGL5asE9PPE=
X-Google-Smtp-Source: AK7set/MHOZYekAZd5ZV7YWe5gsJzYSVnc4TM2HmOdkPR3U48i9jymw7kMEr+AX2u4IyNdpvnLFfPw==
X-Received: by 2002:a17:903:2349:b0:19b:fed:2258 with SMTP id c9-20020a170903234900b0019b0fed2258mr23190841plh.41.1678316936898;
        Wed, 08 Mar 2023 15:08:56 -0800 (PST)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id lh15-20020a170903290f00b0019aa5528a5csm10285184plb.144.2023.03.08.15.08.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 15:08:55 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Sergey Organov <sorganov@gmail.com>
Cc:     Glen Choo <chooglen@google.com>, git@vger.kernel.org
Subject: Re: so/diff-merges-more (was Re: What's cooking in git.git (Feb
 2023, #01; Thu, 2))
References: <xmqqr0v7o0pp.fsf@gitster.g> <871qn5pyez.fsf@osv.gnss.ru>
        <kl6lr0v2i0gn.fsf@chooglen-macbookpro.roam.corp.google.com>
        <87wn4tej2f.fsf@osv.gnss.ru>
        <kl6lh6v43s4g.fsf@chooglen-macbookpro.roam.corp.google.com>
        <xmqqr0u7ku3j.fsf@gitster.g> <87wn3zqefx.fsf@osv.gnss.ru>
        <kl6lzg8pcygl.fsf@chooglen-macbookpro.roam.corp.google.com>
        <878rg8j2vg.fsf@osv.gnss.ru> <xmqqzg8ozbuh.fsf@gitster.g>
        <87jzzqzy20.fsf@osv.gnss.ru>
Date:   Wed, 08 Mar 2023 15:08:55 -0800
In-Reply-To: <87jzzqzy20.fsf@osv.gnss.ru> (Sergey Organov's message of "Thu,
        09 Mar 2023 01:19:03 +0300")
Message-ID: <xmqqzg8mrgc8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sergey Organov <sorganov@gmail.com> writes:

> My point is that the story with -c, or --cc is roughly the same, and
> that you yourself fixed --cc once upon a time to imply -p, so it's
> especially confusing for me that you are now in opposition to similar
> change to "-m".

I think we all saw a good explanation for that already in the
thread.

The mistake by "--cc" was fixed relatively quickly, but it is now
way too late to change the behaviour of "-m" without hurting
existing users.  I think I've wasted enough time on this in this
thread already, so let's stop comparing --cc and -m now.

Thanks.
