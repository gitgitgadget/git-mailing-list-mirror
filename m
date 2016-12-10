Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5F8E2209B4
	for <e@80x24.org>; Sat, 10 Dec 2016 00:04:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752589AbcLJAEG (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Dec 2016 19:04:06 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:36350 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751745AbcLJAEF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Dec 2016 19:04:05 -0500
Received: by mail-pg0-f66.google.com with SMTP id x23so3697434pgx.3
        for <git@vger.kernel.org>; Fri, 09 Dec 2016 16:04:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fJW8iNY/C3ke0OytU7AoVu6s2vpSLk6qwqe5lbOoUqk=;
        b=dRK43YKReCSNd4wmCsHmDv6U70+VDJiu2ovdTXKzSHkyQOGyhPvwfOBM6wWrL/aFy3
         mARESTYmMXU0L6snsHNVZ/4EisW2UK5my24Rr3acUqPXt0Agfiw17GaMEsIwoRy4r0Pf
         5RDqoORskIKgjPWc9WiNVYOO8tlHVVOd4TM1nGpRmnt0dnbAHeBLwiGEkQLiwTT+BUGN
         ELTcn+fkMxCEV27BGvIT+AcsqwldREHAhl4Tr+f5VQzccwmsTBdZPzh3e70NRTYFdA2U
         cM2ZbALcbl9vkPEClJSRCUDgW6Fhue+4pNNu3CPMZ5Z0Pz/2ZMolE7flbaMYI4buB0E1
         NeYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fJW8iNY/C3ke0OytU7AoVu6s2vpSLk6qwqe5lbOoUqk=;
        b=lF6NG3NJNggfJVwlnT7XhPS3r70TziaSBj/B/WW4Fh9uQwVopjcKtnOjHHslna9mPz
         873Mcqqu5z+8q3eCRyWltHFgrm63X5N07XkVW8kgB2JzqBEmtrH/0ZPMDjVTi/4D7nG1
         3YL5zec2Ehm3x6thrQZYLRqP3pHmrYSUh1sNmSD2gaa47/+by8RJh3wKdYzs0Qnk8ZSn
         G6jjlqi/ajuaDW2dvCGmmZlBZcH4g7gp6f3FcKNCAzFhT0l2MBUlUco8qmItGJ9CErHc
         oeBPYUwiuPiZqO+p++04huA00H7r/tRLx3oP8425dL/KMWp46k/EJmYuwGmlCHjZqw3H
         ZQlg==
X-Gm-Message-State: AKaTC00CL43kI5SDOlygdKpbYZhP2OmSwlCZ8D/Zgv597NtuHa6isaDQvFKXMmem0ZGcRQ==
X-Received: by 10.99.36.65 with SMTP id k62mr146415119pgk.13.1481328244843;
        Fri, 09 Dec 2016 16:04:04 -0800 (PST)
Received: from gmail.com ([198.187.190.1])
        by smtp.gmail.com with ESMTPSA id c128sm59993007pfc.39.2016.12.09.16.04.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 09 Dec 2016 16:04:03 -0800 (PST)
Date:   Fri, 9 Dec 2016 16:03:59 -0800
From:   David Aguilar <davvid@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git ML <git@vger.kernel.org>
Subject: Re: [PATCH 2/3] difftool: chdir as early as possible
Message-ID: <20161210000359.4uypoxg67zlsthc7@gmail.com>
References: <20161209085848.10929-1-davvid@gmail.com>
 <20161209085848.10929-2-davvid@gmail.com>
 <xmqqbmwkr9ji.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqbmwkr9ji.fsf@gitster.mtv.corp.google.com>
User-Agent: NeoMutt/20161104 (1.7.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 09, 2016 at 03:02:09PM -0800, Junio C Hamano wrote:
> David Aguilar <davvid@gmail.com> writes:
> 
> > @@ -182,10 +188,6 @@ EOF
> >  		}
> >  	}
> >  
> > -	# Go to the root of the worktree so that the left index files
> > -	# are properly setup -- the index is toplevel-relative.
> > -	chdir($workdir);
> > -
> >  	# Setup temp directories
> >  	my $tmpdir = tempdir('git-difftool.XXXXX', CLEANUP => 0, TMPDIR => 1);
> >  	my $ldir = "$tmpdir/left";
> 
> What codebase are you basing your work on?  I do not see these
> removed four lines in my tree, so it seems that the patch is fixing
> up some other fix I do not yet have.

Sorry about that.

I forgot to mention that this is based on the patches I recently
sent, which were in the "pu" branch.  The whats-cooking report
mentioned that they'll be merged to "next", so they might be
there already too.

The patch this was based upon:

difftool: fix dir-diff index creation when in a subdirectory
-- 
David
