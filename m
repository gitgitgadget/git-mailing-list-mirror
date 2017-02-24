Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 643DA2022D
	for <e@80x24.org>; Fri, 24 Feb 2017 04:11:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751202AbdBXELQ (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Feb 2017 23:11:16 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:34641 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751049AbdBXELQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Feb 2017 23:11:16 -0500
Received: by mail-pg0-f66.google.com with SMTP id s67so1509932pgb.1
        for <git@vger.kernel.org>; Thu, 23 Feb 2017 20:11:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=6Idg5y42LgJPXoLDzkWBOefTxcreOsdjnSf1nRlShVU=;
        b=vaB4mf8q18Jq05aP+uQ6u0I1GTjhfWWgqGtylPV2bj+1lm+AvoDS67a4Kn9Fw1Qzy4
         8uWWIkEm822UMwxAbsks/WJtCwnfJn9IoJt+MAOqTSLABZoVmO44S+//CImf50hISHwS
         H8MIi+b3C29tVAE1L/DbziDXazk2t83qxgXSZ+q5fehQLGKCUunHzLM0hf6XsI2273a7
         lYKOoQJhMHV1JIMtIqqTv+l/sfV43TjKnQM5jpETGVpth2MiDI7F0mPch+mwlFtPIvjh
         6k7Whs3JWU1yPFZJUoXSkhZAfVikOiznSQ9scymhQJ9Yc19qWRTRSZ2kYKPOzQyJmNIc
         e63Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=6Idg5y42LgJPXoLDzkWBOefTxcreOsdjnSf1nRlShVU=;
        b=Zu2pS5Xal4P726sJKsgMKsI8kjVoKwx0jTTbzgPQidsTjq/zhRhotW6BQ73FwI/pAx
         zE98Q2Ype4gxNs7J8FSk/WtfEWXuseyM42atHwP5BrVEmGrBTVPuPKffLg5trtc1Tcks
         iVzUdNIiScjCur1RQHHCqM93KE8fqXHnCmyBtNbdUdJhfwQdnTmMxSnnOJIEVPT4A5Py
         5FSEDkuff2fvFh2GsMaQsLIIPj3fhY7NAXMRK9ul8F0jdITwrpZSjwPnLSiUrbxOnBD7
         nhhbYlbCLw5KsyZ2HfiwKQjYBe2bRiGdWpQPTs2Xi27pPv7ytYRRIy/I4WH60//PmTTG
         6S6Q==
X-Gm-Message-State: AMke39mN2ryEqoOjYUD5j+SsiLtR3lw5qfSf64Qbl7jN0zYmYPSDBlUYNwumDGf9kZ+/wA==
X-Received: by 10.99.95.16 with SMTP id t16mr994079pgb.0.1487909475148;
        Thu, 23 Feb 2017 20:11:15 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:8829:f260:c132:141f])
        by smtp.gmail.com with ESMTPSA id w124sm12297118pfw.29.2017.02.23.20.11.12
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 23 Feb 2017 20:11:12 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     bs.x.ttp@recursor.net, git@vger.kernel.org
Subject: Re: [PATCH 4/4] ident: do not ignore empty config name/email
References: <20170223081157.hwfn3msfux5udmng@sigill.intra.peff.net>
        <20170223081708.ge34zjkmpsolocqx@sigill.intra.peff.net>
        <xmqqfuj47hfk.fsf@gitster.mtv.corp.google.com>
        <20170224010823.my4wmdyezjuqajfx@sigill.intra.peff.net>
Date:   Thu, 23 Feb 2017 20:11:11 -0800
In-Reply-To: <20170224010823.my4wmdyezjuqajfx@sigill.intra.peff.net> (Jeff
        King's message of "Thu, 23 Feb 2017 20:08:23 -0500")
Message-ID: <xmqqlgsw5iu8.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Keep in mind this _only_ affects Git's config variables. So a script
> feeding git via GIT_AUTHOR_NAME, etc, shouldn't change at all with this
> code.

Ah, that changes the equation somewhat ;-)

> So I dunno. I could really go either way on it. Feel free to drop it, or
> even move it into a separate topic to be cooked longer.

If it were 5 years ago, it would have been different, but I do not
think cooking it longer in 'next' would smoke out breakages in
obscure scripts any longer.  Git is used by too many people who have
never seen its source these days.

