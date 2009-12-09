From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: [REROLL PATCH v2 0/8] Remote helpers smart transport extensions
Date: Wed,  9 Dec 2009 17:26:26 +0200
Message-ID: <1260372394-16427-1-git-send-email-ilari.liusvaara@elisanet.fi>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 09 16:26:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NIOR9-0002WL-J8
	for gcvg-git-2@lo.gmane.org; Wed, 09 Dec 2009 16:26:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755238AbZLIP0c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Dec 2009 10:26:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755152AbZLIP0b
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Dec 2009 10:26:31 -0500
Received: from emh07.mail.saunalahti.fi ([62.142.5.117]:43904 "EHLO
	emh07.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752869AbZLIP0b (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Dec 2009 10:26:31 -0500
Received: from saunalahti-vams (vs3-11.mail.saunalahti.fi [62.142.5.95])
	by emh07-2.mail.saunalahti.fi (Postfix) with SMTP id D1D0218D0B4
	for <git@vger.kernel.org>; Wed,  9 Dec 2009 17:26:36 +0200 (EET)
Received: from emh05.mail.saunalahti.fi ([62.142.5.111])
	by vs3-11.mail.saunalahti.fi ([62.142.5.95])
	with SMTP (gateway) id A06E0CCE91E; Wed, 09 Dec 2009 17:26:36 +0200
Received: from LK-Perkele-V (a88-113-39-59.elisa-laajakaista.fi [88.113.39.59])
	by emh05.mail.saunalahti.fi (Postfix) with ESMTP id BFF4927D86
	for <git@vger.kernel.org>; Wed,  9 Dec 2009 17:26:35 +0200 (EET)
X-Mailer: git-send-email 1.6.6.rc1.300.gfbc27
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134980>

Changes from reroll v1:

- Wording fix in pass unknown protocols patch commit message
- Fix NO_CURL and hopefully make remote-http building bit clearer
- Remove extraneous fflush(stderr)
- Simplify remove_ext_force().
- Use strchr() instead of strchrc(). strchr() not const-correct, but...
- Simplify URL checking in is_url()
- Expand stdin and stdout in remote helper documentation
- _recvline -> recvline_fh
- _process_connect -> process_connect_service
- Reworded remote archive patch message
- gitoptions -> transport_options.

Ilari Liusvaara (8):
  Add remote helper debug mode
  Support mandatory capabilities
  Pass unknown protocols to external protocol handlers
  Refactor git transport options parsing
  Support taking over transports
  Support remote helpers implementing smart transports
  Support remote archive from all smart transports
  Remove special casing of http, https and ftp

 .gitignore                           |    4 +
 Documentation/git-remote-helpers.txt |   30 ++++-
 Makefile                             |   27 +++-
 builtin-archive.c                    |   17 ++-
 transport-helper.c                   |  283 ++++++++++++++++++++++++++++++----
 transport.c                          |  214 ++++++++++++++++++++------
 transport.h                          |   22 +++
 7 files changed, 504 insertions(+), 93 deletions(-)
