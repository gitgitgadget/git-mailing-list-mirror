Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2124F202A5
	for <e@80x24.org>; Thu, 21 Sep 2017 21:56:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751792AbdIUVz7 (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Sep 2017 17:55:59 -0400
Received: from mail-pg0-f46.google.com ([74.125.83.46]:50679 "EHLO
        mail-pg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751763AbdIUVz6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Sep 2017 17:55:58 -0400
Received: by mail-pg0-f46.google.com with SMTP id p5so4237912pgn.7
        for <git@vger.kernel.org>; Thu, 21 Sep 2017 14:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RLs32gFLugPUWESz/5afdrt01NIRdEfJK7AyCXHz/bU=;
        b=RRdRcQoX2dS1HeDIrzWi69oN91c9kbfWLwt0AFCzU8GIjm1afJAW59ew4CLFhNw9mj
         7IVrVgTn0lFj1k+g6Dm/foyMWJnwN3lZzTiM3lpGZZiolmv01Ds2KmdJECe/GxYb+QCX
         6R+5H4YywhGltVWGpljJ7LlFEl0nh5VlWfTNWAslK2MlgMPh09oqX3MaT7kow8wcKNW0
         GCQR4sy3N5Ifgbhx8r1Mv5zHQl/Ii4Nfg+Y5FR9v9hdnSZRgg9ITSIRYgt4SHa17Eisq
         to8QbfjDnUhnLyNMV7DhkHQDWpbUpRl131SEidK2VaT6xysqelSkZc/tUDWoT4/lSNMt
         t7vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RLs32gFLugPUWESz/5afdrt01NIRdEfJK7AyCXHz/bU=;
        b=lMCUMwHAHQH3QS1kkKDXjIqmIvAdG2gixe2Qq1Piunzy60y3hZRo4QfneAo99UsCgE
         UCoDJQUgSw5pzvpr5bVLKqYPxnMFJ52YPe88ipFphOeSrw/+KuCXHrglpXbn6FQ22YNz
         C7GVp3mGZ07lY9+w6L4BKAldUT6tLAYpBCq1miMpUcCyNe3uYJAndWSRnvaQQL+s7GVQ
         GeAzdT7srLI+PQTEbE64cbVSFBljVQmvFjsM6czK+LhVN2T6INeWkb9VwrnlugubPBLc
         TWFZ0gT6Jz2KoDew515YTunj9kZgImArCDR3DDarYmo+BDRq0x/enX/8hhWRx3y5RlPp
         zVhA==
X-Gm-Message-State: AHPjjUgXDz/7niXBDjv15yQ8sfs5I0DetkkNJ0k82Xd2F0qCTbYmDmfS
        ezpu9+vtqtNnycIG17ZpsBxPog==
X-Google-Smtp-Source: AOwi7QAfMV3pjOR1yII8c2EX6/YA6Tx1WL8n5DHNnaEiqxSOfX2qCEgnSiy6Y80WJwRra+loaVNDcA==
X-Received: by 10.101.78.131 with SMTP id b3mr7155255pgs.28.1506030957768;
        Thu, 21 Sep 2017 14:55:57 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:1986:3ebf:8c68:2a02])
        by smtp.gmail.com with ESMTPSA id c2sm5662909pgq.61.2017.09.21.14.55.56
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 21 Sep 2017 14:55:56 -0700 (PDT)
Date:   Thu, 21 Sep 2017 14:55:55 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, peff@peff.net, sbeller@google.com,
        gitster@pobox.com, jrnieder@gmail.com, bturner@atlassian.com,
        git@jeffhostetler.com
Subject: Re: [PATCH 3/8] daemon: recognize hidden request arguments
Message-ID: <20170921215555.GA77641@google.com>
References: <20170913215448.84674-1-bmwill@google.com>
 <20170913215448.84674-4-bmwill@google.com>
 <20170920172443.6b42c9ba@twelve2.svl.corp.google.com>
 <20170920173120.2731e761@twelve2.svl.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170920173120.2731e761@twelve2.svl.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 09/20, Jonathan Tan wrote:
> On Wed, 20 Sep 2017 17:24:43 -0700
> Jonathan Tan <jonathantanmy@google.com> wrote:
> 
> > On Wed, 13 Sep 2017 14:54:43 -0700
> > Brandon Williams <bmwill@google.com> wrote:
> > 
> > > A normal request to git-daemon is structured as
> > > "command path/to/repo\0host=..\0" and due to a bug in an old version of
> > > git-daemon 73bb33a94 (daemon: Strictly parse the "extra arg" part of the
> > > command, 2009-06-04) we aren't able to place any extra args (separated
> > > by NULs) besides the host.
> > > 
> > > In order to get around this limitation teach git-daemon to recognize
> > > additional request arguments hidden behind a second NUL byte.  Requests
> > > can then be structured like:
> > > "command path/to/repo\0host=..\0\0version=1\0key=value\0".  git-daemon
> > > can then parse out the extra arguments and set 'GIT_PROTOCOL'
> > > accordingly.
> > 
> > A test in this patch (if possible) would be nice, but it is probably
> > clearer to test this when one of the commands (e.g. upload-pack) is
> > done. Could a test be added to the next patch to verify (using
> > GIT_TRACE_PACKET, maybe) that the expected strings are sent? Then
> > mention in this commit message that this will be tested in the next
> > patch too.
> 
> Ah, I see that it is tested in 6/8. You can ignore this comment.

Yeah I felt it would have been difficult to test any earlier without
both the client and server sides done.

-- 
Brandon Williams
