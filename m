X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: SEGV when lookup_* returns NULL
Date: Mon, 27 Nov 2006 13:55:21 -0800
Message-ID: <7vu00kftbq.fsf@assigned-by-dhcp.cox.net>
References: <20061127211315.GC18810@admingilde.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Mon, 27 Nov 2006 21:56:01 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <20061127211315.GC18810@admingilde.org> (Martin Waitz's message
	of "Mon, 27 Nov 2006 22:13:15 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32453>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GooRi-0001Lb-J0 for gcvg-git@gmane.org; Mon, 27 Nov
 2006 22:55:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S933778AbWK0VzX (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 27 Nov 2006
 16:55:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933793AbWK0VzX
 (ORCPT <rfc822;git-outgoing>); Mon, 27 Nov 2006 16:55:23 -0500
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:36277 "EHLO
 fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP id S933778AbWK0VzX
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 27 Nov 2006 16:55:23 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao07.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061127215522.NGNC27894.fed1rmmtao07.cox.net@fed1rmimpo01.cox.net>; Mon, 27
 Nov 2006 16:55:22 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id rxuq1V00Y1kojtg0000000; Mon, 27 Nov 2006
 16:54:51 -0500
To: Martin Waitz <tali@admingilde.org>
Sender: git-owner@vger.kernel.org

Martin Waitz <tali@admingilde.org> writes:

> All the lookup_{blob,tree,commit} functions check that the object
> really is of the requested type and return NULL otherwise.
> However this NULL pointer is not checked in the calling functions.
>
> Should we make lookup_* to just die when invoked on another object-type?

Making lookup_{specific type} die when they see unexpected type
would not hurt that much, I think, aside from the possibility
that some callers may check NULL to see if object already
exists, but they should be using has_sha1_file() instead.
