From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Fix git-fsck-cache segfault on invalid tag
Date: Fri, 20 May 2005 06:58:07 -0700
Message-ID: <7voeb6uhhs.fsf@assigned-by-dhcp.cox.net>
References: <428D8B19.4070605@tuxrocks.com>
	<20050520085047.GA27787@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Frank Sorenson <frank@tuxrocks.com>,
	Git Mailing List <git@vger.kernel.org>,
	Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Fri May 20 15:59:52 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DZ80C-0004Vh-5B
	for gcvg-git@gmane.org; Fri, 20 May 2005 15:57:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261468AbVETN6Q (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 May 2005 09:58:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261470AbVETN6Q
	(ORCPT <rfc822;git-outgoing>); Fri, 20 May 2005 09:58:16 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:33462 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S261468AbVETN6J (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 May 2005 09:58:09 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050520135809.RDRW23392.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 20 May 2005 09:58:09 -0400
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050520085047.GA27787@pasky.ji.cz> (Petr Baudis's message of
 "Fri, 20 May 2005 10:50:47 +0200")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "PB" == Petr Baudis <pasky@ucw.cz> writes:

>> obj = lookup_object(sha1);
>> +	if (!obj) {
>> +		fprintf(stderr, "invalid tag %s - %s\n", path, hexname);
>> +		return;
>> +	}
>> ...

PB> My error message is
PB> 	error("%s: invalid sha1 pointer %.40s", path, hexname);
PB> I'd prefer that (at least use the error() call).

Ack.

I was about to say "doesn't lookup_object() give its own error
message before you say that, though?" because I remembered a
comment to that effect around ll 410 that gets the heads from
the command line argument, and then looked at lookup_object()
implementation to find that it does _not_ give error message.

So if you are going to do this, would you mind giving similar
error message to that command line heads stuff while you are at
it, please?

