Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3AC851FA14
	for <e@80x24.org>; Wed, 12 Apr 2017 17:47:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755258AbdDLRrS (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Apr 2017 13:47:18 -0400
Received: from mail-io0-f182.google.com ([209.85.223.182]:34610 "EHLO
        mail-io0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755145AbdDLRqR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Apr 2017 13:46:17 -0400
Received: by mail-io0-f182.google.com with SMTP id a103so51693273ioj.1
        for <git@vger.kernel.org>; Wed, 12 Apr 2017 10:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=AzwvTRITvfIfmCLR4TBfpZxYJDu9D1ZNr8XXwn5B9XY=;
        b=K1289931UlZeJb67asjPnIVa2JhAOrCJ6cqOiBPpjl0ExmixSjPAJqzCjPyUK1VrtS
         LUMWNHKawut010P3lCN/a6Bh2fEd5IbSGEVXtkLhmDvKsJOXLcFbfw3GidMKvF2xvz6V
         DkHkNeKquwnaVracAhb/t5AqIVVgDs0tgmPXo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=AzwvTRITvfIfmCLR4TBfpZxYJDu9D1ZNr8XXwn5B9XY=;
        b=haBf8sbx004NhlAEksOBd/LJ29AKqUKJPwciMSUloXZlwaHu+HbPc0kkhx71J5nt3b
         elbqiag13NoUa+bh4OFrzboIRUX9dBBgHcbGt18NubFcmBqQzNId0yjrTiVPY2UQe5Vp
         jNdIf8+IlWAR9zSxpLkcNqDlB9umPDIDPcAsbTL7plv3wkRu1LfwmIl2FcGvzVqcUlLQ
         8hQuUss2yhYxE3Avl7heLGDkfIb1Fj7Av+cFq8L6hW33qkPn7sysljP+uYR4XeTmrUZk
         5wJ4gWhovGPd+zE74CNBt87tEZPHuJotDnzxiUNq0hC/T8hwLtl9PFisq8/g9jD4IA+D
         9zKg==
X-Gm-Message-State: AN3rC/6il1FLcGefEUPBd8jeNuGDlVlENHrtJkqCphI6B8bpSYFKmEHbv3u5Hqkm1bpQGCki
X-Received: by 10.36.184.134 with SMTP id m128mr7316846ite.7.1492019171924;
        Wed, 12 Apr 2017 10:46:11 -0700 (PDT)
Received: from localhost ([2601:401:c500:7dd8:212c:7f4d:6af3:f7a7])
        by smtp.gmail.com with ESMTPSA id 123sm9760742iow.28.2017.04.12.10.46.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Apr 2017 10:46:11 -0700 (PDT)
Date:   Wed, 12 Apr 2017 13:46:10 -0400
From:   Taylor Blau <ttaylorr@github.com>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
        tboegi@web.de, e@80x24.org
Subject: Re: [PATCH v3 4/4] convert: add "status=delayed" to filter process
 protocol
Message-ID: <20170412174610.GB49694@Ida>
References: <20170409191107.20547-1-larsxschneider@gmail.com>
 <20170409191107.20547-5-larsxschneider@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170409191107.20547-5-larsxschneider@gmail.com>
User-Agent: Mutt/1.8.0 (2017-02-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I think this is a great approach and one that I'd be happy to implement in LFS.
The additional capability isn't too complex, so I think other similar filters to
LFS shouldn't have a hard time implementing it either.

I left a few comments, mostly expressing approval to the documentation changes.
I'll leave the C review to someone more expert than me.

+1 from me on the protocol changes.

> +Delay
> +^^^^^
> +
> +If the filter supports the "delay" capability, then Git can send the
> +flag "delay-able" after the filter command and pathname.

Nit: I think either way is fine, but `can_delay` will save us 1 byte per each
new checkout entry.

> +"delay-id", a number that identifies the blob, and a flush packet. The
> +filter acknowledges this number with a "success" status and a flush
> +packet.

I mentioned this in another thread, but I'd prefer, if possible, that we use the
pathname as a unique identifier for referring back to a particular checkout
entry. I think adding an additional identifier adds unnecessary complication to
the protocol and introduces a forced mapping on the filter side from id to
path.

Both Git and the filter are going to have to keep these paths in memory
somewhere, be that in-process, or on disk. That being said, I can see potential
troubles with a large number of long paths that exceed the memory available to
Git or the filter when stored in a hashmap/set.

On Git's side, I think trading that for some CPU time might make sense. If Git
were to SHA1 each path and store that in a hashmap, it would consume more CPU
time, but less memory to store each path. Git and the filter could then exchange
path names, and Git would simply SHA1 the pathname each time it needed to refer
back to memory associated with that entry in a hashmap.

> +by a "success" status that is also terminated with a flush packet. If
> +no blobs for the delayed paths are available, yet, then the filter is
> +expected to block the response until at least one blob becomes
> +available. The filter can tell Git that it has no more delayed blobs
> +by sending an empty list.

I think the blocking nature of the `list_available_blobs` command is a great
synchronization mechanism for telling the filter when it can and can't send new
blob information to Git. I was tenatively thinking of suggesting to remove this
command and instead allow the filter to send readied blobs in sequence after all
unique checkout entries had been sent from Git to the filter. But I think this
allows approach allows us more flexibility, and isn't that much extra
complication or bytes across the pipe.


--
Thanks,
Taylor Blau
