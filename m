X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH 1/2] Suggest use of 'git add' when 'nothing to commit'
 gets shown.
Date: Fri, 15 Dec 2006 10:11:48 +0100
Message-ID: <458266D4.5050301@op5.se>
References: <20061215001350.GA26755@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Fri, 15 Dec 2006 09:12:08 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
	Andy Parkins <andyparkins@gmail.com>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
In-Reply-To: <20061215001350.GA26755@spearce.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34482>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gv96p-0003kt-2z for gcvg-git@gmane.org; Fri, 15 Dec
 2006 10:12:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751327AbWLOJLv (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 15 Dec 2006
 04:11:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751346AbWLOJLv
 (ORCPT <rfc822;git-outgoing>); Fri, 15 Dec 2006 04:11:51 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:48651 "EHLO
 smtp-gw1.op5.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id
 S1751327AbWLOJLu (ORCPT <rfc822;git@vger.kernel.org>); Fri, 15 Dec 2006
 04:11:50 -0500
Received: from [192.168.1.20] (unknown [213.88.215.14]) by smtp-gw1.op5.se
 (Postfix) with ESMTP id 1043C6BCBC; Fri, 15 Dec 2006 10:11:49 +0100 (CET)
To: "Shawn O. Pearce" <spearce@spearce.org>
Sender: git-owner@vger.kernel.org

Shawn O. Pearce wrote:
>  else
>  	if [ -z "$(git-ls-files)" ]; then
> -		echo >&2 Nothing to commit
> +		echo >&2 "Nothing to commit (use \"git add\" include for commit)"

s/git add include/git add to include/

>  		exit 1
>  	fi
>  	PARENTS=""
> diff --git a/wt-status.c b/wt-status.c
> index 6e9414d..f9ed54f 100644
> --- a/wt-status.c
> +++ b/wt-status.c
> @@ -163,7 +163,7 @@ static void wt_status_print_changed_cb(struct diff_queue_struct *q,
>  	int i;
>  	if (q->nr)
>  		wt_status_print_header("Changed but not updated",
> -				"use git-add on files to include for commit");
> +				"use \"git add\" on files to include for commit");

Here it's "on files", whereas in other threads people have stated that 
git add adds content, so perhaps

use \"git add file1 file2\" to include for commit

which also gives a nice "simplest-possible-usage" message.


>  		if (!shown_header) {
>  			wt_status_print_header("Untracked files",
> -				"use \"git add\" to add to commit");
> +				"use \"git add\" on files to include for commit");

Same here.


>  	if (!s->commitable)
> -		printf("%s\n", s->amend ? "# No changes" : "nothing to commit");
> +		printf("%s (use \"git add\" include for commit)\n",
> +			s->amend ? "# No changes" : "Nothing to commit");
>  }

This is same as first one (missing "to " before "include").

It would probably be nice to use one and the same message everywhere though.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
