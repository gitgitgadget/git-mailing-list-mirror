From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] index-pack: correctly initialize appended objects
Date: Fri, 25 Jul 2008 15:15:48 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0807251513240.11976@eeepc-johanness>
References: <alpine.DEB.1.00.0807241821440.8986@racer> <7vy73q4jzp.fsf@gitster.siamese.dyndns.org> <20080725115519.GA32487@atjola.homenet>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="658432-828356703-1216991750=:11976"
Cc: Junio C Hamano <gitster@pobox.com>, Nicolas Pitre <nico@cam.org>,
	spearce@spearce.org, git@vger.kernel.org
To: =?ISO-8859-15?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jul 25 15:16:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMN9D-0000zZ-Os
	for gcvg-git-2@gmane.org; Fri, 25 Jul 2008 15:15:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751557AbYGYNOw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jul 2008 09:14:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752113AbYGYNOw
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Jul 2008 09:14:52 -0400
Received: from mail.gmx.net ([213.165.64.20]:49573 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751552AbYGYNOv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jul 2008 09:14:51 -0400
Received: (qmail invoked by alias); 25 Jul 2008 13:14:48 -0000
Received: from 88-107-142-10.dynamic.dsl.as9105.com (EHLO eeepc-johanness.st-andrews.ac.uk) [88.107.142.10]
  by mail.gmx.net (mp014) with SMTP; 25 Jul 2008 15:14:48 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18slZQUR1oslQijbr+ucWDIH8GZ7WygB7XcyZXrCI
	L0pXbm6Z2cVYcZ
X-X-Sender: user@eeepc-johanness
In-Reply-To: <20080725115519.GA32487@atjola.homenet>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90045>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--658432-828356703-1216991750=:11976
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT

Hi,

On Fri, 25 Jul 2008, Björn Steinbrink wrote:

> On 2008.07.24 22:21:14 -0700, Junio C Hamano wrote:
> > Reading get_data_from_pack(), it does rely on hdr_size, idx.offset and 
> > idx.offset of the next entry to be set correctly.  The function does 
> > not seem to use type (which the patch is also setting) nor real_type 
> > (which the patch does not set).
> 
> type is used in get_base_data().
> 
> > However, the code checks objects[nth].real_type all over the place in 
> > the code.  Doesn't the lack of real_type assignment in 
> > append_obj_to_pack() affect them in any way?
> 
> I had thought that resolve_delta() would set that, but it seems that we 
> never call that function like that. Hm...

So, let's add the comment as Nico suggested, and set real_type, too?  (And 
it would be smashing if you could verify that the type is indeed correctly 
set to non-delta...)

I think that setting real_type is necessary to have less surprises when 
the code is extended in the future.

Thanks,
Dscho

--658432-828356703-1216991750=:11976--
