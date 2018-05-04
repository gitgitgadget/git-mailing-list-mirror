Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 139AF200B9
	for <e@80x24.org>; Fri,  4 May 2018 21:03:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751704AbeEDVDu (ORCPT <rfc822;e@80x24.org>);
        Fri, 4 May 2018 17:03:50 -0400
Received: from mail-pg0-f52.google.com ([74.125.83.52]:38821 "EHLO
        mail-pg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751629AbeEDVDt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 May 2018 17:03:49 -0400
Received: by mail-pg0-f52.google.com with SMTP id n9-v6so16225301pgq.5
        for <git@vger.kernel.org>; Fri, 04 May 2018 14:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5H/Ii95ZvjTVp2LpjSDw1uCLOikt7fJo7Y8fP2xXaTY=;
        b=krXemI0lxlkEvawbvZCJHpIxQLAVaqkohc7XOaWdueK2gaWDw5PT8/1G3ZxSGkzXd1
         Hw4U0K9ZodIFS3XnbXm3BEDBLtjl32fqe0GafbXeJ5yx6Thq4v+DSGlIMzUdwsvlizNE
         XoL6gC2Ck2TyHGQXg2pDm96mDmAUcPJ+9L4QXnVzVWo4hSyp7eaRdN3Bgz8w560B94fK
         b30XIaEmUjajpZRFqXnS9R3CtgTmE7NnkknudJGJrtWgt7BheSgrUv/TVNPVSl7M56ac
         6MlLer7ELLRDw3HafX+LvpQDIDIQZmNfQxG5/DFDgUydGYThz/+4wnE43Y3ryFau+RPd
         gHag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5H/Ii95ZvjTVp2LpjSDw1uCLOikt7fJo7Y8fP2xXaTY=;
        b=YmBFtGWiEZT41uhXjYToPf06Nd/rAMhoLHXl/EuQjvzX0M64AJnHbTbGis4F63R2Cf
         Y3cUm0uvh/QsgdvT/la3sEWySpT3ycnYa/hid0TRJTS9e7aV1rjoib6K26Y6v3eqG5Xg
         xF+SsIkPN56wlNgkqFQaMHOCkNuNqk+Q+1IDGpzlkSzXAN1KObFG2dxMSVBd5iquSoR2
         EapnIbfGeN1vGQIXhkJPzY1MStfi4tAO+zbNyKhjJ2YCo0pZQQJSYqEZ+L8hgGYEt4V7
         MWqOqruMfJ4PXhD+/JPJxN/NX3Zl5tAl6ZLgP0Twfz78YJw88ZaAnMYodCsNjOgvbRwr
         U5Sw==
X-Gm-Message-State: ALQs6tBHg9mZZXmOkTvxbrkAdAsmPGwy8DaSWv8YPKE+mrcmhxODYA06
        zyIXaN2YlG6Cs6fNlfvWBHi+zW+MsCE=
X-Google-Smtp-Source: AB8JxZqYQgTH+InetVe33u9cxzbgQT3yjdePWzuC22p0fV2nYt6aDdsBIVW+IjG5dt3XK0GNJJ+7/A==
X-Received: by 2002:a17:902:9898:: with SMTP id s24-v6mr29219102plp.51.1525467828725;
        Fri, 04 May 2018 14:03:48 -0700 (PDT)
Received: from twelve3.svl.corp.google.com ([2620:0:100e:422:ffac:c1d4:4bf7:bb93])
        by smtp.gmail.com with ESMTPSA id y2-v6sm24969773pgp.92.2018.05.04.14.03.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 04 May 2018 14:03:47 -0700 (PDT)
Date:   Fri, 4 May 2018 14:03:46 -0700
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>
Subject: Re: [PATCH 1/5] submodule foreach: correct '$path' in nested
 submodules from a subdirectory
Message-Id: <20180504140346.f088452c4a73539ef140a1da@google.com>
In-Reply-To: <CAGZ79kYq0Qs7tvG0NEYwKHeYxF_tN1-eZA2skdjCiDZ4JkyuRQ@mail.gmail.com>
References: <20180503005358.89082-1-sbeller@google.com>
        <20180503005358.89082-2-sbeller@google.com>
        <20180503104754.6aefd8ba38eb5a8871281b01@google.com>
        <CAGZ79kYq0Qs7tvG0NEYwKHeYxF_tN1-eZA2skdjCiDZ4JkyuRQ@mail.gmail.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 3 May 2018 11:12:27 -0700
Stefan Beller <sbeller@google.com> wrote:

> >> There are three different possible solutions that have more value:
> >> (a) The path value is documented as the path from the toplevel of the
> >>     superproject to the mount point of the submodule. If 'the' refers to
> >>     the superproject holding this submodule ('sub' holding 'nested'),
> >>     the path would be expected to be path='nested'.
> >
> > What is "the", and why is it quoted?
> 
> because it is unclear what is emphasizes.
> It could be the intermediate (direct) superproject, or it
> could be the topmost superproject (where the command was run from).
> 
> Just having "the", makes it unclear which of both it refers to.

Ah, I see - so s/'the'/'the superproject'/

> >> (b) In case 'the' superproject is referring to the toplevel, which
> >>     is the superproject in which the original command was invoked,
> >>     then path is expected to be path='sub/nested'.

And here, s/'the' superproject/'the superproject'/

> > Same comment about "the", and I think s/toplevel, which is the
> > superproject in which the original command was invoked/outermost
> > superproject/.
> 
> The outermost superproject may not be the one you invoke the
> command in.

Good point. Maybe "the superproject the original command was run from",
but I'm open to a better name. So I would write the beginning as
follows:

  <your first paragraph starting with "When running">

  Also, in git-submodule.txt, $path is documented to be the "name of the
  submodule directory relative to the superproject", but "the
  superproject" is ambiguous.

  To resolve both these issues, we could:
  (a) Change "the superproject" to "its immediate superproject", so
      $path would be "nested" instead of "../nested".
  (b) Change "the superproject" to "the superproject the original
      command was run from", so $path would be "sub/nested" instead of
      "../nested".
  (c) Change "the superproject" to "the directory the original command
      was run from", so $path would be "../sub/nested" instead of
      "../nested".

Going back to the original patch:

> The behavior for (c) was introduced in 091a6eb0fe (submodule: drop the
> top-level requirement, 2013-06-16) the intent for $path seemed to be
> relative to $cwd to the submodule worktree, but that did not work for
> nested submodules, as the intermittent submodules were not included in
> the path.

The (c) behavior was never really introduced, right? 091a6eb0fe
attempted to introduce (c), but it didn't work when --recursive was
specified.
