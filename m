From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: [PATCH 0/4] Fix various integer overflows
Date: Tue, 26 Jan 2010 20:24:11 +0200
Message-ID: <1264530255-4682-1-git-send-email-ilari.liusvaara@elisanet.fi>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 26 19:24:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NZq5R-00053J-5R
	for gcvg-git-2@lo.gmane.org; Tue, 26 Jan 2010 19:24:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754763Ab0AZSYT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Jan 2010 13:24:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753187Ab0AZSYS
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Jan 2010 13:24:18 -0500
Received: from emh03.mail.saunalahti.fi ([62.142.5.109]:55317 "EHLO
	emh03.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750824Ab0AZSYS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jan 2010 13:24:18 -0500
Received: from saunalahti-vams (vs3-11.mail.saunalahti.fi [62.142.5.95])
	by emh03-2.mail.saunalahti.fi (Postfix) with SMTP id 6D5E8EC1B8
	for <git@vger.kernel.org>; Tue, 26 Jan 2010 20:24:16 +0200 (EET)
Received: from emh07.mail.saunalahti.fi ([62.142.5.117])
	by vs3-11.mail.saunalahti.fi ([62.142.5.95])
	with SMTP (gateway) id A01B406C62F; Tue, 26 Jan 2010 20:24:16 +0200
Received: from LK-Perkele-V (a88-113-39-59.elisa-laajakaista.fi [88.113.39.59])
	by emh07.mail.saunalahti.fi (Postfix) with ESMTP id 61F731C639D
	for <git@vger.kernel.org>; Tue, 26 Jan 2010 20:24:15 +0200 (EET)
X-Mailer: git-send-email 1.6.6.1.439.gf06b6
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138061>

Fix integer overflows in patch_delta(), unpack_sha1_rest() and
unpack_compressed_entry().

These at least can cause git to segfault, possibly worse. Operations
that cause integer overflow are not possible to do (even whole virtual
memory space would not be sufficient), so die() instead.

Ilari Liusvaara (4):
  Add xmallocz()
  Fix integer overflow in patch_delta()
  Fix integer overflow in unpack_sha1_rest()
  Fix integer overflow in unpack_compressed_entry()

 git-compat-util.h |    1 +
 patch-delta.c     |    3 +--
 sha1_file.c       |    5 ++---
 wrapper.c         |   12 +++++++++++-
 4 files changed, 15 insertions(+), 6 deletions(-)
