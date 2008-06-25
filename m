From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] pack.indexversion config option now defaults to 2
Date: Wed, 25 Jun 2008 12:19:46 -0700
Message-ID: <7vd4m51fvx.fsf@gitster.siamese.dyndns.org>
References: <alpine.LFD.1.10.0806250025130.2979@xanadu.home>
 <alpine.LFD.1.10.0806242130450.22069@hp.linux-foundation.org>
 <7vd4m66rfp.fsf@gitster.siamese.dyndns.org>
 <alpine.LFD.1.10.0806251442500.2979@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Wed Jun 25 21:21:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBaY7-0002WY-Pi
	for gcvg-git-2@gmane.org; Wed, 25 Jun 2008 21:21:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753395AbYFYTUE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jun 2008 15:20:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753026AbYFYTUD
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jun 2008 15:20:03 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:49882 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752748AbYFYTUC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jun 2008 15:20:02 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 0D3C11BBC1;
	Wed, 25 Jun 2008 15:20:01 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 329021BBB9; Wed, 25 Jun 2008 15:19:56 -0400 (EDT)
In-Reply-To: <alpine.LFD.1.10.0806251442500.2979@xanadu.home> (Nicolas
 Pitre's message of "Wed, 25 Jun 2008 14:49:20 -0400 (EDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: B4E1A00C-42EB-11DD-A4F6-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86326>

Nicolas Pitre <nico@cam.org> writes:

> On Tue, 24 Jun 2008, Junio C Hamano wrote:
> ...
> Actually the first release to support this is v1.4.4 not v1.5.0.
>
>> I am basing the above 1.5.0 on description of b6945f5 (git-repack:
>> repo.usedeltabaseoffset, 2006-10-13).
>
> $ git describe --contains b6945f5
> v1.4.4-rc1~77^2~2

I know, as I did that myself; but I wanted to be conservative and gave a
release after a major release bump.

>> On the "indexVersion" change, the documentation reads:
>> 
>> pack.indexVersion::
>> 	Specify the default pack index version.  Valid values are 1 for
>>  	legacy pack index used by Git versions prior to 1.5.2, and 2 for
>>  	the new pack index with capabilities for packs larger than 4 GB
>>  	as well as proper protection against the repacking of corrupted
>> +	packs.  Version 2 is the default.  Note that version 2 is enforced
>> +	and this config option ignored whenever the corresponding pack is
>> +	larger than 2 GB.
>> 
>> which lacks the recovery insn (and it is int strictly the fault of this
>> patch, but we should have done this when we introduced the v2 idx).  I
>> think a separate paragraph after the above would be necessary and
>> sufficient:
>> 
>> 	If you have an ancient git that does not understand the version 2
>> 	`*.idx` file, cloning or fetching over a non native protocol
>> 	(e.g. "http" and "rsync") which will copy both `*.pack` file and
>> 	corresponding `*.idx` file from the other side may give you a
>> 	repository that cannot be accessed with your old git.  If the
>> 	`*.pack` file is smaller than 2 GB, however, you can use
>> 	`git-index-pack` on the `*.pack` to regenerate the `*.idx` file.
>
> Looks fine to me.  Will you amend the patches or do you want me to 
> repost them?

No worries.  After re-reading what you wrote I think both are fine as they
are.  I do not mind adding the above 7 lines to the indexVersion one
myself.
