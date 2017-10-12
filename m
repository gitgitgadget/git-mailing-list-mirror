Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 351301FF32
	for <e@80x24.org>; Thu, 12 Oct 2017 03:17:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752440AbdJLDRG (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Oct 2017 23:17:06 -0400
Received: from mail-pf0-f182.google.com ([209.85.192.182]:48835 "EHLO
        mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752029AbdJLDRG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Oct 2017 23:17:06 -0400
Received: by mail-pf0-f182.google.com with SMTP id b79so3056736pfk.5
        for <git@vger.kernel.org>; Wed, 11 Oct 2017 20:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Mmrt7eT0IKTJDXQ06eJNnidd/w1ylElGjENk9fAZcqM=;
        b=p8GHla7GFGnAC6rADtg+AsgfgymgqgN7Kmh4QBE+BBo4GQZlCUOnD3T66HOpF8RN7h
         9aoiI97S80Wk8fvAJXIj/94ZiRNoGOBf720K2ksmOtVgA5Bfw+8TClJiK92FtUbCHt8D
         diMR5kJCNw3VcB7a7YnHzAbbbpnLscP5W7jpbdeERVQqIkT1QPc7GwbhWFbPipqNk69o
         PxEJDS9EbKheTSu3i7b0S48kElNQcK3tiHhctaTGpQvJ30eMETpiQJqXQSn/bC64alFS
         BjJZWyN3wRxsh9QDozfrCQLfPR5kIqlkSXbZVi8PMlkpmFzE7sfGkfjvMVAcfP/lL1mH
         YQyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Mmrt7eT0IKTJDXQ06eJNnidd/w1ylElGjENk9fAZcqM=;
        b=IXggePmF1yC1f9HOwLCquCclmUdRkJ5gmYydIcntEAD+zgYMR1LeJdmmzWnHObf+Hb
         8dbHWtgKB910aHDybO8oaVaQxIqbhw2/p3cE189wnnhVUYg9rn7oB6mEveSPadNmhfTK
         hwV2tG5hDmUd/0/lwZlEYch1UtQhyitP93UERhZCTfqh7Y8LQjiRbhgNM1SVCVU49tdc
         wcLRm8+MFoVAURYaCuhN8eZCdCP2GeFm6TK8WyJDQLPcJIb2jaboVvKvIMeO+5LRsfdv
         hn2T1eQ+6polce3/gtQM7AaEbHjXi9fKxk2sDKrkZd3HjnDtL0FUYc4EQi0DuMCpamtd
         Wj7A==
X-Gm-Message-State: AMCzsaUy8FZZRaJenbnhklhrCfvz0KJ1GEFKCCfNM5G/S/vp0vIJ0KNe
        KYR3zJB0YwEORDoNNMPUcps=
X-Google-Smtp-Source: AOwi7QDSKsrFOXvkqgcWzgHRHkNLt3262yzKqT1POCl03SLiKOtUyjdAOFRUPpqMk788DIwjZmQz2A==
X-Received: by 10.84.252.136 with SMTP id y8mr942526pll.137.1507778225348;
        Wed, 11 Oct 2017 20:17:05 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:9e:660c:b9bb:a349])
        by smtp.gmail.com with ESMTPSA id l85sm27076639pfg.155.2017.10.11.20.17.04
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 11 Oct 2017 20:17:04 -0700 (PDT)
Date:   Wed, 11 Oct 2017 20:17:03 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Andreas Krey <a.krey@gmx.de>
Cc:     Git Users <git@vger.kernel.org>
Subject: Re: git repack leaks disk space on ENOSPC
Message-ID: <20171012031702.GB155740@aiede.mtv.corp.google.com>
References: <20171011150546.GC32090@inner.h.apk.li>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171011150546.GC32090@inner.h.apk.li>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Andreas,

Andreas Krey wrote:

> I observed (again) an annoying behavior of 'git repack':

Do you have context for this 'again'?  E.g. was this discussed
previously on-list?

> When the new pack file cannot be fully written because
> the disk gets full beforehand, the tmp_pack file isn't
> deleted, meaning the disk stays full:
>
>   $ df -h .; git repack -ad; df -h .; ls -lart .git/objects/pack/tmp*; rm .git/objects/pack/tmp*; df -h .
>   Filesystem                        Size  Used Avail Use% Mounted on
>   /dev/mapper/vg02-localworkspaces  250G  245G  5.1G  98% /workspaces/calvin
>   Counting objects: 4715349, done.
>   Delta compression using up to 8 threads.
>   Compressing objects: 100% (978051/978051), done.
>   fatal: sha1 file '.git/objects/pack/tmp_pack_xB7DMt' write error: No space left on device
>   Filesystem                        Size  Used Avail Use% Mounted on
>   /dev/mapper/vg02-localworkspaces  250G  250G   20K 100% /workspaces/calvin
>   -r--r--r-- 1 andrkrey users 5438435328 Oct 11 17:03 .git/objects/pack/tmp_pack_xB7DMt
>   rm: remove write-protected regular file '.git/objects/pack/tmp_pack_xB7DMt'? y
>   Filesystem                        Size  Used Avail Use% Mounted on
>   /dev/mapper/vg02-localworkspaces  250G  245G  5.1G  98% /workspaces/calvin
>
> git version 2.15.0.rc0

I can imagine this behavior of retaining tmp_pack being useful for
debugging in some circumstances, but I agree with you that it is
certainly not a good default.

Chasing this down, I find:

  pack-write.c::create_tmp_packfile chooses the filename
  builtin/pack-objects.c::write_pack_file writes to it and the .bitmap, calling
  pack-write.c::finish_tmp_packfile to rename it into place

Nothing tries to install an atexit handler to do anything special to it
on exit.

The natural thing, I'd expect, would be for pack-write to use the
tempfile API (see tempfile.h) to create and finish the file.  That way,
we'd get such atexit handlers for free.  If we want a way to keep temp
files for debugging on abnormal exit, we could set that up separately as
a generic feature of the tempfile API (e.g. an envvar
GIT_KEEP_TEMPFILES_ON_FAILURE), making that an orthogonal topic.

Does using create_tempfile there seem like a good path forward to you?
Would you be interested in working on it (either writing a patch with
such a fix or a test in t/ to make sure it keeps working)?

Thanks,
Jonathan
