Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 91BAE1FBB0
	for <e@80x24.org>; Thu,  1 Dec 2016 17:46:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934234AbcLARpw (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Dec 2016 12:45:52 -0500
Received: from mail-pf0-f176.google.com ([209.85.192.176]:34643 "EHLO
        mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934229AbcLARpu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Dec 2016 12:45:50 -0500
Received: by mail-pf0-f176.google.com with SMTP id c4so47251332pfb.1
        for <git@vger.kernel.org>; Thu, 01 Dec 2016 09:45:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=I+OjCJGEhNZUV6x0bIFxrk6OLli2lvOTTuAkv/XtxXw=;
        b=RweaTIDxWUkJFS+wpDKTThQw87d/6fMbJn2jRWkCUTpQR4oZlln43ZzOR8BIVRQLUP
         WsAdT9pUeMhxUhRT9/qYdKEkQ+y9YSs3HVjZb5tQTBgKCo5Dp0llox5YajB5gCmDSyyc
         uaXVtvsXHnmCSjIF4dLoRcMqtt1zWFoOydEOXrcqjRn6MfHXAuMdthB99HFo1QZm/2Q5
         5nbZmWgTUu7nUMTrNC8NTMD1egkq4uvSnU8eCRni31RDsNBuzi/aBSqft7A1G4oxSWYV
         zPf2MDg+9cNqQMTU/5xMPH1mXy6jcVD/vSUeEwMC479XnbRgYKzPawAGtNLYvfy8ustF
         hPQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=I+OjCJGEhNZUV6x0bIFxrk6OLli2lvOTTuAkv/XtxXw=;
        b=He67/M18NDorcc+uGDGS3/jgEdx1B1XoqarNaOaP1wDtQVsAB6Tq8N3ZJdTrRMRPo2
         7daZrpEuaDNlryEqrFMg/hGvPZt9B7SM8PV6KQAbUeu9A6KzU0Y6dg1sB9obu4BQgnsu
         upRYaMxZko4MbyO35H+qX+lDaBVLW3iofOeVRUfsiXHQMEBUt1WjNiXhekhP+NiD/0+D
         pIiP+HDZ5TQphIId/JiGIQYS3tN/TY6KxLQEKLaebyJJgvaOIqQjfIAovaE3jvVCPiu6
         SE3Xy2H3wa3TV6WGvQ6QgGQGx8M93JuBvpvpSHdjJRAG5RKvkXQPUPLC3WyKk5ooaJ+M
         NAHw==
X-Gm-Message-State: AKaTC03ftBvfAjYpuo7DhWb1geNf88yMflefsQPpPBqSLBgYXDKdlJ7YbW/sXsWfUXyudz/r
X-Received: by 10.99.188.2 with SMTP id q2mr71170415pge.34.1480614350120;
        Thu, 01 Dec 2016 09:45:50 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:2ce9:cac6:1258:bbf3])
        by smtp.gmail.com with ESMTPSA id y2sm1599671pff.82.2016.12.01.09.45.48
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 01 Dec 2016 09:45:49 -0800 (PST)
Date:   Thu, 1 Dec 2016 09:45:47 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, sbeller@google.com, jonathantanmy@google.com,
        gitster@pobox.com
Subject: Re: [PATCH v6 0/6] recursively grep across submodules
Message-ID: <20161201174547.GA51406@google.com>
References: <1479840397-68264-1-git-send-email-bmwill@google.com>
 <1480555714-186183-1-git-send-email-bmwill@google.com>
 <20161201042228.ynug33mcsqkdbuoe@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161201042228.ynug33mcsqkdbuoe@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/30, Jeff King wrote:
> On Wed, Nov 30, 2016 at 05:28:28PM -0800, Brandon Williams wrote:
> 
> > v6 fixes a race condition which existed in the 'is_submodule_populated'
> > function.  Instead of calling 'resolve_gitdir' to check for the existance of a
> > .git file/directory, use 'stat'.  'resolve_gitdir' calls 'chdir' which can
> > affect other running threads trying to load thier files into a buffer in
> > memory.
> 
> This one passes my stress-test for t7814 (though I imagine you already
> knew that).
> 
> I tried to think of things that could go wrong by using a simple stat()
> instead of resolve_gitdir(). They should only differ when ".git" for
> some reason does not point to a git repository. My initial thought is
> that this might be more vocal about errors, because the child process
> will complain. But actually, the original would already die if the
> ".git" file is funny, so we were pretty vocal already.
> 
> I also wondered whether the sub-process might skip a bogus ".git" file
> and keep looking upward in the filesystem tree (which would confusingly
> end up back in the super-project!). But it looks like we bail hard when
> we see a ".git" file but it's bogus. Which is probably a good thing in
> general for submodules.
> 
> I'm not sure any of that is actually even worth worrying about, as such
> a setup is broken by definition. I just wanted to think it through as a
> devil's advocate, and even that seems pretty reasonable.
> 
> -Peff

Yeah I was trying to think through these scenarios myself last night.
And like you found it seemed alright to let the child process deal with
the .git file/dir as long as once actually exists at that path.  If one
didn't then there would be the possibility that we ended up back at the
superproject, which would result in an infinite loop.  And yeah if the
.git file doesn't resolve to anything sensible then the user probably
mangled their repository somehow anyways.

Thanks again for all the help!

-- 
Brandon Williams
