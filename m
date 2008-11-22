From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-status for submodules
Date: Fri, 21 Nov 2008 16:55:41 -0800
Message-ID: <7vod08poj6.fsf@gitster.siamese.dyndns.org>
References: <20081120033615.GA21128@foursquare.net>
 <7vabbtqga8.fsf@gitster.siamese.dyndns.org>
 <20081121224247.GB27049@foursquare.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Chris Frey <cdfrey@foursquare.net>
X-From: git-owner@vger.kernel.org Sat Nov 22 01:57:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L3goV-0004FS-G1
	for gcvg-git-2@gmane.org; Sat, 22 Nov 2008 01:57:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755016AbYKVA4G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Nov 2008 19:56:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755600AbYKVA4F
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Nov 2008 19:56:05 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:41413 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753724AbYKVA4E (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Nov 2008 19:56:04 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 699E617414;
	Fri, 21 Nov 2008 19:56:01 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id CC82C17419; Fri,
 21 Nov 2008 19:55:42 -0500 (EST)
In-Reply-To: <20081121224247.GB27049@foursquare.net> (Chris Frey's message of
 "Fri, 21 Nov 2008 17:42:47 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 54F3F09A-B830-11DD-86D4-F83E113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101549>

Chris Frey <cdfrey@foursquare.net> writes:

> It's true that subproject X has to be able to stand on its own.  That
> is important from git's perspective as well as for managing subprojects
> in general.
>
> But I don't see the advantage in hiding submodule information from the
> supermodule, and if that hiding is by design, I think the design is wrong.

There is no "wrong" design in git.  There are ones that do not cover 360
degrees of the field, because nobody designed out let alone coded to cover
such use cases.

> In order to manage the various modules effectively (actually, in order to
> manage any git repo effectively), you need to know what's changed,
> and git-status is the way to do that.  I don't see why submodules should
> break that.

Changes to parts of submodules are fundamentally different from changes to
parts of your main project.  A change to what commit the superproject
wants for a submodule is at the same level as a change to what content the
superprojects wants for a blob.

It is not unreasonable to want to have both modes of operation, one that
shows the uncommitted details in the submodule even when you are viewing
from the superproject (which does not exist), and one that does not (which
does exist, because somebody felt need for it and coded so).

In order to see the status of your working tree, you may want to take into
account what untracked files are in there, but some people do not want to,
so there is an option to pick which behaviour you want.  We would need a
similar switch.

> With the new submodule foreach command, though, it should be possible
> to add that as a config option, similar to the way submodule summary
> is handled now.  Maybe I can cook up a patch for that.

Yup, that's the spirit.
