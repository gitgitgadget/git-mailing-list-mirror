Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0E90E1FBF4
	for <e@80x24.org>; Mon, 30 Oct 2017 16:58:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932515AbdJ3Q6S (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Oct 2017 12:58:18 -0400
Received: from bitergia.com ([146.255.100.9]:43572 "EHLO bitergia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932361AbdJ3Q6Q (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Oct 2017 12:58:16 -0400
Received: from [192.168.1.38] (20.red-88-20-62.staticip.rima-tde.net [88.20.62.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by bitergia.com (Postfix) with ESMTPSA id C756A25C184;
        Mon, 30 Oct 2017 17:58:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=bitergia.com; s=mail;
        t=1509382695; bh=+N32iwW9mcR6dEPEHgAbbCLbtSCdQruVtLQyhHvI7cM=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=oA5pR/lUZnJ5I+YgdnImQEZjT6wxoNsl1uN1HlTF4knOkcYaz/17RPkiUkrcJkqXx
         M1keM2bQ8e7+1AWMNCqRP5cxec+lcU3z1UjA+WZ9XUHOy0Up9otjSv6VJOS0kpowT4
         5ikVCuovvd6FjGt/8J8KGbvdhNOpgLyxy4U8mgk8=
Message-ID: <1509382693.27976.15.camel@bitergia.com>
Subject: Re: Why does fetch-pack not works over http?
From:   Alvaro del Castillo <acs@bitergia.com>
To:     Andreas Schwab <schwab@linux-m68k.org>
Cc:     git@vger.kernel.org, sduenas@bitergia.com
Date:   Mon, 30 Oct 2017 17:58:13 +0100
In-Reply-To: <873764bwjd.fsf@linux-m68k.org>
References: <1509100979.32292.19.camel@bitergia.com>
         <873764bwjd.fsf@linux-m68k.org>
Organization: Bitergia
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.18.5.2-0ubuntu3.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Andreas,

El vie, 27-10-2017 a las 14:33 +0200, Andreas Schwab escribió:
> On Okt 27 2017, Alvaro del Castillo <acs@bitergia.com> wrote:
> 
> > 
> > We're wondering why "fetch-pack" (when is running from the command
> > line) doesn't handle "https://" protocol. It only works with
> > "git://".
> > 
> > For instance, this doesn't work:
> > 
> > $ git fetch-pack https://github.com/git/git refs/heads/master
> > fatal: I don't handle protocol 'https'
> > 
> > while this does:
> > 
> > $ git fetch-pack git://github.com/git/git refs/heads/master
> > 
> > The funny thing is that under the hood, "fetch" calls "fetch-pack"
> > using "https" procotol. Example of a trace below:
> > 
> > 12:03:07.512558 git.c:344               trace: built-in: git
> > 'fetch-
> > pack' '--stateless-rpc' '--stdin' '--lock-pack' '--thin' 'https://g
> > ithu
> > b.com/git/git/'
> With --stateless-rpc, fetch-pack doesn't do the connect itself, but
> expects the caller having set up a pipe to it.  The URL is then
> actually
> ignored.

Ok, I have understood that reading the git code but, is it possible to
create this pipe using command line? Or is that something designed to
be used inside the git execution?

Thanks!

> 
> Andreas.
> 

-- 
Alvaro del Castillo San Félix
acs@bitergia.com - Chief Technical Officer (CTO)
http://www.bitergia.com
"Software metrics for your peace of mind"



