From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Make sure the diff machinery outputs "\ No newline ..." in english
Date: Sun, 04 Sep 2005 11:48:08 -0700
Message-ID: <7vd5nohdp3.fsf@assigned-by-dhcp.cox.net>
References: <20050904181724.GA23525@c165.ib.student.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, junkio@cox.net
X-From: git-owner@vger.kernel.org Sun Sep 04 20:49:14 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EBzXK-00069H-1c
	for gcvg-git@gmane.org; Sun, 04 Sep 2005 20:48:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751000AbVIDSsL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 4 Sep 2005 14:48:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751002AbVIDSsL
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Sep 2005 14:48:11 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:6380 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S1750992AbVIDSsK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Sep 2005 14:48:10 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050904184810.OPIB2438.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 4 Sep 2005 14:48:10 -0400
To: Fredrik Kuivinen <freku045@student.liu.se>
In-Reply-To: <20050904181724.GA23525@c165.ib.student.liu.se> (Fredrik
	Kuivinen's message of "Sun, 4 Sep 2005 20:17:24 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8067>

Fredrik Kuivinen <freku045@student.liu.se> writes:

> In non-english locales diff(1) do sometimes output "\ No newline at end of
> file" in some other language. Set LC_ALL to C before execing diff to avoid
> this behaviour.
>
> Signed-off-by: Fredrik Kuivinen <freku045@student.liu.se>

I was thinking about this when I was examining your other patch.

What else, other than the incomplete line marker (and timestamp
output it uses by default, which we disable by passing explicit
-L flags), are affected by locale in diff output?

Especially, if the diff output is more readable for human
consumers (i.e. reviewers) without making it harder to use to
machine consumers (i.e. patch or git-apply) when generated under
a locale that is 'native' to the data, this patch robs from
users the possibility of doing so.

IOW, in a Swedes-only project that tracks a document in Swedish,
it _might_ be friendlier and more useful to the users if allowed
generating diffs under sv_SE locale, as long as such a diff does
not make the processing by patch and git-apply more difficult
(which your other patch already solved for git-apply).
