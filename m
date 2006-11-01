X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 1/6] Allow pack header preprocessing before unpack-objects/index-pack.
Date: Wed, 01 Nov 2006 15:50:08 -0800
Message-ID: <7v3b92zpzj.fsf@assigned-by-dhcp.cox.net>
References: <11624187853116-git-send-email-nico@cam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 1 Nov 2006 23:50:25 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <11624187853116-git-send-email-nico@cam.org> (Nicolas Pitre's
	message of "Wed, 01 Nov 2006 17:06:20 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30675>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GfPqY-0001Cq-Rs for gcvg-git@gmane.org; Thu, 02 Nov
 2006 00:50:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1750855AbWKAXuK (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 1 Nov 2006
 18:50:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750897AbWKAXuK
 (ORCPT <rfc822;git-outgoing>); Wed, 1 Nov 2006 18:50:10 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:58591 "EHLO
 fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP id S1750882AbWKAXuJ
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 1 Nov 2006 18:50:09 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao09.cox.net
 (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP id
 <20061101235008.MQKO16798.fed1rmmtao09.cox.net@fed1rmimpo02.cox.net>; Wed, 1
 Nov 2006 18:50:08 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id hbqD1V00G1kojtg0000000 Wed, 01 Nov 2006
 18:50:13 -0500
To: Nicolas Pitre <nico@cam.org>
Sender: git-owner@vger.kernel.org

Rather nicely done.  I see upto 2/6 are identical to what has
sitting in "pu" for the past few days, modulo some indentation?

I wonder how much testing has this series seen, by the way.

Also, I wonder what happens after 5/6 errors out.  It dies and
the caller (typically receive-pack) reports it back, which would
fail the push (and does not update the refs).  Retrying in such
a case would probably use the same set of refs on both ends,
resulting in exactly the same pack...

