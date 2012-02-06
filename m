From: Jeff King <peff@peff.net>
Subject: Re: [bug] blame duplicates trailing ">" in mailmapped emails
Date: Sun, 5 Feb 2012 22:03:39 -0500
Message-ID: <20120206030339.GA29123@sigill.intra.peff.net>
References: <CAMP44s1gWNG+jJ6M7OnLS-1VA5YPa07LJfnrvdbsQb0MOJB7PA@mail.gmail.com>
 <7vhaz8vkhd.fsf@alter.siamese.dyndns.org>
 <CAMP44s0Fq_BGwcmDM5E1kWNiyoJw6e6Hr=8XaNF6tmQAcdnUmw@mail.gmail.com>
 <7vehuboe5g.fsf@alter.siamese.dyndns.org>
 <CAMP44s2QdJ4+qgg4fF5-DOWHx3Btd0pTivTT9s_E=qqxg16YLQ@mail.gmail.com>
 <20120204182611.GA31091@sigill.intra.peff.net>
 <7v39aphw85.fsf@alter.siamese.dyndns.org>
 <7vipjlezas.fsf@alter.siamese.dyndns.org>
 <20120205234750.GA28735@sigill.intra.peff.net>
 <7vehu8dcc8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 06 04:04:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RuEsH-0006TL-3u
	for gcvg-git-2@plane.gmane.org; Mon, 06 Feb 2012 04:04:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753224Ab2BFDDl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Feb 2012 22:03:41 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:58500
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752002Ab2BFDDl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Feb 2012 22:03:41 -0500
Received: (qmail 21995 invoked by uid 107); 6 Feb 2012 03:10:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 05 Feb 2012 22:10:47 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 05 Feb 2012 22:03:39 -0500
Content-Disposition: inline
In-Reply-To: <7vehu8dcc8.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190001>

On Sun, Feb 05, 2012 at 04:39:35PM -0800, Junio C Hamano wrote:

> > We could also go as far as saying that map_user would _always_ terminate
> > in this way (i.e., the caller gets a munged result, whether we found
> > anything or not). Then internally, map_user could be simplified to stop
> > worrying about making a temporary copy in mailbuf. And callers could
> > simply call map_user without worrying about branching on whether it
> > found anything or not.
> 
> I thought about it, but such a change needs to audit all the call sites
> that assumes the promise original map_user() used to make before it was
> broken. If we return 0 to the caller, the caller does not have to worry
> about map_user() munging the buffer it lent to it.
> 
> It might be a worthwhile thing to do. I dunno; I didn't look into it.

Ugh, yeah. I was thinking about how it would improve this call site, but
I don't want to get into auditing the others. Let's drop it and go with
your patch.

-Peff
