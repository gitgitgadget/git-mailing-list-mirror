From: Mike Hommey <mh@glandium.org>
Subject: [WIP Patch 00/12] Refactoring the http API
Date: Sun, 18 Jan 2009 09:04:25 +0100
Message-ID: <1232265877-3649-1-git-send-email-mh@glandium.org>
References: <20090118074911.GB30228@glandium.org>
Cc: johannes.schindelin@gmx.de
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Jan 18 09:06:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOSfl-0001kf-D6
	for gcvg-git-2@gmane.org; Sun, 18 Jan 2009 09:06:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760219AbZARIEx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Jan 2009 03:04:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758756AbZARIEr
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Jan 2009 03:04:47 -0500
Received: from vuizook.err.no ([85.19.221.46]:42437 "EHLO vuizook.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757837AbZARIEp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Jan 2009 03:04:45 -0500
Received: from cha92-13-88-165-248-19.fbx.proxad.net ([88.165.248.19] helo=jigen)
	by vuizook.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <mh@glandium.org>)
	id 1LOSe5-0002EQ-TH; Sun, 18 Jan 2009 09:04:40 +0100
Received: from mh by jigen with local (Exim 4.69)
	(envelope-from <mh@jigen>)
	id 1LOSe5-0000y0-4E; Sun, 18 Jan 2009 09:04:37 +0100
X-Mailer: git-send-email 1.6.1.141.gb32a
In-Reply-To: <20090118074911.GB30228@glandium.org>
X-Spam-Status: (score 0.1): No, score=0.1 required=5.0 tests=RDNS_DYNAMIC autolearn=disabled version=3.2.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106153>

> And I realize I have had a partial improvement on that sitting on my
> harddrive, without me having time (nor motivation) to go further.
>
> Maybe it's time I let it go and post the work in progress for someone
> else to take over.

Here it is. 

Note I already sent the first patch a year ago:
 http://markmail.org/message/s4w4pmla4tzjkpsf

This set of patches only deals with HTTP GET requests, so all of http-push
is not taken care of.

As it is work in progress, some error handling might have regressions, but
the original error handling is not necessarily much better.

Also note I only rebased my one-year-old work on current master, and haven't
actually tested it, though, as the code hasn't changed much, I guess it
should be fine.

I hope someone will have an itch to scratch to improve the whole thing.

Mike Hommey (12):
  Don't expect verify_pack() callers to set pack_size
  Some cleanup in get_refs_via_curl()
  Two new functions for the http API
  Use the new http API in http_fetch_ref()
  Use the new http API in get_refs_via_curl()
  Use the new http API in http-walker.c:fetch_indices()
  Use the new http API in http-push.c:fetch_indices()
  Use the new http API in update_remote_info_refs()
  Use the new http API in fetch_symref()
  Use the new http API in http-walker.c:fetch_index()
  Use the new http API in http-push.c:fetch_index()
  Use the new http API in http-walker.c:fetch_pack()

 http-push.c   |  159 ++++++++++-----------------------------------------------
 http-walker.c |  141 ++++++--------------------------------------------
 http.c        |  112 ++++++++++++++++++++++++++++++++--------
 http.h        |   17 ++++++
 pack-check.c  |    8 ++-
 transport.c   |   29 ++--------
 6 files changed, 162 insertions(+), 304 deletions(-)
