From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 3/2] format-patch: use clear_commit_marks() instead of
 some adhocery
Date: Tue, 27 Jun 2006 00:44:12 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0606270042420.29667@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0606250349280.29667@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.63.0606261728340.29667@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vhd27j3v8.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 27 00:45:13 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FuzpL-0005nP-Vt
	for gcvg-git@gmane.org; Tue, 27 Jun 2006 00:45:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933361AbWFZWow (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Jun 2006 18:44:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933349AbWFZWod
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Jun 2006 18:44:33 -0400
Received: from mail.gmx.de ([213.165.64.21]:23942 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S933347AbWFZWoN (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 26 Jun 2006 18:44:13 -0400
Received: (qmail invoked by alias); 26 Jun 2006 22:44:12 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp017) with SMTP; 27 Jun 2006 00:44:12 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vhd27j3v8.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22685>

Hi,

On Mon, 26 Jun 2006, Junio C Hamano wrote:

> diff --git a/commit.c b/commit.c
> index 946615d..69fbc41 100644
> --- a/commit.c
> +++ b/commit.c
> @@ -397,8 +397,7 @@ void clear_commit_marks(struct commit *c
>  	commit->object.flags &= ~mark;
>  	while (parents) {
>  		struct commit *parent = parents->item;
> -		if (parent && parent->object.parsed &&
> -		    (parent->object.flags & mark))
> +		if (parent && (parent->object.flags & mark))

This is probably not necessary for existing users, but it's a good change 
for the future: new users might be surprised to learn that there are 
unparsed objects, which still want to be handled.

Ciao,
Dscho
