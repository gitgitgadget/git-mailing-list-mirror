From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] builtin-revert: Make use of merge_recursive()
Date: Mon, 11 Aug 2008 16:52:16 -0700
Message-ID: <7vvdy7t8i7.fsf@gitster.siamese.dyndns.org>
References: <20080811190924.GR18960@genesis.frugalware.org>
 <1218491096-28756-1-git-send-email-s-beyer@gmx.net>
 <7v7ianuo8q.fsf@gitster.siamese.dyndns.org>
 <20080811234733.GB28340@leksak.fem-net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Miklos Vajna <vmiklos@frugalware.org>
To: Stephan Beyer <s-beyer@gmx.net>
X-From: git-owner@vger.kernel.org Tue Aug 12 01:53:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KShCa-0002X3-Ei
	for gcvg-git-2@gmane.org; Tue, 12 Aug 2008 01:53:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754046AbYHKXwZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Aug 2008 19:52:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753931AbYHKXwZ
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Aug 2008 19:52:25 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:63678 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752754AbYHKXwZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Aug 2008 19:52:25 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 457AC55BA4;
	Mon, 11 Aug 2008 19:52:24 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 0FFAD55BA3; Mon, 11 Aug 2008 19:52:18 -0400 (EDT)
In-Reply-To: <20080811234733.GB28340@leksak.fem-net> (Stephan Beyer's message
 of "Tue, 12 Aug 2008 01:47:33 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 8B9F4C00-6800-11DD-84E8-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92027>

Stephan Beyer <s-beyer@gmx.net> writes:

>> Would we need to consolidate this and Miklos's "call recursive internally
>> from git-merge wrapper" by making them into three patches?
>> I.e.
>> 
>>  (1) move bulk of code from builtin-merge-recursive.c to a new file
>>      merge-recursive.c and introduce merge_recursive_helper() in there so
>>      that both of you and cmd_merge_recursive() itself can call it;
>
> I'd like to see a "libified" merge-recursive.c, but I wouldn't call the
> interesting function merge_recursive_helper(), I'd just take
> merge_recursive().
> Of course those index locking could be done in it.
>
> Looking at my sequencer code, I'd also be satisfied, if it takes SHAs
> as argument and no "struct commit *".
> But then this should be more generic, i.e. OBJ_TAG has to be handled
> correctly (builtin-revert does that at the beginning at parse-args()).
>
> Hmm, then step (1) is ok. :-)
>
>>  (2) make revert.c use merge_recursive_helper();
>> 
>>  (3) make builtin-merge.c use merge_recursive_helper().
>
> This is ok then.

Thanks.

Let me try to be a bit more explicit to avoid confusion.

I won't queue this round of patch (neither this nor Miklos's), as we are
not in a hurry during the 1.6.0-rc period anyway, but expect (1) to happen
first, Ok?
