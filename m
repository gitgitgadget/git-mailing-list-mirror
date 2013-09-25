From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: Local tag killer
Date: Wed, 25 Sep 2013 18:54:10 -0400 (EDT)
Message-ID: <alpine.LFD.2.03.1309251834210.312@syhkavp.arg>
References: <52327E62.2040301@alum.mit.edu>
 <CAPc5daXvCf90WYoUWC+DxRyZEQhXGL7Bd_ZJKwfoqxeKt8TADQ@mail.gmail.com>
 <xmqqd2o3p0nk.fsf@gitster.dls.corp.google.com> <523D3FD2.4090002@alum.mit.edu>
 <20130924075119.GD7257@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	=?ISO-8859-15?Q?Carlos_Mart=EDn_Nieto?= <cmn@elego.de>,
	Michael Schubert <mschub@elegosoft.com>,
	Johan Herland <johan@herland.net>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Sep 26 00:54:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VOxyK-0001mS-Nw
	for gcvg-git-2@plane.gmane.org; Thu, 26 Sep 2013 00:54:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755373Ab3IYWyM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Sep 2013 18:54:12 -0400
Received: from relais.videotron.ca ([24.201.245.36]:15598 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753991Ab3IYWyM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Sep 2013 18:54:12 -0400
Received: from yoda.home ([70.83.209.44]) by VL-VM-MR006.ip.videotron.ca
 (Oracle Communications Messaging Exchange Server 7u4-22.01 64bit (built Apr 21
 2011)) with ESMTP id <0MTP00CNIEABZ840@VL-VM-MR006.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 25 Sep 2013 18:54:11 -0400 (EDT)
Received: from xanadu.home (xanadu.home [192.168.2.2])	by yoda.home (Postfix)
 with ESMTPSA id C728E2DA045F; Wed, 25 Sep 2013 18:54:10 -0400 (EDT)
In-reply-to: <20130924075119.GD7257@sigill.intra.peff.net>
User-Agent: Alpine 2.03 (LFD 1266 2009-07-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235379>

On Tue, 24 Sep 2013, Jeff King wrote:

> On Sat, Sep 21, 2013 at 08:42:26AM +0200, Michael Haggerty wrote:
> 
> > I think it would be preferable if "--prune" would *not* affect tags, and
> > if there were an extra option like "--prune-tags" that would have to be
> > used explicitly to cause tags to be pruned.  Would somebody object to
> > such a change?
> 
> I think most of this problem is the way that we fetch tags straight into
> the refs/tags hierarchy. You would not do:
> 
>   [remote "origin"]
>   fetch = +refs/heads/*:refs/heads/*
>   prune = true
> 
> unless you wanted to be a pure-mirror, because you would hose your local
> changes any time you fetched. But that is _exactly_ what we do with a
> refs/tags/*:refs/tags/* fetch.
> 
> If we instead moved to a default fetch refspec more like:
> 
>   [remote "origin"]
>   fetch = +refs/*:refs/remotes/origin/refs/*
> 
> Then everything would Just Work. If you prune what the other side has
> locally, that's fine. All you're doing is pruning your view of what he
> has, not anything you've done locally.
> 
> The tricky part is tweaking the lookup rules so that "origin/master"
> still works, and that looking for "v1.0" checks both refs/tags and
> refs/remotes/*/refs/tags. And of course managing backwards
> compatibility. :)

Cheers !!!

I remember participating to a discussion about this like 2.5 years ago:

http://news.gmane.org/group/gmane.comp.version-control.git/thread=165799

The flat tag namespace remains my major annoyance with git IMHO.


Nicolas
