From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (topics)
Date: Thu, 22 May 2008 11:17:02 -0700
Message-ID: <7vlk22urtt.fsf@gitster.siamese.dyndns.org>
References: <7vlk4snpj3.fsf@gitster.siamese.dyndns.org>
 <7vwso85qkf.fsf@gitster.siamese.dyndns.org>
 <7vwso5r87q.fsf@gitster.siamese.dyndns.org>
 <7v8x0992hy.fsf@gitster.siamese.dyndns.org>
 <7vd4pf7h9y.fsf@gitster.siamese.dyndns.org>
 <7vwsnjl21c.fsf@gitster.siamese.dyndns.org>
 <7vhcehzdeg.fsf@gitster.siamese.dyndns.org>
 <7vbq4j748l.fsf@gitster.siamese.dyndns.org>
 <7vr6d8apjx.fsf@gitster.siamese.dyndns.org>
 <7vhcdyfe9u.fsf@gitster.siamese.dyndns.org>
 <7vabjm1a0q.fsf@gitster.siamese.dyndns.org>
 <7vr6crj0jk.fsf@gitster.siamese.dyndns.org>
 <7vmyn4hr8f.fsf@gitster.siamese.dyndns.org>
 <7vmymsjz6x.fsf@gitster.siamese.dyndns.org>
 <7vabijxhk4.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0805221212200.30431@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu May 22 20:18:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JzFMj-000171-D9
	for gcvg-git-2@gmane.org; Thu, 22 May 2008 20:18:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756904AbYEVSRT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 May 2008 14:17:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756846AbYEVSRT
	(ORCPT <rfc822;git-outgoing>); Thu, 22 May 2008 14:17:19 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:53224 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756719AbYEVSRS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 May 2008 14:17:18 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id C604218C3;
	Thu, 22 May 2008 14:17:14 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 91E53161C; Thu, 22 May 2008 14:17:09 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 4DFAA274-282B-11DD-BCE6-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82646>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> * js/config-cb (Wed May 14 18:46:53 2008 +0100) 1 commit
>>  - Provide git_config with a callback-data parameter
>> 
>> This needs to wait until most of the other things graduate for 1.5.6; 
>> luckily, unlike the other "path-list" changes, misconversions is much 
>> easier to catch for this change and I am not worried about it.
>
> Just let me know when to resubmit, and against what branch(es).

It is probably easier for me to munge the original submission from you
when I decide to tag -rc0, adjusting any potential new callers (I do not
think of any offhand in diff between master and next).  We will need a
quiescent time for this kind of change, and that way we will get such a
quiescent window by definition.

>> * js/mailinfo (Fri May 16 14:03:30 2008 +0100) 1 commit
>>  - <<PARK - BASE64 and QP still broken>> mailsplit and mailinfo:
>>    gracefully handle NUL characters
>> 
>> When "am" processes a patch that modifies a line with NUL, we used to
>> chomp the patch line there, resulting in rejects.  This patch fixes the
>> issue partially, only when the message is not encoded in BASE64 nor
>> Quoted-Printable.

> Like I said, I would be happy if Tommy took care of that patch.

I dunno.  Is it likely to happen?  I'd take a look at it myself when I
have a chance.

>> * js/ignore-submodule (Wed May 14 18:03:59 2008 +0100) 3 commits
>>  + Ignore dirty submodule states during rebase and stash
>>  + Teach update-index about --ignore-submodules
>>  + diff options: Introduce --ignore-submodules
>
> I haven't heard back from you about renaming that option.  I think I 
> suggested --non-gitlinks or something equally discouraging for 
> porcelain users.

The name is fine.  I had more trouble with what it does, rather, what it
doesn't --- it does not ignore typechange that involve a gitlink if I
recall correctly.

>> * db/clone-in-c (Tue May 20 14:15:14 2008 -0400) 11 commits
>>  + clone: fall back to copying if hardlinking fails
>>  + builtin-clone.c: Need to closedir() in copy_or_link_directory()
>>  + builtin-clone: fix initial checkout
>>  + Build in clone
>>  + Provide API access to init_db()
>>  + Add a function to set a non-default work tree
>>  + Allow for having for_each_ref() list extra refs
>>  + Have a constant extern refspec for "--tags"
>>  + Add a library function to add an alternate to the alternates file
>>  + Add a lockfile function to append to a file
>>  + Mark the list of refs to fetch as const
>
> Fingers crossed.

Rather, uncross them and type a few more tests ;-)?
