From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: [PATCH] Implement git remote rename
Date: Mon, 10 Nov 2008 21:42:59 +0100
Message-ID: <cover.1226349595.git.vmiklos@frugalware.org>
References: <7v63nh1sc7.fsf@gitster.siamese.dyndns.org>
Cc: Jeff King <peff@peff.net>, Brandon Casey <casey@nrlssc.navy.mil>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 10 21:43:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KzdbY-0003i8-Oy
	for gcvg-git-2@gmane.org; Mon, 10 Nov 2008 21:43:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753757AbYKJUmM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Nov 2008 15:42:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753001AbYKJUmL
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Nov 2008 15:42:11 -0500
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:57750 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751870AbYKJUmH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Nov 2008 15:42:07 -0500
Received: from vmobile.example.net (dsl5401C2D3.pool.t-online.hu [84.1.194.211])
	by yugo.frugalware.org (Postfix) with ESMTPA id 213DB446CCD;
	Mon, 10 Nov 2008 21:42:04 +0100 (CET)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id 0FB0A19DB16; Mon, 10 Nov 2008 21:43:03 +0100 (CET)
X-Mailer: git-send-email 1.6.0.2
In-Reply-To: <7v63nh1sc7.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100565>

On Fri, Oct 24, 2008 at 04:33:28PM -0700, Junio C Hamano <gitster@pobox.com> wrote:
> I suspect that if you record where you read the configuration from in
> "struct remote" and add necessary code to remove the original when
> rename.old is *not* coming from in-config definition, you would make
> it possible for repositories initialized with older git that has
> either $GIT_DIR/branches/origin or $GIT_DIR/remotes/origin to be
> migrated to the in-config format using "git remote rename origin
> origin".

Here are 4 patches to implement this + add the related
testcases/documentation.

Miklos Vajna (4):
  remote: add a new 'origin' variable to the struct
  git-remote rename: support remotes->config migration
  git-remote rename: support branches->config migration
  git-remote: document the migration feature of the rename subcommand

 Documentation/git-remote.txt |    4 ++++
 builtin-remote.c             |   35 +++++++++++++++++++++++++++++++++++
 remote.c                     |    3 +++
 remote.h                     |    7 +++++++
 t/t5505-remote.sh            |   33 +++++++++++++++++++++++++++++++++
 5 files changed, 82 insertions(+), 0 deletions(-)
