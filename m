From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH v2 0/4] git-remote rename: support branches->config migration
Date: Wed, 12 Nov 2008 18:11:00 +0100
Message-ID: <cover.1226508805.git.vmiklos@frugalware.org>
References: <7viqqtshdd.fsf@gitster.siamese.dyndns.org>
Cc: Jeff King <peff@peff.net>, Brandon Casey <casey@nrlssc.navy.mil>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 12 18:12:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0JFu-00065i-6H
	for gcvg-git-2@gmane.org; Wed, 12 Nov 2008 18:11:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752653AbYKLRKQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Nov 2008 12:10:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751466AbYKLRKP
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Nov 2008 12:10:15 -0500
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:49998 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753699AbYKLRKG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Nov 2008 12:10:06 -0500
Received: from vmobile.example.net (dsl5401C37A.pool.t-online.hu [84.1.195.122])
	by yugo.frugalware.org (Postfix) with ESMTPA id 62930446CCF;
	Wed, 12 Nov 2008 18:10:03 +0100 (CET)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id 606E419DB15; Wed, 12 Nov 2008 18:11:04 +0100 (CET)
X-Mailer: git-send-email 1.6.0.2
In-Reply-To: <7viqqtshdd.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100773>

On Tue, Nov 11, 2008 at 08:22:38PM -0800, Junio C Hamano <gitster@pobox.com> wrote:
> The function migrate_file() introduced by [2/4] is called for any
> remote definition that did not come from config (by definition, it
> either came from remotes/foo or branches/foo).  The function adds the
> entries for the given remote definition to the config file, and then
> removes remotes/foo file if the remote definition came from it.  So it
> is a logically consistent change if you only called this function only
> for remote definitions that came from remotes/foo.
>
> But the function is called for a remote definition that originally
> came from branches/foo as well.  It happily adds the definition to the
> config, even though it *fails to remove* branches/foo file.
>
> Do you still think 2/4 is a logically contained good change?

OK, here is an updated series, which is supposed to fix this issue. 1/4
and 4/4 is unchanged.

Miklos Vajna (4):
  remote: add a new 'origin' variable to the struct
  git-remote rename: support remotes->config migration
  git-remote rename: support branches->config migration
  git-remote: document the migration feature of the rename subcommand

 Documentation/git-remote.txt |    4 ++++
 builtin-remote.c             |   37 +++++++++++++++++++++++++++++++++++++
 remote.c                     |    3 +++
 remote.h                     |    7 +++++++
 t/t5505-remote.sh            |   33 +++++++++++++++++++++++++++++++++
 5 files changed, 84 insertions(+), 0 deletions(-)
