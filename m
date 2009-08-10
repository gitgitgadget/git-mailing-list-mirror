From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] fix potential infinite loop given large unsigned
 integer
Date: Mon, 10 Aug 2009 18:53:34 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0908101850570.8324@intel-tinevez-2-302>
References: <a3f15ee60908082141l7b2134cg5ddcef17c45fc888@mail.gmail.com>  <7v3a81a13z.fsf@alter.siamese.dyndns.org>  <40aa078e0908090525h7b4d6efeh658e2edcfbe16c7e@mail.gmail.com>  <200908100724.53345.chriscool@tuxfamily.org> 
 <40aa078e0908100412l3c2afd1bnda9b10aaf1de383f@mail.gmail.com>  <alpine.DEB.1.00.0908101421340.8324@intel-tinevez-2-302> <a3f15ee60908100917k2a2d6de7ndd5e4ddd1d926cc3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-883654123-1249923215=:8324"
Cc: Erik Faye-Lund <kusmabite@googlemail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Ryan Flynn <parseerror@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 10 18:53:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MaY82-00021P-B0
	for gcvg-git-2@gmane.org; Mon, 10 Aug 2009 18:53:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932211AbZHJQxg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Aug 2009 12:53:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755366AbZHJQxg
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Aug 2009 12:53:36 -0400
Received: from mail.gmx.net ([213.165.64.20]:47557 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754990AbZHJQxg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Aug 2009 12:53:36 -0400
Received: (qmail invoked by alias); 10 Aug 2009 16:53:35 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp051) with SMTP; 10 Aug 2009 18:53:35 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+5xI1s+iC5ZHkgYizu2zytNFq0FrQmBZrGJ5qjc2
	uO6YmYgxPERj4j
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <a3f15ee60908100917k2a2d6de7ndd5e4ddd1d926cc3@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125487>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-883654123-1249923215=:8324
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT

Hi,

[please cull the quoted text to what you are actually replying to.  
Thanks]

On Mon, 10 Aug 2009, Ryan Flynn wrote:

> On Mon, Aug 10, 2009 at 8:24 AM, Johannes
> Schindelin<Johannes.Schindelin@gmx.de> wrote:
> >
> > static unsigned int digits_of_number(unsigned int number) {
> >     unsigned int result;
> >     for (result = 1; number; number /= 10, result++)
> >         ; /* do nothing */
> >     return result;
> > }
> 
> whoops, actually yours: digits_of_number(1) -> 2

static unsigned int digits(unsigned int number)
{
        unsigned int result;
        for (result = 1; (number /= 10); result++)
                ; /* do nothing */
        return result;
}

I'm sorry, I forgot the "something like this" in my mail.

This version is actually tested.

It has non-optimal runtime, but then, it does not really matter.

Ciao,
Dscho
--8323329-883654123-1249923215=:8324--
