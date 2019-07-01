Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CD6921F461
	for <e@80x24.org>; Mon,  1 Jul 2019 17:02:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729821AbfGARCs (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Jul 2019 13:02:48 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:43379 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728253AbfGARCs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Jul 2019 13:02:48 -0400
Received: by mail-yw1-f66.google.com with SMTP id t2so222230ywe.10
        for <git@vger.kernel.org>; Mon, 01 Jul 2019 10:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xRM1nbW0oK7Lhk4U1SkZY2y+wOUMk40bo9e0p2rkrwk=;
        b=V0IZYi/gIAsa7PAmgrLUuhcc2UghmJFgnRxqg38lByBl8jqVqSxTZOvD3YGVijzIKy
         5uzcJXTsKUl1k9RhSbjXqyHonjZdkmTPpn94cpEloRmgyEP7RJYix76PIIqU9VvxYlCH
         JsuHh0pBjuH26J6qylS/40gN25eLxyTCAJsQQzBPQ7CmnaWTb5WFL68K7+tkwqJRFlnm
         F6IXsmkp7nKVe+WD011PGRGfhTY/vd6uAhS8hZw2cv00bA906aq8aJGv2TPJLT0zUplz
         SKScF3Xwq0pwHmGMWKymH2EY+Z98pHUv5oedvw1gqSUWND3XEoUfZCfr+lnXgo+L1DJf
         WRjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xRM1nbW0oK7Lhk4U1SkZY2y+wOUMk40bo9e0p2rkrwk=;
        b=bvLMyqMJU13x0jNPNAfq/y0w4u35RFVbRRcKEFSyDPszvhWPys89b/1KGlTKnVxDxI
         2YxP7iFF2qDItDdWGivU/Km16OhapI+kc3fd/LiebFtuw9vtOzy2IVDj7k2V/4T/kXnx
         BuCZMdLd73/jEv1h1jff54Nzg9qaw5+7WKU7mqF5EhryDqhd/Cb3YM+Vh/rSJXxKps+I
         JhO9uJIal1V/Tul2Rl5UcUoSUP4lczcfWNY6DzUZuLfj4u14KsRrA3c+P0k3z9Md23MI
         CSee/9Qy1RiovcMN4O+Rz31UUnaJEA36wbtZhz3WNGmEK5uQpBenDylkOKOcz9XNthTS
         Dwfw==
X-Gm-Message-State: APjAAAVg9p9JPmNQ8L5FV580WfZi8Vb5gDFpUTP/MxQ5X7UfAoyoa3om
        NYl3R7zFCdHE1t6d2Z1+lHuYpQ==
X-Google-Smtp-Source: APXvYqxRltmM+DoTiEZAHwxluUHe6RDSDBwvfLz7SMjB6YV/zKN/4lpLCEFYS4U7wArVP3EQi9/VWQ==
X-Received: by 2002:a81:1f87:: with SMTP id f129mr15531141ywf.135.1562000566890;
        Mon, 01 Jul 2019 10:02:46 -0700 (PDT)
Received: from localhost ([2600:1700:6e90:7930:6841:343f:64f7:7ef1])
        by smtp.gmail.com with ESMTPSA id u6sm2571031ywl.10.2019.07.01.10.02.45
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 01 Jul 2019 10:02:46 -0700 (PDT)
Date:   Mon, 1 Jul 2019 12:02:45 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     Derrick Stolee <stolee@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH] check_everything_connected: assume alternate ref tips
 are valid
Message-ID: <20190701170245.GA54693@TaylorsMBP5815.attlocal.net>
References: <20190628101131.GA22862@sigill.intra.peff.net>
 <601d8561-6e24-559c-6fbb-fa25a7389fa0@gmail.com>
 <20190629074348.GA5080@sigill.intra.peff.net>
 <418213f2-82d6-f7bd-7379-7f20f0e83084@gmail.com>
 <20190701125945.GB4704@sigill.intra.peff.net>
 <20190701131713.GA25349@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190701131713.GA25349@sigill.intra.peff.net>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Mon, Jul 01, 2019 at 09:17:13AM -0400, Jeff King wrote:
> On Mon, Jul 01, 2019 at 08:59:45AM -0400, Jeff King wrote:
>
> > Yes, this is weakening the ties of the feature to the transport code.
> > Traditionally transport-oriented code was the only user, but it also
> > used the upload-pack transport under the hood to access the alternate
> > (that was changed a while ago to for-each-ref for speed).
> >
> > I don't think there's any functional difference in having it there, but
> > it could be moved to live alongside foreach_alt_odb() in sha1-file.c.
>
> Looks like this hasn't quite hit 'next' yet, so perhaps we can
> reorganize it as a preparatory patch.
>
>   [1/2]: object-store.h: move for_each_alternate_ref() from transport.h
>   [2/2]: check_everything_connected: assume alternate ref tips are valid
>
>  Documentation/rev-list-options.txt |  8 +++
>  builtin/receive-pack.c             |  1 -
>  connected.c                        |  1 +
>  object-store.h                     |  2 +
>  revision.c                         | 29 +++++++++
>  sha1-file.c                        | 97 ++++++++++++++++++++++++++++++
>  t/perf/p5600-clone-reference.sh    | 27 +++++++++
>  t/t5618-alternate-refs.sh          | 60 ++++++++++++++++++
>  transport.c                        | 97 ------------------------------
>  transport.h                        |  2 -
>  10 files changed, 224 insertions(+), 100 deletions(-)
>  create mode 100755 t/perf/p5600-clone-reference.sh
>  create mode 100755 t/t5618-alternate-refs.sh

This looks good to me, too (and matches my recollection from our prior
off-list review against GitHub's fork).

One thing that I didn't catch in my initial review that I am seeing now
is the ".alternate" marker. Why did you choose this? I was thinking that
".have" would make more sense since it's consistent with what's shown in
the ref advertisement, but I think that actually ".alternate" is a
_better_ choice: the two really do refer to different things.

Either way, I don't think that it matters much: this series is already
on 'next' and I think that either is fine (especially since ".have"
refers to a nameless ref and ".alternate" refers to a nameless
pseudo-remote).

> -Peff

Thanks,
Taylor
