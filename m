From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH 0/3] symref rename/delete fixes
Date: Mon, 27 Oct 2008 20:50:19 +0100
Message-ID: <cover.1225136865.git.vmiklos@frugalware.org>
References: <20081027085055.GL2273@genesis.frugalware.org>
Cc: Jeff King <peff@peff.net>, Brandon Casey <casey@nrlssc.navy.mil>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 27 20:51:09 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KuY7G-0008Rs-6Y
	for gcvg-git-2@gmane.org; Mon, 27 Oct 2008 20:51:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753053AbYJ0Tts (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Oct 2008 15:49:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754403AbYJ0Ttr
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Oct 2008 15:49:47 -0400
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:38264 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754387AbYJ0Ttp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Oct 2008 15:49:45 -0400
Received: from vmobile.example.net (dsl5401C086.pool.t-online.hu [84.1.192.134])
	by yugo.frugalware.org (Postfix) with ESMTPA id 4F4D9446CD1;
	Mon, 27 Oct 2008 20:49:43 +0100 (CET)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id 51DCA14E35; Mon, 27 Oct 2008 20:50:23 +0100 (CET)
X-Mailer: git-send-email 1.6.0.2
In-Reply-To: <20081027085055.GL2273@genesis.frugalware.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99256>

On Mon, Oct 27, 2008 at 09:50:55AM +0100, Miklos Vajna <vmiklos@frugalware.org> wrote:
> Ah, I missed that. You convienced me, I'll post updated patches later
> today. :)

Here they are. The first is updated: the delete_ref() part is unchanged,
but the rename_ref() part is dropped and it just bails out with an error
if it detects a symref. The testcase is updated according to this as
well.

The two others are just rebased on top of the new first one, no
functional changes.

Miklos Vajna (3):
  Disallow git branch -m for symrefs.
  rename_ref(): handle the case when the reflog of a ref does not exist
  Fix git update-ref --no-deref -d.

 builtin-branch.c       |    2 +-
 builtin-receive-pack.c |    2 +-
 builtin-remote.c       |    4 ++--
 builtin-reset.c        |    2 +-
 builtin-send-pack.c    |    2 +-
 builtin-tag.c          |    2 +-
 builtin-update-ref.c   |    8 +++++---
 cache.h                |    2 +-
 refs.c                 |   35 ++++++++++++++++++++++++-----------
 t/t1400-update-ref.sh  |    7 +++++++
 t/t3200-branch.sh      |    9 +++++++++
 11 files changed, 53 insertions(+), 22 deletions(-)
