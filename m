From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH/RFC v4 0/13] Introduce index file format version 5
Date: Thu, 16 Aug 2012 11:58:36 +0200
Message-ID: <1345111129-6925-1-git-send-email-t.gummerer@gmail.com>
Cc: trast@student.ethz.ch, pclouds@gmail.com, mhagger@alum.mit.edu,
	gitster@pobox.com, robin.rosenberg@dewire.com, t.gummerer@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 16 11:59:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T1wrJ-0007z6-Ov
	for gcvg-git-2@plane.gmane.org; Thu, 16 Aug 2012 11:59:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756351Ab2HPJ7Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Aug 2012 05:59:16 -0400
Received: from li348-43.members.linode.com ([178.79.179.43]:48154 "EHLO
	tgummerer.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756191Ab2HPJ7M (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Aug 2012 05:59:12 -0400
Received: by tgummerer.com (Postfix, from userid 1001)
	id 5D42D4EF57; Thu, 16 Aug 2012 11:59:07 +0200 (CEST)
X-Mailer: git-send-email 1.7.10.GIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Previous rounds of the series are at $gmane/202752 and $gmane/202923
and $gmane/203088.

The modification to t3700 was removed as the smudge marker is replaced
with a CE_SMUDGED flag and therefore the code doesn't interfere with
the test.

Changes since the last round:

 [PATCH/RFC v4 01/13] Move index v2 specific functions to their own
 [PATCH/RFC v4 02/13] read-cache.c: Re-read index if index file
    Re-read the index file if the index file has changed since
    the first time we read it.  Checking if the index file changed
    is done by using it's stat data.

 [PATCH/RFC v4 03/13] t2104: Don't fail for index versions other than
 [PATCH/RFC v4 04/13] Add documentation of the index-v5 file format
    Documentation updates as suggested by Junio.

 [PATCH/RFC v4 05/13] Make in-memory format aware of stat_crc
 [PATCH/RFC v4 06/13] Read index-v5
    Replace the pointer casts with ptr_add makro as suggested by Junio.

    Use a CE_SMUDGED flag instaed of ce_mtime as smudge marker.

    Ignore the crc sum if we don't trust_cetime, since it may give
    us wrong results.

 [PATCH/RFC v4 07/13] Read resolve-undo data
    No longer do the conversion in resolve-undo.c but in
    read-cache-v5.c.  (The same is valid for 11/13)

 [PATCH/RFC v4 08/13] Read cache-tree in index-v5
    No longer do the conversion in cache-tree.c but in
    read-cache-v5.c.  (The same is valid for 10/13)

 [PATCH/RFC v4 09/13] Write index-v5
 [PATCH/RFC v4 10/13] Write index-v5 cache-tree data
 [PATCH/RFC v4 11/13] Write resolve-undo data for index-v5
 [PATCH/RFC v4 12/13] update-index.c: rewrite index when
    Don't introduce the force-rewrite option, but always rewrite the
    index if a index-version is given.

 [PATCH/RFC v4 13/13] p0002-index.sh: add perf test for the index
