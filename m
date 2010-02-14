From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [RFC PATCH] ls-tree: dump full tree if it was named as such
Date: Sun, 14 Feb 2010 17:33:52 +0100
Message-ID: <201002141733.53137.trast@student.ethz.ch>
References: <f3e853a9329a68cc9b1d544b204ed6a0469b10a2.1265644609.git.trast@student.ethz.ch> <7vpr4fo85r.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Feb 14 17:36:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NghSF-0000qy-Om
	for gcvg-git-2@lo.gmane.org; Sun, 14 Feb 2010 17:36:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751450Ab0BNQeQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Feb 2010 11:34:16 -0500
Received: from gwse.ethz.ch ([129.132.178.237]:45325 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750995Ab0BNQeQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Feb 2010 11:34:16 -0500
Received: from CAS00.d.ethz.ch (129.132.178.234) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.2.234.1; Sun, 14 Feb
 2010 17:34:16 +0100
Received: from thomas.localnet (217.162.250.31) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.234.1; Sun, 14 Feb
 2010 17:33:53 +0100
User-Agent: KMail/1.13.0 (Linux/2.6.31.12-0.1-desktop; KDE/4.4.0; x86_64; ; )
In-Reply-To: <7vpr4fo85r.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139924>

[I noticed only just now that you only sent this to me.  Accidentally
I suppose?]

On Monday 08 February 2010 20:10:40 Junio C Hamano wrote:
> 
> This obviously was meant to be used with the full tree recorded by a
> commit and what you are seeing (e.g. cd to "valgrind" that is not even
> tracked, and pretend HEAD:t were the full contents---the full contents of
> the tree limited to the work tree location "valgrind" is shown) is an
> artifact of that.
> 
> I think the right solution is along the lines of --full-tree option to
> allow people (i.e. scripts) to ask for the exact tree contents without any
> funny path limiting based on the location in the work tree.  They can
> apply whatever path limiting from the command line, e.g. by running
> 
>     git ls-tree --full-tree HEAD:t valgrind
> 
> instead of running
> 
>     mkdir -p valgrind && cd valgrind && git ls-tree HEAD:t
> 
> when they want to apply path limit to the ls-tree output.

I guess in the (very) long run, the scripts should be forced to always
use --full-tree so that we can eventually make it the default?

I'm just not sure how the existing behaviour could ever be useful,
though admittedly 'git ls-tree $(git write-tree)' would change
semantics if you're in a subdirectory.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
