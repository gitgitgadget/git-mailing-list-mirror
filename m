Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6FCCF2047F
	for <e@80x24.org>; Tue,  1 Aug 2017 18:20:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751923AbdHASUi (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 Aug 2017 14:20:38 -0400
Received: from mail-pf0-f177.google.com ([209.85.192.177]:35403 "EHLO
        mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751327AbdHASUg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Aug 2017 14:20:36 -0400
Received: by mail-pf0-f177.google.com with SMTP id t86so10899243pfe.2
        for <git@vger.kernel.org>; Tue, 01 Aug 2017 11:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5tQSOPLPGrdx0YKoCiQyd5WQlrlYXyHMggq+ZPkKUQ8=;
        b=HsDsw5zAhA8F4vaS9ITjglr5AJFIaZFubLwcuezD9dGhqtsJIwR6P2pWBP44/94gnG
         hI0zeYPGHYJd6EFVAtOuurk/sORx3XfRMPycOfxmy5V4Tzrxx4VynPqAyLmPlMh2kaRq
         9xYDKxCn6qnTMEMrT0cg6+PDIlXViPT4jvcQJwFoXT9E9DKZy6WLwfH6DRiWL6C7IvSJ
         OOzjBuHgo8MpB4iZQUtLGtn4BK/dMZTK+YvDnbELb8n8E2lnWJ59UbRjTBehxldbhu0I
         CizgLrm39rMjoph9p0D2L53UtUwxC4zxnSpsdYU/xR/w6frXIoEzs5eo+o/OUFxYa7qT
         CGEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5tQSOPLPGrdx0YKoCiQyd5WQlrlYXyHMggq+ZPkKUQ8=;
        b=U2aAVfAZwpTLfcZPaakpNgj4YFvjNAoobCwW+Bj00uRX/CH314O7iIHKKDXzqF8UAU
         qw7oyHsAsvWXuoWrwkhZxr6cnVIQROWzPmsgD4j1jpvmLzsqhi03/tErZSdWDHooA9ty
         6hgxPuSIf4Uc/crUrmo01jSfr8xUDgcxMVRlNvm7BmfeNjVh2nLUoVDg6TjzSrKGAFIr
         CN2ok58bvQWbcScrNV3/ACwX2KViEXhxJkS6GcZ/UrGErm33bzDcUCvp7WV54qdBH0Pv
         gcHdmUL3XrQ0Ke/OtgQ99DWUpkhiFcAfqJj5zARq9t3yEBNwPhk8mcFDRzgU8Sv9u6WN
         cpcQ==
X-Gm-Message-State: AIVw111xqOYajW0bQ+wm7IsBhA01kjHosJX044+A2bIVlcdgxHElQnUt
        1zFY6dPwsra/b9Xb
X-Received: by 10.99.65.196 with SMTP id o187mr19864372pga.193.1501611635390;
        Tue, 01 Aug 2017 11:20:35 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:b8e2:744f:de6d:a74e])
        by smtp.gmail.com with ESMTPSA id b87sm33620575pfd.33.2017.08.01.11.20.34
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 01 Aug 2017 11:20:34 -0700 (PDT)
Date:   Tue, 1 Aug 2017 11:20:33 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Paul Jolly <paul@myitcv.io>
Cc:     gitster@pobox.com, git@vger.kernel.org, jacob.keller@gmail.com
Subject: Re: [PATCH 3/2] ls-files: only recurse on active submodules
Message-ID: <20170801182033.GB110646@google.com>
References: <xmqqefwpdx9x.fsf@gitster.mtv.corp.google.com>
 <20170512162109.49752-1-paul@myitcv.io>
 <20170512172657.GA98586@google.com>
 <CACoUkn5fyk054BJ5e+C8KynYMJg=EkMLOTiZya8KTNZh+=u5dQ@mail.gmail.com>
 <20170512181950.GE98586@google.com>
 <CACoUkn7i76dEsQa3eoN+7WR8QmsD1pWsRQ0dvhkxzFN0sxTmRQ@mail.gmail.com>
 <20170801181820.GA110646@google.com>
 <CACoUkn46an6rStWhhJfgP-vbRU_+898S-TgDcefN3zL-jyDFJQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACoUkn46an6rStWhhJfgP-vbRU_+898S-TgDcefN3zL-jyDFJQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 08/01, Paul Jolly wrote:
> > It looks like it was merged to master.  This should be the relevant
> > commit: 188dce131 (ls-files: use repository object, 2017-06-22).
> 
> I was just typing a response to my response. Apologies, I was testing
> locally with the wrong compiled version of git.
> 
> Confirmed fixed for me in e2d9c4613 at least.

Perfect!  Glad to hear that it fixed the problem.

-- 
Brandon Williams
