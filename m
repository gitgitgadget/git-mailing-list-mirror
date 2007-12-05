From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Soft aliases: add "less" and minimal documentation
Date: Wed, 05 Dec 2007 11:45:23 -0800
Message-ID: <7vd4tlorho.fsf@gitster.siamese.dyndns.org>
References: <20071022063222.GS14735@spearce.org>
	<7vzly84qwf.fsf@gitster.siamese.dyndns.org>
	<7vmytycykt.fsf@gitster.siamese.dyndns.org>
	<7vr6j6ve90.fsf@gitster.siamese.dyndns.org>
	<7vir4d40sw.fsf@gitster.siamese.dyndns.org>
	<7vwsso3poo.fsf@gitster.siamese.dyndns.org>
	<7vfxz89x9q.fsf@gitster.siamese.dyndns.org>
	<7vabpctx3b.fsf@gitster.siamese.dyndns.org>
	<7vsl30eyuk.fsf@gitster.siamese.dyndns.org>
	<7vve7tuz3a.fsf@gitster.siamese.dyndns.org>
	<7v4pfakr4j.fsf@gitster.siamese.dyndns.org>
	<7vzlwv6sxr.fsf@gitster.siamese.dyndns.org>
	<7vy7ca6ea9.fsf@gitster.siamese.dyndns.org>
	<7vzlwps8zf.fsf@gitster.siamese.dyndns.org>
	<Pine.LNX.4.64.0712051131120.27959@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Dec 05 20:48:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J00Dv-0004F4-57
	for gcvg-git-2@gmane.org; Wed, 05 Dec 2007 20:47:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755690AbXLETpc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Dec 2007 14:45:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754014AbXLETpb
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Dec 2007 14:45:31 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:45775 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755631AbXLETp3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Dec 2007 14:45:29 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 781A82F0;
	Wed,  5 Dec 2007 14:45:49 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id EA3E49D2F4;
	Wed,  5 Dec 2007 14:45:46 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67187>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Now you can use "git less HEAD" to view the raw HEAD commit object.  It
> is really a soft alias (i.e. it can be overridden by any user-specified
> alias) to "-p cat-file -p".

I actually regret to have suggested "git less".  Not only because you
can always say "git show" instead, but because the error message you
would get with usage string will _not_ say "git-less", but some other
command's name if you say "git less nonsense".

I on the other hand find the "view" alias moderately less problematic.
As long as the future direction for the "view" alias is to allow it to
notice user preference and launch something other than the default
"gitk", iow, it is crystal clear that "git view" is just a short-hand
for launching a history browser and the users are free to choose
whichever viewer available, it won't feel inconsistent if underlying
"gitk" barfed on malformed input using its own name.

But then the users can do all that themselves.  People who like qgit do
not have to configure "git view" to launch qgit but instead run their
favorite program directly.  One thing the built-in alias is possibly
bringing to the table is to give smaller number of commands people need
to learn, without having to know "gitk", "qgit", "tig", "gitview",
"instaweb", and possibly others, while at the same time enforcing a
policy that the history viewer of choice is aliased to "git view" (not
"git viewer" or "git visualize") to maintain a bit of consistency across
users.

By extension to this reasoning, I am not too keen on adding "update",
"up", "checkin", "ci", nor "co".  I do not think of any alternative
backend implementations to these aliases, which means that there isn't
even the advantage of giving a single front-end that lets the user do
the same thing using a choice from multiple backends and keeps the
interface simple for these names.
