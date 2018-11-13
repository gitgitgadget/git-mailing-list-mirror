Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.1 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7B41B1F87F
	for <e@80x24.org>; Tue, 13 Nov 2018 22:28:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731166AbeKNI3D (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Nov 2018 03:29:03 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:39089 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbeKNI3C (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Nov 2018 03:29:02 -0500
Received: by mail-pf1-f195.google.com with SMTP id c72so2112664pfc.6
        for <git@vger.kernel.org>; Tue, 13 Nov 2018 14:28:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=f7vW+BlXhMKg3WLgmrU+8GAkJzwwacbjtbHg9n5E2T0=;
        b=GqchBciF/s1AmjrZ+ERnCrw1H+Hl364y6WDPQio5YIc0NuUOG57xhT9QkgJvdT0vUq
         UZO79Yx2OalpuvS/IUvF2chw6hXXHnGP04AipIhm97EeePPIWeLdNyok1mtAXBXQDm9S
         GQxV1/Aa4p9EoZMfPjeval5xVekElTOGPmxZGhcIVBoxwEYcGrmlwDJEWPuqMYo/45od
         7SdliE/6S57+G0bcSvVn6Tq+1/VXra0CbTE7MpSN/HOEGQF7a2kvsK9XNRnWREDuY8gn
         yE4AoVi9oGTB31FvPe00O0WjN+vRCIcgzRmQr7ql/nNYRnoiTah+nqr+y+hSAqfJCSDG
         OLIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=f7vW+BlXhMKg3WLgmrU+8GAkJzwwacbjtbHg9n5E2T0=;
        b=ofKsm3YBdSQxZdLK1lG/cNpPgTxzgZP/IiEdjjxibiZyphPFJEWpP7G28HZP9Ay5UM
         x620GooNPdQ3l07yVwx3LGPZghJQVmFuXJIQ9+buRZks9FLfr1LWjh+us5R9WPYw1WV3
         66gFihgKoz5OPn5aN1Hs5g/0wIenhL9NiT80xD6HtyZfaDdUtXcD67AtgQNuU9TQHyZR
         audhZ+42Z1nLwKxur1NgEcAz0vkVLK8yja+Yq6AFCfOcH64Hi+vsUOExs97mQRmc3b+2
         VVhDHbbmLrNPzjg9uWjnwmUS7Y1WVT/T0TmEspZCey1hP1vbmqR00VdhVK/+X2QyckfC
         bcTg==
X-Gm-Message-State: AGRZ1gJVWZTXNPt/E/Avlpj9u/1VyhKHr2BAqx8Aa89FNv+Aq8NJ/Nb2
        eHJBYivPM9A9XJbV1luFxJ0bvA==
X-Google-Smtp-Source: AJdET5cQFEcmDcI6nTtU9TS1jwBQekxKu+uXtILdt1Qb6s3oJYUPjvS6oGqg7Ag0WLDUWY9wkYQaWg==
X-Received: by 2002:a62:9989:: with SMTP id t9-v6mr6932597pfk.179.1542148127306;
        Tue, 13 Nov 2018 14:28:47 -0800 (PST)
Received: from google.com ([2620:0:100e:913:5bb:3076:546:99b0])
        by smtp.gmail.com with ESMTPSA id f6-v6sm26703222pfg.128.2018.11.13.14.28.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 13 Nov 2018 14:28:46 -0800 (PST)
Date:   Tue, 13 Nov 2018 14:28:41 -0800
From:   Josh Steadmon <steadmon@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] remote-curl: die on server-side errors
Message-ID: <20181113222841.GF126896@google.com>
Mail-Followup-To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <9a89e54e79593f6455b52e01d802695362f4ec21.1542062657.git.steadmon@google.com>
 <xmqq4lcluk1u.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq4lcluk1u.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2018.11.13 23:30, Junio C Hamano wrote:
> steadmon@google.com writes:
> 
> > When a smart HTTP server sends an error message via pkt-line,
> > remote-curl will fail to detect the error (which usually results in
> > incorrectly falling back to dumb-HTTP mode).
> 
> OK, that is a valid thing to worry about.
> 
> >
> > This patch adds a check in discover_refs() for server-side error
> > messages, as well as a test case for this issue.
> 
> This makes me wonder if discoer_refs() is the only place where we
> ought to be checking for ERR packets but we are not.  Are there
> other places that we also need a similar fix?

Quite possibly; I'll review the other client code to see if there are
similar issues before sending v2.
