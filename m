X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Colourise git-branch output
Date: Fri, 03 Nov 2006 11:25:59 -0800
Message-ID: <7v3b908h88.fsf@assigned-by-dhcp.cox.net>
References: <200611031052.16095.andyparkins@gmail.com>
	<200611031206.12515.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Fri, 3 Nov 2006 19:26:22 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <200611031206.12515.andyparkins@gmail.com> (Andy Parkins's
	message of "Fri, 3 Nov 2006 12:06:12 +0000")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30876>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gg4g2-0006Si-HF for gcvg-git@gmane.org; Fri, 03 Nov
 2006 20:26:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1753488AbWKCT0B (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 3 Nov 2006
 14:26:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753490AbWKCT0B
 (ORCPT <rfc822;git-outgoing>); Fri, 3 Nov 2006 14:26:01 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:25784 "EHLO
 fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP id S1753488AbWKCT0A
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 3 Nov 2006 14:26:00 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao08.cox.net
 (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP id
 <20061103192600.GCFZ22977.fed1rmmtao08.cox.net@fed1rmimpo01.cox.net>; Fri, 3
 Nov 2006 14:26:00 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id iKRe1V00e1kojtg0000000 Fri, 03 Nov 2006
 14:25:39 -0500
To: Andy Parkins <andyparkins@gmail.com>
Sender: git-owner@vger.kernel.org

Andy Parkins <andyparkins@gmail.com> writes:

> I wanted to have a visual indication of which branches are
> local and which are remote in git-branch -a output; however
> Junio was concerned that someone might be using the output in
> a script.  This patch addresses the problem by colouring the
> git-branch output - which in "auto" mode won't be activated.

Yuck.  We are getting more and more color happy.  As long as
this stays optional I'm Ok with it; we'll see if people find it
useful soon enough.

> @@ -165,11 +199,28 @@ static void print_ref_list( int type_wan
>  	qsort(ref_list.list, ref_list.index, sizeof(struct ref_item), ref_cmp);
>  
>  	for (i = 0; i < ref_list.index; i++) {
> +		switch( ref_list.list[i].type ) {
> +			case REF_LOCAL_BRANCH:
> +				color = COLOR_BRANCH_LOCAL;
> +				break;

Style.  SP between "switch" and open parenthesis, no SP after
that open parenthesis.  We tend to align "switch", "case", and
"default" on the same column.
