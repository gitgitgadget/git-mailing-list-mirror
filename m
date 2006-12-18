X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Quy Tonthat <qtonthat@gmail.com>
Subject: Re: [PATCH] git-branch: deleting remote branches in new layout
Date: Mon, 18 Dec 2006 21:02:05 +1100
Message-ID: <4586671D.5020305@gmail.com>
References: <45863044.4040406@gmail.com>	<7vbqm13cm0.fsf@assigned-by-dhcp.cox.net> <7vodq11w49.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Mon, 18 Dec 2006 10:02:28 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
In-Reply-To: <7vodq11w49.fsf@assigned-by-dhcp.cox.net>
X-Enigmail-Version: 0.94.1.1
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34735>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GwFK2-0003CB-4Z for gcvg-git@gmane.org; Mon, 18 Dec
 2006 11:02:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1753701AbWLRKCK (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 18 Dec 2006
 05:02:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753704AbWLRKCK
 (ORCPT <rfc822;git-outgoing>); Mon, 18 Dec 2006 05:02:10 -0500
Received: from pecan-mail.exetel.com.au ([220.233.0.8]:33218 "EHLO
 pecan.exetel.com.au" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
 id S1753701AbWLRKCJ (ORCPT <rfc822;git@vger.kernel.org>); Mon, 18 Dec 2006
 05:02:09 -0500
Received: from 95.69.233.220.exetel.com.au ([220.233.69.95]
 helo=[192.168.64.35]) by pecan.exetel.com.au with esmtp (Exim 4.63)
 (envelope-from <qtonthat@gmail.com>) id 1GwFJv-0002Jt-Am; Mon, 18 Dec 2006
 21:02:07 +1100
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Junio C Hamano wrote:
> How about this instead?
> 
> Because -r already means "remote" when listing, you can say:
> 
> 	$ git branch -d -r origin/todo origin/html origin/man
> 
> I just twisted it not to do fast-forward check with the current
> branch, because remote tracking branches are more like tags than
> branches, and when you are removing them, most likely that is
> not because you are "done with" them (for a local branch, it
> usually means "you merged it up") but because you are not even
> interested in them.

It sure is much more unambiguous that way.

Users won't be able to mix "local" and "remote" on one command
line as they were with the old layout. But that's OK for such an
infrequently used command.

>  		if (!resolve_ref(name, sha1, 1, NULL))
> -			die("Branch '%s' not found.", argv[i]);
> +			die("%sbranch '%s' not found.", remote, argv[i]);

This should not be a fatal error. We should only give warning
and move on to the next item. The way "rm" does.

Quy
