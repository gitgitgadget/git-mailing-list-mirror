From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] add '%d' pretty format specifier to show decoration
Date: Wed, 03 Sep 2008 13:10:12 -0700
Message-ID: <7v4p4xat3v.fsf@gitster.siamese.dyndns.org>
References: <alpine.LNX.1.10.0809032036270.32295@pollux>
 <20080903191217.GA31195@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Dressel <MichaelTiloDressel@t-online.de>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Sep 03 22:11:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KayhQ-0006vs-Bw
	for gcvg-git-2@gmane.org; Wed, 03 Sep 2008 22:11:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753470AbYICUK1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Sep 2008 16:10:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753144AbYICUK0
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Sep 2008 16:10:26 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:52127 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751416AbYICUK0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Sep 2008 16:10:26 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 0E7CC72D49;
	Wed,  3 Sep 2008 16:10:25 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 34E7372D45; Wed,  3 Sep 2008 16:10:15 -0400 (EDT)
In-Reply-To: <20080903191217.GA31195@coredump.intra.peff.net> (Jeff King's
 message of "Wed, 3 Sep 2008 15:12:17 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 583F1952-79F4-11DD-92C3-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94848>

Jeff King <peff@peff.net> writes:

>>   git log --pretty=format:'%H (%d) %s'
>
> I think Junio requested the enclosing parentheses be included. I am not
> sure I agree, but we are already mandating the comma separator.
> Personally, I think the right solution is more like
>
>   %(decorate:delim=, )
>
> but that is a much bigger change (and part of what was holding me up on
> just improving this patch). I think adding %d in the meantime (with or
> without the surrounding parentheses) is reasonable.

I agree with the above reasoning.  If we go with surrounding parentheses,
it might even make sense to include a SP _before_ the opening parenthesis,
so that "%h %s%d" expands to either of these:

   $ git show -s --pretty=format:'%h %s%d' v1.6.0^0 v1.6.0^1
   ea02eef GIT 1.6.0 (refs/tags/v1.6.0)
   373a273 Merge git-gui 0.11.0

Also I did not like the bug to misidentify "git log --grep=pretty=format:"
you pointed out in your message.
