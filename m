X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Teach receive-pack how to keep pack files when unpacklooseobjects = 0.
Date: Mon, 30 Oct 2006 20:54:37 -0800
Message-ID: <7v7iyhrsoi.fsf@assigned-by-dhcp.cox.net>
References: <20061030223615.GH5775@spearce.org>
	<7vlkmxtmln.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0610302258400.11384@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Tue, 31 Oct 2006 04:54:52 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <Pine.LNX.4.64.0610302258400.11384@xanadu.home> (Nicolas Pitre's
	message of "Mon, 30 Oct 2006 23:08:56 -0500 (EST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30567>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GeleA-0007CM-Nk for gcvg-git@gmane.org; Tue, 31 Oct
 2006 05:54:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1422674AbWJaEyj (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 30 Oct 2006
 23:54:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422678AbWJaEyj
 (ORCPT <rfc822;git-outgoing>); Mon, 30 Oct 2006 23:54:39 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:27304 "EHLO
 fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP id S1422674AbWJaEyi
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 30 Oct 2006 23:54:38 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao10.cox.net
 (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP id
 <20061031045438.PWDK18985.fed1rmmtao10.cox.net@fed1rmimpo01.cox.net>; Mon, 30
 Oct 2006 23:54:38 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id gsuJ1V00V1kojtg0000000 Mon, 30 Oct 2006
 23:54:19 -0500
To: Nicolas Pitre <nico@cam.org>
Sender: git-owner@vger.kernel.org

Nicolas Pitre <nico@cam.org> writes:

> Why not just parse the pack header in receive-pack / fetch-pack, and 
> decide on the first-hand information?  Sure the pack header is then 
> gone, but then the only thing that is needed is an extra flag to both 
> unpack-objects and index-pack to tell them that we've already parsed the 
> pack header and that the pack version is x and the number of objects is 
> y.  Simply something like --pack_header=x,y.  No protocol extension 
> needed, no extra rev-list, no reliance on the remote server providing 
> the needed info.

I like it.

Because that approach assumes recieve-pack and unpack-objects
and index-pack are from the same vintage (otherwise your
receive-pack would need to have a way to see if unpack-objects
and index-pack would grok --pack_header argument), we could even
get away without passing the pack version if we wanted to.


