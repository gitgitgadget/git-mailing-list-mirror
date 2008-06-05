From: Junio C Hamano <gitster@pobox.com>
Subject: Re: log --graph --first-parent weirdness
Date: Thu, 05 Jun 2008 11:31:10 -0700
Message-ID: <7vbq2f3f9t.fsf@gitster.siamese.dyndns.org>
References: <20080604150042.GA3038@mithlond.arda.local>
 <7vmym1xgy4.fsf@gitster.siamese.dyndns.org>
 <20080604173820.GA3038@mithlond.arda.local>
 <7v1w3dxeh9.fsf@gitster.siamese.dyndns.org>
 <20080605095033.GC5946@mithlond.arda.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Adam Simpkins <adam@adamsimpkins.net>, git@vger.kernel.org
To: Teemu Likonen <tlikonen@iki.fi>
X-From: git-owner@vger.kernel.org Thu Jun 05 20:32:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4KG8-0004OF-1c
	for gcvg-git-2@gmane.org; Thu, 05 Jun 2008 20:32:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754003AbYFESbb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Jun 2008 14:31:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753944AbYFESba
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Jun 2008 14:31:30 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:47187 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753289AbYFESb3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jun 2008 14:31:29 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 1E6E95399;
	Thu,  5 Jun 2008 14:31:23 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 20FE55396; Thu,  5 Jun 2008 14:31:17 -0400 (EDT)
In-Reply-To: <20080605095033.GC5946@mithlond.arda.local> (Teemu Likonen's
 message of "Thu, 5 Jun 2008 12:50:33 +0300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 9965EA7C-332D-11DD-A804-F9737025C2AA-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83950>

Teemu Likonen <tlikonen@iki.fi> writes:

> Well, I disagree :-) Merges are interesting points in history (they
> introduce features etc.) and for a "--graph --first-parent" user
> a certain already known merge is easier to find if there is a stable
> identifier for them.

Step back a bit.  Regular commits also introduce features.  If you want to
argue for marking a merge as more significant than single parent commits,
you need to justify the reason why a bit better.

When you are looking at a history (be it 'first-parent' or regular), each
transition introduces changes, but especially when you are talking about
first-parent, a merge is merely a squashed commit of everything that
happened on the side branch, which may be trivial one-liner fix or an
addition of full new command.  Why a merge of trivial one-liner fix should
be treated as more significant than a more involved change that directly
was done on the master branch?

A full and perfect implementation of a new command may have happened on a
side branch as a single commit.  If the master branch was dormant while it
was being done, the final merge of that side branch will result in a
fast-forward, and the introduction of the new command would appear as a
non-merge, regular commit.  If on the other hand there were activities on
master since the side branch forked, the introduction of the new command
would appear as a merge.  Why do you paint the latter as more significant
than the former?

If somebody argues for making the marking different (perhaps by color-code
the asterisk differently) depending on how much each commit changes the
tree relative to its parents, I would say it might be a great feature.
Such a display would treat the two cases I mentioned above equally.

I however do not think the number of recorded parents deserves such a
special treatment to clutter the output and distract people, especially
when "is it a merge?" can be easily seen by two other means (log message
and graph lines).
