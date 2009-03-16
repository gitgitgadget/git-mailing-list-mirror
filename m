From: Junio C Hamano <gitster@pobox.com>
Subject: Re: undoing something
Date: Mon, 16 Mar 2009 12:14:00 -0700
Message-ID: <7veiwxwa9z.fsf@gitster.siamese.dyndns.org>
References: <450196A1AAAE4B42A00A8B27A59278E70A2AEFA4@EXCHANGE.trad.tradestation.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>
To: "John Dlugosz" <JDlugosz@TradeStation.com>
X-From: git-owner@vger.kernel.org Mon Mar 16 20:15:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LjIHp-0008D9-3l
	for gcvg-git-2@gmane.org; Mon, 16 Mar 2009 20:15:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755529AbZCPTOR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Mar 2009 15:14:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754316AbZCPTOQ
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Mar 2009 15:14:16 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:37880 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754494AbZCPTOP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Mar 2009 15:14:15 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id F3CF964B3;
	Mon, 16 Mar 2009 15:14:09 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 5E6BD64B2; Mon,
 16 Mar 2009 15:14:07 -0400 (EDT)
In-Reply-To: <450196A1AAAE4B42A00A8B27A59278E70A2AEFA4@EXCHANGE.trad.tradestation.com>
 (John Dlugosz's message of "Mon, 16 Mar 2009 15:06:31 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: A0B12B00-125E-11DE-89D3-C5D912508E2D-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113356>

"John Dlugosz" <JDlugosz@TradeStation.com> writes:

> I made a mistake.  Big deal, now that I know that git storage is
> immutable and changes just add to what's already there.  
>
> A quick look at
> 	git reflog show topic
> tells me that {1} is the one I want.  So, how do I rewind branch topic
> to point to topic@{1} ?
> I did it by making a tag, and then in gitk pointing to it and picking
> "reset to here" from the context menu.  
>
> A while back I was looking for the right/easy way to simply repoint my
> branch to where I wanted.  The best answer was to use push.

The answer was best only because in your previous question you wanted to
ensure fast-forwardness, i.e. "git push . origin/dev:dev" without plus in
front to cause it to fail if it is not fast-forward.

If you know you have one unwanted commit you would want to discard at the
tip of topic, you do not want fast-foward safety to kick in.

 (1) if you are on the topic branch, you can say "git reset --hard HEAD^";
     or

 (2) if you are not, you can obviously check out topic and do the above,
     or "git branch -f topic topic^".

If the garbage you have at the tip of the topic is not just a single
commit, you can replace HEAD^ and topic^ in the above with whatever commit
you would want to point the tip at.
