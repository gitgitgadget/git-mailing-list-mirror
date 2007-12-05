From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4] Allow update hooks to update refs on their own.
Date: Wed, 05 Dec 2007 14:19:58 -0800
Message-ID: <7vhciwn5rl.fsf@gitster.siamese.dyndns.org>
References: <7vr6i8sfsa.fsf@gitster.siamese.dyndns.org>
	<20071202212224.GA22117@midwinter.com>
	<20071203021333.GC8322@coredump.intra.peff.net>
	<7vlk8csetl.fsf@gitster.siamese.dyndns.org>
	<5920F34B-A94B-4C24-A95B-D35F35A4F0C0@midwinter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Steven Grimm <koreth@midwinter.com>
X-From: git-owner@vger.kernel.org Wed Dec 05 23:20:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J02bV-0008K0-St
	for gcvg-git-2@gmane.org; Wed, 05 Dec 2007 23:20:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752129AbXLEWUG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Dec 2007 17:20:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751754AbXLEWUG
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Dec 2007 17:20:06 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:40237 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752068AbXLEWUE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Dec 2007 17:20:04 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id DE5882EF;
	Wed,  5 Dec 2007 17:20:25 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 61A5C9D503;
	Wed,  5 Dec 2007 17:20:22 -0500 (EST)
In-Reply-To: <5920F34B-A94B-4C24-A95B-D35F35A4F0C0@midwinter.com> (Steven
	Grimm's message of "Wed, 5 Dec 2007 14:14:17 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67205>

Steven Grimm <koreth@midwinter.com> writes:

> On Dec 2, 2007, at 6:16 PM, Junio C Hamano wrote:
>>> ..., but an
>>> "ok, but btw I changed your commit" status from receive-pack seems
>>> like
>>> it would be useful, for two reasons:
>> Sensible argument.  I stand corrected.
>
> If we want that status in principle, I'd argue that sending down the
> updated commit SHA1 is actually the right way to indicate it, because
> it gives the client all the information it needs to make an
> intelligent choice about what to do next. If you don't transmit the
> modified SHA1, the client will have to do another fetch to find out
> what rewriting was done by the server, and if another push happened in
> the meantime, the client will have to basically guess about which
> commits correspond to the ones it pushed.

Ok, but the output from fetch is meant to be human readable and we do
not promise parsability, so if we go this route (which I think you made
a sensible argument for) we would need a hook on the pushing end to act
on this (perhaps record the correspondence of pushed and rewritten sha1
somewhere for the hook's own use).
