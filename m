From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] provide advance warning of some future pack default changes
Date: Mon, 17 Dec 2007 14:17:01 -0800
Message-ID: <7vtzmh55lu.fsf@gitster.siamese.dyndns.org>
References: <alpine.LFD.0.999999.0712141724260.8467@xanadu.home>
	<20071214223957.GC7300@mail.oracle.com>
	<alpine.LFD.0.999999.0712141744460.8467@xanadu.home>
	<20071215004230.GF7300@mail.oracle.com>
	<alpine.LFD.0.999999.0712142114400.8467@xanadu.home>
	<20071217200920.GB19816@mail.oracle.com>
	<alpine.LFD.0.999999.0712171517320.8467@xanadu.home>
	<20071217211317.GC19816@mail.oracle.com>
	<20071217213049.GG13515@fieldses.org>
	<alpine.LFD.0.999999.0712171646230.8467@xanadu.home>
	<20071217215709.GH13515@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@cam.org>, Joel Becker <Joel.Becker@oracle.com>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: "J. Bruce Fields" <bfields@fieldses.org>
X-From: git-owner@vger.kernel.org Mon Dec 17 23:17:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4OHQ-0003Up-J8
	for gcvg-git-2@gmane.org; Mon, 17 Dec 2007 23:17:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757580AbXLQWRV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Dec 2007 17:17:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757484AbXLQWRV
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Dec 2007 17:17:21 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:60356 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757179AbXLQWRU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Dec 2007 17:17:20 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id DC9BC4BBA;
	Mon, 17 Dec 2007 17:17:10 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 2549B4BB7;
	Mon, 17 Dec 2007 17:17:04 -0500 (EST)
In-Reply-To: <20071217215709.GH13515@fieldses.org> (J. Bruce Fields's message
	of "Mon, 17 Dec 2007 16:57:09 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68637>

"J. Bruce Fields" <bfields@fieldses.org> writes:

> On Mon, Dec 17, 2007 at 04:52:16PM -0500, Nicolas Pitre wrote:
>> On Mon, 17 Dec 2007, J. Bruce Fields wrote:
>> 
>> > By the way, just as a data point: I do keep some git repositories on
>> > NFS, and access them from multiple machines with different git versions
>> > (not on purpose--it's just that the machines don't all run the same
>> > distro, so it'd be extra work to give them all the same version).  I
>> > don't use anything older than 1.5.0.  If the repository became unusable
>> > on one of those machines without warning it'd be annoying.
>> 
>> What the v1.5.5 release notes will say is that you'll have to set 
>> pack.indexversion=1 to remain compatible with pre-1.5.2 Git versions.  
>
> Is there any reason not to make pack.indexversion=1 the default (for
> preexisting repositories at the very least) and suggest in the release
> notes that people set something else if they want the features the new
> version provides?

That's a judgement call.

Pack-idx format v2 is by design much safer in the face of bitflip (do we
have a test case to make sure this is indeed true?).  But from the end
user's point of view, all the usual "I do not want to be forced to
update that old box I do not want to touch" applies.

And the people who needs to suffer from the dilemma are only the ones
who access a single repository across NFS with git from different
vintage.  If that is a minority and/or tends to be more clueful people,
the inconvenience factor may be outweighed by the advantage v2 offers,
and pushing adoption of v2 harder the way Nico is driving at would
generally be a good thing.
