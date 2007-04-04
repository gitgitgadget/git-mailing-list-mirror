From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] rerere should not repeat the earlier hunks in later ones
Date: Wed, 04 Apr 2007 11:28:28 -0700
Message-ID: <7v8xd83sfn.fsf@assigned-by-dhcp.cox.net>
References: <7v1wj1ujf5.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0704041746580.4045@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Apr 04 20:35:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HZAK7-0000Jo-D9
	for gcvg-git@gmane.org; Wed, 04 Apr 2007 20:35:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753941AbXDDS3e (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 4 Apr 2007 14:29:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753940AbXDDS3U
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Apr 2007 14:29:20 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:44711 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752080AbXDDS3C (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Apr 2007 14:29:02 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070404182829.NUSL27119.fed1rmmtao107.cox.net@fed1rmimpo02.cox.net>;
          Wed, 4 Apr 2007 14:28:29 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id j6UU1W00g1kojtg0000000; Wed, 04 Apr 2007 14:28:29 -0400
In-Reply-To: <Pine.LNX.4.63.0704041746580.4045@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Wed, 4 Apr 2007 17:51:21 +0200
	(CEST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43763>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> I wonder if we should also do
>
> diff --git a/builtin-rerere.c b/builtin-rerere.c
> index b8867ab..4eae27b 100644
> --- a/builtin-rerere.c
> +++ b/builtin-rerere.c
> @@ -112,7 +112,8 @@ static int handle_file(const char *path,
>  		else if (!prefixcmp(buf, ">>>>>>> ")) {
>  			hunk_no++;
>  			hunk = 0;
> -			if (memcmp(one->ptr, two->ptr, one->nr < two->nr ?
> +			if (one->nr > two->nr || memcmp(one->ptr, two->ptr,
> +						one->nr < two->nr ?
>  						one->nr : two->nr) > 0) {
>  				struct buffer *swap = one;
>  				one = two;
>
> in case that one conflicting region is prefix of the other one.

If one is not a prefix of two but simply longer what does that
code do?
