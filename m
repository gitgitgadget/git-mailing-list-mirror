From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 0/4] Fix handling of remotes with single-character names
Date: Tue, 28 Jul 2015 23:08:17 +0200
Message-ID: <cover.1438117334.git.mhagger@alum.mit.edu>
Cc: =?UTF-8?q?Bj=C3=B6rn=20Gustavsson?= <bgustavsson@gmail.com>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 28 23:08:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZKC77-0002zA-Uv
	for gcvg-git-2@plane.gmane.org; Tue, 28 Jul 2015 23:08:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753370AbbG1VIh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jul 2015 17:08:37 -0400
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:55489 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753285AbbG1VIe (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 28 Jul 2015 17:08:34 -0400
X-AuditID: 12074414-f794f6d000007852-05-55b7ef4c8047
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id C4.C5.30802.C4FE7B55; Tue, 28 Jul 2015 17:08:28 -0400 (EDT)
Received: from michael.fritz.box (p4FC97CAD.dip0.t-ipconnect.de [79.201.124.173])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t6SL8PUA021490
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Tue, 28 Jul 2015 17:08:27 -0400
X-Mailer: git-send-email 2.4.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrBIsWRmVeSWpSXmKPExsUixO6iqOvzfnuowbsHvBbzjy1mtui60s1k
	0dB7hdni9or5zA4sHn/ff2Dy2DnrLrvHxUvKHp83yQWwRHHbJCWWlAVnpufp2yVwZ7TeO8Rc
	cJy94vffg+wNjBPZuhg5OSQETCTa23czQ9hiEhfurQeKc3EICVxmlLg57xYLhHOSSeLI0S1g
	HWwCuhKLepqZQGwRATWJiW2HwIqYBdoYJS6s2QU2SljAQ2LGrTnsIDaLgKrE5RU/WEBsXgFz
	ic+Lz0Gtk5O4dnYr6wRG7gWMDKsY5RJzSnN1cxMzc4pTk3WLkxPz8lKLdC30cjNL9FJTSjcx
	QkJCZAfjkZNyhxgFOBiVeHgD324PFWJNLCuuzD3EKMnBpCTKO+MeUIgvKT+lMiOxOCO+qDQn
	tfgQowQHs5IIb8NDoBxvSmJlVWpRPkxKmoNFSZz322J1PyGB9MSS1OzU1ILUIpisDAeHkgQv
	7zugRsGi1PTUirTMnBKENBMHJ8hwLimR4tS8lNSixNKSjHhQsMcXA8MdJMUDtFcbpJ23uCAx
	FygK0XqKUZdjwY/ba5mEWPLy81KlxHnfgfwiAFKUUZoHtwKWAF4xigN9LMybBjKKB5g84Ca9
	AlrCBLTEs2cLyJKSRISUVAPjQm1TtrBdTPlcT17XCGbbKYc2f+vQcPh9I2NVI/OGxS5V6Y6O
	VRfDZNtnKe5eHniy9lLz8ctdX25oc8RlT+hYyVVrKJeb+PJAtMHZCJEJP0qzP0/1+LRouw3b
	NqUHF1m3Rwfxzsli3T1HdtmSKzecPC5s8qr1DJjiuqs3lEHGIWav9RdL39NKLMUZ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274848>

The parsing of `remotes.<groupname>` was broken if any of the remotes
in the group has a name consisting of a single character.

The first patch fixes the bug; the others are general refactoring to
make the function a little bit clearer.

This series is based on maint, which I just noticed is still v2.4.7,
but it also rebases cleanly to master. It might make sense to apply
only the first patch to maint and the others only to master.

These patches are also available from my GitHub repository [1] as
branch "single-character-remotes".

Michael

[1] https://github.com/mhagger/git

Michael Haggerty (4):
  get_remote_group(): handle remotes with single-character names
  get_remote_group(): rename local variable "space" to "wordlen"
  get_remote_group(): eliminate superfluous call to strcspn()
  get_remote_group(): use skip_prefix()

 builtin/fetch.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

-- 
2.4.6
