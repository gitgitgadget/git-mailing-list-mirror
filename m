Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 13B361FF6D
	for <e@80x24.org>; Fri,  2 Dec 2016 18:37:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753302AbcLBShE (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Dec 2016 13:37:04 -0500
Received: from mail-pg0-f54.google.com ([74.125.83.54]:36326 "EHLO
        mail-pg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750942AbcLBShC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Dec 2016 13:37:02 -0500
Received: by mail-pg0-f54.google.com with SMTP id f188so109664315pgc.3
        for <git@vger.kernel.org>; Fri, 02 Dec 2016 10:36:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=P2NqNuGbGfFofzP8QCVvSTqze2xfbAqIEG8XsVmw76Q=;
        b=GRHA3q4Nj2Vk2WINQ2aMRbJMEHmaCm+g30WiYsbTpFEHbmBQ5W22UN/cBlCz9ep2Qv
         B9ydizs8i6hEF3zyNPqxceSYZC27+2yx9PfkPF8zfcSkyilhHyIBEbPcNPayQO8SvOwq
         iutSDPQ0HEfUmBPDHjUywlMGmAiw119Bn8DXmMVGEola4PBobhKGezGadBYbgJrMaHXT
         ZpIyZZmRnQSkfbQk71Od/HvmEn9/PDdLMEgSA7Xk3q0bPR3bQMIJg4M1h2IPGEDlstME
         zGNFzEy9zblKD6pOcRlPCq22z1tnEXRc5WjnnfzZBP6HwH6FaJ2cG0KiGOMF5fm/xrSw
         xLgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=P2NqNuGbGfFofzP8QCVvSTqze2xfbAqIEG8XsVmw76Q=;
        b=KULZmav9u365wHhjjFKv4rWAFRuJ9d15LTVjaZICtaxpKN0Z2qlO3N3J/AAyiG2ARS
         NtWbYGLoaiZ9PxWlrZNP1cQsBc9NVGE6nfS6dZ2UgcnG70aAPOMP9C9zvYMgiUSzKIUJ
         Ehmq5Slk1YyOmp176dZBAqOk3T4Wdfmm4P/2Iy5IMPK7z2laNfmtK3YJMtxu1np96zhB
         W5sN1PCw4sH6q6z9YlXRxwkIp4t4elnGrHy5b1QZ1m8lZ0rqNNlVGgfpbtyuN4LJtdc6
         CpsgGV039ji2s5LL5nE6jW76bHD0RWVwBIG9AC3reWB2Z5SUn90BEdhMXLua4RA/+SU3
         bnTA==
X-Gm-Message-State: AKaTC01XgQTTotoW9BEPGw1VqfaF1CuyDI6ByNiBi7tYT3b4Ce0u4g0gDpl+f8pHouKqGvN0
X-Received: by 10.98.71.218 with SMTP id p87mr46056590pfi.125.1480703784980;
        Fri, 02 Dec 2016 10:36:24 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:217c:34ba:fcf8:d822])
        by smtp.gmail.com with ESMTPSA id i194sm9324445pgc.46.2016.12.02.10.36.23
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 02 Dec 2016 10:36:23 -0800 (PST)
Date:   Fri, 2 Dec 2016 10:36:22 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Jeff King <peff@peff.net>
Cc:     Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH v6 1/6] submodules: add helper functions to determine
 presence of submodules
Message-ID: <20161202183622.GB117792@google.com>
References: <1480555714-186183-1-git-send-email-bmwill@google.com>
 <1480555714-186183-2-git-send-email-bmwill@google.com>
 <20161201042926.mr2qdta7hviizcya@sigill.intra.peff.net>
 <xmqqwpfja3nk.fsf@gitster.mtv.corp.google.com>
 <20161201190925.xi2z7vauxyf3yxyc@sigill.intra.peff.net>
 <20161201191603.GB54082@google.com>
 <20161201205444.GG54082@google.com>
 <20161201205944.2py2ijranq4g2wap@sigill.intra.peff.net>
 <CAGZ79kaqzssfN_bRQYpqC9HsKmyQZNCQcs+T5ke95Sf-C5PaRQ@mail.gmail.com>
 <20161201215934.g7dt5ioekmx6ssii@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161201215934.g7dt5ioekmx6ssii@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/01, Jeff King wrote:
> On Thu, Dec 01, 2016 at 01:56:32PM -0800, Stefan Beller wrote:
> 
> > > Bleh. Looks like it happens as part of the recently-added
> > > get_common_dir(). I'm not sure if that is ever relevant for submodules,
> > > but I guess in theory you could have a submodule clone that is part of a
> > > worktree?
> > 
> > Sure we can, for a test that we don't have that, see the embedgitdirs series. ;)
> > 
> > For now each submodule has its own complete git dir, but the vision
> > would be to have a common git dir for submodules in the common
> > superprojects git dir as well, such that objects are shared actually. :)
> 
> Fair enough. Given that it seems to behave OK even in error cases, the
> simple stat() test may be the best option, then. I do think we should
> consider adding a few test cases to make sure it continues to behave in
> the error cases (just because we are relying partially on what git's
> setup code happens to do currently, and we'd want to protect ourselves
> against regressions).

For the naive (ie me), is there a reason why real_path() couldn't be
re-implemented to avoid using chdir?  I tried looking into the history of
the function but couldn't find anything explaining why it was done that
way.  I assume it has to do with symlinks, but I thought there was a
syscall (readlink?) that could do the resolution.

-- 
Brandon Williams
