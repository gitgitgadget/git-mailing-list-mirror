From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] upload-pack: add a trigger for post-upload-pack hook
Date: Wed, 26 Aug 2009 12:06:59 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0908261200160.4713@intel-tinevez-2-302>
References: <1250579093-40706-1-git-send-email-tom@mojombo.com> <12c267e40908251043g4f3e36aya05d9c705f5afee2@mail.gmail.com> <20090825184525.GC23731@coredump.intra.peff.net> <7vprajmp16.fsf@alter.siamese.dyndns.org> <alpine.DEB.1.00.0908261043140.4713@intel-tinevez-2-302>
 <7vr5uzeyl7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jeff King <peff@peff.net>, Tom Werner <mojombo@gmail.com>,
	Tom Preston-Werner <tom@mojombo.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 26 12:07:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MgFPN-000758-0a
	for gcvg-git-2@lo.gmane.org; Wed, 26 Aug 2009 12:07:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756615AbZHZKHB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Aug 2009 06:07:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755792AbZHZKHA
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Aug 2009 06:07:00 -0400
Received: from mail.gmx.net ([213.165.64.20]:39411 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754895AbZHZKHA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Aug 2009 06:07:00 -0400
Received: (qmail invoked by alias); 26 Aug 2009 10:07:00 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp045) with SMTP; 26 Aug 2009 12:07:00 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19lX/4N86RlWywSp4iUPyIvhbgW8Gr3k8KS/X1GDH
	N/8L1/EskvmPpi
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <7vr5uzeyl7.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.63
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127084>

Hi,

On Wed, 26 Aug 2009, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > On Tue, 25 Aug 2009, Junio C Hamano wrote:
> >
> >> and if one of the primary reason for this new hook is statistics, it 
> >> would be useful to see the number of bytes given, where the 
> >> fetch-pack came from, and if we are using git-daemon virtual hosting 
> >> which of our domain served the request.
> >
> > Certainly those are possible add-on patches, but would you require 
> > them to be in the same commit?
> 
> I was merely responding to the "what else would be useful" question posed
> by Peff.

Sure.

> Did you get an impression that I was saying "you must add these 
> otherwise I'll reject the patch"?

Well, I got the impression that you'd not accept the patch without 
additional information given by the hook, and I got the impression that 
Tom would decide as a consequence to rather live with his eternal fork 
instead of working on getting this patch included.

> It might make sense to define the external interface to be "information 
> is given through the standard input of the hook, formatted in YAML, and 
> here are the initial set of items that may be fed", so that we do not 
> have to worry about the details too much.

Hmm.  You bring up YAML a few times recently, it seems, but I think this 
is not what you are meaning.  In this case, you'd need to have a simple 
enquiry system that asks for some information and receives it as a 
response.

But I would find it utterly overengineered if upload-pack would support 
something as complicated as that.  IMHO either upload-pack knows already 
about the information, or the script has to try to discover it using Git 
commands itself.

My conclusion: I _think_ it would make sense to pass the name of the pack 
file(s) created by upload-pack to the hook, or something similar, but 
nothing more.  Well, _maybe_ the byte count of the protocol exchange and 
the IP.  But nothing that requires calculations.

Ciao,
Dscho
