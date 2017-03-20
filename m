Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 67C7B2095B
	for <e@80x24.org>; Mon, 20 Mar 2017 22:34:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753629AbdCTWe0 (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Mar 2017 18:34:26 -0400
Received: from mail-pf0-f179.google.com ([209.85.192.179]:33807 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753273AbdCTWeZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Mar 2017 18:34:25 -0400
Received: by mail-pf0-f179.google.com with SMTP id p189so48523871pfp.1
        for <git@vger.kernel.org>; Mon, 20 Mar 2017 15:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=X7fiFK9gDIgG0oVJ8lXm4vSApG/wBk7reDWWWn4tDVI=;
        b=PlGTj5vx007w+TiD96YcqrMfYgLP4Y9bTxPRCyTqYBU77f+x+mwl85iKP/5INQPwEe
         idOCxyUgBEhfBNXFcH6/9AMJB/6pbBIBfXTHAOA6FedBGumtzulx1APrrlB1YTBMSq5y
         jZpYWuHDYxIrY0vDovFmsbxg129l1lhtPraVXmPWGnZEZlYhmrJivwNlhrYyaAgJ63uf
         0dXXvJktIawP5XmrKX+eN3sSplY920WK1HwRu8rZ5QimCvlrxUvFQpYYaobg8bZlNNlZ
         OnclhVRT+tpz8fphW12GpgJskvKP1Z5tBK5LN4IAd2IwjkZyGRgSpQlPal9RuC6PispW
         mAsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=X7fiFK9gDIgG0oVJ8lXm4vSApG/wBk7reDWWWn4tDVI=;
        b=rP3+GnEC6zjv6Z9A1hwEKV5nKvF6uFnjbcQCjX3c3dzNE4LlhajNXYFx/m2gT/g7sF
         elM8ZxR2joJcCMP1vMyVYiHoX75LM665K+vltbkQeUnij/tdwi576GfnU051U9umSlMa
         vdsz4qJ1Om3IuWlUJMDDu/yp1/pYT5lusu9+zeJnN5wWarGpA7x4lCE217N28RM/+CeO
         1PVJrKQDZoOCVL0xjvWxHc6cV2r/E8YxsL6HrQSr272N/jRxxrl661/Ps2gP9htqCIlB
         ni2AI98J3yqiCkchP+bqSUL6f3e9rVr31xWzR01JcXTGnAiDv2piOUgF8Xk4LFmK4rxN
         VOew==
X-Gm-Message-State: AFeK/H3zfJH/2kklQ8jBumyGTIhuDpQvJn5cKFuwfncbTFS9UOLrcXcjumLf5fGeIzv+m5PK
X-Received: by 10.98.11.8 with SMTP id t8mr35662230pfi.195.1490049261171;
        Mon, 20 Mar 2017 15:34:21 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b10:5dcb:9513:dc80:9079])
        by smtp.gmail.com with ESMTPSA id t82sm1245051pgb.13.2017.03.20.15.34.19
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 20 Mar 2017 15:34:20 -0700 (PDT)
Date:   Mon, 20 Mar 2017 15:34:18 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Stefan Beller <sbeller@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v3 2/5] setup: allow for prefix to be passed to git
 commands
Message-ID: <20170320223418.GB188475@google.com>
References: <20170314221100.24856-1-bmwill@google.com>
 <20170317172257.4690-1-bmwill@google.com>
 <20170317172257.4690-3-bmwill@google.com>
 <CAGZ79kZAZeb5rsL80dty_tRM5SDCAXVq_yATpDQREq_vV4Yj+Q@mail.gmail.com>
 <xmqq60j77lx3.fsf@gitster.mtv.corp.google.com>
 <20170317192103.GE110341@google.com>
 <xmqqy3w363yx.fsf@gitster.mtv.corp.google.com>
 <20170317210031.GA63813@google.com>
 <xmqqinn761f7.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqinn761f7.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/17, Junio C Hamano wrote:
> Brandon Williams <bmwill@google.com> writes:
> 
> > I don't think that prefix can ever have ".." in it.  From what I
> > understand it is always a path from the root of the repository to the
> > cwd that the git command was invoked by.  So in your example prefix
> > would be "src/".
> 
> The prefix would be NULL or "", as you will be at the root-level of
> the working tree when you are running _IN_ the submodule (by
> recursing into it).  Not src/, nor anything with ../ in it, I would
> think.

Yes, the prefix that is found during setup of a submodule process would
be NULL or "" as the command would be invoked from the root of that
repository.  This series would sort of change that though.

If a command was invoked from 'src/' with a pathspec of '../dir/' and
there is a submodule at 'dir/sub', the process working on the submodule
will have the following:

super_prefix = 'dir/sub/'
prefix = 'src/' (Passed from the parent process via the
                 GIT_INTERNAL_TOPLEVEL_PREFIX env var)
pathspec = '../dir/'

With that information the child process will be able to properly resolve
the pathspec to be 'dir/' (using the prefix) and will be able to match
against it by pre-pending the super_prefix (e.g. dir/sub/some/file, where
some/file is a file in the submodule).  It will also be able to generate
correct output relative to the directory the command was originally
invoked from by first pre-pending the super_prefix so we have
'dir/sub/some/file' and then calling relative_path() with the prefix
that was passed in such that the output for this file looks like
'../dir/sub/some/file'

That the gist of how I'm hoping to solve the problem.  Hopefully that was
clear enough to get some feedback on.

-- 
Brandon Williams
