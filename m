From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Tracking of local branches
Date: Fri, 20 Mar 2009 09:46:02 -0700
Message-ID: <7viqm4i1md.fsf@gitster.siamese.dyndns.org>
References: <49C3A6AE.7020104@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Mar 20 17:48:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lkht1-0001kZ-03
	for gcvg-git-2@gmane.org; Fri, 20 Mar 2009 17:47:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758906AbZCTQqN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Mar 2009 12:46:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757073AbZCTQqN
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Mar 2009 12:46:13 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:36609 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758754AbZCTQqM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Mar 2009 12:46:12 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 59750A1768;
	Fri, 20 Mar 2009 12:46:10 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id BEB63A1763; Fri,
 20 Mar 2009 12:46:04 -0400 (EDT)
In-Reply-To: <49C3A6AE.7020104@drmicha.warpmail.net> (Michael J. Gruber's
 message of "Fri, 20 Mar 2009 15:22:38 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 9DA9BCAC-156E-11DE-A958-32B0EBB1AA3C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113977>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> I semi-successfully messed around in remote.c (format_tracking_info(),
> stat_tracking_info()) to make it use branch->merge_name rather than
> branch->merge. This makes "git status" work as expected ("Your branch
> is... severely screwed.") for tracked local branches. (It's messed up
> for remote ones but hey it was a first shot; merge[0]->dst is really
> needed here I guess.)
>
> Now I could go after sha1_name.c and do the same,
>
> OR
>
> make it so that all branches have their merge member set up, uhm. Any
> possible side effects?

My gut feeling is that the latter if works should be preferable for
consistency if nothing else.

The "struct branch" hasn't changed ever since it was introduced by cf81834
(Report information on branches from remote.h, 2007-09-10) and Daniel
might know about some corner cases that rely on branch.merge not being set
up for local ones, but honestly, I would think it would be a bug in the
existing code if there were such cases.
