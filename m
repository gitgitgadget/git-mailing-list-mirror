From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH] rebase -i: avoid checking out $branch when possible
Date: Fri, 20 Apr 2012 18:01:32 +0200
Message-ID: <87lilqjstf.fsf@thomas.inf.ethz.ch>
References: <fee3225e29915e1b61e29a5d2fe37db20fa4b596.1334933837.git.trast@student.ethz.ch>
	<xmqqwr5atn89.fsf@junio.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: Thomas Rast <trast@student.ethz.ch>, <git@vger.kernel.org>,
	"Martin von Zweigbergk" <martin.von.zweigbergk@gmail.com>,
	Shezan Baig <shezbaig.wk@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 20 18:01:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SLGHF-0002Tw-4c
	for gcvg-git-2@plane.gmane.org; Fri, 20 Apr 2012 18:01:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757228Ab2DTQBg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Apr 2012 12:01:36 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:57290 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755032Ab2DTQBg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Apr 2012 12:01:36 -0400
Received: from CAS20.d.ethz.ch (172.31.51.110) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.283.3; Fri, 20 Apr
 2012 18:01:30 +0200
Received: from thomas.inf.ethz.ch.ethz.ch (129.132.153.233) by CAS20.d.ethz.ch
 (172.31.51.110) with Microsoft SMTP Server (TLS) id 14.1.355.2; Fri, 20 Apr
 2012 18:01:33 +0200
In-Reply-To: <xmqqwr5atn89.fsf@junio.mtv.corp.google.com> (Junio C. Hamano's
	message of "Fri, 20 Apr 2012 08:52:06 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196006>

Junio C Hamano <gitster@pobox.com> writes:

> Thomas Rast <trast@student.ethz.ch> writes:
>
>> I was a bit torn on whether I should abort with checkout, or without
>> it.  The manual clearly states that rebase "will perform an automatic
>> git checkout <branch> before doing anything else", which mandates at
>> least *trying* the checkout in the error path, hence this version.
>>
>> However, in contrived cases this can lead to strange behavior.  For
>> example, a checkout conflict with a file in the worktree may prevent
>> the abort path from working correctly, even though going through with
>> the rebase itself may succeed.
>
> Given all that contortion, is it even worth doing this?

Well, the logic isn't new; 0cb0664 already does the same.  It just never
carried over to interactive rebase.

As to whether the whole thing is worth it: if you rebase all your topics
against master regularly, and 'make test' on each, this patch may speed
that up greatly if you are careful about using a branch argument for
rebase.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
