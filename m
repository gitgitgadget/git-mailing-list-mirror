From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Funny: git -p submodule summary
Date: Fri, 09 Jan 2009 01:30:23 -0800
Message-ID: <7veizc25e8.fsf@gitster.siamese.dyndns.org>
References: <alpine.DEB.1.00.0901081601240.30769@pacific.mpi-cbg.de>
 <20090109083836.GB21389@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jan 09 10:32:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LLDic-0004mU-CP
	for gcvg-git-2@gmane.org; Fri, 09 Jan 2009 10:31:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754496AbZAIJae (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Jan 2009 04:30:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754389AbZAIJad
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Jan 2009 04:30:33 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:58884 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755556AbZAIJaa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Jan 2009 04:30:30 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 46B458ECCE;
	Fri,  9 Jan 2009 04:30:29 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 568B88ECCD; Fri,
  9 Jan 2009 04:30:25 -0500 (EST)
In-Reply-To: <20090109083836.GB21389@coredump.intra.peff.net> (Jeff King's
 message of "Fri, 9 Jan 2009 03:38:36 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 27735270-DE30-11DD-B260-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104992>

Jeff King <peff@peff.net> writes:

> So the _real_ problem is that we are not always triggering the "wait for
> pager to finish" code because we exec and forget about it. Which means
> this strategy of "git runs child pager" will never work properly.
> Instead, we have to use three processes: git and the pager become child
> processes, while the original process waits for both to exit and returns
> the proper exit code from git.
>
> Let me try to work up a patch.

This arrangement to have the third process could even open the possibility
of having it read from git and write to pager, and not launching the pager
if there is no interesting data from git to feed it with.

I do not know if I like the performance implications associated with it,
though.
