Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.2 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 997881F453
	for <e@80x24.org>; Mon, 22 Oct 2018 23:51:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726073AbeJWIMR (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Oct 2018 04:12:17 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38637 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725752AbeJWIMR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Oct 2018 04:12:17 -0400
Received: by mail-pf1-f194.google.com with SMTP id v11-v6so145362pfn.5
        for <git@vger.kernel.org>; Mon, 22 Oct 2018 16:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cJuq06ztM1WF7KxQw5iM1FBwgsNX3dIrWq5kPMLW+aQ=;
        b=U9XUaecvw9oTGkIvKJHy2wvmiyGO4foX/7fPQha8re0oRw5//3H7EklEz5tuf+PVd+
         tLTmWhJG4sklAuHbcKupOBQ5jya/XVeosB/6mW0HNuPtRZXpx5NpxkSzK07yaDc4rJUt
         Jr4C7L1WeTIt2u2xzziejGCwepOp5TJ2yLSQpmzI5barkUWed6qZzJ941ajIqTesCKvD
         UF0fQU9lT9otQZDrwHy0xZJBQ3+n5tDRuyr+14quAoN5DMFWc5ABI25s3gvTmpOelguV
         PVhp5O8ziDIekchOWEjnVtE+71XTlsbyElMZRfVuouuzPValsyI97zmrocU7rcDF0iOi
         9Fag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=cJuq06ztM1WF7KxQw5iM1FBwgsNX3dIrWq5kPMLW+aQ=;
        b=jhUD22/cpBWi6TsJB/pV90K3cXH6dnnmIkrRRtiydvRU6xsg28rw4bsqqeShUISqiE
         q6joDEvXQmpoFThmYx5ieRNaVMht5RINTNvPWcgDCTD/37dSN0G1Cnx4fHhAT/wPoK3m
         Kcb3USbbbLc7cdJ0wHjEtO7WGHlRgnpgcyAQAYYqKBrPE8ECBRPRExKheKEhimC/e3Nl
         bl9MguzXr8cE4xpjmwLA3bdGdToQJ7Emm2BLLDHqXuD9OZUtd0G+cMCBslDj5EMlE1pG
         E8f8o3TiG1mMEcU1v7Hnuqw20J7st4pXgi3IcgAg+Sv6+17xpge+omWaxFFGAB2YYHjC
         XVJw==
X-Gm-Message-State: ABuFfohKK4M24nBniSXC0ttZIPSPKopJXxnM+3B76arFR4YdC67iVke0
        Z3ccl+MPUHek57An4nmqEdvK9A==
X-Google-Smtp-Source: ACcGV62YDF4GsnLeeB7Lfv2wqysbw8g5uP2VifYhcQgTLNQhBPtr2EaqEES7wKaDuDYAphIVcji2Bg==
X-Received: by 2002:a62:7e81:: with SMTP id z123-v6mr47395663pfc.139.1540252292860;
        Mon, 22 Oct 2018 16:51:32 -0700 (PDT)
Received: from google.com ([2620:0:100e:913:5bb:3076:546:99b0])
        by smtp.gmail.com with ESMTPSA id w10-v6sm23735409pfg.1.2018.10.22.16.51.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 22 Oct 2018 16:51:31 -0700 (PDT)
Date:   Mon, 22 Oct 2018 16:51:27 -0700
From:   Josh Steadmon <steadmon@google.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH v2] archive: initialize archivers earlier
Message-ID: <20181022235127.GE233961@google.com>
Mail-Followup-To: Jeff King <peff@peff.net>, git@vger.kernel.org,
        gitster@pobox.com
References: <cover.1539990488.git.steadmon@google.com>
 <bc6f20274dfe11f1451745e0accb065544cc59ca.1540244445.git.steadmon@google.com>
 <20181022223536.GB19019@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181022223536.GB19019@sigill.intra.peff.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2018.10.22 18:35, Jeff King wrote:
> On Mon, Oct 22, 2018 at 02:48:11PM -0700, steadmon@google.com wrote:
> 
> > Initialize archivers as soon as possible when running git-archive and
> > git-upload-archive. Various non-obvious behavior depends on having the
> > archivers initialized, such as determining the desired archival format
> > from the provided filename.
> > 
> > Since 08716b3c11 ("archive: refactor file extension format-guessing",
> > 2011-06-21), archive_format_from_filename() has used the registered
> > archivers to match filenames (provided via --output) to archival
> > formats. However, when git-archive is executed with --remote, format
> > detection happens before the archivers have been registered. This causes
> > archives from remotes to always be generated as TAR files, regardless of
> > the actual filename (unless an explicit --format is provided).
> > 
> > This patch fixes that behavior; archival format is determined properly
> > from the output filename, even when --remote is used.
> > 
> > Signed-off-by: Josh Steadmon <steadmon@google.com>
> > Helped-by: Jeff King <peff@peff.net>
> 
> Thanks, this looks good overall.
> 
> A few minor comments (that I'm not even sure are worth re-rolling for):
> 
> > diff --git a/builtin/upload-archive.c b/builtin/upload-archive.c
> > index 25d9116356..3f35ebcfe8 100644
> > --- a/builtin/upload-archive.c
> > +++ b/builtin/upload-archive.c
> > @@ -43,6 +43,7 @@ int cmd_upload_archive_writer(int argc, const char **argv, const char *prefix)
> >  	}
> >  
> >  	/* parse all options sent by the client */
> > +	init_archivers();
> >  	return write_archive(sent_argv.argc, sent_argv.argv, prefix,
> >  			     the_repository, NULL, 1);
> >  }
> 
> This seems to separate the comment from what it describes. Any reason
> not to just init_archivers() closer to the top of the function here
> (probably after the enter_repo() call)?

Ack, fixed.


> > diff --git a/t/t5000-tar-tree.sh b/t/t5000-tar-tree.sh
> > index 2a97b27b0a..3e95fdf660 100755
> > --- a/t/t5000-tar-tree.sh
> > +++ b/t/t5000-tar-tree.sh
> > @@ -206,6 +206,12 @@ test_expect_success 'git archive with --output, override inferred format' '
> >  	test_cmp_bin b.tar d4.zip
> >  '
> >  
> > +test_expect_success GZIP 'git archive with --output and --remote uses expected format' '
> > +	git archive --output=d5.tgz --remote=. HEAD &&
> > +	gzip -d -c < d5.tgz > d5.tar &&
> > +	test_cmp_bin b.tar d5.tar
> > +'
> 
> This nicely tests the more-interesting tgz case. But unfortunately it
> won't run on machines without the GZIP prerequisite. I'd think that
> would really be _most_ machines, but is it worth having a separate zip
> test to cover machines without gzip? I guess that just creates the
> opposite problem: not everybody has ZIP.

Added a test to compare the file lists from the .zip file to the
reference .tar file. I'm not sure if this is the best way to do things,
but it at least verifies that a .zip is produced. However, it's brittle
if the output of "zip -sf" changes. Let me know if you have a better
idea.
