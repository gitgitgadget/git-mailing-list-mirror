From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/4] Add log.mailmap as configurational option for
 mailmap location
Date: Sun, 01 Feb 2009 23:56:52 -0800
Message-ID: <7vr62hl1a3.fsf@gitster.siamese.dyndns.org>
References: <cover.1233520945.git.marius@trolltech.com>
 <ce94ea88e3182e97997c23f71e184e0db64fa708.1233520945.git.marius@trolltech.com> <7vwsc9o82r.fsf@gitster.siamese.dyndns.org> <4986A539.3080606@trolltech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Marius Storm-Olsen <marius@trolltech.com>
X-From: git-owner@vger.kernel.org Mon Feb 02 08:58:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LTthU-0007Ir-CF
	for gcvg-git-2@gmane.org; Mon, 02 Feb 2009 08:58:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751059AbZBBH46 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Feb 2009 02:56:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751005AbZBBH46
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Feb 2009 02:56:58 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:41225 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750715AbZBBH45 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Feb 2009 02:56:57 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id E0D9F2A465;
	Mon,  2 Feb 2009 02:56:56 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 08E0C2A464; Mon, 
 2 Feb 2009 02:56:53 -0500 (EST)
In-Reply-To: <4986A539.3080606@trolltech.com> (Marius Storm-Olsen's message
 of "Mon, 02 Feb 2009 08:48:09 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 1023B998-F0FF-11DD-B2DE-F63E8D1D4FD0-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108064>

Marius Storm-Olsen <marius@trolltech.com> writes:

> Junio C Hamano said the following on 02.02.2009 04:01:
>> Marius Storm-Olsen <marius@trolltech.com> writes:
>>> This allows us to override a repo mailmap file, or to use
>>> mailmap files elsewhere than the repository root.
>>
>> I think the new feature is not so well conceived.
>>
>> Should it always be a wholesale override, or should it also support
>> augmenting the repository version with a private copy?
>
> Sure, I can rewrite it to be augmenting, rather than overriding.
> I assume that the normal .mailmap file should be parsed first, then
> the log.mailmap one?

Augmenting one would behave that way.  I was more wondering if people
would want to be able to choose either, perhaps from the command line
option or something.

> Sure, but I left it in to allow "old-style" usage. Just in case the
> were use-cases for not using the log.mailmap one. I can nuke the
> arguments if you don't want them anymore.

What I think would be sensible, if we really want to make this feature
flexible, would be to introduce a command line option (and perhaps
environment variable) that takes the usual precidence (the command line
that specifies the mailmap file, then the environment and then finally the
log.mailmap config variable).  And if we go that route, that "usuall NULL"
parameter would be where the callers pass the filename they got from their
command line.

But if you feel it is overengineering, I would not disagree.  In such a
case, however, I do not think there is a reason for one particular caller
to pass some custom value there, just to be inconsistent from others.
