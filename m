Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EA37720401
	for <e@80x24.org>; Wed, 21 Jun 2017 21:20:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752461AbdFUVUe (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Jun 2017 17:20:34 -0400
Received: from mail-pg0-f42.google.com ([74.125.83.42]:33317 "EHLO
        mail-pg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751154AbdFUVUc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jun 2017 17:20:32 -0400
Received: by mail-pg0-f42.google.com with SMTP id f127so5466466pgc.0
        for <git@vger.kernel.org>; Wed, 21 Jun 2017 14:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wfMuzL47InbAeq1Ms8Ant3GGwO0lgFkHdq1PdP3rUHE=;
        b=mCTU3I1trJDE2i3QNFvLQQKpy2FFOgy3DbPBD8SUx1t/k20iHZbyQU0sEaAp+DQQYd
         jjJiZUNEQ7OorUQeWchriF58hBhiruLbh7hZ8FMynbycR0kUEo5yUywMo+oUWi6+1vcx
         gRj9E5+4yAlyWjOt1Fh9dC99OF4KmK03BdCF3994Vm88s2wXFUAmiw1dktlP7Gjd/4fb
         NZgURKon98E1OrwsaHUMd66obvfYeo/wC277sQwsCH+zv6QuDNW2UeM7W12531qZ0r23
         34nrA7kq5D10Q9OkRwq/9U/3mDPJM7l05q4R7TnTe7zDivF28yreHE4jxKadRS0Yipe+
         OjDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wfMuzL47InbAeq1Ms8Ant3GGwO0lgFkHdq1PdP3rUHE=;
        b=Qy07R5T8apwSTv0d8Er68go0RqAV1WOc3/wbSCNgny/rffvqfBsuES16hONibAGNw2
         GGrlCvzeDr2scjztK+3jT3tJIUgYQyY3hS7NBm7eVR3iALzt8P7wxrEEnwzDdQj/aJVf
         ikUUDOFE9P4lpkDMmYhOzyMQK0DXViQ5CzSwfxuyuo2tB3gO6jCMCcjgXTgtCtOKdBM9
         e6R63DSO9kT4vQVp0JnodNAP+dLITw5UGTk7uAY+DptPnPyQbwrVwQxKPZnUqv+Mlwbj
         NsnrgGYMfb0hnrUK30U3DxXRSUaiQKEFPENDJZ62UGmF7ekdeNf8TwpkriMX2d9QkFK6
         aVTQ==
X-Gm-Message-State: AKS2vOxX8o31ObTJvlYHNTtOjFVm+gTzFY+TE2xi7HirF9Is1q4evH6/
        ji3do+E368n+KiBF36gBHw==
X-Received: by 10.99.122.13 with SMTP id v13mr27443065pgc.156.1498080022043;
        Wed, 21 Jun 2017 14:20:22 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:d052:1af5:b2b3:bc81])
        by smtp.gmail.com with ESMTPSA id b86sm37153349pfc.27.2017.06.21.14.20.20
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 21 Jun 2017 14:20:21 -0700 (PDT)
Date:   Wed, 21 Jun 2017 14:20:19 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, sbeller@google.com, jrnieder@gmail.com,
        jacob.keller@gmail.com, Johannes.Schindelin@gmx.de,
        sandals@crustytoothpaste.net, peartben@gmail.com,
        pclouds@gmail.com, gitster@pobox.com, peff@peff.net,
        git@jeffhostetler.com, avarab@gmail.com
Subject: Re: [PATCH v3 10/20] path: convert do_git_path to take a 'struct
 repository'
Message-ID: <20170621212019.GB53348@google.com>
References: <20170608234100.188529-1-bmwill@google.com>
 <20170620191951.84791-1-bmwill@google.com>
 <20170620191951.84791-11-bmwill@google.com>
 <20170620152308.42984ee7@twelve2.svl.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170620152308.42984ee7@twelve2.svl.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 06/20, Jonathan Tan wrote:
> On Tue, 20 Jun 2017 12:19:41 -0700
> Brandon Williams <bmwill@google.com> wrote:
> 
> > +static void do_git_path(const struct repository *repo,
> > +			const struct worktree *wt, struct strbuf *buf,
> >  			const char *fmt, va_list args)
> >  {
> >  	int gitdir_len;
> > -	strbuf_addstr(buf, get_worktree_git_dir(wt));
> 
> With this change, the get_worktree_git_dir() function no longer seems to
> be used from outside - could it be marked static?

Probably?  But you could argue that it is ok to be part of the public
API.  As in it may be ok to leave as is because some future caller may
want it at some point.

> 
> > +	strbuf_worktree_gitdir(buf, repo, wt);
> >  	if (buf->len && !is_dir_sep(buf->buf[buf->len - 1]))
> >  		strbuf_addch(buf, '/');
> >  	gitdir_len = buf->len;
> >  	strbuf_vaddf(buf, fmt, args);
> > -	adjust_git_path(buf, gitdir_len);
> > +	adjust_git_path(repo, buf, gitdir_len);
> >  	strbuf_cleanup_path(buf);
> >  }

-- 
Brandon Williams
