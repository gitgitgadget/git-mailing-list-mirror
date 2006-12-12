X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Colourise git-branch output
Date: Tue, 12 Dec 2006 10:43:41 -0800
Message-ID: <7vpsapuf8i.fsf@assigned-by-dhcp.cox.net>
References: <200612120641.52556.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Tue, 12 Dec 2006 18:43:52 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34122>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GuCbU-00037s-66 for gcvg-git@gmane.org; Tue, 12 Dec
 2006 19:43:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932329AbWLLSnq (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 12 Dec 2006
 13:43:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932330AbWLLSnp
 (ORCPT <rfc822;git-outgoing>); Tue, 12 Dec 2006 13:43:45 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:46007 "EHLO
 fed1rmmtao08.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S932329AbWLLSno (ORCPT <rfc822;git@vger.kernel.org>); Tue, 12 Dec 2006
 13:43:44 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao08.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061212184342.KYRO16632.fed1rmmtao08.cox.net@fed1rmimpo01.cox.net>; Tue, 12
 Dec 2006 13:43:42 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id xuj31V00d1kojtg0000000; Tue, 12 Dec 2006
 13:43:04 -0500
To: Andy Parkins <andyparkins@gmail.com>
Sender: git-owner@vger.kernel.org

Andy Parkins <andyparkins@gmail.com> writes:

> The colour parameter is "color.branch" rather than "branch.color" to
> avoid clashing with the default namespace for default branch merge
> definitions.

Very nice.

>  		c = ' ';
>  		if (ref_list.list[i].kind == REF_LOCAL_BRANCH &&
> -				!strcmp(ref_list.list[i].name, head))
> +				!strcmp(ref_list.list[i].name, head)) {
>  			c = '*';
> +			color = COLOR_BRANCH_CURRENT;
> +		}
>  
>  		if (verbose) {
> -			printf("%c %-*s", c, ref_list.maxwidth,
> -			       ref_list.list[i].name);
> +			printf("%c %s%-*s%s", c,
> +					branch_get_color(color),
> +					ref_list.maxwidth,
> +					ref_list.list[i].name,
> +					branch_get_color(COLOR_BRANCH_RESET));
>  			print_ref_info(ref_list.list[i].sha1, abbrev);
>  		}
>  		else
> -			printf("%c %s\n", c, ref_list.list[i].name);
> +			printf("%c %s%s%s\n", c,
> +					branch_get_color(color),
> +					ref_list.list[i].name,
> +					branch_get_color(COLOR_BRANCH_RESET));
>  	}

Now this makes me wonder if under output coloring we would still
want the two-space indent and '*' prefix.
