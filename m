From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Mark Levedahl's gitk patches
Date: Tue, 26 Jun 2007 17:41:44 -0700
Message-ID: <7v645axm7r.fsf@assigned-by-dhcp.pobox.com>
References: <467FE7C4.5E421535@eudaptics.com> <46807CEF.2010109@verizon.net>
	<18048.36797.283166.952377@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mark Levedahl <mdl123@verizon.net>,
	Johannes Sixt <J.Sixt@eudaptics.com>, git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Wed Jun 27 02:42:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I3Lbi-0005Dc-6L
	for gcvg-git@gmane.org; Wed, 27 Jun 2007 02:42:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752109AbXF0Alq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Jun 2007 20:41:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752055AbXF0Alq
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Jun 2007 20:41:46 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:46181 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751348AbXF0Alp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jun 2007 20:41:45 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070627004145.YYKN3133.fed1rmmtao102.cox.net@fed1rmimpo02.cox.net>;
          Tue, 26 Jun 2007 20:41:45 -0400
Received: from assigned-by-dhcp.pobox.com ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id GQhk1X00Y1kojtg0000000; Tue, 26 Jun 2007 20:41:45 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50992>

Paul Mackerras <paulus@samba.org> writes:

> Mark Levedahl writes:
>
>> I found a bug in the highlight patch (the color picker updated the wrong 
>> panel in the chooser but did set the correct color), and updated the 
>> tab-stop patch to use a spin control to enforce entry of small integers 
>> only. As there is possible interest, I am sending the amended series.
>
> Ah.  I just pushed out a pile of patches to gitk.git including your
> three.  Could you do an incremental patch on top of that for me?

I took a look at differences between your gitk.git and what I
have.  It appears that our "proc readrefs" differ a bit.

Most notably, the global hash tagcontents is read when readrefs
run in the version I have, while gitk.git version fills it
lazily in showtag, where it is actually used.  Because you read
the refs using "show-ref -d", you do not need to do extra forks
to figure out the objects referred to by the tags in your code.

I think what you have is a lot better from interactive latency
point of view.  I'll take the version from gitk.git and push the
results out.
