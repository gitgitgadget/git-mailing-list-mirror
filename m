From: Sergio Callegari <sergio.callegari@gmail.com>
Subject: Multiblobs
Date: Wed, 28 Apr 2010 15:12:07 +0000 (UTC)
Message-ID: <loom.20100428T164432-954@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 28 17:12:26 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O78w5-00021A-Re
	for gcvg-git-2@lo.gmane.org; Wed, 28 Apr 2010 17:12:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754232Ab0D1PMT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Apr 2010 11:12:19 -0400
Received: from lo.gmane.org ([80.91.229.12]:51860 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751539Ab0D1PMT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Apr 2010 11:12:19 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1O78vv-0001xU-6J
	for git@vger.kernel.org; Wed, 28 Apr 2010 17:12:17 +0200
Received: from i2-ve060.ingce.unibo.it ([137.204.107.60])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 28 Apr 2010 17:12:15 +0200
Received: from sergio.callegari by i2-ve060.ingce.unibo.it with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 28 Apr 2010 17:12:15 +0200
X-Injected-Via-Gmane: http://gmane.org/
connect(): No such file or directory
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 137.204.107.60 (Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.9) Gecko/20100402 Ubuntu/9.10 (karmic) Firefox/3.5.9)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145996>

Hi,

it happened to me to read an older post by Jeff King about "multiblobs"
(http://kerneltrap.org/mailarchive/git/2008/4/6/1360014) and I was wandering
whether the idea has been abandoned for some reason or just put on hold.

Apparently, this would marvellously help on
- storing large binary blobs (the split could happen with a rolling checksum
approach)
- storing "structured files", such as the many zip-based file formats
(Opendocument, Docx, Jar files, zip files themselves), tars (including
compressed tars), pdfs, etc, whose number is rising day after day...
- storing binary files with textual tags, where the tags could go on a separate
blob, greatly simplifying their readout without any need for caching them on a
note tree.
- etc...

Furthermore, this could also
- help the management of upstream trees. This could be simplified since the
"pristine tree" distributed as a tar.gz file and the exploded repo could share
their blobs making commands such as pristine-tree unnecessary.
- help projects such as bup that currently need to provide split mechanisms of
their own.
- be used to add "different representations" to objects... for instance, when
storing a pdf one could use a fake split to store in a separate blob the
corresponding text, making the git-diff of pdfs almost instantaneous.

>From Jeff's post, I guess that the major issue could be that the same file could
get a different sha1 as a multiblob versus a regular blob, but maybe it could be
possible to make the multiblob take the same sha1 of the "equivalent plain blob"
rather than its real hash.

For the moment, I am just very curious about the idea and the possible pros and
cons... can someone (maybe Jeff himself) tell me a little more? Also I wonder
about the two possibilities (implement it in git vs implement it "on top of"
git).

Sergio
