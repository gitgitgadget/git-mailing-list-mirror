From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] builtin-grep: workaround for non GNU grep.
Date: Wed, 17 May 2006 11:59:34 -0700
Message-ID: <7vodxwcwa1.fsf@assigned-by-dhcp.cox.net>
References: <f3d7535d0605161652n3b2ec033r874336082755e728@mail.gmail.com>
	<Pine.LNX.4.64.0605161904260.16475@g5.osdl.org>
	<7vejythvkr.fsf@assigned-by-dhcp.cox.net>
	<7vves5geng.fsf_-_@assigned-by-dhcp.cox.net>
	<4fb292fa0605170839r259732dcw1c1bae3f1808db32@mail.gmail.com>
	<7vhd3ofsyv.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0605171109170.10823@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 17 21:00:01 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FgRFC-0006cu-VR
	for gcvg-git@gmane.org; Wed, 17 May 2006 20:59:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750969AbWEQS7g (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 17 May 2006 14:59:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750976AbWEQS7g
	(ORCPT <rfc822;git-outgoing>); Wed, 17 May 2006 14:59:36 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:12228 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S1750968AbWEQS7f (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 May 2006 14:59:35 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060517185935.HVBF17501.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 17 May 2006 14:59:35 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0605171109170.10823@g5.osdl.org> (Linus Torvalds's
	message of "Wed, 17 May 2006 11:12:22 -0700 (PDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20224>

Linus Torvalds <torvalds@osdl.org> writes:

> I think this is portable and correct.
>
> Of course, it still ignores the fact that not all grep's support some of 
> the flags like -F/-L/-A/-C etc, but for those cases, the external grep 
> itself will happily just say "unrecognized option -F" or similar.
>
> So with this change, "git grep" should handle all the flags the native 
> grep handles, which is really quite fine. We don't _need_ to expose 
> anything more, and if you do want our extensions, you can get them with 
> "--uncached" and an up-to-date index.
>
> No configuration necessary, and we automatically take advantage of any 
> native grep we have, if possible.

This makes -c misbehave in a subtle way.

	git grep -c -e no-such-string-anywhere | head -n 1

But I do not think we care.
