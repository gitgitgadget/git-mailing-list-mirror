From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git remote update: New option --prune (-p)
Date: Thu, 02 Apr 2009 11:06:56 -0700
Message-ID: <7vab6zexq7.fsf@gitster.siamese.dyndns.org>
References: <20090402123823.GA1756@pvv.org>
 <9b18b3110904020634i17633645ue4ba91701ea243a1@mail.gmail.com>
 <20090402134414.GB26699@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: demerphq <demerphq@gmail.com>, Finn Arne Gangstad <finnag@pvv.org>,
	git@vger.kernel.org, gitster@pobox.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Apr 02 20:09:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LpRLN-0001DT-Kf
	for gcvg-git-2@gmane.org; Thu, 02 Apr 2009 20:08:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760867AbZDBSHR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Apr 2009 14:07:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760029AbZDBSHR
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Apr 2009 14:07:17 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:53089 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754939AbZDBSHQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Apr 2009 14:07:16 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 1D06FA7EC9;
	Thu,  2 Apr 2009 14:07:12 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 17D97A7EC8; Thu,
  2 Apr 2009 14:07:04 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 16DCD5EA-1FB1-11DE-A18F-BB14ECB1AA3C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115480>

Jeff King <peff@peff.net> writes:

> I think it makes sense under update as pruning is really just a
> different (and perhaps slightly more dangerous) form of update.
> Generally I would only want to run prune after having run update, so
> combining them makes sense from a workflow perspective.

I agree with you that "oh by the way please prune as well" makes perfect
sense, but I actually would even go stronger than that---if we _were_
adding this command today, I would probably make "update" prune by
default, perhaps with an option to skip the pruning step.

I gave the patch an only cursory look, so I wouldn't comment on the
implementation; two things I would look at in the code would be if it
makes two connections to the remote to learn the same information (which
would be bad) and if it skips the pruning stage if the update stage failed
(which would probably be a sane precaution).
