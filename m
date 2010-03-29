From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: [PATCH 0/7] remote-helpers: exporting
Date: Mon, 29 Mar 2010 11:48:22 -0500
Message-ID: <1269881309-19690-1-git-send-email-srabbelier@gmail.com>
To: "Git List" <git@vger.kernel.org>,
	"Junio C Hamano" <gitster@pobox.com>,
	"Daniel Barkalow" <barkalow@iabervon.org>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Jonathan Niede
X-From: git-owner@vger.kernel.org Mon Mar 29 18:48:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NwI8w-0007Vo-LO
	for gcvg-git-2@lo.gmane.org; Mon, 29 Mar 2010 18:48:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754678Ab0C2Qsm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Mar 2010 12:48:42 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:44618 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754585Ab0C2Qsl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Mar 2010 12:48:41 -0400
Received: by gyg13 with SMTP id 13so1551144gyg.19
        for <git@vger.kernel.org>; Mon, 29 Mar 2010 09:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :message-id:x-mailer;
        bh=3RvBR7TOP4wofzwzKvhwjAOmSC1kVJkD0Ye4a0bdv2k=;
        b=FuGTJ6AOAMMMFRRwTyWrANzYeypjFmh3q0TNdwekDRP6ecKh+QXjzBSMWADIYlmOPj
         3ICJSPlc5EFxL9ug69Jq38sZRzu/FeW7A3ujSIdgbP+HaCndoH22R5yvKpuoNLlAVz9P
         A3P0xr56p7ZGj43s164a7o81hZU+lEnAGmErE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:message-id:x-mailer;
        b=UqQTQGg5it/G2MbBInaEOqD1TNNDlc3abfVkQYcEcQIa7inEc3hNO+OfhZQeuQJdV7
         /CpCUHwCPs/fJ0kR/+qR4taodcIZF4scO+wpAokzbAeAjhSu6Ve+93BxqVr+ydqEZ1JN
         JlFhzUuYnyNfIqvd3CTde9InKvhSZoQw+ZW+Y=
Received: by 10.143.20.1 with SMTP id x1mr1819628wfi.148.1269881320217;
        Mon, 29 Mar 2010 09:48:40 -0700 (PDT)
Received: from localhost.localdomain (97-114-181-145.frgo.qwest.net [97.114.181.145])
        by mx.google.com with ESMTPS id 23sm4102040iwn.10.2010.03.29.09.48.37
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 29 Mar 2010 09:48:39 -0700 (PDT)
X-Mailer: git-send-email 1.7.0.3.317.gbb04ec
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143491>

Hopefully this is in time for 1.7.1, it'd be good to have the 'export'
command in asap. I'm fairly sure that the first two patches are good
(all tests pass, and I've spent a lot of time debugging the relevant
code), but I'd still appreciate if the clone experts could give
it a look.

I'm really glad to finally get this working, hopefully I'll also have
time to finish up the remote-hg implementation, but probably not
before the 1.7.1 window closes (assuming that will be somewhere in
the next few days).

Sverre Rabbelier (7):
      clone: pass the remote name to remote_get
      clone: also configure url for bare clones
      fast-import: always create marks_file directories
      remote-helpers: allow requesing the path to the .git directory
      remote-helpers: add support for an export command
      remote-helpers: add testgit helper
      remote-helpers: add tests for testgit helper

 .gitignore                          |    1 +
 Makefile                            |    2 +
 builtin/clone.c                     |   16 ++--
 fast-import.c                       |    2 +
 git-remote-testgit.py               |  233 +++++++++++++++++++++++++++++++++++
 git_remote_helpers/git/exporter.py  |   51 ++++++++
 git_remote_helpers/git/importer.py  |   38 ++++++
 git_remote_helpers/git/non_local.py |   61 +++++++++
 git_remote_helpers/git/repo.py      |   70 +++++++++++
 t/t5800-remote-helpers.sh           |   70 +++++++++++
 transport-helper.c                  |  141 +++++++++++++++++++--
 11 files changed, 665 insertions(+), 20 deletions(-)
