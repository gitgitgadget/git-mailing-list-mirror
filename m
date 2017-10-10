Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E125920405
	for <e@80x24.org>; Tue, 10 Oct 2017 02:24:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754287AbdJJCYX (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Oct 2017 22:24:23 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:33814 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754126AbdJJCYX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Oct 2017 22:24:23 -0400
Received: by mail-pf0-f194.google.com with SMTP id b85so11507155pfj.1
        for <git@vger.kernel.org>; Mon, 09 Oct 2017 19:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1zWpUQdRbqj4YBomeEMbCJBltCcwrufUTyqtSBkp7AU=;
        b=O7XOm05R28Ld7vQm/Q27QjG2KDNwzinPddWfeSz/pzGcpGjDot5x58XLo0jpm5BalW
         P8tR2ydpsW8CY+ddqvfw5dcjldA8j74xqq4nobTL8TIa+JOAupbPhmtPjBWjlELDhse3
         KByPpvAOC/6/MT15ePgbENPpKkWRApOccLp7D+V/9heVn51oY+GXPsxbOwb72b9UnoAK
         82JUX1ZH0eqQILwa2BctV8Sp8HoiKXdWgKot9Pu8eRhnG2xO8bY/ja+sypyrV1UIy3Je
         9dmRKw2oqte6uyQxYRo39MAe/IsRXZv0A3CxCX6I/j/uofth1BaeJskhzIXFniR8PAhb
         nZQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1zWpUQdRbqj4YBomeEMbCJBltCcwrufUTyqtSBkp7AU=;
        b=MS7NuTyQHgjagGOmFFtwmwWydS78a41W2q84q1BdAN3cB6H+mGOYbzIfm32CjAaHHL
         d+vlD6danw8M35W06C9PALOiisPLjTfnByPR5bTYnsKKm/kKazrRyB1U9UqzE3SKsXqS
         P2rukuyQr53UwUTeDX/vOyhcP3U5aAZe/2rMJgeLnOiU7cnVgtMTveGRbPczvnPmExZa
         qCQ/2+Qp2o3BBfyRcWNj0c0EfiPTrrAbEbEt9yM0uVdHRqhCH4qHnj4ocj/Huy9RgALh
         m6izbEuVFu0eyVu+VlCM4AqdY7J877dXo6UjjUpTXuflzvwpHVckrt90ldGorEmTZF93
         cH/A==
X-Gm-Message-State: AMCzsaX0cvkhShYRuE+lDC/1+SRou1bD7eNNykIyXE5MOTWvZFRm43MX
        egijvm8XRtlyUrmmMSe8bFw=
X-Google-Smtp-Source: AOwi7QC0NbOzR1K0tVgd328pHCJNea7Dl5Hc9mlOroPkMbNyVt/8g5lIQEXs0PCyKigvIWTfs1YL5Q==
X-Received: by 10.98.53.196 with SMTP id c187mr12010563pfa.38.1507602262421;
        Mon, 09 Oct 2017 19:24:22 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:c9c7:66a0:181:dab2])
        by smtp.gmail.com with ESMTPSA id b3sm843697pgr.81.2017.10.09.19.24.21
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 09 Oct 2017 19:24:21 -0700 (PDT)
Date:   Mon, 9 Oct 2017 19:24:19 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Brandon Williams <bmwill@google.com>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v2 13/24] builtin/pack-objects: convert to struct
 object_id
Message-ID: <20171010022419.GU19555@aiede.mtv.corp.google.com>
References: <20171009011132.675341-1-sandals@crustytoothpaste.net>
 <20171009011132.675341-14-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171009011132.675341-14-sandals@crustytoothpaste.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

brian m. carlson wrote:

> This is one of the last unconverted callers to peel_ref.  While we're
> fixing that, convert the rest of the file, since it will need to be
> converted at some point anyway.
>
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
>  builtin/pack-objects.c | 135 +++++++++++++++++++++++++------------------------
>  1 file changed, 68 insertions(+), 67 deletions(-)

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
