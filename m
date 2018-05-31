Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 042A41F42D
	for <e@80x24.org>; Thu, 31 May 2018 01:07:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932605AbeEaBHn (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 May 2018 21:07:43 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:46911 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932561AbeEaBHm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 May 2018 21:07:42 -0400
Received: by mail-pg0-f68.google.com with SMTP id a3-v6so8906025pgt.13
        for <git@vger.kernel.org>; Wed, 30 May 2018 18:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bwuilOMdgy2eRdF2iv8aQsfzLdZLTI9D/CWHcAvTTA8=;
        b=s9xAiN2y4zxeK4K9MTT3oaTZ3LT4vUoVusl36qW4pCLdG0iZhghj12A6mCzioq9Es2
         0qP8/tyBUqlEGiFGsg6YXTuV7UaRKWSqLj6A5SA96PznTQpfA8XmNvlKjFT2BrCb1qS0
         ooAE59R/vlVefP0tb4SwiZQzaeb5D4c6jzHWbTisKQjI1e6t0b9xsplYmkOdLAH+IZVI
         bTEbjBFhohKEF4a+qV0sL5qJQ6FaozIF7hgtgcxV4K3TTB2/f0Bh1zRL5tAlnhBBAx/a
         H1uWjZEHBcLyWqYDR50mximhwaNLHxFriJZ3QucR/TJB+HU3pGVyUyu4KZOgCxRfByvr
         /HrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bwuilOMdgy2eRdF2iv8aQsfzLdZLTI9D/CWHcAvTTA8=;
        b=rlObqjaHRZqMISm6KNsaS38qCpd/byesBIy6GmNXW4Hww7NTwXd5j1n0gqqwMaLKh/
         NTuNXkqyMOdYQV7+eSLorn5wKZcAWGQjKSjlHRyjN0WV8+LCwWR6mjczSxFQ7HW3MuF4
         96OiDfwzukeMQOTQmaP3RBkivMlh34sN64MNAAYB3SvzcCPfVIfS1/ZnSLQCg+LgQnUL
         tyPXsr/DiFOzZBzemCtpbXhyEhY6gUXXLAgrtspjJqvcHqvgZIdMfUERTwJHN9zi2bRx
         R3QiS1Vw8Hjpv398G2J1vdEVM8ITFLB2sjE8JvMvVMmuaFUbI/HLi37ogq1e7COF7edi
         jFhA==
X-Gm-Message-State: ALKqPweDQGeaJbjMO0QIi0TC5jBPHsdl3YEF7BxrPVWj3nJFZg6HcCTY
        C2MzhBPpW5wDblkZK+G8PpS38KgW
X-Google-Smtp-Source: ADUXVKI475jq3Zokp9VSHy1W99iBvc+KpIhGGFDU3kXHgXALqKn5lEXyhTkuHgOrgMeeqUD3c+78zA==
X-Received: by 2002:a63:82c7:: with SMTP id w190-v6mr3878291pgd.172.1527728861771;
        Wed, 30 May 2018 18:07:41 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id a5-v6sm80264152pff.8.2018.05.30.18.07.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 30 May 2018 18:07:40 -0700 (PDT)
Date:   Wed, 30 May 2018 18:07:39 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/2] refspec: consolidate ref-prefix generation logic
Message-ID: <20180531010739.GB36515@aiede.svl.corp.google.com>
References: <20180516225823.235426-1-bmwill@google.com>
 <20180516234822.182663-1-bmwill@google.com>
 <20180516234822.182663-2-bmwill@google.com>
 <20180531004309.GA36515@aiede.svl.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180531004309.GA36515@aiede.svl.corp.google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder wrote:
> Brandon Williams wrote:

>> When using protocol v2 a client constructs a list of ref-prefixes which
>> are sent across the wire so that the server can do server-side filtering
>> of the ref-advertisement.  The logic that does this exists for both
>> fetch and push (even though no push support for v2 currently exists yet)
>> and is roughly the same so lets consolidate this logic and make it
>> general enough that it can be used for both the push and fetch cases.
>>
>> Signed-off-by: Brandon Williams <bmwill@google.com>
>> ---
>>  builtin/fetch.c | 13 +------------
>>  refspec.c       | 29 +++++++++++++++++++++++++++++
>>  refspec.h       |  4 ++++
>>  transport.c     | 21 +--------------------
>>  4 files changed, 35 insertions(+), 32 deletions(-)
>
> I assume this is meant to be a refactoring with no functional change.
> Alas, it's causing fetch-by-SHA-1 to fail for me:
[...]
>  $ bin-wrappers/git -C /tmp/r -c protocol.version=2 fetch \
> 	https://kernel.googlesource.com/pub/scm/git/git \
> 	6373cb598e1a4e0340583ad75d5abba01ff79774
>  fatal: no matching remote head

Backtrace:

 #0  0x0000555555671e09 in fetch_pack (args=0x7fffffffda80, fd=0x555555a6a9b0, conn=0x555555a65780, ref=0x0, 
     dest=0x555555a64900 "https://kernel.googlesource.com/pub/scm/git/git", sought=0x555555a69a80, nr_sought=1, shallow=0x555555a6a9d8, 
     pack_lockfile=0x555555a631c8, version=protocol_v2) at fetch-pack.c:1562
 #1  0x00005555557290b9 in fetch_refs_via_pack (transport=0x555555a63190, nr_heads=1, to_fetch=0x555555a69a80) at transport.c:326
 #2  0x000055555572b712 in transport_fetch_refs (transport=0x555555a63190, refs=0x555555a65520) at transport.c:1247
 #3  0x000055555559a2a6 in fetch_refs (transport=0x555555a63190, ref_map=0x555555a65520) at builtin/fetch.c:942
 #4  0x000055555559ac3e in do_fetch (transport=0x555555a63190, rs=0x7fffffffdc30) at builtin/fetch.c:1157
 #5  0x000055555559b535 in fetch_one (remote=0x555555a63870, argc=1, argv=0x7fffffffdff8, prune_tags_ok=0) at builtin/fetch.c:1398
 #6  0x000055555559b9a3 in cmd_fetch (argc=1, argv=0x7fffffffdff8, prefix=0x0) at builtin/fetch.c:1487
 #7  0x000055555556764b in run_builtin (p=0x555555a0fa30 <commands+816>, argc=3, argv=0x7fffffffdff0) at git.c:350
 #8  0x000055555556795f in handle_builtin (argc=3, argv=0x7fffffffdff0) at git.c:565
 #9  0x0000555555567b07 in run_argv (argcp=0x7fffffffde8c, argv=0x7fffffffde80) at git.c:617
 #10 0x0000555555567cbc in cmd_main (argc=3, argv=0x7fffffffdff0) at git.c:694
 #11 0x000055555560774c in main (argc=8, argv=0x7fffffffdfc8) at common-main.c:45

Both refs_tmp and transport->remote_refs are NULL.

When refspec_ref_prefixes gets called, it produces the usual
argv_array with 6373cb598e1a4e0340583ad75d5abba01ff79774,
refs/6373cb598e1a4e0340583ad75d5abba01ff79774, etc.

In the old code, this doesn't happen because we trigger the
item->exact_sha1 test.

Would something like the following make sense?  It passes tests and
appears to avoid trouble but I haven't looked any closer than that.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>

--- i/refspec.c
+++ w/refspec.c
@@ -202,6 +202,8 @@ void refspec_ref_prefixes(const struct refspec *rs,
 		const struct refspec_item *item = &rs->items[i];
 		const char *prefix = NULL;
 
+		if (item->exact_sha1)
+			continue;
 		if (rs->fetch == REFSPEC_FETCH)
 			prefix = item->src;
 		else if (item->dst)
