Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 519A420960
	for <e@80x24.org>; Fri, 14 Apr 2017 05:26:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751513AbdDNF00 (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Apr 2017 01:26:26 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:52512 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750750AbdDNF0Z (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Apr 2017 01:26:25 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 8524220960;
        Fri, 14 Apr 2017 05:26:24 +0000 (UTC)
Date:   Fri, 14 Apr 2017 05:26:24 +0000
From:   Eric Wong <e@80x24.org>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, jrnieder@gmail.com
Subject: Re: [PATCH 7/6] run-command: block signals between fork and execve
Message-ID: <20170414052624.GA815@starla>
References: <20170410234919.34586-1-bmwill@google.com>
 <20170413183252.4713-1-bmwill@google.com>
 <20170413211428.GA5961@whir>
 <20170414024202.GA27281@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170414024202.GA27281@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> wrote:
> On 04/13, Eric Wong wrote:
> > @@ -277,6 +278,8 @@ static void child_err_spew(struct child_process *cmd, struct child_err *cerr)
> >  		error_errno("exec '%s': cd to '%s' failed",
> >  			    cmd->argv[0], cmd->dir);
> >  		break;
> > +	case CHILD_ERR_SIGPROCMASK:
> > +		error_errno("sigprocmask failed restoring signals");
> 
> missing a break statement here I'll add it in, in the re-roll.

Good catch, thanks!

> >  	case CHILD_ERR_ENOENT:
> >  		error_errno("cannot run %s", cmd->argv[0]);
> >  		break;
