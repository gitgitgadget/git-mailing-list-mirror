X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH/RFC] gitweb: Default to $hash_base or HEAD for $hash in "commit" and "commitdiff" views
Date: Wed, 08 Nov 2006 14:21:38 -0800
Message-ID: <7vvelpr34d.fsf@assigned-by-dhcp.cox.net>
References: <200611082311.35161.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 8 Nov 2006 22:23:02 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <200611082311.35161.jnareb@gmail.com> (Jakub Narebski's message
	of "Wed, 8 Nov 2006 23:11:34 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31163>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GhvoO-00013q-Og for gcvg-git@gmane.org; Wed, 08 Nov
 2006 23:22:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1161463AbWKHWVm (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 8 Nov 2006
 17:21:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161747AbWKHWVl
 (ORCPT <rfc822;git-outgoing>); Wed, 8 Nov 2006 17:21:41 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:27804 "EHLO
 fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP id S1161463AbWKHWVk
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 8 Nov 2006 17:21:40 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao08.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061108222139.VUPU18207.fed1rmmtao08.cox.net@fed1rmimpo02.cox.net>; Wed, 8
 Nov 2006 17:21:39 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id kNMk1V00G1kojtg0000000; Wed, 08 Nov 2006
 17:21:44 -0500
To: Jakub Narebski <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org

Jakub Narebski <jnareb@gmail.com> writes:

> Set $hash parameter to $hash_base || "HEAD" if it is not set (if it is
> not true to be more exact). This allows [hand-edited] URLs with 'action'
> "commit" or "commitdiff" but without 'hash' parameter.
>
> Signed-off-by: Jakub Narebski <jnareb@gmail.com>
> ---
> RFC because I want to ask if we should default to HEAD if hash is not
> provided for commit and commitdiff views, or should we error out with
> more reasonable error message.

Probably the latter; the user might be hand-crafting a URL
(maybe learned a commit object name from mailing list and
cutting and pasting) and mispasted the long hexadecimal string.
Silently giving HEAD may leave the user confused than "oops, we
do not see that commit object".
