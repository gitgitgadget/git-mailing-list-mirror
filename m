Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E7FFB1F406
	for <e@80x24.org>; Tue, 12 Dec 2017 14:14:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752299AbdLLOOE (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Dec 2017 09:14:04 -0500
Received: from washoe.dartmouth.edu ([129.170.30.229]:40649 "EHLO
        smtp.onerussian.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751643AbdLLOOD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Dec 2017 09:14:03 -0500
Received: from c-76-24-253-1.hsd1.nh.comcast.net ([76.24.253.1] helo=localhost)
        by smtp.onerussian.com with esmtpsa (TLS1.2:RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <yoh@onerussian.com>)
        id 1eOlJo-0000OV-W8; Tue, 12 Dec 2017 09:14:02 -0500
Date:   Tue, 12 Dec 2017 09:13:55 -0500
From:   Yaroslav Halchenko <yoh@onerussian.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>, kyle@kyleam.com,
        Jeff King <peff@peff.net>
Message-ID: <20171212141355.7hcuegaopb6hee2l@hopa.kiewit.dartmouth.edu>
References: <20171211211102.rrxqd6yscnd33efd@hopa.kiewit.dartmouth.edu>
 <20171211225615.GC214273@aiede.mtv.corp.google.com>
 <xmqqtvww3gea.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqtvww3gea.fsf@gitster.mtv.corp.google.com>
X-URL:  http://www.onerussian.com
X-Image-Url: http://www.onerussian.com/img/yoh.png
X-PGP-Key: http://www.onerussian.com/gpg-yoh.asc
X-fingerprint: C5B9 05F0 E8D9 FD96 68FF  366F A2DE 2350 62DA 33FA
User-Agent: NeoMutt/20170609 (1.8.3)
X-SA-Exim-Connect-IP: 76.24.253.1
X-SA-Exim-Rcpt-To: gitster@pobox.com, jrnieder@gmail.com, git@vger.kernel.org, kyle@kyleam.com, peff@peff.net
X-SA-Exim-Mail-From: yoh@onerussian.com
Subject: Re: Q: rational for $XDG_CONFIG_HOME/git/config to be "non global"
 or just a bug?
X-SA-Exim-Version: 4.2.1 (built Mon, 26 Dec 2011 16:57:07 +0000)
X-SA-Exim-Scanned: Yes (on smtp.onerussian.com)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, 11 Dec 2017, Junio C Hamano wrote:

> Jonathan Nieder <jrnieder@gmail.com> writes:

> > I think the documentation

> > 	~/.gitconfig
> > 		User-specific configuration file. Also called "global"
> > 		configuration file.

> > should be clarified --- e.g. it could say

> > 	$XDG_CONFIG_HOME/git/config
> > 	~/.gitconfig
> > 		User-specific configuration files. Because options in
> > 		these files are not specific to any repository, thes
> > 		are sometimes called global configuration files.

> Yeah, I think that makes sense.

> > As for "git config --global", I think the best thing would be to split
> > it into two options: something like "git config --user" and "git
> > config --xdg-user".  That way, it is unambiguous which configuration
> > file the user intends to inspect or modify.  When a user calls "git
> > config --global" and both files exist, it could warn that the command
> > is ambiguous.

> > Thoughts?

> I actually thought that the plan was "you either have this, or the
> other one, never both at the same time" (and I think those who
> pushed the XDG thing in to the system made us favor it over the
> traditional one).  So as long as --global updates the one that
> exists, and updates XDG one when both or neither do, I think we
> should be OK.  And from that viewpoint, we definitely do not want
> two kinds of --global to pretend as if we support use of both at the
> same time.

note that atm $XDG_CONFIG_HOME/git/config is read as --global iff
~/.gitconfig is absent and read always without --global.  So it is
flipping between "global" and "some kind of non-global but user-specific
configuration file" (so sounds like  a global to me ;) )

-- 
Yaroslav O. Halchenko
Center for Open Neuroscience     http://centerforopenneuroscience.org
Dartmouth College, 419 Moore Hall, Hinman Box 6207, Hanover, NH 03755
Phone: +1 (603) 646-9834                       Fax: +1 (603) 646-1419
WWW:   http://www.linkedin.com/in/yarik        
