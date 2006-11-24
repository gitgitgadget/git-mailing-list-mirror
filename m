X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Salikh Zakirov <Salikh.Zakirov@Intel.com>
Subject: Re: [PATCH] Make git-clone --use-separate-remote the default
Date: Fri, 24 Nov 2006 14:56:52 +0300
Message-ID: <ek6mm5$j2f$1@sea.gmane.org>
References: <20061123225835.30071.99265.stgit@machine.or.cz>	<7vejrtiwqd.fsf@assigned-by-dhcp.cox.net>	<20061123234203.GN7201@pasky.or.cz>	<7vlkm1hf57.fsf@assigned-by-dhcp.cox.net>	<7vzmahe6qe.fsf@assigned-by-dhcp.cox.net>	<7vpsbde4fy.fsf@assigned-by-dhcp.cox.net> <ek6glc$pn$1@sea.gmane.org> <7vslg9axzv.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Fri, 24 Nov 2006 11:57:33 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 30
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: msfwpr01.ims.intel.com
User-Agent: Thunderbird 1.5.0.8 (Windows/20061025)
In-Reply-To: <7vslg9axzv.fsf@assigned-by-dhcp.cox.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32213>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GnZgE-0006BH-KA for gcvg-git@gmane.org; Fri, 24 Nov
 2006 12:57:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S934292AbWKXL5O (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 24 Nov 2006
 06:57:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934285AbWKXL5O
 (ORCPT <rfc822;git-outgoing>); Fri, 24 Nov 2006 06:57:14 -0500
Received: from main.gmane.org ([80.91.229.2]:61919 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S934292AbWKXL5N (ORCPT
 <rfc822;git@vger.kernel.org>); Fri, 24 Nov 2006 06:57:13 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1GnZg3-00068f-IX for git@vger.kernel.org; Fri, 24 Nov 2006 12:57:07 +0100
Received: from msfwpr01.ims.intel.com ([62.118.80.132]) by main.gmane.org
 with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Fri, 24 Nov 2006 12:57:07 +0100
Received: from Salikh.Zakirov by msfwpr01.ims.intel.com with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Fri, 24 Nov 2006
 12:57:07 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Junio C Hamano wrote:
> and if you write
> 
> 	git push $remote master
> 
> it is handled exactly as if you wrote:
> 
> 	git push $remote master:master
> 
> The manual correctly describes the above, but the issue the fix
> addresses is about what happens to that 'master' string that
> follows the colon, and the 'master' string becomes ambiguous if
> the remote end uses separate-remote layout.

Indeed, the manual describes it correctly.
My point is that this semantics fairly complex
and easy to understand incorrectly.

> Even under separate-remote layout, we would want to be able to
> say:
> 
> 	git push master
> 
> to mean we want to push to remote's heads/master when the remote
> has remotes/{origin,blech}/master.

I agree with your main point that 'git push master' should "just work"
for all existing and new repositories, however,
it is very confusing that 'git push master' can update something other than
refs/heads/master, depending on the refs existing in the remote repo.
