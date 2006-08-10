From: Junio C Hamano <junkio@cox.net>
Subject: Re: diff machinery cleanup
Date: Thu, 10 Aug 2006 10:06:42 -0700
Message-ID: <7vzmecv7tp.fsf@assigned-by-dhcp.cox.net>
References: <20060810082455.GA30739@coredump.intra.peff.net>
	<7vejvpvsni.fsf@assigned-by-dhcp.cox.net>
	<20060810103836.GA1317@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 10 19:06:49 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GBDzc-0000xj-R8
	for gcvg-git@gmane.org; Thu, 10 Aug 2006 19:06:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161462AbWHJRGo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 10 Aug 2006 13:06:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161464AbWHJRGo
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Aug 2006 13:06:44 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:62598 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S1161462AbWHJRGo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Aug 2006 13:06:44 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060810170643.OHXI18458.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 10 Aug 2006 13:06:43 -0400
To: Jeff King <peff@peff.net>
In-Reply-To: <20060810103836.GA1317@coredump.intra.peff.net> (Jeff King's
	message of "Thu, 10 Aug 2006 06:38:37 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25202>

Jeff King <peff@peff.net> writes:

> OK, doing a discard_cache() between the call to run_diff_index and
> run_diff_files seems to clear up the problem. But if I understand
> correctly, are you saying that run_diff_index has munged the index on
> disk, and I really need to be poking at a temporary copy? If so, why
> isn't that a problem when running (e.g.) "git-diff-index; git-ls-files"?

No, run_diff_index munges the index in-core, and it does not
writes it out for obvious reasons.

Some of the "interrogation commands" do munge the index without
writing it out because that is the easiest/cleanest way to
implement what they do.  ls-files does it to filter by paths,
for example.

> That does sound the cleanest, and it would enable a more useful status
> message, as you mentioned before. What caused you to stop working on it?
> Infeasible, or simply more infeasible than you would like right now?

Finding out somebody was already working on it?
