From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-commit: add a prepare-commit-msg hook
Date: Mon, 21 Jan 2008 14:44:30 -0800
Message-ID: <7vve5mx0hd.fsf@gitster.siamese.dyndns.org>
References: <4790BCED.4050207@gnu.org>
	<7vbq7ibxhh.fsf@gitster.siamese.dyndns.org> <4791C3A8.7000308@gnu.org>
	<alpine.LSU.1.00.0801191119050.5731@racer.site>
	<7vd4rw6siv.fsf@gitster.siamese.dyndns.org> <479438D1.2050107@gnu.org>
	<alpine.LSU.1.00.0801211101450.5731@racer.site>
	<47948C9B.7030100@gnu.org>
	<alpine.LSU.1.00.0801211231480.5731@racer.site>
	<4794972F.9000007@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
To: Paolo Bonzini <bonzini@gnu.org>
X-From: git-owner@vger.kernel.org Mon Jan 21 23:45:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JH5OC-0004D2-JG
	for gcvg-git-2@gmane.org; Mon, 21 Jan 2008 23:45:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754848AbYAUWon (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jan 2008 17:44:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754860AbYAUWon
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jan 2008 17:44:43 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:35426 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754330AbYAUWom (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jan 2008 17:44:42 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 58A50337D;
	Mon, 21 Jan 2008 17:44:41 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id BFEA53372;
	Mon, 21 Jan 2008 17:44:37 -0500 (EST)
In-Reply-To: <4794972F.9000007@gnu.org> (Paolo Bonzini's message of "Mon, 21
	Jan 2008 13:59:27 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71361>

Paolo Bonzini <bonzini@gnu.org> writes:

>> Actually, reading your patch again I think it also triggers for
>> "-c", as well as for "[-C|-F|-m] ... -e".
>
> Not for "-c", that's the point of the "edit_message" check.  You're
> right about "-e" though.
>
> Points taken, and patch will be resubmitted after 1.5.4.

Thanks.  I think the approach is sane, and it naturally falls
into the second category of "why we might want to a hook for"
list I sent earlier.

I do not think adding "-X makes that hook ignored" for
description of every option is warranted, though.  Users should
not have to be reminded that there is a hook he may never use
and it does not trigger if he specifies his own message using -X
or -Y or -Z option.

The usage of the hook is optional, and the primary description
of what it does and why a user might want to use it should be in
its own description (perhaps in hooks.txt and a section that
lists hooks in git-commit manpage).  As long as that description
makes it clear that the hook is a way to specify a dynamic
template in a situation that requries a fresh message, the users
who are interested in using it would perfectly well understand
that options that make git-commit not to take a fresh message
would not invoke the hook.
