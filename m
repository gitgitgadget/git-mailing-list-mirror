From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Provide a way to flush git-diff-tree's output
Date: Thu, 18 May 2006 00:24:14 -0700
Message-ID: <7vmzdf6bj5.fsf@assigned-by-dhcp.cox.net>
References: <17516.6955.282732.460675@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 18 09:24:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fgcrr-0003Cj-1T
	for gcvg-git@gmane.org; Thu, 18 May 2006 09:24:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750713AbWERHYQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 18 May 2006 03:24:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750741AbWERHYQ
	(ORCPT <rfc822;git-outgoing>); Thu, 18 May 2006 03:24:16 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:42470 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1750713AbWERHYP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 May 2006 03:24:15 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060518072415.DCIX24290.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 18 May 2006 03:24:15 -0400
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <17516.6955.282732.460675@cargo.ozlabs.ibm.com> (Paul Mackerras's
	message of "Thu, 18 May 2006 16:58:51 +1000")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20269>

Paul Mackerras <paulus@samba.org> writes:

> The --stdin flag to git-diff-tree is suitable for this, but the main
> difficulty is that the output of git-diff-tree gets buffered and
> doesn't get sent until the buffer is full.
>
> This provides a way to get git-diff-tree to flush its output buffers.
> If a blank line is supplied on git-diff-tree's standard input, it will
> flush its output buffers and then accept further input.

Sounds low impact and sane.

I suspect the usual caveat on bidirectional pipe deadlock
applies to the caller.  Does gitk do that?  The current code
seems to feed a pre-generated list with "open | cmd <<"
construct to the command, so perhaps you are planning to change
that?
