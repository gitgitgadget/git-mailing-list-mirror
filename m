Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8B8FE1F404
	for <e@80x24.org>; Wed, 24 Jan 2018 18:02:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964971AbeAXSCe (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Jan 2018 13:02:34 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:46430 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964826AbeAXSCd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Jan 2018 13:02:33 -0500
Received: by mail-pg0-f66.google.com with SMTP id s9so3221846pgq.13
        for <git@vger.kernel.org>; Wed, 24 Jan 2018 10:02:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=wEIAvRyUYM4K+alY1qIlw09zcsZbJSjF9t4NneXki1g=;
        b=hlt4Grs+lx+/hv9ffneUn4/8/m+y3zXARPoxzfdpb9HPBeV8ZjSJsdD9gFGfOtR+wR
         VpLmZ4ig4jCloPQR4E8b5QKdJMtXRYiFbQN2saKdwUzptggNs5z/l9uylcg5aZpWAJZU
         Ie9n/QS291VPWkrd466Drwzhrq7xbLIx46YP5E+u4bC0lAwPm2iWLOvEhDjEvh+RnQxf
         TyYTJkaNW3MfZuGgvpanYqa+KWLQe6NG+Rs2DpnguCnD9aYJdfb5SZP8GJ0fzByh4DaF
         FdaNDAs91Ehg1D6EFokad7rNxX7M8qiduZwRtHOXuMLNnbmi0JFywiB/5wdBkfWHVgau
         4pqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=wEIAvRyUYM4K+alY1qIlw09zcsZbJSjF9t4NneXki1g=;
        b=F9iUDV70HgOCw4Zzrs5Fvm2vJEYE9FrfBzYaxj9XncVGr9mVAbyR+5gbgaW3CH9Tra
         cW6cI2v5pY25255EvxLdOkREJHeeuiXhmMXkxmOeGtcuNBrZyu/Z9CMrMSZn1mmb8fpM
         lBGxYLcQmIYNKcMyslX2vFW2lcmRoj5mFROX6jMLpWKAp1A2c8QUEcTY2ez6d3FHdl4g
         SSvr3yfS/Umt2d20PqylR8TqTq7jkRIv5GUd1oDtxcjBK2CLgWGq3jDhJAFh//yWZJOK
         yx1dMNCD89WLa5j0J7gDSyfUhZ9Cgm8973CKvpcQ7lmz14Bh685YEKy4By4DdKB2P+pi
         9sNw==
X-Gm-Message-State: AKwxytf4QlDEV6qixfnrBSWLcKXaq5zgaqRNauat6MTFj3/k8eZpq4Jn
        9h57BOOHC4PFXHLoylnqqRI=
X-Google-Smtp-Source: AH8x22437rTkeeSR5S4EwpG554vE0oDYqQijMBTUTOBb8TOHD9KBynHs+eHNu0vGByTl7S8mfbalNA==
X-Received: by 10.99.171.12 with SMTP id p12mr11490264pgf.304.1516816953032;
        Wed, 24 Jan 2018 10:02:33 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:69e6:5f42:e334:a0e2])
        by smtp.gmail.com with ESMTPSA id j4sm12089420pfe.53.2018.01.24.10.02.32
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 24 Jan 2018 10:02:32 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Gargi Sharma <gs051095@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH v6] mru: Replace mru.[ch] with list.h implementation
References: <1516751211-19307-1-git-send-email-gs051095@gmail.com>
        <20180124040341.GC1330@sigill.intra.peff.net>
Date:   Wed, 24 Jan 2018 10:02:31 -0800
In-Reply-To: <20180124040341.GC1330@sigill.intra.peff.net> (Jeff King's
        message of "Tue, 23 Jan 2018 23:03:42 -0500")
Message-ID: <xmqqa7x3f83s.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Tue, Jan 23, 2018 at 06:46:51PM -0500, Gargi Sharma wrote:
>
>> Replace the custom calls to mru.[ch] with calls to list.h. This patch is
>> the final step in removing the mru API completely and inlining the logic.
>> This patch leads to significant code reduction and the mru API hence, is
>> not a useful abstraction anymore.
>> 
>> Signed-off-by: Gargi Sharma <gs051095@gmail.com>
>
> Thanks, this version looks good to me.

Yes, indeed it does.  Thanks, both.

Will queue.
