From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Adding Reviewed-by/Tested-by tags to other peoples commits
Date: Sat, 11 Oct 2008 04:48:18 -0700
Message-ID: <7vfxn3jqt9.fsf@gitster.siamese.dyndns.org>
References: <b2cdc9f30810102337q13432bepa957acaace9ddc5d@mail.gmail.com>
 <alpine.DEB.1.00.0810111239590.22125@pacific.mpi-cbg.de.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alex Bennee <kernel-hacker@bennee.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Oct 11 13:50:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Koczd-0007EW-Ce
	for gcvg-git-2@gmane.org; Sat, 11 Oct 2008 13:50:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751933AbYJKLsb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Oct 2008 07:48:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751505AbYJKLsb
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Oct 2008 07:48:31 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:57379 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751433AbYJKLsb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Oct 2008 07:48:31 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 75A426CF75;
	Sat, 11 Oct 2008 07:48:29 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id E96216CF74; Sat, 11 Oct 2008 07:48:20 -0400 (EDT)
In-Reply-To: <alpine.DEB.1.00.0810111239590.22125@pacific.mpi-cbg.de.mpi-cbg.de> (Johannes
 Schindelin's message of "Sat, 11 Oct 2008 12:42:08 +0200 (CEST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 85A8BC0A-978A-11DD-8820-1E1F86D30F62-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97976>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Sat, 11 Oct 2008, Alex Bennee wrote:
>
>> I've just tested/reviewed a patch of someone elses and I want to forward 
>> it on the appropriate mailing list. I gather for Linux you just add the 
>> appropriate tags to the commit. Does git offer a shortcut for doing this 
>> or do you have to do a reset HEAD^ and re-commit with a copy&pasted and 
>> modified commit message?
>
> http://thread.gmane.org/gmane.comp.version-control.git/75250/focus=76304
>
> In the end, nothing happened, but I could see that you might want to push 
> for this patch.

The fact a particular change has been reviewed is an attribute of a
commit, and by recording the fact once (perhaps when you commit for the
first time, or if your workflow is "commit blindly, then review, and then
amend" then when you amend that commit), the commit object will remember
that fact.

The patch you quoted adds Reviewed-by: at format-patch time, but I suspect
that is a wrong approach.  You have to remember and recall which ones you
reviewed (and which ones you didn't) when you run format-patch.  People
who commit and immediately format-patch to send, or people who do not
review until immediately before format-patch to send, would not realize
the downside of the approach, but when your work style is to perform
commit/review and e-mail communication in separate phases, it matters.

This is a bit tangent, but perhaps rebase needs a hook so that users can
strip certain tags automatically from the commit log messages (e.g.
things like Reviewd-by: and Tested-by: become less trustworthy when you
rebase; S-o-b: becomes somewhat less trustworthy when you "edit" in
rebase-i; etc).
