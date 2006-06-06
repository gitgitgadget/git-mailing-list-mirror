From: Junio C Hamano <junkio@cox.net>
Subject: Re: [REGRESSION] Interrupted clone/fetch leaves .lock files around
Date: Tue, 06 Jun 2006 12:09:44 -0700
Message-ID: <7vmzcqp0cn.fsf@assigned-by-dhcp.cox.net>
References: <20060606185148.GA15521@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 06 21:09:58 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fngw4-0003n1-Bq
	for gcvg-git@gmane.org; Tue, 06 Jun 2006 21:09:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750979AbWFFTJq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Jun 2006 15:09:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750981AbWFFTJq
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Jun 2006 15:09:46 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:51165 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1750976AbWFFTJq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jun 2006 15:09:46 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060606190945.OEXX11027.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 6 Jun 2006 15:09:45 -0400
To: Jonas Fonseca <fonseca@diku.dk>
In-Reply-To: <20060606185148.GA15521@diku.dk> (Jonas Fonseca's message of
	"Tue, 6 Jun 2006 20:51:48 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21397>

Jonas Fonseca <fonseca@diku.dk> writes:

> Below is my feeble attempt at a (tested) fix.
>
> diff --git a/fetch.c b/fetch.c
> index e040ef9..861dc60 100644
> --- a/fetch.c
> +++ b/fetch.c
> @@ -1,3 +1,5 @@
> +#include <signal.h>
> +
>  #include "fetch.h"

I suspect you could do something similar to what we already do
for index updates using atexit().  Let me take a look.
