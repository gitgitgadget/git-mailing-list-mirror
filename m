From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git-rev-list: fix --header
Date: Mon, 17 Apr 2006 12:36:50 -0700
Message-ID: <7vwtdom1t9.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0604171443300.18017@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 17 21:36:59 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FVZWp-000556-SI
	for gcvg-git@gmane.org; Mon, 17 Apr 2006 21:36:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750724AbWDQTgw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 17 Apr 2006 15:36:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750787AbWDQTgw
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Apr 2006 15:36:52 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:51440 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S1750724AbWDQTgw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Apr 2006 15:36:52 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060417193651.UETK17757.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 17 Apr 2006 15:36:51 -0400
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18833>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> gitk expects raw verbose headers limited by \0. Meet these expectations.
>
> Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

Thanks.

Wouldn't this be simpler and do the same thing, I wonder?  The
point being that "--pretty --header" and "--header --pretty"
traditionally did not make --header to override --pretty.

diff --git a/rev-list.c b/rev-list.c
index 000f27a..d3c0dd9 100644
--- a/rev-list.c
+++ b/rev-list.c
@@ -326,6 +326,9 @@ int main(int argc, const char **argv)
 		else
 			revs.header_prefix = "commit ";
 	}
+	else if (revs.verbose_header)
+		/* Only --header was specified */
+		revs.commit_format = CMIT_FMT_RAW;
 
 	list = revs.commits;
 
