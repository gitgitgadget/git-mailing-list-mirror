From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] push: Add '--current', which pushes only the current branch
Date: Sun, 18 Nov 2007 23:50:54 -0800
Message-ID: <7v4pfiptb5.fsf@gitster.siamese.dyndns.org>
References: <Pine.LNX.4.64.0711121501500.4362@racer.site>
	<11954023881802-git-send-email-prohaska@zib.de>
	<119540238994-git-send-email-prohaska@zib.de>
	<7vwssfqb0w.fsf@gitster.siamese.dyndns.org>
	<EA5C3227-12E1-43C4-96E8-43BABF26792B@zib.de>
	<7vejempudf.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Mon Nov 19 08:51:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iu1Pb-0005ho-HW
	for gcvg-git-2@gmane.org; Mon, 19 Nov 2007 08:51:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750988AbXKSHvC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Nov 2007 02:51:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751215AbXKSHvB
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Nov 2007 02:51:01 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:44940 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750914AbXKSHvA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Nov 2007 02:51:00 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 3AD282FA;
	Mon, 19 Nov 2007 02:51:21 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id A871D958C3;
	Mon, 19 Nov 2007 02:51:17 -0500 (EST)
In-Reply-To: <7vejempudf.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
	message of "Sun, 18 Nov 2007 23:27:56 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65410>

Junio C Hamano <gitster@pobox.com> writes:

> Steffen Prohaska <prohaska@zib.de> writes:
> ...
>> I think 3) is the interesting case.  "git push" should do
>> nothing by default.
>
> NO WAY.
>
> Making things cumbersome to everybody does not achieve anything
> useful except for a false sense of equality, does it?
>
> Drop that step (3).  That is not useful to anybody.

Thinking about it a bit more, I think my wording was a bit too
strong and needs clarifying explanations.

In a case like this, a fix of a "misfeature" for somebody is a
regression for somebody else.  Because there is no single right
default that is appropriate for everybody.

At least having _one_ default (and picking arbitrarily the
historical default as that one default) is better than no
default at all.  The former will not inconvenience anybody by
forcing what has been necessary from before.  The latter will
hurt the lucky ones whose preferred way happened to be the
historical default.

Keeping the status quo, however, will inconvinience unfortunate
people whose preferred way was not the historical default.
That's where we start to tackle the problem, by introducing the
configuration variable.

If we can come up with a way to tell projects that use the
workflow better served with --current, perhaps when a remote is
added to the repository (either the initial clone or "git remote
add") and/or when a new branch is created.  If we automatically
set up the configuration "push.defaultRefs = current" in such a
case, I suspect that we do not have to have the built-in default
(at least, the value of the built-in default would not matter
much).
