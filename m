From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Possibly-spurious 'not uptodate. Cannot merge'
Date: Sun, 14 Dec 2008 11:33:57 -0800
Message-ID: <7vwse21rh6.fsf@gitster.siamese.dyndns.org>
References: <874p16puuq.fsf@hades.wkstn.nix>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Nix <nix@esperi.org.uk>
X-From: git-owner@vger.kernel.org Sun Dec 14 20:35:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LBwkS-0007Z3-8v
	for gcvg-git-2@gmane.org; Sun, 14 Dec 2008 20:35:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751280AbYLNTeJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Dec 2008 14:34:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751241AbYLNTeI
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Dec 2008 14:34:08 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:47078 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750945AbYLNTeH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Dec 2008 14:34:07 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id B9E421A1E6;
	Sun, 14 Dec 2008 14:34:04 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 9BBA5185F9; Sun,
 14 Dec 2008 14:34:01 -0500 (EST)
In-Reply-To: <874p16puuq.fsf@hades.wkstn.nix> (nix@esperi.org.uk's message of
 "Sun, 14 Dec 2008 16:47:09 +0000")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 2AD215D8-CA16-11DD-B824-F83E113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103097>

Nix <nix@esperi.org.uk> writes:

> Recently (as of perhaps git 1.5.4?), whenever I update my l-k tree I get
> this:
> ...
> I suspect the 'problem' is that I've hardlinked a bunch of build trees
> to this tree in the interim via 'cp -al', then applied patches to each
> of those trees with quilt, then deleted all those trees prior to the git
> pull. This doesn't change the original files at all, but *does* update
> their link count: is git getting annoyed by the corresponding change in
> ctime? (If so, why did it start happening only fairly recently?)

In git timescale 1.5.4 is not recent at all ;-)

Ancient git, whose "git merge" was a scripted command, refreshed the index
before starting, but it lost that when the command was rewritten in C soon
after v1.5.6 by 1c7b76b (Build in merge, 2008-07-07), and nobody noticed
it until 76c3fb1 (Merge branch 'mv/merge-refresh', 2008-10-09).  In other
words, the tip of 'master' (and upcoming 1.6.1) already has the fix.

The fix should have been cherry-picked to 'maint' to be part of 1.6.0.X
series, but it apparently was forgotten.  Fault of mine and Shawn ;-)
