Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA187C6FD1F
	for <git@archiver.kernel.org>; Thu,  9 Mar 2023 13:56:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231313AbjCIN4P (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Mar 2023 08:56:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231236AbjCINzJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Mar 2023 08:55:09 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7137E10A8B
        for <git@vger.kernel.org>; Thu,  9 Mar 2023 05:54:44 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id i28so2431294lfv.0
        for <git@vger.kernel.org>; Thu, 09 Mar 2023 05:54:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678370082;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DCk0HvoOqpTCFsNm1mqRZrl+mAcgye+V8EF86Fjbr60=;
        b=l+gKbWmDN3iNX5IbDMSv5JtBBCmuErVcSumFbEOEQiFsAuQ0wZSioAOXthLLoII3nA
         I98f9qz14KfLRJ0JsrUH0s36b7URD+2ikhIp9yNcfaA6ofQyt4DGvtuifn4GbHQn0Cm+
         hPJZLEhMXRPzB7BeempQpk2J3BxD4Iv6AdNaQ9+H7mZtNKPbCjr9I+G4jgLczx4l5jMQ
         b0O4IHBCb1lb12990vco4PRVPjpBx+dCAgHUxJBTNEINhErRSXWGPs6lYvsyX4eAmfR6
         S7nLWLAzN6gQnyubegeYra4K7m2vEFslBdLEdcla38A3/vslR8zzfKFMvde0deSsuLXb
         5naA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678370082;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DCk0HvoOqpTCFsNm1mqRZrl+mAcgye+V8EF86Fjbr60=;
        b=QZKNnKnAAkTpp6j2zIeAVnESs94Ds3Q+XHfirmABGvwjXRQaDZrYM3JTB/ng9v8cyI
         QdEAkNHjG56UZtBKS+iKmwojAtt0In2xnXPBLy8Kpu2pgJ2X1W1W252wpjcj/yj64zRI
         ckgf0DcbcPIfeAYfc//jeWiCMh3Y0lzWdUdjVcMYsNhZysnjZrdloT96x+quAaWVh5KN
         lu6dv2GnIOrWTC4mSBPA9E1YN0UUBN9zyBSvW1JwPnBcZdhKMJxzS7mggQw2ZcsnhcaV
         2ku251OszOZLWJ7MTR0MEK1t9bJ7xkT30PiLlF6XeDDc3wF8rNjZ8EzBRYOeN1jRg9UF
         5E2A==
X-Gm-Message-State: AO0yUKU1BhqFYX4ab7xjroEOw0uIyRwN9aKFB+5GjK8eD9qccOvdOw6G
        euKNyPisxOHXShmxi/PQkqCaAUeMwuY=
X-Google-Smtp-Source: AK7set8NH/Y4uXExqgoLOcYXKWmGxcMSzxLasO0MuFy5tRTWNqmbDRMXECe3SJIwRxfZRByFJ/10MA==
X-Received: by 2002:ac2:5307:0:b0:4e7:fa9a:4d41 with SMTP id c7-20020ac25307000000b004e7fa9a4d41mr4835453lfh.14.1678370082228;
        Thu, 09 Mar 2023 05:54:42 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id r6-20020ac25a46000000b004cc9042c9cfsm2648065lfn.158.2023.03.09.05.54.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Mar 2023 05:54:41 -0800 (PST)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
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
        <87jzzqzy20.fsf@osv.gnss.ru> <xmqqzg8mrgc8.fsf@gitster.g>
Date:   Thu, 09 Mar 2023 16:54:40 +0300
In-Reply-To: <xmqqzg8mrgc8.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
        08 Mar 2023 15:08:55 -0800")
Message-ID: <874jquxc67.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Sergey Organov <sorganov@gmail.com> writes:
>
>> My point is that the story with -c, or --cc is roughly the same, and
>> that you yourself fixed --cc once upon a time to imply -p, so it's
>> especially confusing for me that you are now in opposition to similar
>> change to "-m".
>
> I think we all saw a good explanation for that already in the
> thread.
>
> The mistake by "--cc" was fixed relatively quickly, but it is now
> way too late to change the behaviour of "-m" without hurting
> existing users.  I think I've wasted enough time on this in this
> thread already, so let's stop comparing --cc and -m now.

That's fine with me.

I already agreed long ago that to be on the safe side we shouldn't
simply change -m nowadays, and addressed that concern by putting -m
behavior change under configuration option in the current series. So
what's the reason of rejection?

Thanks,
-- Sergey
