Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A5C051F935
	for <e@80x24.org>; Tue, 20 Sep 2016 11:08:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932167AbcITLHn (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Sep 2016 07:07:43 -0400
Received: from [80.67.18.44] ([80.67.18.44]:47044 "EHLO
        smtprelay02.ispgateway.de" rhost-flags-FAIL-FAIL-OK-OK)
        by vger.kernel.org with ESMTP id S1752463AbcITLHm (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 20 Sep 2016 07:07:42 -0400
X-Greylist: delayed 53942 seconds by postgrey-1.27 at vger.kernel.org; Tue, 20 Sep 2016 07:07:42 EDT
Received: from [91.63.252.67] (helo=book.hvoigt.net)
        by smtprelay02.ispgateway.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.84)
        (envelope-from <hvoigt@hvoigt.net>)
        id 1bmItB-0007Qe-TV; Tue, 20 Sep 2016 13:07:02 +0200
Date:   Tue, 20 Sep 2016 13:07:00 +0200
From:   Heiko Voigt <hvoigt@hvoigt.net>
To:     Jonas Thiel <jonas.lierschied@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: Re: Homebrew and Git
Message-ID: <20160920110700.GB64315@book.hvoigt.net>
References: <trinity-9c8f1bd1-d6be-48f3-8575-03be09bd1243-1474213828361@3capp-gmx-bs53>
 <20160920110228.GA64315@book.hvoigt.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160920110228.GA64315@book.hvoigt.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 20, 2016 at 01:02:28PM +0200, Heiko Voigt wrote:
> Hi,
> 
> On Sun, Sep 18, 2016 at 05:50:28PM +0200, Jonas Thiel wrote:
> > A while ago I have described my problem with Homebrew at the following
> > GitHub channel
> > (https://github.com/Homebrew/homebrew-core/issues/2970). In the
> > meanwhile, I believe that I my problem with Homebrew is based on an
> > issues with my Git. I have found the attached Git Crash reports on my
> > Mac and because I am not familiar with reading/analysing Crash
> > Reports, it would be great if someone could give me some feedback on
> > it.
> >  
> > If you have any question, please do not hesitate to contact me.
> 
> From your crash reports I see that git is apparently crashing in a
> strchr() call from within ident_default_email() which is a function that
> tries to assemble a name and email to put into your commits.

BTW, here is the callstack inlined from the crashreport:

bsystem_platform.dylib      	0x00007fff840db41c _platform_strchr$VARIANT$Haswell + 28
1   git                           	0x000000010ba1d3f4 ident_default_email + 801
2   git                           	0x000000010ba1d68f fmt_ident + 66
3   git                           	0x000000010ba4b495 files_log_ref_write + 175
4   git                           	0x000000010ba4b0a6 commit_ref_update + 106
5   git                           	0x000000010ba4c3a8 ref_transaction_commit + 468
6   git                           	0x000000010b994dd8 s_update_ref + 271
7   git                           	0x000000010b994556 fetch_refs + 1969
8   git                           	0x000000010b9935f2 fetch_one + 1913
9   git                           	0x000000010b992bc4 cmd_fetch + 549
10  git                           	0x000000010b9666c4 handle_builtin + 478
11  git                           	0x000000010b96602f main + 376
12  libdyld.dylib                 	0x00007fff834ef5ad start + 1

Maybe someone else has an idea what might be causing this...

Cheers Heiko
