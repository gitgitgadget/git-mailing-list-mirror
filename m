From: Sergei Organov <osv@javad.com>
Subject: Re: [PATCH 3/4] git.el: Check for existing buffers on revert.
Date: Fri, 08 Feb 2008 17:30:02 +0300
Message-ID: <87ve4zzfkl.fsf@osv.gnss.ru>
References: <87r6fporp3.fsf@wine.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Alexandre Julliard <julliard@winehq.org>
X-From: git-owner@vger.kernel.org Fri Feb 08 15:31:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNUFj-0007a7-Gx
	for gcvg-git-2@gmane.org; Fri, 08 Feb 2008 15:30:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757071AbYBHOaX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Feb 2008 09:30:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757090AbYBHOaX
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Feb 2008 09:30:23 -0500
Received: from javad.com ([216.122.176.236]:4415 "EHLO javad.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757065AbYBHOaW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Feb 2008 09:30:22 -0500
Received: from osv ([87.236.81.130])
	by javad.com (8.11.6/8.11.0) with ESMTP id m18EU9d98689;
	Fri, 8 Feb 2008 14:30:10 GMT
	(envelope-from s.organov@javad.com)
Received: from osv by osv with local (Exim 4.63)
	(envelope-from <s.organov@javad.com>)
	id 1JNUEs-00086D-Ta; Fri, 08 Feb 2008 17:30:02 +0300
In-Reply-To: <87r6fporp3.fsf@wine.dyndns.org> (Alexandre Julliard's message of "Thu\, 07 Feb 2008 13\:51\:20 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73096>

Alexandre Julliard <julliard@winehq.org> writes:
> Refuse to revert a file if it is modified in an existing buffer but
> not saved.

What's the point? What if I do want to have modified buffer and still
revert the on-disk file? Why git-revert cares to the level of
prohibiting this?

Besides, it's inconsistent with the rest of Emacs, I think, as in
similar situations Emacs usually allows to either save the buffer(s), do
not save the buffer(s) and continue, or abort operation (I suppose using
(save-some-buffers) call, though I didn't check). See, for example, how
(compile) behaves when some of buffers are not saved.

In fact I believe the way PCL-CVS handles this, and that was implemented
in my earlier patch, is superior compared to this patch. An addition of
save-some-buffers call won't hurt either, but IMHO is not very useful in
the specific case of git-revert.

BTW, what definitely lacks (save-some-buffers) call is git-commit, as it
silently commits on-disk state of a file when corresponding buffer is
modified.

> On success, revert the buffers that contains the files that have been
> reverted.

This part is indeed very handy.

-- Sergei Organov.
