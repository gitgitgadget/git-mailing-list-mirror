From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: fetch_refs_via_pack() discards status?
Date: Wed, 5 Dec 2007 14:16:04 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0712051356040.5349@iabervon.org>
References: <b8bf37780711211659i4d621533o6a3b97349bb75f8c@mail.gmail.com>
 <20071122160959.GA3411@steel.home> <b8bf37780711221427q5dda709dt38ce1837c0e56c1f@mail.gmail.com>
 <b8bf37780711251339y796286fbj2cd8d9225008e13@mail.gmail.com>
 <7v3aunqvha.fsf_-_@gitster.siamese.dyndns.org> <7vk5nt1v7k.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 05 20:16:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IzzjY-0007a0-9r
	for gcvg-git-2@gmane.org; Wed, 05 Dec 2007 20:16:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751968AbXLETQI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Dec 2007 14:16:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751943AbXLETQH
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Dec 2007 14:16:07 -0500
Received: from iabervon.org ([66.92.72.58]:41097 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751936AbXLETQG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Dec 2007 14:16:06 -0500
Received: (qmail 27747 invoked by uid 1000); 5 Dec 2007 19:16:04 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 5 Dec 2007 19:16:04 -0000
In-Reply-To: <7vk5nt1v7k.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67182>

On Tue, 4 Dec 2007, Junio C Hamano wrote:

> The code calls fetch_pack() to get the list of refs it fetched, and
> discards refs and always returns 0 to signal success.
> 
> But builtin-fetch-pack.c::fetch_pack() has error cases.  The function
> returns NULL if error is detected (shallow-support side seems to choose
> to die but I suspect that is easily fixable to error out as well).
> 
> Shouldn't fetch_refs_via_pack() propagate that error to the caller?

I think that's right. I think I got as far as having the error status from 
fetch_pack() actually returned correctly, and then failed to look at it. 
I'd personally avoid testing a pointer to freed memory, but that's 
obviously not actually wrong.

	-Daniel
*This .sig left intentionally blank*
