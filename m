From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] Do not show "diff --git" metainfo with --no-prefix
Date: Tue, 15 Jan 2008 20:18:55 -0800
Message-ID: <7vy7aqs8r4.fsf@gitster.siamese.dyndns.org>
References: <c0f2d4110801150559x155ffabaj6bea52715522a070@mail.gmail.com>
	<alpine.DEB.1.00.0801151444180.5289@eeepc-johanness>
	<c0f2d4110801150758t68714570y83e1e74acbb67325@mail.gmail.com>
	<alpine.LNX.1.00.0801151728120.13593@iabervon.org>
	<7vhched3kw.fsf@gitster.siamese.dyndns.org>
	<7v4pded1rk.fsf_-_@gitster.siamese.dyndns.org>
	<7v7iiabjyh.fsf_-_@gitster.siamese.dyndns.org>
	<alpine.LFD.1.00.0801151902080.2806@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Chris Ortman <chrisortman@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Jan 16 05:19:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JEzkh-0002xj-NT
	for gcvg-git-2@gmane.org; Wed, 16 Jan 2008 05:19:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753193AbYAPETT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jan 2008 23:19:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753186AbYAPETT
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Jan 2008 23:19:19 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:58190 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753179AbYAPETS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jan 2008 23:19:18 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 9D87A7B00;
	Tue, 15 Jan 2008 23:19:15 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id B43897AB7;
	Tue, 15 Jan 2008 23:19:06 -0500 (EST)
In-Reply-To: <alpine.LFD.1.00.0801151902080.2806@woody.linux-foundation.org>
	(Linus Torvalds's message of "Tue, 15 Jan 2008 19:09:51 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70621>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> We do not want to make it particularly easy for people to create 
> mind-bogglingly stupid diff output. 

Although the discussion was triggered by that Tortoise thing,
the RFC patch was not about helping that.  That's a new feature
asked long after we went into rc freeze, and I am not interested
in discussing such a feature, especially when I am sick.

The only objective was to make sure that a patch that is not
kosher in git-apply's eyes is not marked with "diff --git";
otherwise, its output will confuse git-apply.  As --no-prefix
will be a new feature in 1.5.4, we would be shipping with a
known-to-be-bad new feature that is --no-prefix, unless we do
something about it.  Fixing that breakage was the sole
motivation behind my patch.

I think a reasonable short-term solution might be to disable any
git specific stuff (renames, rewrites, etc) when --no-prefix and
its friends are used, along with the patch you are commenting on
to remove " --git" from the header.  That would at least make
sure that the --no-prefix feature is safe.
