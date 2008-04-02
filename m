From: Junio C Hamano <gitster@pobox.com>
Subject: Re: how do i revert to a previous version, keeping the history
Date: Wed, 02 Apr 2008 00:12:52 -0700
Message-ID: <7vfxu4afwr.fsf@gitster.siamese.dyndns.org>
References: <47F32CBE.2040305@tikalk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ittay Dror <ittayd@tikalk.com>
X-From: git-owner@vger.kernel.org Wed Apr 02 09:13:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JgxAM-0002pC-QE
	for gcvg-git-2@gmane.org; Wed, 02 Apr 2008 09:13:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758134AbYDBHNH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Apr 2008 03:13:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751724AbYDBHNH
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Apr 2008 03:13:07 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:49882 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756094AbYDBHNG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Apr 2008 03:13:06 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id E12A04792;
	Wed,  2 Apr 2008 03:13:01 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 8F3D74790; Wed,  2 Apr 2008 03:12:55 -0400 (EDT)
In-Reply-To: <47F32CBE.2040305@tikalk.com> (Ittay Dror's message of "Wed, 02
 Apr 2008 09:50:38 +0300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78687>

Ittay Dror <ittayd@tikalk.com> writes:

> I have this revision history: A-B
> I want to go back to the code in A, but keep B in the history: A-B-A
>
> How do I do that?

Straight answer (iow, what you asked, which may not match what you wanted
to really do):

	$ git read-tree -m -u A
        $ git commit -m 'Revert to A'

Probably a more useful answer, guessing what you really wanted to do:

You have a botched commit F that was in the sequence of longer commits,
A--B--C--D--E--F--G--H, and you want to recover from the mistake F made
(iow, the change between E and F is bad):

	$ git revert F

This will make your history A--B--C--D--E--F--G--H--F' where the
difference between H and F' counteracts what F did relative to E.
