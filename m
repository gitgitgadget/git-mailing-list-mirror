From: Sam Vilain <sam@vilain.net>
Subject: Re: [spf:guess] Re: [spf:guess] Re: Git import of the recent full
 enwiki dump
Date: Sat, 17 Apr 2010 15:34:52 +1200
Message-ID: <1271475292.3506.53.camel@denix>
References: <w2x2d460de71004161647z41492baav3685249fa05145d6@mail.gmail.com>
	 <m2ofabb9a1e1004161719h977b53b7oc2c452c2a2b0025e@mail.gmail.com>
	 <20100417004852.GA32053@post.servercare.de>
	 <20100417005342.GA8475@spearce.org>
	 <20100417010147.GB32053@post.servercare.de>
	 <1271468696.3302.35.camel@denix>
	 <20100417015857.GD32053@post.servercare.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Richard Hartmann <richih.mailinglist@gmail.com>,
	Git List <git@vger.kernel.org>,
	Avery Pennarun <apenwarr@gmail.com>,
	Nicolas Pitre <nico@fluxnic.net>
To: Sebastian Bober <sbober@servercare.de>
X-From: git-owner@vger.kernel.org Sat Apr 17 05:35:21 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O2yoR-0002vI-VM
	for gcvg-git-2@lo.gmane.org; Sat, 17 Apr 2010 05:35:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758732Ab0DQDfE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Apr 2010 23:35:04 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:39298 "EHLO mail.utsl.gen.nz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758727Ab0DQDfB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Apr 2010 23:35:01 -0400
Received: by mail.utsl.gen.nz (Postfix, from userid 1004)
	id E66C221C414; Sat, 17 Apr 2010 15:34:59 +1200 (NZST)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on
	mail.musashi.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00,
	FH_DATE_PAST_20XX autolearn=no version=3.2.5
Received: from [192.168.69.233] (203-97-235-49.cable.telstraclear.net [203.97.235.49])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.utsl.gen.nz (Postfix) with ESMTPSA id 24A5D21C389;
	Sat, 17 Apr 2010 15:34:54 +1200 (NZST)
In-Reply-To: <20100417015857.GD32053@post.servercare.de>
X-Mailer: Evolution 2.28.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145112>

On Sat, 2010-04-17 at 03:58 +0200, Sebastian Bober wrote:
> > Without good data set partitioning I don't think I see the above
> > workflow being as possible.  I was approaching the problem by first
> > trying to back a SQL RDBMS to git, eg MySQL or SQLite (postgres would be
> > nice, but probably much harder) - so I first set out by designing a
> > table store.  But the representation of the data is not important, just
> > the distributed version of it.
> 
> Yep, we had many ideas how to partition the data. All that was not tried
> up to now, because we had the hope to get it done the "straight" way.
> But that may not be possible.

I just don't think it's a practical aim or even useful.  Who really
wants the complete history of all wikipedia pages?  Only a very few -
libraries, national archives, and some collectors.

> We have tried checkpointing (even stopping/starting fast-import) every
> 10,000 - 100,000 commits. That does mitigate some speed and memory
> issues of fast-import. But in the end fast-import lost time at every
> restart / checkpoint.

One more thought - fast-import really does work better if you send it
all the versions of a blob in sequence so that it can write out deltas
the first time around.

Another advantage of the per-page partitioning is that they can
checkpoint/gc independently, allowing for more parallelization of the
job.

> > Actually this raises the question - what is it that you are trying to
> > achieve with this wikipedia import?
> 
> Ultimately, having a distributed Wikipedia. Having the possibility to
> fork or branch Wikipedia, to have an inclusionist and exclusionist
> Wikipedia all in one.

This sounds like far too much fun for me to miss out on, now downloading
enwiki-20100312-pages-meta-history.xml.7z :-) and I will give this a
crack!

Sam
