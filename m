From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] diff options: Introduce --ignore-submodules
Date: Wed, 14 May 2008 18:50:36 -0700
Message-ID: <7v3aokjpxv.fsf@gitster.siamese.dyndns.org>
References: <alpine.DEB.1.00.0805141802480.30431@racer>
 <alpine.DEB.1.00.0805141803240.30431@racer>
 <7vbq38oi3j.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0805141940460.30431@racer>
 <7vy76cn1aq.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0805142308400.30431@racer>
 <7vod78k022.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0805150204440.30431@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu May 15 03:51:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JwSdC-00049U-LK
	for gcvg-git-2@gmane.org; Thu, 15 May 2008 03:51:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751245AbYEOBus (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 May 2008 21:50:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751273AbYEOBus
	(ORCPT <rfc822;git-outgoing>); Wed, 14 May 2008 21:50:48 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:57340 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750959AbYEOBus (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 May 2008 21:50:48 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 4CE145105;
	Wed, 14 May 2008 21:50:46 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 942DC5101; Wed, 14 May 2008 21:50:43 -0400 (EDT)
In-Reply-To: <alpine.DEB.1.00.0805150204440.30431@racer> (Johannes
 Schindelin's message of "Thu, 15 May 2008 02:09:22 +0100 (BST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 55FEE562-2221-11DD-A6F9-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82166>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> That's exactly the point.  The option reads "ignore submodules", not 
>> "special option for use only by stash and rebase".
>
> But it also does not read "ignore submodules and those blobs/trees that 
> happen to replace (or be replaced by) submodules".

I think "ignore submodules" option, if exists, would mean "ignore changes
that involve submodules", and I think everybody would agree with that.

Because we are talking about an option to "diff", changes involve two
sides (preimage and postimage).  Logically, you can define the class of
changes that involve submodules in two ways:

 * both sides of the change must be a submodule; otherwise the change does
   not involve a submodule.

 * either side of the change is a submodule; such a change involve a
   submodule.

I am saying that the latter makes much more sense (worse yet, what you did
for creation and deletion is inconsistent --- they are void vs submodule
and you treat them as "change that involve submodule").

Didn't you make the option introduction to read "sometimes you are not
interested in submodules..." or something?
