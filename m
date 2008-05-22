From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Restricting access to a branch
Date: Wed, 21 May 2008 18:43:55 -0700
Message-ID: <7v63t7xgdg.fsf@gitster.siamese.dyndns.org>
References: <20080521163616.31fad56f@extreme>
 <7vhccrxkdm.fsf@gitster.siamese.dyndns.org>
 <alpine.LFD.1.10.0805211732520.3081@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stephen Hemminger <shemminger@vyatta.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu May 22 03:45:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jyzs8-0000Dc-41
	for gcvg-git-2@gmane.org; Thu, 22 May 2008 03:45:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933021AbYEVBo0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 May 2008 21:44:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932652AbYEVBo0
	(ORCPT <rfc822;git-outgoing>); Wed, 21 May 2008 21:44:26 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:44236 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755268AbYEVBoY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 May 2008 21:44:24 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 7293F6F8D;
	Wed, 21 May 2008 21:44:22 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id ABE3C6F8C; Wed, 21 May 2008 21:44:14 -0400 (EDT)
In-Reply-To: <alpine.LFD.1.10.0805211732520.3081@woody.linux-foundation.org>
 (Linus Torvalds's message of "Wed, 21 May 2008 17:37:20 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 9A191446-27A0-11DD-AB44-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82599>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> What you *can* do is:
>
>  - rename the branch to something that includes a slash (aka 
>    subdirectory). Let's call it "frozen/mybranch" as an example.
>
>  - do a 'git gc' to make sure that branch is in the packed refs file.
>
>  - make the subdirectory of that branch is unwritable (ie just do 
>    something like "chmod -w refs/heads/frozen")
>
> and now the filesystem permissions should mean that you can't actually 
> update that branch any more, even though you can read it.

Hmmmmm... and deleting of the branch would take the same lock used for
updating, which is under frozen/ directory, so that is also safe.

That's sneaky.

I'd however throw that into "happens to work, unsure if we would want to
promise supporting it as a _feature_ forever" category.
