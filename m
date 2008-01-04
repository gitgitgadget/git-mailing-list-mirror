From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-am: Run git gc only once and not for every patch.
Date: Fri, 04 Jan 2008 12:38:15 -0800
Message-ID: <7vhchtjphk.fsf@gitster.siamese.dyndns.org>
References: <20080104185926.GA11912@redhat.com>
	<alpine.LFD.1.00.0801041437190.2649@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@cam.org>, git@vger.kernel.org
To: Michael Stefaniuc <mstefani@redhat.com>
X-From: git-owner@vger.kernel.org Fri Jan 04 21:39:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JAtJv-000356-RO
	for gcvg-git-2@gmane.org; Fri, 04 Jan 2008 21:39:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753984AbYADUiZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Jan 2008 15:38:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753985AbYADUiZ
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Jan 2008 15:38:25 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:65466 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753982AbYADUiY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Jan 2008 15:38:24 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 06AB44A49;
	Fri,  4 Jan 2008 15:38:22 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 6FFCF4A48;
	Fri,  4 Jan 2008 15:38:17 -0500 (EST)
In-Reply-To: <alpine.LFD.1.00.0801041437190.2649@xanadu.home> (Nicolas Pitre's
	message of "Fri, 04 Jan 2008 14:38:42 -0500 (EST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69602>

Nicolas Pitre <nico@cam.org> writes:

> On Fri, 4 Jan 2008, Michael Stefaniuc wrote:
>
>> With "too many unreachable loose objects" git gc --auto will always
>> trigger. This clutters the output of git am and thus git rebase.
>> 
>> The work flow of the Wine project doesn't include git merge. git rebase
>> is therefor used to track the origin. This will produce soon too many
>> loose objects for git gc --auto's taste. Pruning the repository would
>> "fix" it. But we tell Wine developers new to git to NOT prune as long as
>> they aren't confident enough with git; just as a safety net in case they
>> have thrown away month of work.
>
> The safety is the reflog.  What it refers to doesn't get pruned.

What Nico said.

More importantly, ones who are not confident with git would not
be able to resurrect unreachables that are left unpruned anyway.
The unreachables are by definition not connected to anything, so
they cannot do much better than grepping through droppings left
by "fsck --lost-found", which they probably even do not know how
to do yet.
