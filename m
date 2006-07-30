From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 1/3] read-trees: refactor the unpack_trees() part
Date: Sun, 30 Jul 2006 14:36:40 -0700
Message-ID: <7v4pwydbbr.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0607302024090.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 30 23:36:59 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G7Ixw-0003TB-2Z
	for gcvg-git@gmane.org; Sun, 30 Jul 2006 23:36:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932346AbWG3Vgm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 30 Jul 2006 17:36:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932393AbWG3Vgm
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Jul 2006 17:36:42 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:8603 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S932346AbWG3Vgl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Jul 2006 17:36:41 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060730213641.RFPC2704.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 30 Jul 2006 17:36:41 -0400
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0607302024090.29667@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Sun, 30 Jul 2006 20:25:18 +0200
	(CEST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24474>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> diff --git a/unpack-trees.h b/unpack-trees.h
> new file mode 100644
> index 0000000..babfcd7
> --- /dev/null
> +++ b/unpack-trees.h
> @@ -0,0 +1,30 @@
> +#ifndef UNPACK_TREES_H
> +#define UNPACK_TREES_H
>...
> +struct unpack_trees_options {
> +	int reset;
> +	int merge;
> +	int update;
> +	int index_only;
> +	int nontrivial_merge;
> +	int trivial_merges_only;
> +	int verbose_update;
> +	int aggressive;
> +	const char *prefix;
> +	merge_fn_t fn;
> +
> +	int head_idx;
> +	int merge_size;
> +
> +	struct cache_entry df_conflict_entry;
> +};

Hmmmm.....

gcc -o unpack-trees.o -c -O2 -Werror -ansi -pedantic -std=c99 -D_XOPEN_SOURCE=500 -D_BSD_SOURCE -Wall -Wdeclaration-after-statement -g -DSHA1_HEADER='<openssl/sha.h>' -DNO_STRLCPY unpack-trees.c
cc1: warnings being treated as errors
In file included from unpack-trees.c:7:
unpack-trees.h:24: warning: invalid use of structure with flexible array member
make: *** [unpack-trees.o] Error 1
