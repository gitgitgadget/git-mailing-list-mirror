From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC PATCH 0/4] Teach git fetch to verify signed tags
 automatically
Date: Fri, 28 Nov 2008 02:18:55 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0811280213140.30769@pacific.mpi-cbg.de>
References: <1227497000-8684-1-git-send-email-deskinm@umich.edu> <7v4p1xohbw.fsf@gitster.siamese.dyndns.org> <7vmyfpn10v.fsf@gitster.siamese.dyndns.org> <20081128000606.GB2759@euler>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Deskin Miller <deskinm@umich.edu>
X-From: git-owner@vger.kernel.org Fri Nov 28 02:12:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L5rtz-0005EZ-Jb
	for gcvg-git-2@gmane.org; Fri, 28 Nov 2008 02:12:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752689AbYK1BKq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Nov 2008 20:10:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752602AbYK1BKp
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Nov 2008 20:10:45 -0500
Received: from mail.gmx.net ([213.165.64.20]:33697 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752521AbYK1BKp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Nov 2008 20:10:45 -0500
Received: (qmail invoked by alias); 28 Nov 2008 01:10:42 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp039) with SMTP; 28 Nov 2008 02:10:42 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/zwYRhmTXz1dolR3ntoaPp5DVV0/JIRhbQMcxyxz
	sjhRdnuVgwfueC
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <20081128000606.GB2759@euler>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101853>

Hi,

On Thu, 27 Nov 2008, Deskin Miller wrote:

> This patch series mitigates this risk by trying to verify each signed 
> tag when it is first fetched.  Since, however, not everyone is concerned 
> with the security of signed tags, this feature tries to be conservative 
> insofar as signatures with public keys which are missing from the user's 
> keyring do not cause anything to be said about the tag's validity;

Now, in the context of security, this is not conservative.  Conservative 
would be to fail as soon as a signature could not be verified, be it that 
there is no key to match against, or that the signature is corrupt.

Your notion to fail silently if the necessary keys were not found makes 
your patch series rather useless, no?

After all, the whole idea is to let Git check if every signature is 
correct, and when Git does not fail, rely on them being valid.

So I think that the _only_ thing that would make sense is to fail _unless_ 
all the signatures were verified to be correct.

_That_ is why I want this feature to be off by default.

Ciao,
Dscho
