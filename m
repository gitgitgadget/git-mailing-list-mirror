From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] Re: Convert 'git blame' to parse_options()
Date: Mon, 23 Jun 2008 15:11:11 -0700
Message-ID: <7v3an3hke8.fsf@gitster.siamese.dyndns.org>
References: <alpine.DEB.1.00.0806231312130.6440@racer>
 <alpine.LFD.1.10.0806230912230.2926@woody.linux-foundation.org>
 <20080623164917.GA25474@sigill.intra.peff.net>
 <alpine.LFD.1.10.0806230953550.2926@woody.linux-foundation.org>
 <20080623171505.GB27265@sigill.intra.peff.net>
 <alpine.LFD.1.10.0806231027210.2926@woody.linux-foundation.org>
 <alpine.LFD.1.10.0806231114180.2926@woody.linux-foundation.org>
 <20080623183358.GA28941@sigill.intra.peff.net>
 <alpine.LFD.1.10.0806231137070.2926@woody.linux-foundation.org>
 <alpine.LFD.1.10.0806231158340.2926@woody.linux-foundation.org>
 <20080623210935.GC13395@artemis.madism.org>
 <alpine.LFD.1.10.0806231425270.2926@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pierre Habouzit <madcoder@debian.org>, Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Jun 24 00:12:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KAuGt-000159-Dk
	for gcvg-git-2@gmane.org; Tue, 24 Jun 2008 00:12:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753500AbYFWWL2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jun 2008 18:11:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753499AbYFWWL2
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jun 2008 18:11:28 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:36337 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753407AbYFWWL1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jun 2008 18:11:27 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id D85A260DC;
	Mon, 23 Jun 2008 18:11:24 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 05DAB60D8; Mon, 23 Jun 2008 18:11:18 -0400 (EDT)
In-Reply-To: <alpine.LFD.1.10.0806231425270.2926@woody.linux-foundation.org>
 (Linus Torvalds's message of "Mon, 23 Jun 2008 14:26:39 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 51B27D06-4171-11DD-B096-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85942>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Mon, 23 Jun 2008, Pierre Habouzit wrote:
>> 
>>   Let's see if I can catch it elegantly.
>
> No.
>
> Look at builtin-blame.c.
>
> THEN get back to me.
>
> Trust me, you need what I wrote. Something that parses all the options in 
> one go, and ignores the ones it cannot parse, because a TOTALLY DIFFERENT 
> function than the caller will call it!

I do not think you two are saying vastly different things.

The series Pierre has just posted is prerequisite for teaching
parse_options() to queue the unknown ones (besides allowing a finer
grained stepwise parsing), so that the caller like cmd_blame() can call
revision parser with the remainder.
