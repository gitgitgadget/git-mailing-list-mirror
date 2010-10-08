From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: [RFC PATCH v5 0/3] git-remote-fd & git-remote-ext
Date: Fri,  8 Oct 2010 21:39:57 +0300
Message-ID: <1286563200-7270-1-git-send-email-ilari.liusvaara@elisanet.fi>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 08 20:34:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P4HlX-0002mx-Gb
	for gcvg-git-2@lo.gmane.org; Fri, 08 Oct 2010 20:33:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753043Ab0JHSdt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Oct 2010 14:33:49 -0400
Received: from emh01.mail.saunalahti.fi ([62.142.5.107]:48694 "EHLO
	emh01.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752239Ab0JHSdt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Oct 2010 14:33:49 -0400
Received: from saunalahti-vams (vs3-11.mail.saunalahti.fi [62.142.5.95])
	by emh01-2.mail.saunalahti.fi (Postfix) with SMTP id AED978C72B
	for <git@vger.kernel.org>; Fri,  8 Oct 2010 21:33:47 +0300 (EEST)
Received: from emh07.mail.saunalahti.fi ([62.142.5.117])
	by vs3-11.mail.saunalahti.fi ([62.142.5.95])
	with SMTP (gateway) id A03FFFA9D01; Fri, 08 Oct 2010 21:33:47 +0300
Received: from LK-Perkele-V2 (a88-112-50-174.elisa-laajakaista.fi [88.112.50.174])
	by emh07.mail.saunalahti.fi (Postfix) with ESMTP id 9E4951C6386
	for <git@vger.kernel.org>; Fri,  8 Oct 2010 21:33:46 +0300 (EEST)
X-Mailer: git-send-email 1.7.1.rc2.10.g714149
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158520>

This adds two new remote helpers.

* git-remote-fd, which connects to git service on given file descriptor(s),
useful for graphical user interfaces that want to use internal ssh client.

* git-remote-ext, which connect to git service using external program. Useful
for connecting using odd one-off ssh options, to services in abstract
namespace, using unix domain sockets, using TLS, etc...

Changes from last time:

* Rewrite the bidirectional copy loop to use threads or processes. The
resulting code is bit simpler and doesn't rely on poll/select working
on sockets/pipes.

Ilari Liusvaara (3):
  Add bidirectional_transfer_loop()
  git-remote-fd
  git-remote-ext

 .gitignore                       |    2 +
 Documentation/git-remote-ext.txt |  125 ++++++++++++++++++
 Documentation/git-remote-fd.txt  |   59 +++++++++
 Makefile                         |    2 +
 builtin.h                        |    2 +
 builtin/remote-ext.c             |  243 +++++++++++++++++++++++++++++++++++
 builtin/remote-fd.c              |   80 ++++++++++++
 compat/mingw.h                   |    5 +
 git.c                            |    2 +
 transport-helper.c               |  261 ++++++++++++++++++++++++++++++++++++++
 transport.h                      |    1 +
 11 files changed, 782 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/git-remote-ext.txt
 create mode 100644 Documentation/git-remote-fd.txt
 create mode 100644 builtin/remote-ext.c
 create mode 100644 builtin/remote-fd.c

-- 
1.7.3.1.53.gb58bd
