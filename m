From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] config: Use parseopt.
Date: Sat, 14 Feb 2009 18:22:46 -0800
Message-ID: <7vab8oqw09.fsf@gitster.siamese.dyndns.org>
References: <1234577142-22965-1-git-send-email-felipe.contreras@gmail.com>
 <7vab8pweod.fsf@gitster.siamese.dyndns.org>
 <94a0d4530902140237o7d26ff4j1c7350d926d12c1a@mail.gmail.com>
 <7vhc2wu8a0.fsf@gitster.siamese.dyndns.org>
 <94a0d4530902141209j7a3a9976l80355bee526852ed@mail.gmail.com>
 <alpine.DEB.1.00.0902142213090.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Feb 15 03:24:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYWgB-0002Cr-6i
	for gcvg-git-2@gmane.org; Sun, 15 Feb 2009 03:24:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752670AbZBOCWz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Feb 2009 21:22:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752654AbZBOCWz
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Feb 2009 21:22:55 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:42940 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752393AbZBOCWz (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Feb 2009 21:22:55 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 624B199904;
	Sat, 14 Feb 2009 21:22:52 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 1884B99902; Sat,
 14 Feb 2009 21:22:47 -0500 (EST)
In-Reply-To: <alpine.DEB.1.00.0902142213090.10279@pacific.mpi-cbg.de>
 (Johannes Schindelin's message of "Sat, 14 Feb 2009 22:15:59 +0100 (CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 8C09E84A-FB07-11DD-B420-0433C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109954>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Maybe I should point out something that is obvious to somebody who 
> followed the Git list for a long time: there are two areas of the code 
> that had such a track record of regressions that Junio grew a distaste for 
> them: git-config and parse options.

There is a difference between them; please don't confuse new readers.

git-config does have a rather unfortunate track record and the code may
still be a mess.  But parse-options itself is a good code overall.  Only
that some of the parse-opt-ification attempts in the past might have been
quite bad.

Parse-opt-ification is an obvious, trivial change with a limited scope,
well-defined end results and clear gain to the end users.  The API exists
so the patch author does not have to invent a new framework, the change a
patch needs will typically be limited to a single command, the set of
options the command needs to accept/reject are already defined, and at the
end you can give unique prefix of flags from the command line.

There may be a correlation between parse-opt-ification attempts and bad
review cycles, but there is no such a causal relationship "parse-opt
patches are bad because parse-opt is a bad idea".  

If there is such a correlation, it is more likely that it is merely
because parse-opt-ification attracted more inexperienced people than
tricker areas like revision traversal or extended SHA-1 syntax.

But people can send bad patches to any area ;-).
