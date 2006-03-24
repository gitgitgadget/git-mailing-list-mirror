From: Junio C Hamano <junkio@cox.net>
Subject: Re: Fw: [PATCH 31/49] PCI: PCI/Cardbus cards hidden, needs pci=assign-busses to fix
Date: Thu, 23 Mar 2006 17:26:29 -0800
Message-ID: <7vbqvw3a62.fsf@assigned-by-dhcp.cox.net>
References: <20060323161521.28a874e6.akpm@osdl.org>
	<20060324002930.GA21184@kroah.com>
	<20060323163844.5fda7589.akpm@osdl.org>
	<20060324004654.GA19763@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andrew Morton <akpm@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 24 02:26:46 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FMb4W-0005du-HE
	for gcvg-git@gmane.org; Fri, 24 Mar 2006 02:26:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422969AbWCXB0d (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 23 Mar 2006 20:26:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422970AbWCXB0d
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Mar 2006 20:26:33 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:51946 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1422969AbWCXB0c (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Mar 2006 20:26:32 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060324012630.YYLI6244.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 23 Mar 2006 20:26:30 -0500
To: Greg KH <greg@kroah.com>
In-Reply-To: <20060324004654.GA19763@kroah.com> (Greg KH's message of "Thu, 23
	Mar 2006 16:46:54 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17895>

Greg KH <greg@kroah.com> writes:

> I'm using:
> 	git format-patch -n origin..HEAD
> to generate the raw patch files, and then:
> 	git-send-email --in-reply-to "<some_message_id>" --to some_mailing_list@somewhere.com
>
> fixing the obvious message id and mailing list address to be the correct
> one depending on the subsystem the patches are from.

I think format-patch does the right thing (I wrote it), but I am
not sure what send-email does wrt the From: header.  Who wrote
the send-email anyway?  I see your name on it ;-)

The cleanest way send-email should handle a patch authored by
somebody other than you, I think, is to still use From: to name
the author (format-patch output records the author on From:
line), and use Sender: of the outgoing e-mail to record that the
message is from you.  I suspect it probably doesn't.

The second best would be to add the duplicated From: to name the
author (who is _not_ you) to the top of the body of the message.
I do not particularly like that format myself, though.  Sender:
header was invented to send an e-mail authored by somebody other
than the sender of the message at the mail transport level, long
before Documentation/SubmittingPatches were written and git was
invented, and somehow I think that is a more kosher way to
handle that than the "extra From: at the beginning of the
message" clutch recommended in SubmittingPatches document.  

On the acceptance side, "git am" (or "git applymbox") should be
able to handle either format.
