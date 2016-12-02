Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 63FD71FC96
	for <e@80x24.org>; Fri,  2 Dec 2016 18:49:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752286AbcLBStt (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Dec 2016 13:49:49 -0500
Received: from mail-pf0-f178.google.com ([209.85.192.178]:35137 "EHLO
        mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751704AbcLBStr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Dec 2016 13:49:47 -0500
Received: by mail-pf0-f178.google.com with SMTP id i88so53756780pfk.2
        for <git@vger.kernel.org>; Fri, 02 Dec 2016 10:49:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Hpp24qHGYTvApV/BMtnrpbB6UYuIRNMnyUMoBvXMd9U=;
        b=FQ1rRDUu7ji4QmupmO3BNZCB7FXnnhOq+pkHMGyCB7TXzDj8nm/ZWxY0I+I1cHbmMS
         VQqgVLNCJho5K4axl4SGo5mwAKRIwYoTzvEgXyIoE/2n4wL12t1+NJv3oYgqlr3KdHLp
         7ooGPNdPVZ7VW4JOrt+5NxpeigKVLygZbWm0YOaONaIVt478hDtpqGEDGK/dxfmD0tw5
         UcI+198vJgZM0yRz7MDY6tzxdDHtt6rkeK3TfkXZDUUkJs2+JfpbtYv70RUJxDwmgfTv
         6gd97kexcqHVIRWu0seL7rbrZEeYYsgsM2PBJSi6Gfd7S9PRWvwquCC/YTx9nby9ZGhs
         8dEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Hpp24qHGYTvApV/BMtnrpbB6UYuIRNMnyUMoBvXMd9U=;
        b=UVow9ejnK7V4/6n/n0eV5jdwYroxAe/jzqRFOqyl/2FyIzblE3mF/WDbDxEz7uLaZ3
         dhWfAOUsRZOMfQNBijkvrW7vnz0UIdmENKue2N+vzfPBZ8vuEssd9XExGdJ+6MhRPAOm
         RhLAcchUpRj/byqrnh/22NON+rGcMByEGVynVbZytrp+G0ngCSaw9OkMSAtnIHckQVlv
         YcagPxApOYLxZ2uHJwOEK/yZJ4FZYfTE8m1edYkd9Tu421scJhkQpcfHbkqRa+VvWx6y
         ipRXn7s1H3yc7e4zqUI4Jjfk1jJKVDtCroIE3NhIFo1uqbRBTv0Xz9718ceLBnvQH93m
         guRw==
X-Gm-Message-State: AKaTC02a7/OXhf6NnZDgJE82CFcbsxCBti63P0XvzXu6DYNM+crkUOyeS/DxVqZws4D4iQkF
X-Received: by 10.84.213.137 with SMTP id g9mr99087854pli.146.1480704586908;
        Fri, 02 Dec 2016 10:49:46 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:217c:34ba:fcf8:d822])
        by smtp.gmail.com with ESMTPSA id q145sm9490333pfq.22.2016.12.02.10.49.45
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 02 Dec 2016 10:49:45 -0800 (PST)
Date:   Fri, 2 Dec 2016 10:49:44 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     Jeff King <peff@peff.net>, Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH v6 1/6] submodules: add helper functions to determine
 presence of submodules
Message-ID: <20161202184944.GC117792@google.com>
References: <20161201042926.mr2qdta7hviizcya@sigill.intra.peff.net>
 <xmqqwpfja3nk.fsf@gitster.mtv.corp.google.com>
 <20161201190925.xi2z7vauxyf3yxyc@sigill.intra.peff.net>
 <20161201191603.GB54082@google.com>
 <20161201205444.GG54082@google.com>
 <20161201205944.2py2ijranq4g2wap@sigill.intra.peff.net>
 <CAGZ79kaqzssfN_bRQYpqC9HsKmyQZNCQcs+T5ke95Sf-C5PaRQ@mail.gmail.com>
 <20161201215934.g7dt5ioekmx6ssii@sigill.intra.peff.net>
 <20161202183622.GB117792@google.com>
 <CA+P7+xpoO=ieRyQb8r8Xz12nN10f53LKeVMgAO8XPdSwvG7fuA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+P7+xpoO=ieRyQb8r8Xz12nN10f53LKeVMgAO8XPdSwvG7fuA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/02, Jacob Keller wrote:
> On Fri, Dec 2, 2016 at 10:36 AM, Brandon Williams <bmwill@google.com> wrote:
> > On 12/01, Jeff King wrote:
> >> On Thu, Dec 01, 2016 at 01:56:32PM -0800, Stefan Beller wrote:
> >>
> >> > > Bleh. Looks like it happens as part of the recently-added
> >> > > get_common_dir(). I'm not sure if that is ever relevant for submodules,
> >> > > but I guess in theory you could have a submodule clone that is part of a
> >> > > worktree?
> >> >
> >> > Sure we can, for a test that we don't have that, see the embedgitdirs series. ;)
> >> >
> >> > For now each submodule has its own complete git dir, but the vision
> >> > would be to have a common git dir for submodules in the common
> >> > superprojects git dir as well, such that objects are shared actually. :)
> >>
> >> Fair enough. Given that it seems to behave OK even in error cases, the
> >> simple stat() test may be the best option, then. I do think we should
> >> consider adding a few test cases to make sure it continues to behave in
> >> the error cases (just because we are relying partially on what git's
> >> setup code happens to do currently, and we'd want to protect ourselves
> >> against regressions).
> >
> > For the naive (ie me), is there a reason why real_path() couldn't be
> > re-implemented to avoid using chdir?  I tried looking into the history of
> > the function but couldn't find anything explaining why it was done that
> > way.  I assume it has to do with symlinks, but I thought there was a
> > syscall (readlink?) that could do the resolution.
> >
> > --
> > Brandon Williams
> 
> The reason as far as I understand it, is that it uses chdir() to
> guarantee that it follows symlinks correctly and then looks up the
> resulting path after the chdir(). I do not think there is a syscall
> that actually correctly works like real_path() does. You *could*
> re-write real_path() to do the symlink lookups itself, but as Jeff
> recently pointed out, that way lies madness.

So is there a reason why the library function realpath() can't be used?
From a cursory look at its man page it seems to do the symlink
resolution.

-- 
Brandon Williams
