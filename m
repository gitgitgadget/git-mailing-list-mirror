From: Junio C Hamano <gitster@pobox.com>
Subject: Re: combined diff, but not condensed, howto?
Date: Wed, 17 Sep 2008 23:14:06 -0700
Message-ID: <7vy71qyo9d.fsf@gitster.siamese.dyndns.org>
References: <48D0B907.7040903@viscovery.net>
 <7vwsha6761.fsf@gitster.siamese.dyndns.org> <48D1EDB7.5070107@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Sep 18 08:15:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KgCnj-0001g4-P9
	for gcvg-git-2@gmane.org; Thu, 18 Sep 2008 08:15:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752533AbYIRGOR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Sep 2008 02:14:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751809AbYIRGOR
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Sep 2008 02:14:17 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:46861 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751146AbYIRGOQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Sep 2008 02:14:16 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id F268C62B23;
	Thu, 18 Sep 2008 02:14:12 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 07A1262B22; Thu, 18 Sep 2008 02:14:08 -0400 (EDT)
In-Reply-To: <48D1EDB7.5070107@viscovery.net> (Johannes Sixt's message of
 "Thu, 18 Sep 2008 07:57:11 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 038D9BD0-8549-11DD-A128-D0CFFE4BC1C1-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96162>

Johannes Sixt <j.sixt@viscovery.net> writes:

> Junio C Hamano schrieb:
>> Johannes Sixt <j.sixt@viscovery.net> writes:
>> 
>>> After a merge conflict, 'git diff' shows a combined diff, which presents
>>> only the parts that conflicted or where there are near-by changes from
>>> different parents (potential conflicts). Is there a command line switch so
>>> that *all* changes are shown, even non-conflicting ones?
>> 
>> Like "git diff HEAD"?
>
> No. Something that produces
...

Ah, I see what you mean.

It all happens inside combine-diff.c::make_hunks().  If you pass dense==0,
you should be able to get all the uninteresting hunks, I think.

Perhaps

	$ git diff --base -c

???
