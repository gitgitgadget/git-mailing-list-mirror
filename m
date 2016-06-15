From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-daemon: Simplify child management and associated
 logging by
Date: Tue, 12 Aug 2008 17:20:13 -0700
Message-ID: <7vvdy5pxz6.fsf@gitster.siamese.dyndns.org>
References: <20080812193613.32388.92145.stgit@aristoteles.cuci.nl>
 <20080812212534.6871.19377.stgit@aristoteles.cuci.nl>
 <7vzlnhq48b.fsf@gitster.siamese.dyndns.org> <20080812225642.GA15265@cuci.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Stephen R. van den Berg" <srb@cuci.nl>
X-From: git-owner@vger.kernel.org Wed Aug 13 02:21:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KT47C-0001ky-Al
	for gcvg-git-2@gmane.org; Wed, 13 Aug 2008 02:21:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754130AbYHMAUV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Aug 2008 20:20:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752316AbYHMAUV
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Aug 2008 20:20:21 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:50181 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752108AbYHMAUT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Aug 2008 20:20:19 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 5935157B92;
	Tue, 12 Aug 2008 20:20:18 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 960A857B91; Tue, 12 Aug 2008 20:20:15 -0400 (EDT)
In-Reply-To: <20080812225642.GA15265@cuci.nl> (Stephen R. van den Berg's
 message of "Wed, 13 Aug 2008 00:56:42 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 9BDD945A-68CD-11DD-96A1-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92160>

"Stephen R. van den Berg" <srb@cuci.nl> writes:

> Separating it causes two things:
> a. The patches to become dependent on each other in the timeline.
> b. More (redundant) work, because some parts that need to be rewritten, get
>    deleted by the following patch(es).

These are actually desirable properties from reviewability point of view.

>> - I see you have a call to vsyslog, which is the first user of the
>>   function.  How portable is it (the patch coming from you, I know
>>   Solaris would have it, and recent 4BSD also would, but what about the
>>   others)?
>
> Cygwin has it, Solaris does, Linux does, MacOSX does.
> AIX and HPUX don't, perhaps.
> I'll see what I can do to avoid it, yet simplify the code.

That's one of the reasons why I asked you to split it to three patches, so
that the syslog change can potentially be independently replaced with a
better alternative.

In any case, it is already late in the rc cycle; I'd like to apply your
earlier "In SysV, signal(SIGCHLD) need to be rearmed" patch and nothing
else for now.  The clean-up is very attractive but can be done post 1.6.0.
