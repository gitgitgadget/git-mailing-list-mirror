From: Andreas Krey <a.krey@gmx.de>
Subject: diff.renameLimit biting/silently ignored in cherry-pick
Date: Wed, 16 Jul 2014 12:28:51 +0200
Message-ID: <20140716102851.GA14736@inner.h.apk.li>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jul 16 12:58:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X7Mv0-0000mk-4j
	for gcvg-git-2@plane.gmane.org; Wed, 16 Jul 2014 12:58:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758221AbaGPK6f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jul 2014 06:58:35 -0400
Received: from continuum.iocl.org ([217.140.74.2]:34556 "EHLO
	continuum.iocl.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756387AbaGPK6e (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jul 2014 06:58:34 -0400
X-Greylist: delayed 1779 seconds by postgrey-1.27 at vger.kernel.org; Wed, 16 Jul 2014 06:58:33 EDT
Received: (from krey@localhost)
	by continuum.iocl.org (8.11.3/8.9.3) id s6GASqr15260;
	Wed, 16 Jul 2014 12:28:52 +0200
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253662>

Hi all,

we're running into a problem with the rename detection; we're
at num_src=27320 and num_create=46731, which means that 'matrix'
would still be enumerable in int32, but... well, I don't yet know
where exactly it refuses to perform rename detection. I've tried to
set needed_rename_limit to 2^31-2 at the place where it was set to the
maximum of num_src and num_create, but that doesn't help. Where could
I affect this?

Also we have the impression that 'git cherry-pick' silently stops
doing rename detection in this situation - it doesn't take nearly
long enough to perform it, and it clearly misses renames.

I'm trying to do a 'diff --name-status -M' to see whether the
rename is properly detected, but I guess the real way would
be to make cherry-pick still perform rename detection, and
to find out how to do *that*.

Cheers,

Andreas

-- 
"Totally trivial. Famous last words."
From: Linus Torvalds <torvalds@*.org>
Date: Fri, 22 Jan 2010 07:29:21 -0800
