From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Bugfix: initialize pack_base to NULL.
Date: Tue, 28 Jun 2005 14:55:16 -0700
Message-ID: <7vvf3ytad7.fsf_-_@assigned-by-dhcp.cox.net>
References: <20050624.212009.92584730.davem@davemloft.net>
	<42BCE026.8050405@pobox.com>
	<Pine.LNX.4.58.0506242208210.11175@ppc970.osdl.org>
	<42BCF02B.5090706@pobox.com>
	<Pine.LNX.4.58.0506242257450.11175@ppc970.osdl.org>
	<Pine.LNX.4.58.0506260905200.19755@ppc970.osdl.org>
	<Pine.LNX.4.63.0506281351150.1667@localhost.localdomain>
	<Pine.LNX.4.58.0506281201510.19755@ppc970.osdl.org>
	<Pine.LNX.4.63.0506281655140.1667@localhost.localdomain>
	<Pine.LNX.4.58.0506281424420.19755@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 28 23:52:24 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DnO06-0003vL-1d
	for gcvg-git@gmane.org; Tue, 28 Jun 2005 23:52:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261544AbVF1V6z (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 28 Jun 2005 17:58:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261511AbVF1V4P
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Jun 2005 17:56:15 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:60652 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S261383AbVF1VzW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jun 2005 17:55:22 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050628215516.YBER7275.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 28 Jun 2005 17:55:16 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0506281424420.19755@ppc970.osdl.org> (Linus
 Torvalds's message of "Tue, 28 Jun 2005 14:27:19 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This was causing random segfaults, because use_packed_git() got
confused by random garbage there.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 sha1_file.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

facb119577a28bbb3f2ac1e5f8db37fd2f6d31d8
diff --git a/sha1_file.c b/sha1_file.c
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -395,6 +395,7 @@ static struct packed_git *add_packed_git
 	p->pack_size = st.st_size;
 	p->index_base = idx_map;
 	p->next = NULL;
+	p->pack_base = NULL;
 	p->pack_last_used = 0;
 	return p;
 }
------------
