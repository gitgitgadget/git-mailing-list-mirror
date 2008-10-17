From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Rebasing Multiple branches at once...
Date: Thu, 16 Oct 2008 19:00:41 -0700
Message-ID: <7vabd4q8ty.fsf@gitster.siamese.dyndns.org>
References: <48F730D0.9040008@calicojack.co.uk>
 <20081016135908.GI536@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Rick Moynihan <rick@calicojack.co.uk>, git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Fri Oct 17 04:02:03 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KqefC-0007mW-UI
	for gcvg-git-2@gmane.org; Fri, 17 Oct 2008 04:02:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752029AbYJQCAv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Oct 2008 22:00:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751517AbYJQCAv
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Oct 2008 22:00:51 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:63257 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751322AbYJQCAv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Oct 2008 22:00:51 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id E787C8C307;
	Thu, 16 Oct 2008 22:00:49 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 64A1B8C302; Thu, 16 Oct 2008 22:00:45 -0400 (EDT)
In-Reply-To: <20081016135908.GI536@genesis.frugalware.org> (Miklos Vajna's
 message of "Thu, 16 Oct 2008 15:59:08 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 6BD1BF5C-9BEF-11DD-970E-4F5276724C3F-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98442>

Miklos Vajna <vmiklos@frugalware.org> writes:

> On Thu, Oct 16, 2008 at 01:17:20PM +0100, Rick Moynihan <rick@calicojack.co.uk> wrote:
>> I have a master branch, a dev branch and a number of feature branches from 
>> dev.  And I was wondering if there was an easy way to rebase dev and all of 
>> it's sub-branches onto master.
>
> In general this is considered harmful. Why do you rebase your branch
> from time to time? For example in git.git, topic branches are based on
> master, then merged to master when they are ready, but they are never
> rebased.

I do not think it is harmful per-se as long as they are not published.

But rebasing topic branches regularly (i.e. without reasons better than
"the master has more commits than before") is _pointless_.  The whole
point of a topic branch is to house the development related to one single
topic.  If you keep rebasing it, its progress (when you look at the
differences between topic@{1} and topic, topic@{2} and topic@{1}, ...)
would not be about the single topic, but about the single topic _and
all the other random things that happened on the master branch_.

When you merge a topic branch that forked from an older version of
'master', you may have conflicts, and you may want to resolve it earlier
and that might be why you would want to rebase.  But if you _know_ you are
going to have conflicts, you wouldn't wish to rebase all of them at once
to begin with, as you would need to resolve such conflicts yourself
anyway.  On the other hand, if you expect there won't be any conflict,
then there absolutely is no point in rebasing them.  If you want to make
sure that your topics would all work with the updated 'master', you are
much better off creating trial tree, merging your topics on top of the
updated 'master' one by one, than rebasing all of your topic branches.
