From: John Keeping <john@keeping.me.uk>
Subject: [PATCH 0/4] fast-import: handle empty paths better
Date: Sun, 23 Jun 2013 15:58:18 +0100
Message-ID: <cover.1371999369.git.john@keeping.me.uk>
Cc: Dave Abrahams <dave@boostpro.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	John Keeping <john@keeping.me.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 23 16:58:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UqlkW-0000qb-D4
	for gcvg-git-2@plane.gmane.org; Sun, 23 Jun 2013 16:58:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751557Ab3FWO6g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Jun 2013 10:58:36 -0400
Received: from coyote.aluminati.org ([72.9.247.114]:60711 "EHLO
	coyote.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751191Ab3FWO6g (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Jun 2013 10:58:36 -0400
Received: from localhost (localhost [127.0.0.1])
	by coyote.aluminati.org (Postfix) with ESMTP id E4CA96064E3;
	Sun, 23 Jun 2013 15:58:35 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at caracal.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -12.899
X-Spam-Level: 
X-Spam-Status: No, score=-12.899 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9,
	URIBL_BLOCKED=0.001] autolearn=ham
Received: from coyote.aluminati.org ([127.0.0.1])
	by localhost (coyote.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4XLdGecfsns5; Sun, 23 Jun 2013 15:58:35 +0100 (BST)
Received: from pichi.aluminati.org (pichi.aluminati.org [10.0.16.50])
	by coyote.aluminati.org (Postfix) with ESMTP id 744AB6064D7;
	Sun, 23 Jun 2013 15:58:35 +0100 (BST)
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id 65B98161E361;
	Sun, 23 Jun 2013 15:58:35 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at aluminati.org
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WvLeFiEAKK1j; Sun, 23 Jun 2013 15:58:34 +0100 (BST)
Received: from river.lan (tg2.aluminati.org [10.0.7.178])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id 3C19B161E3F1;
	Sun, 23 Jun 2013 15:58:26 +0100 (BST)
X-Mailer: git-send-email 1.8.3.1.676.gaae6535
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228741>

This series addressed Dave Abraham's recent bug report [1] about using
fast-import's "ls" command with an empty path.  I also found a couple of
other places that do not handle the empty path when it can reasonably be
interpreted as meaning the root tree object, which are also fixed here.

[1] http://article.gmane.org/gmane.comp.version-control.git/228586

John Keeping (4):
  t9300: document fast-import empty path issues
  fast-import: set valid mode on root tree in "ls"
  fast-import: allow ls or filecopy of the root tree
  fast-import: allow moving the root tree

 fast-import.c          | 58 ++++++++++++++++++++++++++++----------------
 t/t9300-fast-import.sh | 65 ++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 103 insertions(+), 20 deletions(-)

-- 
1.8.3.1.676.gaae6535
