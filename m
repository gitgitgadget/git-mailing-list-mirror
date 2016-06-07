From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 0/5] Improve test coverage of update-ref error messages
Date: Tue,  7 Jun 2016 13:50:05 +0200
Message-ID: <cover.1465299118.git.mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>,
	David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Tue Jun 07 13:51:10 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bAFWy-0004XT-EI
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jun 2016 13:50:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161129AbcFGLua (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jun 2016 07:50:30 -0400
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:48209 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1161121AbcFGLu2 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 7 Jun 2016 07:50:28 -0400
X-AuditID: 1207440d-bc7ff7000000090b-c8-5756b4f785e4
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id F9.A2.02315.7F4B6575; Tue,  7 Jun 2016 07:50:15 -0400 (EDT)
Received: from michael.fritz.box (p548D6137.dip0.t-ipconnect.de [84.141.97.55])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u57BoCZx014544
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Tue, 7 Jun 2016 07:50:13 -0400
X-Mailer: git-send-email 2.8.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrIIsWRmVeSWpSXmKPExsUixO6iqPt9S1i4wYI3yhbzN51gtOi60s1k
	0dB7hdni9or5zBbdU94yWvxo6WF2YPP4+/4Dk8fOWXfZPZ717mH0uHhJ2WPB8/vsHp83yQWw
	RXHbJCWWlAVnpufp2yVwZ/ybllDwhq/iy/HvjA2Mi3m6GDk5JARMJI5N/c0GYgsJbGWUmPmM
	CcI+xiRx438QiM0moCuxqKcZLC4iECHR8KqFsYuRi4NZYB+jxMl181lAEsIC7hJzLk4DK2IR
	UJW4+u46K4jNK2Au0f1nFjPEMjmJy9MfsE1g5FrAyLCKUS4xpzRXNzcxM6c4NVm3ODkxLy+1
	SNdILzezRC81pXQTIyQ4eHcw/l8nc4hRgINRiYdX4HtouBBrYllxZe4hRkkOJiVR3ofeYeFC
	fEn5KZUZicUZ8UWlOanFhxglOJiVRHgT1gLleFMSK6tSi/JhUtIcLErivGpL1P2EBNITS1Kz
	U1MLUotgsjIcHEoSvB83AzUKFqWmp1akZeaUIKSZODhBhnNJiRSn5qWkFiWWlmTEg8I5vhgY
	0CApHqC9r0DaeYsLEnOBohCtpxgVpcR5t4EkBEASGaV5cGNhMf+KURzoS2Fec2ACEOIBpgu4
	7ldAg5mABi+7FgwyuCQRISXVwBhl88Yqlmn5vF3GW0p+MikfOJr0dtEcaeWYGGcr2aedxp/E
	7u5jyCxU2NA2YZJ97nO1TNPr1lUzRJxeyy+592LPjV0/Tt9Vu7C1k/File6jvbu4ppq9aTm9
	+dzB5ekLv3+offXy/fnLSnfmHz0tO/NP/K9DexvlLwt0WxyK0fb7+zZXdH2Ses5n 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296626>

The logic for deciding what error to emit under various update-ref
failure scenarios is nontrivial. Add a bunch of tests of these error
messages. Then improve a few error messages that were not ideal. One
or two other error messages could still be improved, but that would
take more work so I will skip it for now.

This patch series applies on top of mh/split-under-lock. Improving the
testing of that patch series was in fact the main motivation for this
one. It didn't turn up any serious errors, so I don't think that this
patch series needs to hold up the other one. On the other hand, each
of the patch series changes some error messages, so if possible it
would be preferable to ship them in the same Git release.

Happily, this branch doesn't conflict with either of the other large
patch series that are queued up in this area (mh/ref-iterators [2] and
ref-store [3]).

These patches are also available from my GitHub account [4] as branch
update-ref-errors.

Michael

[1] http://thread.gmane.org/gmane.comp.version-control.git/293800
[2] http://thread.gmane.org/gmane.comp.version-control.git/296322
[3] http://thread.gmane.org/gmane.comp.version-control.git/296409
[4] https://github.com/mhagger/git

Michael Haggerty (5):
  t1404: rename file to t1404-update-ref-errors.sh
  t1404: document function test_update_rejected
  t1404: add more tests of update-ref error handling
  lock_ref_for_update(): make error handling more uniform
  lock_ref_for_update(): avoid a symref resolution

 refs/files-backend.c               |  77 ++++---
 t/t1404-update-ref-df-conflicts.sh | 181 -----------------
 t/t1404-update-ref-errors.sh       | 402 +++++++++++++++++++++++++++++++++++++
 3 files changed, 447 insertions(+), 213 deletions(-)
 delete mode 100755 t/t1404-update-ref-df-conflicts.sh
 create mode 100755 t/t1404-update-ref-errors.sh

-- 
2.8.1
