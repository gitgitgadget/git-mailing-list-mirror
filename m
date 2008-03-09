From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-quiltimport: better parser to  grok "enhanced" 
 series files.
Date: Sun, 09 Mar 2008 03:17:18 -0700
Message-ID: <7vpru4p5g1.fsf@gitster.siamese.dyndns.org>
References: <20080308182709.GA3109@artemis.madism.org>
 <7vk5kcsh06.fsf@gitster.siamese.dyndns.org>
 <20080309095918.GA23924@artemis.madism.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git ML <git@vger.kernel.org>
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Sun Mar 09 11:18:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JYIbZ-00067D-Gw
	for gcvg-git-2@gmane.org; Sun, 09 Mar 2008 11:18:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750699AbYCIKR3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Mar 2008 06:17:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750739AbYCIKR3
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Mar 2008 06:17:29 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:37105 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1749667AbYCIKR2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Mar 2008 06:17:28 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id F2EC61609;
	Sun,  9 Mar 2008 06:17:24 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 4FD661608; Sun,  9 Mar 2008 06:17:21 -0400 (EDT)
In-Reply-To: <20080309095918.GA23924@artemis.madism.org> (Pierre Habouzit's
 message of "Sun, 09 Mar 2008 10:59:19 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76644>

Pierre Habouzit <madcoder@debian.org> writes:

>> You made the loop a subshell but I think you can redirect into the while
>> loop without an extra "cat" process.
>
> Well probably yeah, I could use an exec -- < series or an alike trick
> for sure.

It seems many people forget that it is perfectly fine to redirect into
while loop itself, like

	while read foo bar
        do
        	do a lot of stuff
	done <input-file

>> Can a patch name contain $IFS whitespace characters?
>
>   I tested and quilt says that:
>
> $ quilt new a\ b.patch
> Patch a is now on top
>
> And when I quilt refresh it, it creates a patch named 'a'.  (and yes, I thought
> of this and tested it prior to sending the patch).
>
>> If so, this patch would regress them.  Otherwise it looks fine.

Ok, somehow in an earlier patch to quiltimport I picked up an incorrect
notion that they could contain a blank, but then that's fine.

Will queue, but I am very well into my merge binge for tonight (and it
hasn't finished even though it is past 3 AM, sheesh), so it will be in the
next round.
