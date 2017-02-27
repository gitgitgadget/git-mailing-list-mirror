Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C703D1F5FB
	for <e@80x24.org>; Mon, 27 Feb 2017 21:37:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752003AbdB0Vgn (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Feb 2017 16:36:43 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:34301 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751747AbdB0Vey (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Feb 2017 16:34:54 -0500
Received: by mail-pg0-f68.google.com with SMTP id s67so2179726pgb.1
        for <git@vger.kernel.org>; Mon, 27 Feb 2017 13:34:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=BJMNJvIeqXbXJjfj8iH6YPHDqBiRMkdmkiDCYbjbGpE=;
        b=IPEV1YsfXUkZj8KJ/dxYXsMJk4wQF3gZCJrl1AHWFOo2HOaTabrNorNiF4X55exJbE
         /gN6NnuwMOLWwv/hfiyOhKcJpnty/9RbcDkEX7X4EDMIpmStDodbpZ5RXQJkdRwQz40S
         9gXlRlAjBjFg6aPcwICw9wy9851jFJ/PQ/TANOHHRcx3nZQlExk60LN4lO/YiXATtJ6+
         QjE0a6o8gprCnaY5VZKjqJZw9XWIKgKwCLSVkVWWCRtMCbpc95mtbo9OoocmobtiBgoK
         pDfsAipLvc6S7UPYefEaUjOMHILKke6dWv9FvOZLBMRJ8P13/cY09NM6Rn/t3hzSE2jm
         y+ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=BJMNJvIeqXbXJjfj8iH6YPHDqBiRMkdmkiDCYbjbGpE=;
        b=fAeEN6s9qCB5+hFykjXrxe2e9+fD63K7dzE/6lRuu4lUbfqLX4qh4kVTRzITyt4FwD
         AcP2kYT9R3mZjteOs804CIqN0e0vbhuE55Km9IKMdAbEITy8fHpib2dEFslXAMfNx9Cu
         /8+CYw2Ei6ULqPVkkiwvDF+YkZgfaHHBZ+fJkIa/liaKA17eS7SDg/4BJfcvCOtGBGj6
         vTsULj+gERWRo48tPuLgp7n4sXo+Ll/c3f0Zqk44Gjw3xTw3vV8qOKg/RMTTJzbd17AQ
         jjBHAmcey1ESEmH52J3gKJszgsbcUK5vygR4YW9k77H/I7f2MenPMj1ugLNFQDCUzn4S
         8F3Q==
X-Gm-Message-State: AMke39mAaCp7FP4B4oaRqxwpbDy/sW2Y4OxiRMWmuzrapWF+nYip9oJx/drOq4PqARbI8w==
X-Received: by 10.99.94.195 with SMTP id s186mr23243584pgb.198.1488227733144;
        Mon, 27 Feb 2017 12:35:33 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:c953:ec42:862e:1e81])
        by smtp.gmail.com with ESMTPSA id m6sm32229851pfm.22.2017.02.27.12.35.32
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 27 Feb 2017 12:35:32 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        sunny@sunbase.org,
        Jakub =?utf-8?Q?Nar?= =?utf-8?Q?=C4=99bski?= <jnareb@gmail.com>,
        Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v7 4/6] stash: teach 'push' (and 'create_stash') to honor pathspec
References: <20170219110313.24070-1-t.gummerer@gmail.com>
        <20170225213306.2410-1-t.gummerer@gmail.com>
        <20170225213306.2410-5-t.gummerer@gmail.com>
Date:   Mon, 27 Feb 2017 12:35:31 -0800
In-Reply-To: <20170225213306.2410-5-t.gummerer@gmail.com> (Thomas Gummerer's
        message of "Sat, 25 Feb 2017 21:33:04 +0000")
Message-ID: <xmqq60jvwewc.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thomas Gummerer <t.gummerer@gmail.com> writes:

> +	test -n "$untracked" || git ls-files --error-unmatch -- "$@" >/dev/null || exit 1

This silent "exit 1" made me scratch my head, but --error-unmatch
would have already given an error message, like

    error: pathspec 'no such' did not match any file(s) known to git.
    Did you forget to 'git add'?

so that would be OK.
