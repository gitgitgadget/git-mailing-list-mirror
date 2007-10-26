From: bdowning@lavos.net (Brian Downing)
Subject: Re: [PATCH 6/9] git-hash-object: Add --stdin-paths option
Date: Fri, 26 Oct 2007 18:19:02 -0500
Message-ID: <20071026231902.GC2519@lavos.net>
References: <1193307927-3592-1-git-send-email-aroben@apple.com> <1193307927-3592-2-git-send-email-aroben@apple.com> <1193307927-3592-3-git-send-email-aroben@apple.com> <1193307927-3592-4-git-send-email-aroben@apple.com> <1193307927-3592-5-git-send-email-aroben@apple.com> <1193307927-3592-6-git-send-email-aroben@apple.com> <1193307927-3592-7-git-send-email-aroben@apple.com> <7vy7dpwpz4.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Adam Roben <aroben@apple.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Oct 27 01:19:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IlYSe-0007dY-4e
	for gcvg-git-2@gmane.org; Sat, 27 Oct 2007 01:19:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751956AbXJZXTQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Oct 2007 19:19:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751574AbXJZXTP
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Oct 2007 19:19:15 -0400
Received: from mxsf05.insightbb.com ([74.128.0.75]:1920 "EHLO
	mxsf05.insightbb.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751388AbXJZXTP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Oct 2007 19:19:15 -0400
X-IronPort-AV: E=Sophos;i="4.21,335,1188792000"; 
   d="scan'208";a="92130539"
Received: from unknown (HELO asav01.insightbb.com) ([172.31.249.124])
  by mxsf05.insightbb.com with ESMTP; 26 Oct 2007 19:19:13 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Aq4HAP4SIkdKhvkY/2dsb2JhbACBWg
X-IronPort-AV: E=Sophos;i="4.21,335,1188792000"; 
   d="scan'208";a="89292951"
Received: from 74-134-249-24.dhcp.insightbb.com (HELO mail.lavos.net) ([74.134.249.24])
  by asav01.insightbb.com with ESMTP; 26 Oct 2007 19:19:13 -0400
Received: by mail.lavos.net (Postfix, from userid 1000)
	id 982A7309F21; Fri, 26 Oct 2007 18:19:02 -0500 (CDT)
Content-Disposition: inline
In-Reply-To: <7vy7dpwpz4.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62452>

On Fri, Oct 26, 2007 at 02:00:47PM -0700, Junio C Hamano wrote:
> In addition, if you are enhancing cat-file to spew chunked
> output out, I suspect that there should be a mode of operation
> for hash-object that eats that data format.  IOW, this pipe
> 
> 	git-cat-file --batch <list-of-sha1 |
>         git-hash-object --batch
> 
> should be an intuitive no-op, shouldn't it?

I think that's an obviously good thing to do.  However, given your
suggested output format (which I also like):

>    * git-cat-file --batch <list-of-sha1
> 
>      outputs a record of this form
> 
>           <sha1> SP <type> SP <size> LF <contents> LF
> 
>      for each of the input lines.

What should the input behavior be?  Obviously the sha1 will probably
not be known on the input side.  Should that simply be optional (i.e.
it will accept either "<sha1> SP <type> SP <size>" or "<type> SP <size>"
or should it only accept the latter, and a dummy sha1 will need to be
filled in if the sha1 is not known (presumably "000...000")?

-bcd
