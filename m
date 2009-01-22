From: Junio C Hamano <gitster@pobox.com>
Subject: Re: valgrind patches, was Re: What's cooking in git.git (Jan 2009,
 #04; Mon, 19)
Date: Wed, 21 Jan 2009 16:42:22 -0800
Message-ID: <7vr62wb28h.fsf@gitster.siamese.dyndns.org>
References: <20090120044447.GF30714@sigill.intra.peff.net>
 <alpine.DEB.1.00.0901201447290.5159@intel-tinevez-2-302>
 <20090120141932.GB10688@sigill.intra.peff.net>
 <alpine.DEB.1.00.0901201545570.5159@intel-tinevez-2-302>
 <20090120232439.GA17746@coredump.intra.peff.net>
 <alpine.DEB.1.00.0901210105470.19014@racer>
 <20090121001551.GB18169@coredump.intra.peff.net>
 <alpine.DEB.1.00.0901210119510.19014@racer>
 <20090121003739.GA18373@coredump.intra.peff.net>
 <alpine.DEB.1.00.0901210216440.19014@racer>
 <20090121190757.GB21686@coredump.intra.peff.net>
 <alpine.DEB.1.00.0901212259420.3586@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jan 22 01:44:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPnfn-0008Aq-UT
	for gcvg-git-2@gmane.org; Thu, 22 Jan 2009 01:43:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753746AbZAVAmc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Jan 2009 19:42:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753584AbZAVAmb
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Jan 2009 19:42:31 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:45272 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753546AbZAVAmb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Jan 2009 19:42:31 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 1A36C1CF93;
	Wed, 21 Jan 2009 19:42:28 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 3F51E1CF8C; Wed,
 21 Jan 2009 19:42:24 -0500 (EST)
In-Reply-To: <alpine.DEB.1.00.0901212259420.3586@pacific.mpi-cbg.de>
 (Johannes Schindelin's message of "Wed, 21 Jan 2009 23:17:35 +0100 (CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 8B5F2916-E81D-11DD-BA36-BE78113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106710>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Fact is: every test script will check $GIT_VALGRIND/bin/ for 
> up-to-dateness first.  Before running any Git command.

Hmm, is that a good thing in general?  Can't makefile rules be arranged in
such a way that one "valgrind-prep" target runs before all the potentially
parallel executions of actual tests begin?

Independent from the above, I suspect that some of the existing tests
cannot run in parallel; I haven't really looked at any of them, but a
server-ish tests to open a local port and test interaction with client
obviously need to either use different ports or serialize.  Perhaps we
need a way to mark some tests that cannot be run in parallel even under
"make -j"?
