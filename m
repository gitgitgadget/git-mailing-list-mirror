X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: Making literal "20" symbolic
Date: Mon, 20 Nov 2006 02:54:59 -0800
Message-ID: <7v7ixq4ccc.fsf@assigned-by-dhcp.cox.net>
References: <200611201049.41024.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Mon, 20 Nov 2006 10:55:37 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <200611201049.41024.andyparkins@gmail.com> (Andy Parkins's
	message of "Mon, 20 Nov 2006 11:49:35 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31902>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gm6no-0004ga-Pz for gcvg-git@gmane.org; Mon, 20 Nov
 2006 11:55:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1755903AbWKTKzA (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 20 Nov 2006
 05:55:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755905AbWKTKzA
 (ORCPT <rfc822;git-outgoing>); Mon, 20 Nov 2006 05:55:00 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:27547 "EHLO
 fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP id S1755903AbWKTKzA
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 20 Nov 2006 05:55:00 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao03.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061120105459.OAPV4817.fed1rmmtao03.cox.net@fed1rmimpo01.cox.net>; Mon, 20
 Nov 2006 05:54:59 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id oyuW1V00S1kojtg0000000; Mon, 20 Nov 2006
 05:54:31 -0500
To: Andy Parkins <andyparkins@gmail.com>
Sender: git-owner@vger.kernel.org

Andy Parkins <andyparkins@gmail.com> writes:

> I notice that there are a lot of uses of the literal 20 throughout git; I'd 
> like to change them (as appropriate) to HASH_WIDTH, or similar; and maybe 
> HASH_WIDTH_ASCII for the 40s.
>
> Is there a particular header file that is appropriate to put 
>
> #define HASH_WIDTH 20
> #define HASH_WIDTH_ASCII (HASH_WIDTH*2)
>
> Of course, I plan to review each instance to make sure I'm not changing a 
> non-hash width 20.

Probably in cache.h, close to where it defines is_null_sha1(),
hashcmp(), and friends, is the right place.

There are few places that say 42 (because we have 40-hex at the
beginning of line, followed by a single whitespace and then
something should follow so line length must be at least 42
chars), so hunting them all would be a lot of work, but I do
think this is a worthwhile cleanup.
