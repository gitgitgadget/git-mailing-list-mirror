From: Junio C Hamano <gitster@pobox.com>
Subject: Re: how to use two bare repositories?
Date: Fri, 11 Apr 2008 17:12:38 -0700
Message-ID: <7vabk0nd6x.fsf@gitster.siamese.dyndns.org>
References: <20080411234430.GQ29940@cs-wsok.swansea.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Oliver Kullmann <O.Kullmann@swansea.ac.uk>
X-From: git-owner@vger.kernel.org Sat Apr 12 02:13:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JkTNK-00060F-95
	for gcvg-git-2@gmane.org; Sat, 12 Apr 2008 02:13:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756947AbYDLAMu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Apr 2008 20:12:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756669AbYDLAMu
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Apr 2008 20:12:50 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:44359 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756590AbYDLAMu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Apr 2008 20:12:50 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 72D942335;
	Fri, 11 Apr 2008 20:12:46 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id C08B22334; Fri, 11 Apr 2008 20:12:41 -0400 (EDT)
In-Reply-To: <20080411234430.GQ29940@cs-wsok.swansea.ac.uk> (Oliver
 Kullmann's message of "Sat, 12 Apr 2008 00:44:30 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79318>

Oliver Kullmann <O.Kullmann@swansea.ac.uk> writes:

>> > The problem is now that it seems not to be possible
>> > to update B:
>> >
>> > 1. pulling from A is not possible since B is bare;
>> > 2. fetching from A seems to work, checking the content of
>> >    B via gitk seems to indicate that B has been updated
>> >  --- however pulling from B doesn't work
>> 
>> The usual answer when you see a word "http" mentioned is...
>> 
>> 	how are you arranging update-server-info to be run whenever B is
>> 	updated?
>
> Aha, I see: So first I fetch, and then I run update-server-info.
> Just tried it out, and it worked. Thanks!

Typically, you would update a bare repository used for publishing by
pushing into it, and trigger update-server-info from the post-update hook.

But it is perfectly fine if you initiate a mirror-fetch from that
publishing repository (in your case, "B"), and the caller to "git fetch"
can run update-server-info after fetching.

And no, there is not a "post-fetch" hook, nor is there a need for one.
