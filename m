From: Junio C Hamano <gitster@pobox.com>
Subject: Re: How to stop sharing objects between repositories
Date: Mon, 17 Aug 2009 00:24:22 -0700
Message-ID: <7v63cm3ntl.fsf@alter.siamese.dyndns.org>
References: <alpine.DEB.2.00.0908151756150.29215@nhtr.ovalna.fjrygre.arg>
 <alpine.DEB.1.00.0908161042210.8306@pacific.mpi-cbg.de>
 <20090816122842.GA942@sigill.intra.peff.net>
 <alpine.DEB.1.00.0908161429590.8306@pacific.mpi-cbg.de>
 <20090816135703.GA31638@coredump.intra.peff.net>
 <7vmy5z603d.fsf@alter.siamese.dyndns.org>
 <1250475682.7155.16.camel@marge.simson.net>
 <20090817064801.GA31543@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mike Galbraith <efault@gmx.de>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jon Jensen <jon@endpoint.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Aug 17 09:24:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mcwa9-0006Ky-Fd
	for gcvg-git-2@lo.gmane.org; Mon, 17 Aug 2009 09:24:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755618AbZHQHYb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Aug 2009 03:24:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755494AbZHQHYa
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Aug 2009 03:24:30 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:55004 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752277AbZHQHYa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Aug 2009 03:24:30 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 9A4D52C307;
	Mon, 17 Aug 2009 03:24:30 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id BA79C2C303; Mon, 17 Aug 2009
 03:24:23 -0400 (EDT)
In-Reply-To: <20090817064801.GA31543@coredump.intra.peff.net> (Jeff King's
 message of "Mon\, 17 Aug 2009 02\:48\:02 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 01031AEA-8AFF-11DE-BC02-AEF1826986A2-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126131>

Jeff King <peff@peff.net> writes:

> On Mon, Aug 17, 2009 at 04:21:22AM +0200, Mike Galbraith wrote:
>
>> >  (1) Such a user does not necessarily know a casual "git repack -a" breaks
>> >      the dependency, defeating the -s option s/he deliberately used in
>> >      order to save disk space in the first place.  Perhaps we can reword
>> >      this further to kill two penguins with a single stone?
>> 
>> Perhaps a runtime warning that you're about to break it?  This user may
>> not even be the one who set the thing up, no?
>
> I'm not really sure what such a setup would look like....
> ...
> That being said, I can see there being setups where such a warning might
> be useful. However, we don't really know if the user _wants_ that
> effect, or if it is an accident.
> ...
> "here is how you break the dependency" advice will also get the warning.
>
> I'm torn on whether this is actually a good idea.

I would understand if you were torn if the proposed change were to refuse
to run without -l in a repository with alternates when --force is not
given, or something of that nature.

But I can tell you that this "just warn" cannot be a good idea for a very
simple reason: breaking and then warning is useless---it is too late for
the user to do anything about it.
