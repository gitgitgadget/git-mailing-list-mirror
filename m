From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Is "show-ref -h" a good test for an empty repository?
Date: Sun, 07 Sep 2008 10:31:52 -0700
Message-ID: <7vprnfn9pz.fsf@gitster.siamese.dyndns.org>
References: <48C1D2AE.3010001@feds.uwaterloo.ca>
 <20080906012941.GA2009@coredump.intra.peff.net>
 <48C3E35C.2050903@feds.uwaterloo.ca>
 <20080907155033.GA25031@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eric Gerlach <egerlach@feds.uwaterloo.ca>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Sep 07 19:33:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KcO8J-0003Ui-BU
	for gcvg-git-2@gmane.org; Sun, 07 Sep 2008 19:33:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754514AbYIGRcA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Sep 2008 13:32:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754468AbYIGRcA
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Sep 2008 13:32:00 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:52964 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754023AbYIGRb7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Sep 2008 13:31:59 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 1D86F5A1AA;
	Sun,  7 Sep 2008 13:31:58 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 683805A1A9; Sun,  7 Sep 2008 13:31:54 -0400 (EDT)
In-Reply-To: <20080907155033.GA25031@coredump.intra.peff.net> (Jeff King's
 message of "Sun, 7 Sep 2008 11:50:33 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: DF515AE8-7D02-11DD-A492-D0CFFE4BC1C1-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95155>

Jeff King <peff@peff.net> writes:

> On Sun, Sep 07, 2008 at 10:21:16AM -0400, Eric Gerlach wrote:
>
>>>> I'm trying to test to see if "git diff --cached" will fail because 
>>>> there  are no existing commits.  I've come up with running "git 
>>>> show-ref -h -q"  and testing its return value.  My hypothesis is: If 
>>>
>>> Maybe "git rev-parse --verify HEAD"?
>>
>> That seems like it would work too... any reason one would be better than  
>> the other?
>
> My thinking was:
>
>   1. It's a plumbing command, and so less likely to change its behavior
>      versus "git diff".
>
>   2. The seems more obvious to me. rev-parse --verify is meant to ask
>      "is this a valid object name?"
>
> It is slightly different from your show-ref. Yours asks "is there
> anything in refs/heads in this repository?" Mine asks "does the current
> HEAD exist?" In practice, they are both reasonable tests, since once you
> have a branch, it is very difficult to get HEAD to point to something
> invalid short of editing manually to some bogus value. But you might
> prefer one over the other depending on what you are trying to say.

All depends on how "an empty repository" is defined.  My definition of an
empty repository would have been:

 - No objects in it;
 - No index;
 - No refs except symrefs.
