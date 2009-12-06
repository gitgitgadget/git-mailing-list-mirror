From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: [RFC PATCH v3 0/8] Remote helpers smart transport extensions
Date: Sun,  6 Dec 2009 18:28:43 +0200
Message-ID: <1260116931-16549-1-git-send-email-ilari.liusvaara@elisanet.fi>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 06 17:29:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NHJyl-0006Iv-OJ
	for gcvg-git-2@lo.gmane.org; Sun, 06 Dec 2009 17:29:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932865AbZLFQ2s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Dec 2009 11:28:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932758AbZLFQ2r
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Dec 2009 11:28:47 -0500
Received: from emh02.mail.saunalahti.fi ([62.142.5.108]:58591 "EHLO
	emh02.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932766AbZLFQ2r (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Dec 2009 11:28:47 -0500
Received: from saunalahti-vams (vs3-10.mail.saunalahti.fi [62.142.5.94])
	by emh02-2.mail.saunalahti.fi (Postfix) with SMTP id E2107EF263
	for <git@vger.kernel.org>; Sun,  6 Dec 2009 18:28:52 +0200 (EET)
Received: from emh03.mail.saunalahti.fi ([62.142.5.109])
	by vs3-10.mail.saunalahti.fi ([62.142.5.94])
	with SMTP (gateway) id A01DEDDE9EC; Sun, 06 Dec 2009 18:28:52 +0200
Received: from LK-Perkele-V (a88-113-39-59.elisa-laajakaista.fi [88.113.39.59])
	by emh03.mail.saunalahti.fi (Postfix) with ESMTP id CF76D158A63
	for <git@vger.kernel.org>; Sun,  6 Dec 2009 18:28:51 +0200 (EET)
X-Mailer: git-send-email 1.6.6.rc1.300.gfbc27
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134669>

Changes from v2 to v3:

- Rename "FALLBACK" -> "fallback"
- Get rid of magic "layer6 ready" return
- Initialize paths when called as foo::bar://
- Remove dead code as NULL remote can't happen
- Move the stream dupping from unknown protocols patch to taking over
  transports patch (that one needs it)
- Reorder the series so that debugging and mandatory cap patches are
  first.
- Rename virtual_connected to got_remote_heads (that's what it is)
- Coding style fix ups
- Move transport connect code from smart transports to archive patch.

Ilari Liusvaara (8):
  Add remote helper debug mode
  Support mandatory capabilities
  Pass unknown protocols to external protocol handlers
  Refactor git transport options parsing
  Support taking over transports
  Support remote helpers implementing smart transports
  Support remote archive from external protocol helpers
  Remove special casing of http, https and ftp

 .gitignore                           |    4 +
 Documentation/git-remote-helpers.txt |   30 ++++-
 Makefile                             |   24 +++-
 builtin-archive.c                    |   17 ++-
 transport-helper.c                   |  265 +++++++++++++++++++++++++++++-----
 transport.c                          |  231 +++++++++++++++++++++++-------
 transport.h                          |   28 ++++
 7 files changed, 506 insertions(+), 93 deletions(-)
