Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E2BC51F404
	for <e@80x24.org>; Wed, 21 Feb 2018 23:03:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751383AbeBUXDZ (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Feb 2018 18:03:25 -0500
Received: from mail-wm0-f50.google.com ([74.125.82.50]:53579 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750741AbeBUXDV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Feb 2018 18:03:21 -0500
Received: by mail-wm0-f50.google.com with SMTP id t74so435505wme.3
        for <git@vger.kernel.org>; Wed, 21 Feb 2018 15:03:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=6RFuzrUp+dcJ7bgpMxMldCCReA+NxeEkrfSzEXOeeOY=;
        b=P2wv0IJ9Qr3UPPTFuPyOHRDq+09l8LGpMD0sBj+YKoaNy36EsTJOyBkvQCt+IZa8ZY
         KkNGH3EVTaXQI7UbpJ794J3zGzQaVj5IoCNj1yF3uwwZ5ef0sUFdQdSQExn+nPJxQ09v
         tlXTd7loWsRXtamVVRfzWMHKyKKJ2KnEVldmkzBw+DXuXQMj8mka95sKmvCOV5wSSCZE
         5smwOW8haj96YgBaBDPcO7BZzKc0nKp6WjlL51fSsQv8tVLBBjUBYFYoqewWiFQYXGPs
         jlu1y4f9+yG7gjcOdpGd+MM1sP/8lTbA57EcArerOcL/6McZOJ9vgnjRz9OLY1cMtTGj
         enjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=6RFuzrUp+dcJ7bgpMxMldCCReA+NxeEkrfSzEXOeeOY=;
        b=kUy7FePV3JZDNUM8DEg8POHgGn/GER7pOzwxvjXsIdBkDAcUCgmJi8FRfnlZbqRlL5
         +FHjfKldt3sP/PgLC1x/DLfZbOhomL/6WPFiS8k++3rpKnBSCKmVgL+stQwsnxBgvHIf
         e3PolmcrG8+Iz3snd3ueI/XSNs9/6qSSxHhkmyMRGAZFnjZPJDhnBtJQuGelbK8ywIdI
         /Txe2ZP+jbgiifu8qM/N0HWzmOVacDm6djHIKE/eajvJUOlDQwBv2Ez49oTzsbdcqYm+
         WeSYkMIxGGOUiRJkkEGMpCofNASgugLR5hkmVmu45KgTVVM/0KNXAPhtYORrwQqySoCi
         j7NA==
X-Gm-Message-State: APf1xPBF7yLx0wN3FyidgTGseWR3DJLd2aHLdcdaEVqfTRJG3HlepdO4
        BdSxrjQt2JvCtAYpibzzbNc=
X-Google-Smtp-Source: AH8x226PeEPtbGrwARbbk8lrpL0t6FpKn7IFKDOWU8+GoeRvllhI7NkucQ404QrzHcv6uZT766ZD9A==
X-Received: by 10.28.150.86 with SMTP id y83mr3362678wmd.42.1519254200011;
        Wed, 21 Feb 2018 15:03:20 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id w74sm21077492wmd.1.2018.02.21.15.03.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 21 Feb 2018 15:03:19 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Derrick Stolee <stolee@gmail.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: Question about get_cached_commit_buffer()
References: <ecbbe515-b7a8-3dc8-7d14-32412e7b12c3@gmail.com>
        <20180220225726.GA17496@sigill.intra.peff.net>
        <22169205-8020-c816-0968-f6293e8d40bc@gmail.com>
        <20180221184811.GD4333@sigill.intra.peff.net>
        <xmqqtvuax9te.fsf@gitster-ct.c.googlers.com>
        <20180221225002.GB7944@sigill.intra.peff.net>
Date:   Wed, 21 Feb 2018 15:03:18 -0800
In-Reply-To: <20180221225002.GB7944@sigill.intra.peff.net> (Jeff King's
        message of "Wed, 21 Feb 2018 17:50:02 -0500")
Message-ID: <xmqqinaqx7wp.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Out of curiosity, do you actually use --show-all for anything?

Absolutely not.  I'd actually love it if I could say "not anymore"
instead, but I haven't had an opportunity to debug the revision
traversal code for quite some time so I do not even remember when
was the last time I used it, which disqualifies me from saying even
that.

> So what I'm wondering is whether we should consider just ripping it out
> (but I'm OK with keeping it, as once the commit-buffer stuff is fixed,
> it's probably not hurting anybody).

I see no problem in removing it.  With more "interesting" features
relying on post-processing (like 'simplify-merges'), show_all whose
primary focus was how limit_list() behaves soft of outlived its
usefulness, I would think.

