Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	RCVD_IN_DNSWL_HI,T_DKIM_INVALID,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C9E681FAEB
	for <e@80x24.org>; Sat, 10 Jun 2017 11:03:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752007AbdFJLDT (ORCPT <rfc822;e@80x24.org>);
        Sat, 10 Jun 2017 07:03:19 -0400
Received: from mail-pf0-f175.google.com ([209.85.192.175]:36553 "EHLO
        mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751941AbdFJLDS (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Jun 2017 07:03:18 -0400
Received: by mail-pf0-f175.google.com with SMTP id x63so36431968pff.3
        for <git@vger.kernel.org>; Sat, 10 Jun 2017 04:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=ebW69nh2gxCA88grqlgNT+0uxItP3N7/4J8YHif20NA=;
        b=t9i59RnQhnZODYiq8qERMEPU6Xjgr/frS0kFztw+C8tmTPXHfl+UdHwLTK0DoGONIG
         Y+roeMoed0xFMnI+Pm/56cQcx6Kfc1MdhV0zXsdMMo5dKW3fU/xJtVkYtzW8jb6rCGS0
         U8n1GFfWOi2JUDAjuauuylwE4LQFGqljN95m86/kP+gy4jsZcpBb1+zfTWJ6yJ8ypYrz
         b7JNu205OSuasXTtYjRrTKKUyaJ5TSBX0sE7DvOcK/x/KRs+EjJ5PB4m8A118BCowIz0
         +nnM/EZTp/PCSRiaIlRKj19l168A5Dnuyy/LwD8+4C3q6aQvE41KfHPR/6GQOJG445yY
         oToQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=ebW69nh2gxCA88grqlgNT+0uxItP3N7/4J8YHif20NA=;
        b=JB4eVj/e/1MrFJHFVfVaVsxAKu3+DthH034xmA6RIIPaVhJChVYYsukOC1MtLSK7dj
         Ymu2b6PKD6EHXgo1W67R5y8dz+EMV0QxlBmMmuOzPqDK1NqAwegKEynQkSMAOwB0OUXf
         fq3tjg+Vg8d+xw+j1eqQfGlWFOi1XomDCNga2saSsgoPKJxdBK2iNmo9b1xIb6IX8wjX
         NYHscwpJF0mCOBzWY/OA1OzdDkUj07mtyqfyY5bQo53UVVlCkck+6sMSVZjYzoZwj6m3
         O49iE/1QS8WIzr7VwlRvLdHuvW5n1+Sbrv2AGQZXFEycTaPLSlDcmaBQqRDa14BugOxK
         0Arw==
X-Gm-Message-State: AODbwcCfcAmJfsQu8h7il0lnpobYkpOfqutXTMM54Uh4eLO3F7YIMq7Y
        GNuP5JPVpbum4A==
X-Received: by 10.99.66.5 with SMTP id p5mr47930916pga.107.1497092597885;
        Sat, 10 Jun 2017 04:03:17 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:d192:93c8:4f75:5879])
        by smtp.gmail.com with ESMTPSA id b14sm9907881pga.12.2017.06.10.04.03.17
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sat, 10 Jun 2017 04:03:17 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Emily Xie <emilyxxie@gmail.com>, git@vger.kernel.org,
        novalis@novalis.org
Subject: Re: [PATCH] pathspec: die on empty strings as pathspec
References: <20170607033308.33550-1-emilyxxie@gmail.com>
        <xmqq60g56s6x.fsf@gitster.mtv.corp.google.com>
        <20170610062151.fv7d4audrwav2hy3@sigill.intra.peff.net>
Date:   Sat, 10 Jun 2017 20:03:16 +0900
In-Reply-To: <20170610062151.fv7d4audrwav2hy3@sigill.intra.peff.net> (Jeff
        King's message of "Sat, 10 Jun 2017 02:21:51 -0400")
Message-ID: <xmqqvao414wb.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> That's long enough for people who actually ran the intermediate
> versions.  But what about people on distros who jump from v2.10 or lower
> straight to v2.14?
>
> I think to catch them we'd literally need years on our deprecation
> schedules. Maybe it's not worth caring about. That's an awful long time
> for people who _are_ upgrading each version to see the warning. Of
> course the end game in this case is that it becomes an error, so they'll
> be notified either way. :)
>
> I'm OK with this case being a relatively quick deprecation, but your
> "long enough" made me wonder how we would decide that.
>
> -Peff
>
> [1] Debian stable is set to release in a week or so. People doing that
>     stable upgrade will go from v2.1.4 to v2.11.0. So they won't
>     actually skip the deprecation notice, but they'll probably live with
>     the warning for 3 years or so.

Yuck X-<.
