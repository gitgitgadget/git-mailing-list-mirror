From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 00/12] Towards a better merge resolution support
Date: Mon, 01 Sep 2008 10:26:24 -0700
Message-ID: <7v8wubwzen.fsf@gitster.siamese.dyndns.org>
References: <1220056963-2352-1-git-send-email-gitster@pobox.com>
 <20080901094412.GB3993@blimp.local>
 <7vod38w3q6.fsf@gitster.siamese.dyndns.org>
 <20080901113416.GA8610@blimp.localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 01 19:27:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KaDBk-0002SR-I1
	for gcvg-git-2@gmane.org; Mon, 01 Sep 2008 19:27:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750989AbYIAR0b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Sep 2008 13:26:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751061AbYIAR0b
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Sep 2008 13:26:31 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:47944 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750912AbYIAR0b (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Sep 2008 13:26:31 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 93BEB6D214;
	Mon,  1 Sep 2008 13:26:29 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 917016D213; Mon,  1 Sep 2008 13:26:26 -0400 (EDT)
In-Reply-To: <20080901113416.GA8610@blimp.localhost> (Alex Riesen's message
 of "Mon, 1 Sep 2008 13:34:16 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 1D08705E-784B-11DD-8F65-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94596>

Alex Riesen <raa.lkml@gmail.com> writes:

> Junio C Hamano, Mon, Sep 01, 2008 12:38:25 +0200:
>> Alex Riesen <raa.lkml@gmail.com> writes:
>> 
>> > ... IOW, copy the commit
>> > resolution from some other merge commit. Maybe can be a way to use
>> > rerere mechanism with that?
>> 
>> If you know which merge I did you want to steal from, you can prime your
>> rerere database by pretending to be me, doing the merge.  Something like:
>> 
>> 	$ git checkout $merge^1 ;# detach to the parent of merge
>>         $ git merge $merge^2 ;# pretend you were me to redo it
>>         $ git diff -R $merge | git apply --index ;# and get what I did
>
> I ended up using

I think the last step should be "git read-tree --reset -u $merge" if we
really want the minimum  sequence.
