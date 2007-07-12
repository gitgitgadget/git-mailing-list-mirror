From: skimo@liacs.nl
Subject: [PATCH 0/6] Add git-rewrite-commits v2
Date: Thu, 12 Jul 2007 21:05:57 +0200
Message-ID: <11842671631744-git-send-email-skimo@liacs.nl>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 12 21:06:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I93za-0003Zz-HX
	for gcvg-git@gmane.org; Thu, 12 Jul 2007 21:06:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760861AbXGLTGS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Jul 2007 15:06:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759353AbXGLTGS
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jul 2007 15:06:18 -0400
Received: from rhodium.liacs.nl ([132.229.131.16]:46060 "EHLO rhodium.liacs.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756985AbXGLTGQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jul 2007 15:06:16 -0400
Received: from pc117b.liacs.nl (pc117b.liacs.nl [132.229.129.143])
	by rhodium.liacs.nl (8.13.0/8.13.0/LIACS 1.4) with ESMTP id l6CJ634K029829;
	Thu, 12 Jul 2007 21:06:08 +0200
Received: by pc117b.liacs.nl (Postfix, from userid 17122)
	id 5857D3C00A; Thu, 12 Jul 2007 21:06:03 +0200 (CEST)
X-Mailer: git-send-email 1.5.3.rc0.63.gc956
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52323>

From: Sven Verdoolaege <skimo@kotnet.org>

[PATCH 1/6] revision: allow selection of commits that do not match a pattern
[PATCH 2/6] export get_short_sha1
[PATCH 3/6] Define ishex(x) in git-compat-util.h
[PATCH 4/6] refs.c: lock cached_refs during for_each_ref
[PATCH 5/6] revision: mark commits that didn't match a pattern for later use
[PATCH 6/6] Add git-rewrite-commits

The first is fairly independent, but it is used in the tests
of the last patch and may be replaced by Johannes' extended patch.
The next three should be fairly uncontroversial.
The fifth may be considered a waste of a precious bit.
If so, any suggestions for other ways of passing on this information
are welcomed.
The sixth contains the actual git-rewrite-commits builtin.
My main motivation was that cg-admin-rewritehist doesn't
change the SHA1's in commit message and I don't like shell
programming.

The main difference with the previous series is that
the options are now called --index-filter and --commit-filter
instead of --index-map and --commit-map.

The commit filter should now produce a list of commit SHA1
instead of the modified raw commit.
The refs are now rewritten at the very end, which should
be safer if anything goes wrong along the way and obviates
the need for the call to add_ref_decoration of the previous
series.

Most of the changes were requested by Johannes Schindelin.
I'm sure he'll let me know if I forgot anything.
In a follow-up patch (series), he will add more helper functions
for the filters.

skimo
