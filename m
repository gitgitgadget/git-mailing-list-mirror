From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] merge-recursive: fix subtree merge
Date: Sat, 30 Aug 2008 09:39:37 -0700
Message-ID: <7vbpza1mpi.fsf@gitster.siamese.dyndns.org>
References: <1220110929-6803-1-git-send-email-vmiklos@frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Stephan Beyer <s-beyer@gmx.net>
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Sat Aug 30 18:40:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KZTVK-0000yN-FC
	for gcvg-git-2@gmane.org; Sat, 30 Aug 2008 18:40:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752550AbYH3Qjp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Aug 2008 12:39:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752710AbYH3Qjo
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Aug 2008 12:39:44 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:40567 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752238AbYH3Qjo (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Aug 2008 12:39:44 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 45BF25A8C0;
	Sat, 30 Aug 2008 12:39:43 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 80D045A8B8; Sat, 30 Aug 2008 12:39:39 -0400 (EDT)
In-Reply-To: <1220110929-6803-1-git-send-email-vmiklos@frugalware.org>
 (Miklos Vajna's message of "Sat, 30 Aug 2008 17:42:09 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 3F822EA8-76B2-11DD-B965-9EE598D589B0-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94385>

Miklos Vajna <vmiklos@frugalware.org> writes:

> On Mon, Aug 25, 2008 at 04:25:57PM +0200, Miklos Vajna <vmiklos@frugalware.org> wrote:
>> It also takes care of subtree merge, output buffering, verbosity, and
>> rename limits - these were global variables till now in
>> merge-recursive.c.
>
> Actually subtree_merge was not used from the struct merge_options, here
> is the fix.

As bd1e8fe (merge-recursive: introduce merge_options, 2008-08-25) is not
part of any solid integration branch yet, I'll squash this into it.

In the longer term, I suspect that other file scope static variables in
merge-recursive.c, such as call_depth, may want to move to merge_options,
not as "option" but as "current state".  But that is quite minor, as it
only affects reentrancy, and I do not see a reason for merge_recursive()
to be reentrant (yet).
