From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/2] Fix parent rewriting in --early-output
Date: Tue, 13 Nov 2007 10:53:01 -0800
Message-ID: <7vbq9yt1te.fsf@gitster.siamese.dyndns.org>
References: <18211.59478.188419.397886@cargo.ozlabs.ibm.com>
	<18212.13862.637991.30536@cargo.ozlabs.ibm.com>
	<alpine.LFD.0.999.0710280943090.30120@woody.linux-foundation.org>
	<18217.41899.54812.227152@cargo.ozlabs.ibm.com>
	<alpine.LFD.0.999.0711010815320.3342@woody.linux-foundation.org>
	<18218.63946.772767.179841@cargo.ozlabs.ibm.com>
	<e5bfff550711020544h1e9a648apfd268eb549645ccc@mail.gmail.com>
	<alpine.LFD.0.999.0711020828440.3342@woody.linux-foundation.org>
	<alpine.LFD.0.999.0711021114390.3342@woody.linux-foundation.org>
	<alpine.LFD.0.999.0711021301200.3342@woody.linux-foundation.org>
	<alpine.LFD.0.999.0711021809060.3342@woody.linux-foundation.org>
	<alpine.LFD.0.999.0711031103340.3342@woody.linux-foundation.org>
	<18221.14113.498416.396006@cargo.ozlabs.ibm.com>
	<alpine.LFD.0.999.0711032234030.15101@woody.linux-foundation.org>
	<alpine.LFD.0.999.0711041004220.15101@woody.linux-foundation.org>
	<alpine.LFD.0.999.0711041124050.15101@woody.linux-foundation.org>
	<alpine.LFD.0.9999.0711122046570.2786@woody.linux-foundation.org>
	<18233.30098.470244.421468@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Marco Costalba <mcostalba@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Tue Nov 13 19:57:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Is0wM-0007fi-IT
	for gcvg-git-2@gmane.org; Tue, 13 Nov 2007 19:56:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758051AbXKMSxM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2007 13:53:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759494AbXKMSxL
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Nov 2007 13:53:11 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:36266 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758849AbXKMSxJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2007 13:53:09 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 074D62F0;
	Tue, 13 Nov 2007 13:53:30 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 252A49550C;
	Tue, 13 Nov 2007 13:53:25 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64826>

Paul Mackerras <paulus@samba.org> writes:

> In fact it would be easier for me if, instead of getting the id of
> some random ancestor commit, I got an explicit indication to say
> "unknown parent", such as just a "-" in place of the id of the
> unknown parent(s).  Would that be doable?  I could then just not do
> the processing for any unknown parent, and make sure to do it when I
> see the final version of the commit.

I suspect that a "-" in place of a commit object name may not be
enough for your purpose, as the _number_ of parents can later
change in the later re-output.

I wonder if the presense of "incomplete" on the "Final output"
line is a good enough indication for that.  That is, until you
see "Final output: $N done", you will treat the parent
information as unreliable.
