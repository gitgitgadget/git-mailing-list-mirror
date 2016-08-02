Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B6E892021F
	for <e@80x24.org>; Tue,  2 Aug 2016 22:26:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756107AbcHBW0Y (ORCPT <rfc822;e@80x24.org>);
	Tue, 2 Aug 2016 18:26:24 -0400
Received: from smtprelay0250.hostedemail.com ([216.40.44.250]:46224 "EHLO
	smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753011AbcHBW0W (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 2 Aug 2016 18:26:22 -0400
Received: from filter.hostedemail.com (unknown [216.40.38.60])
	by smtprelay06.hostedemail.com (Postfix) with ESMTP id 976CC9EA11;
	Tue,  2 Aug 2016 22:26:20 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: day67_714b6d0619316
X-Filterd-Recvd-Size: 3374
Received: from XPS-9350.home (unknown [96.251.125.34])
	(Authenticated sender: joe@perches.com)
	by omf11.hostedemail.com (Postfix) with ESMTPA;
	Tue,  2 Aug 2016 22:26:18 +0000 (UTC)
Message-ID: <1470176777.3998.203.camel@perches.com>
Subject: Re: get_maintainer.pl and .mailmap entries with more than 2
 addresses
From:	Joe Perches <joe@perches.com>
To:	Florian Mickler <florian@mickler.org>
Cc:	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>, git <git@vger.kernel.org>,
	mchehab@s-opensource.com
Date:	Tue, 02 Aug 2016 15:26:17 -0700
In-Reply-To: <6A56763C-D795-4943-AFE9-8A53ECD61AF6@mickler.org>
References: <1470155781.3998.181.camel@perches.com>
	 <6A56763C-D795-4943-AFE9-8A53ECD61AF6@mickler.org>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.18.5.2-0ubuntu3 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Wed, 2016-08-03 at 00:17 +0200, Florian Mickler wrote:
> cc'd mchehab@s-opensource.com  (Mauro, is your kernel.org address up?)
> 
>  Am Tue, 02 Aug 2016 09:36:21 -0700
> schrieb Joe Perches <joe@perches.com>:
> 
> > 
> > Hello Florian.
> > There is at least an oddity with get_maintainer handling of a
> > .mailmap entry form.
> > 
> > For instance:
> > 
> > Mauro's .mailmap entry is:
> > Mauro Carvalho Chehab <mchehab@kernel.org> <maurochehab@gmail.com>
> > <mchehab@infradead.org> <mchehab@redhat.com> <m.chehab@samsung.com>
> > <mchehab@osg.samsung.com> <mchehab@s-opensource.com>
> > 
> > Is this a valid form?
> > 
> > get_maintainer output for Mauro is:
> > 
> > $ ./scripts/get_maintainer.pl drivers/media/ -f
> > Mauro Carvalho Chehab <mchehab@kernel.org> <maurochehab@gmail.com>
> > <mchehab@infradead.org> <mchehab@redhat.com> <m.chehab@samsung.com>
> > <mchehab@osg.samsung.com> (maintainer:MEDIA INPUT INFRASTRUCTURE
> > (V4L/DVB))
> > 
> > I believe the Mauro's and Shuah's .mailmap entries are improper and
> > should be changed, but I'm not completely aware of git .mailmap
> > handling and the documentation seems weakly specified.
> > 
> Hmm.. looking at Mauros last .mailmap commit it seems like your patch is
> ok for Mauro. 
> 
> Although <mywing81@gmail.com> and <mchehab@brturbo.com.br> are probably
> missing? (@Mauro) 
> 
> 
> $ git shortlog | grep "^Mauro C"
> Mauro Carvalho Chehab (4404):
> $ git log | grep "^Author:.*Mauro Carvalho Chehab" | sort | uniq -c
>       2 Author: Mauro Carvalho Chehab <maurochehab@gmail.com>
>     146 Author: Mauro Carvalho Chehab <mchehab@brturbo.com.br>
>     645 Author: Mauro Carvalho Chehab <mchehab@infradead.org>
>     794 Author: Mauro Carvalho Chehab <mchehab@osg.samsung.com>
>    2015 Author: Mauro Carvalho Chehab <mchehab@redhat.com>
>     448 Author: Mauro Carvalho Chehab <m.chehab@samsung.com>
>     353 Author: Mauro Carvalho Chehab <mchehab@s-opensource.com>
>       1 Author: Mauro Carvalho Chehab <mywing81@gmail.com>
> 
> 
> 
> Anyway, from a technical viewpoint your patches seem to fix
> the .mailmap entry as the author intended. (See Junio's Email for the
> documantation part) 
> But I would wait for the ack from Mauro and Shuah. 

As far as I understand, a single entry with just their
name and preferred email address would work too because
the name parts are all spelled identically.


