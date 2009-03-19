From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Define a version of lstat(2) with posix semantics
Date: Thu, 19 Mar 2009 15:08:40 -0700
Message-ID: <7vr60t6u8n.fsf@gitster.siamese.dyndns.org>
References: <81b0412b0903190327l7745bf01i479fb84fae777af0@mail.gmail.com>
 <alpine.DEB.1.00.0903191155300.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alex Riesen <raa.lkml@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Jeff King <peff@peff.net>, layer <layer@known.net>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Mar 19 23:10:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LkQRq-0005Zd-Ve
	for gcvg-git-2@gmane.org; Thu, 19 Mar 2009 23:10:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754548AbZCSWI4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Mar 2009 18:08:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757539AbZCSWI4
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Mar 2009 18:08:56 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:54525 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753622AbZCSWIz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Mar 2009 18:08:55 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 97ABCA3F7F;
	Thu, 19 Mar 2009 18:08:53 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 320CAA3F7C; Thu,
 19 Mar 2009 18:08:41 -0400 (EDT)
In-Reply-To: <alpine.DEB.1.00.0903191155300.10279@pacific.mpi-cbg.de>
 (Johannes Schindelin's message of "Thu, 19 Mar 2009 11:57:01 +0100 (CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 88A5FE66-14D2-11DE-9D66-32B0EBB1AA3C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113846>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi,
>
> On Thu, 19 Mar 2009, Alex Riesen wrote:
>
>> So that Cygwin port can continue work around its supporting
>> library and get access to its faked file attributes.
>> 
>> Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
>> ---
>
> [patch not inlined: therefore you'll have to guess what I am referring to]
>
> It seems quite wrong to define something for other platforms when only 
> Cygwin is affected.
>
> I'd rather just disable WIN32_STAT for Cygwin, because otherwise, we will 
> keep running into issues.

I am inclined to agree with this.

Back when Cygwin was the only choice, it was a way to bring benefit of git
to folks who have to work on Windows, but with the recent advances in
msysgit, probably Cygwin port should return to a role more in line with
the overall Cygwin theme of bringing the more POSIXy sanity into Windows
world.  I personally see a Cygwin port as a vehicle for people who care
about having a POSIXly-correct world where files have executable bits and
lines are terminated with LF on Windows.  If you want to have a system
that is closer to Window's world view, there is (or will be, as msysgit is
still officially marked as alpha) a viable alternative, and the current
"selective cheating" Cygwin port does may benefit nobody.

But I do not work on Windows myself, so please take this only as a mere
uninformed opinion, nothing more.
