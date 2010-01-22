From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH] Handle double slashes in make_relative_path()
Date: Fri, 22 Jan 2010 22:11:14 +0100
Message-ID: <201001222211.14743.trast@student.ethz.ch>
References: <379d55c6a4110736aadb8ace3b050de879a9deab.1264118830.git.trast@student.ethz.ch> <7vpr52gbmu.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri Jan 22 22:11:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NYQmz-0005nZ-Bt
	for gcvg-git-2@lo.gmane.org; Fri, 22 Jan 2010 22:11:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754510Ab0AVVL0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Jan 2010 16:11:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754506Ab0AVVLZ
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Jan 2010 16:11:25 -0500
Received: from gwse.ethz.ch ([129.132.178.237]:12523 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754492Ab0AVVLX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jan 2010 16:11:23 -0500
Received: from CAS00.d.ethz.ch (129.132.178.234) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.2.213.0; Fri, 22 Jan
 2010 22:11:15 +0100
Received: from thomas.localnet (217.162.250.31) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.213.0; Fri, 22 Jan
 2010 22:11:15 +0100
User-Agent: KMail/1.13.0 (Linux/2.6.31.8-0.1-desktop; KDE/4.4.59; x86_64; ; )
In-Reply-To: <7vpr52gbmu.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137783>

On Friday 22 January 2010 02:40:41 Junio C Hamano wrote:
> 
> Now what is the goal of this patch?  To allow people to have duplicated
> slashes at random places in either abs or base, or is it only interested
> in a particular input that is malformed?  If the latter, what is the
> permitted non-canonical input?
> 
> If abs were "/a//b/c" and base were "/a/b", then the combination is
> rejected by prefixcmp() and full "/a//b/c" is returned.  Is it the
> intended behaviour of the patch?
> 
> I would actually have expected to see [a real fix that handles
> duplicate slashes in all instances.]

It's not about *permitted* input; the problem is simply that the
current function gives back *bogus* paths, which causes git to fail.
So I only went for the minimal patch to fix this.

Not handling the abs="/a//b/c" base="/a/b" case seemed ok to me since
that was never turned as a relative "c", hence there would not be any
speed loss (nor gain) from my patch.

Does that answer the question?

As for your patch, thanks for coming up with a real fix.  I read the
amended version, and it seems correct to me.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
