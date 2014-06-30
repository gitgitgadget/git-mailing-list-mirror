From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 2/2] git-merge-file: do not add LF at EOF while applying
 unrelated change
Date: Mon, 30 Jun 2014 16:55:10 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.1406301650430.14982@s15462909.onlinehome-server.info>
References: <1403993086-15625-1-git-send-email-max@max630.net> <1403993086-15625-3-git-send-email-max@max630.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Bert Wesarg <bert.wesarg@googlemail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Max Kirillov <max@max630.net>
X-From: git-owner@vger.kernel.org Mon Jun 30 16:55:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X1czK-00043Y-UE
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jun 2014 16:55:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753562AbaF3OzT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jun 2014 10:55:19 -0400
Received: from mout.gmx.net ([212.227.15.19]:55473 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752670AbaF3OzS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jun 2014 10:55:18 -0400
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx003) with ESMTPSA (Nemesis) id 0MZkNy-1XN07N0wpC-00LWD8;
 Mon, 30 Jun 2014 16:55:11 +0200
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <1403993086-15625-3-git-send-email-max@max630.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:Mq50BqLZm2XET8LIUmAUSdyyqhV9F6MHJFV8JPbTUH27/yLvW46
 HN7DIy1HR8ARIcRDfCNjCFKKuEhLHOocF8Q7H9UwJO8BP4a7F5gV0g/r1JcH9Q7CarDOGZv
 QI/7ul/4MJnjjkQ5T/mofWhFmfho9731Zh7nazuKH4fzEv+sFHXIlp4MKy4hE4VQ9KH5oAT
 GtGfUCjYcrnXdYMQNettg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252674>

Hi Max,

On Sun, 29 Jun 2014, Max Kirillov wrote:

> diff --git a/xdiff/xmerge.c b/xdiff/xmerge.c
> index 9e13b25..625198e 100644
> --- a/xdiff/xmerge.c
> +++ b/xdiff/xmerge.c
> @@ -245,11 +245,11 @@ static int xdl_fill_merge_buffer(xdfenv_t *xe1, const char *name1,
>  					      dest ? dest + size : NULL);
>  			/* Postimage from side #1 */
>  			if (m->mode & 1)
> -				size += xdl_recs_copy(xe1, m->i1, m->chg1, 1,
> +				size += xdl_recs_copy(xe1, m->i1, m->chg1, (m->mode & 2),
>  						      dest ? dest + size : NULL);
>  			/* Postimage from side #2 */
>  			if (m->mode & 2)
> -				size += xdl_recs_copy(xe2, m->i2, m->chg2, 1,
> +				size += xdl_recs_copy(xe2, m->i2, m->chg2, 0,
>  						      dest ? dest + size : NULL);
>  		} else
>  			continue;

Makes sense to me, especially with the nice explanation in the commit
message. I just wish the tests were a little easier to understand... It is
probably my fault because I insisted on using a text that has *nothing* to
do with Git. These days, I would probably have used better file names and
would have used file contents that reflect the purpose in the tests (i.e.
a line saying "This line ends with a carriage return" or some such).

Having said that, here is my ACK for the current revision of the patch
series (because I know how much work it would be to fix the issue I
described above, and it is an *entirely different* issue from the one you
fixed with this series, too).

Ciao,
Dscho
