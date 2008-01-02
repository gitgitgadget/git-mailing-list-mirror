From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: input validation in receive-pack
Date: Wed, 2 Jan 2008 00:01:20 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0801012353580.13593@iabervon.org>
References: <20080101213451.GA26772@auto.tuwien.ac.at> <7vzlvp3oya.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Martin Koegler <mkoegler@auto.tuwien.ac.at>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 02 06:01:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J9vjg-0004I5-8T
	for gcvg-git-2@gmane.org; Wed, 02 Jan 2008 06:01:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750799AbYABFBW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jan 2008 00:01:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750781AbYABFBW
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Jan 2008 00:01:22 -0500
Received: from iabervon.org ([66.92.72.58]:45238 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750765AbYABFBV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jan 2008 00:01:21 -0500
Received: (qmail 25970 invoked by uid 1000); 2 Jan 2008 05:01:20 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 2 Jan 2008 05:01:20 -0000
In-Reply-To: <7vzlvp3oya.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69454>

On Tue, 1 Jan 2008, Junio C Hamano wrote:

> mkoegler@auto.tuwien.ac.at (Martin Koegler) writes:
> 
> > In the update code path, the check is done in refs.c:
> > | struct ref_lock *lock_any_ref_for_update(const char *ref, const unsigned char *old_sha1, int flags)
> > | {
> > |         if (check_ref_format(ref) == -1)
> > |                 return NULL;
> > |         return lock_ref_sha1_basic(ref, old_sha1, flags, NULL);
> > | }
> >
> > check_ref_format may also return -2 (less than two name levels) and -3
> > (* at the end), which are ignored. Is it really intended, that
> > receive-pack can create such refs.
> 
> Misconversion in 8558fd9ece4c8250a037a6d5482a8040d600ef47 that
> changed check_ref_format() without looking at what its callers
> are checking, I think.

When I got to it, it was already accepting -2. It clearly shouldn't accept 
-3 (and I don't know why I missed it; I was probably misinterpreting the 
original logic there.

	-Daniel
*This .sig left intentionally blank*
