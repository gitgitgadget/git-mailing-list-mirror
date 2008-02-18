From: Jean-Luc Herren <jlh@gmx.ch>
Subject: Re: [PATCH] Remove useless if-before-free tests.
Date: Mon, 18 Feb 2008 15:27:24 +0100
Message-ID: <47B995CC.2000809@gmx.ch>
References: <871w7bz1ly.fsf@rho.meyering.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: Jim Meyering <jim@meyering.net>, git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Feb 18 15:28:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JR6yW-0000QI-IU
	for gcvg-git-2@gmane.org; Mon, 18 Feb 2008 15:28:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755803AbYBRO1c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Feb 2008 09:27:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752769AbYBRO1b
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Feb 2008 09:27:31 -0500
Received: from mail.gmx.net ([213.165.64.20]:40502 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754285AbYBRO1a (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Feb 2008 09:27:30 -0500
Received: (qmail invoked by alias); 18 Feb 2008 14:27:28 -0000
Received: from 148-39.78-83.cust.bluewin.ch (EHLO [192.168.123.202]) [83.78.39.148]
  by mail.gmx.net (mp008) with SMTP; 18 Feb 2008 15:27:28 +0100
X-Authenticated: #14737133
X-Provags-ID: V01U2FsdGVkX1/P5aJI79PPzXRmPLB6DvaJNoHvz0EvjjEeD4b021
	04+opNiHAHrgC5
User-Agent: Thunderbird 2.0.0.9 (X11/20071118)
In-Reply-To: <871w7bz1ly.fsf@rho.meyering.net>
X-Enigmail-Version: 0.95.6
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74296>

Jim Meyering wrote:
> This change removes all useless if-before-free tests.
> E.g., it replace code like this
> 
> 	if (some_expression)
> 		free (some_expression);
> 
> with the now-equivalent
> 
> 	free (some_expression);

While you're at it, you might want to add this to your patch:

diff --git a/imap-send.c b/imap-send.c
index 9025d9a..3b27bca 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -472,7 +472,7 @@ v_issue_imap_cmd( imap_store_t *ctx, struct imap_cmd_cb *cb,
        if (socket_write( &imap->buf.sock, buf, bufl ) != bufl) {
                free( cmd->cmd );
                free( cmd );
-               if (cb && cb->data)
+               if (cb)
                        free( cb->data );
                return NULL;
        }

jlh
