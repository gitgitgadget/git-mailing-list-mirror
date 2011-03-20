From: Hallvard B Furuseth <h.b.furuseth@usit.uio.no>
Subject: Re: git filter-branch --filter-notes/--post-rewrite?
Date: Sun, 20 Mar 2011 23:55:59 +0100
Message-ID: <hbf.20110320kak3@bombur.uio.no>
References: <hbf.20110317iwua@bombur.uio.no>
	<201103180116.14754.johan@herland.net>
	<201103181053.58969.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Johan Herland <johan@herland.net>, <git@vger.kernel.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Sun Mar 20 23:56:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q1RXr-0003EP-3D
	for gcvg-git-2@lo.gmane.org; Sun, 20 Mar 2011 23:56:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751506Ab1CTW4E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Mar 2011 18:56:04 -0400
Received: from mail-out2.uio.no ([129.240.10.58]:41955 "EHLO mail-out2.uio.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751385Ab1CTW4D (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Mar 2011 18:56:03 -0400
Received: from mail-mx2.uio.no ([129.240.10.30])
	by mail-out2.uio.no with esmtp (Exim 4.74)
	(envelope-from <hbf@ulrik.uio.no>)
	id 1Q1RXU-0005UJ-Lt; Sun, 20 Mar 2011 23:56:00 +0100
Received: from bombur.uio.no ([129.240.6.233])
	by mail-mx2.uio.no with esmtp  (Exim 4.72)
	(envelope-from <hbf@ulrik.uio.no>)
	id 1Q1RXU-0005AZ-9b; Sun, 20 Mar 2011 23:56:00 +0100
Received: from hbf by bombur.uio.no with local (Exim 4.72)
	(envelope-from <hbf@ulrik.uio.no>)
	id 1Q1RXT-0006Ur-NR; Sun, 20 Mar 2011 23:55:59 +0100
In-Reply-To: <201103181053.58969.trast@student.ethz.ch>
X-Mailer: VM 7.18 under Emacs 22.2.1
X-UiO-Ratelimit-Test: rcpts/h 7 msgs/h 2 sum rcpts/h 9 sum msgs/h 2 total rcpts 1014 max rcpts/h 17 ratelimit 0
X-UiO-Spam-info: not spam, SpamAssassin (score=-5.0, required=5.0, autolearn=disabled, T_RP_MATCHES_RCVD=-0.01,UIO_MAIL_IS_INTERNAL=-5, uiobl=NO, uiouri=NO)
X-UiO-Scanned: 4F105C69FB0E6A476B69621F70367FE90DDF9571
X-UiO-SPAM-Test: remote_host: 129.240.6.233 spam_score: -49 maxlevel 80 minaction 1 bait 0 mail/h: 2 total 435 max/h 5 blacklist 0 greylist 0 ratelimit 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169532>

Thomas Rast writes:
>Johan Herland wrote:
>
>> Looking at git-rebase.sh (where it _is_ implemented), it seems to be a 
>> matter of feeding "old_sha1 new_sha1" pairs into a "rewritten" file, and 
>> then passing that file to the stdin of "git notes copy --for-rewrite=filter-
>> branch" (followed by passing the same file to the "post-rewrite" hook).

That appends to the notes history instead of replacing it, which seems
broken to me.  So I'm doing fast-export <notes> | edit; fast-import.

> I had a patch for this back when post-rewrite was invented,
> 
>   http://thread.gmane.org/gmane.comp.version-control.git/139919/focus=139917
> 
> but Hannes replied that it should grow a real notes filter, and while
> I dropped it there, I tend to agree with him.  Feel free to pick it up
> again.

A notes filter would be nice, but I don't understand why there's no
post-rewrite hook or option to let us get at the rewrite info before
it is deleted.  For one thing a notes filter might not do just what is
intended (as above), but one might want the mapping info for other
things too.  E.g. just to save it in case there are mailings floating
around which refer to old commit IDs.


In any case, thanks for the answers.  I guess I can live with copying
the git-filter-branch script when needed, it's not as if I run that
every day.

-- 
Hallvard
