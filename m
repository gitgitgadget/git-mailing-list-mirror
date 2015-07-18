From: Spencer Baugh <sbaugh@catern.com>
Subject: New flag (and trailer) for git-quiltimport.sh and git format-patch
Date: Sat, 18 Jul 2015 16:04:55 -0400
Message-ID: <87h9p1qljs.fsf@earth.i-did-not-set--mail-host-address--so-tickle-me>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 18 22:13:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZGYUW-0000Yd-GB
	for gcvg-git-2@plane.gmane.org; Sat, 18 Jul 2015 22:13:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752200AbbGRUNa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Jul 2015 16:13:30 -0400
Received: from catern.com ([104.131.201.120]:38402 "EHLO mail.catern.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752034AbbGRUN3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Jul 2015 16:13:29 -0400
X-Greylist: delayed 507 seconds by postgrey-1.27 at vger.kernel.org; Sat, 18 Jul 2015 16:13:29 EDT
Received: from [127.0.0.1] (localhost [127.0.0.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.catern.com (Postfix) with ESMTPSA id 8A3E047916
	for <git@vger.kernel.org>; Sat, 18 Jul 2015 20:05:01 +0000 (UTC)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274175>


Hi git list,

I think it would be useful if git-quiltimport.sh recognized a flag to
tell it to add a "QuiltFilename:" or "PatchFilename:" trailer to each
imported commit, which would show the filename of the patch that that
commit was imported from.

This would make it much easier (reliably possible, in fact) to match up
imported commits with their original patch; this is something I
frequently want to do, since the original patches might have additional
information associated with them that is not imported into git. (For
example, a comment in the quilt "series" file, or version control
history of the patch if it is kept in version control).

If such a flag and trailer were added, I think another useful addition
could be made to git format-patch: a flag to read the "PatchFilename: "
trailer and create the patch with that name. This would make it possible
to use git format-patch to regenerate the entire quilt patch series
without changing the filename or performing other unnecessary
churn. This is desirable because git tools like interactive rebase are
very powerful for manipulating a patch series, and it would be nice to
be able to use those without unnecessarily renaming all the patches.

(Of course, it would be even nicer to be able to just maintain these
patches in git... but sometimes you really do need them as a patch
series, in which case this ability would come in handy)

(And of course, format-patch still causes some other churn, like adding
the "From HASH DATE" line at the top of the patch and updating the
version number at the bottom, so it would be nice if there were flags to
stop it from adding those as well)

I can write patches to add all these features, but I thought it was best
to ask first, since adding a new pseudo-header/trailer might be a
radical step. I could alternatively do all of this with some local bash
scripts wrapping quiltimport and format-patch, but I think these
features might be useful to others too.

Thanks!
